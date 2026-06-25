import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import random

# Set seed for reproducibility
np.random.seed(42)
random.seed(42)

# ============================================
# STEP 1: Create 100,000 Users
# ============================================

num_users = 100000

users = pd.DataFrame({
    'user_id': range(1, num_users + 1),
    'signup_date': pd.date_range(
        start='2024-01-01',
        end='2024-12-31',
        periods=num_users
    ),
    'platform': np.random.choice(
        ['iOS', 'Android', 'Web'],
        size=num_users,
        p=[0.45, 0.35, 0.20]  # 45% iOS, 35% Android, 20% Web
    ),
    'city': np.random.choice(
        ['Mumbai', 'Delhi', 'Bangalore', 'Hyderabad', 'Chennai', 'Pune'],
        size=num_users
    )
})

# Add user segment (power users vs casual)
users['user_segment'] = np.random.choice(
    ['Power', 'Regular', 'Casual'],
    size=num_users,
    p=[0.15, 0.35, 0.50]
)

print(f"✅ Created {len(users)} users")
print(users.head())

# ============================================
# STEP 2: Define Event Logic
# ============================================

# Event sequence for a typical session
event_sequence = [
    'app_open',
    'search',
    'restaurant_view',
    'group_order_click',
    'invite_friend',
    'checkout',
    'order_complete'
]

# Drop-off probabilities at each stage (INTENTIONAL FAILURE)
# Web users have much higher drop-off after invite_friend
def get_dropoff_probabilities(platform, user_segment):
    base_probs = {
        'app_open': 0.00,
        'search': 0.10,
        'restaurant_view': 0.10,
        'group_order_click': 0.50,   # 50% drop here — major friction
        'invite_friend': 0.60,        # 60% drop here — FEATURE FAILS HERE
        'checkout': 0.30,
        'order_complete': 0.10
    }
    
    # Web users drop more after invite_friend
    if platform == 'Web':
        base_probs['invite_friend'] = 0.85  # 85% drop — invite flow broken on web
    
    # Power users convert better
    if user_segment == 'Power':
        base_probs['group_order_click'] = 0.30
        base_probs['invite_friend'] = 0.40
    
    return base_probs

# ============================================
# STEP 3: Generate Events for Each User
# ============================================

def generate_user_events(user_id, platform, segment, signup_date, num_sessions=5):
    """Generate event stream for a single user"""
    events = []
    today = datetime.now()
    
    # Number of sessions depends on user segment
    if segment == 'Power':
        sessions = random.randint(10, 20)
    elif segment == 'Regular':
        sessions = random.randint(4, 10)
    else:
        sessions = random.randint(1, 4)
    
    for session_num in range(sessions):
        # Session timestamp (spread over time)
        session_date = signup_date + timedelta(days=random.randint(1, 60))
        if session_date > today:
            session_date = today - timedelta(days=random.randint(1, 10))
        
        session_id = f"{user_id}_{session_num}_{int(session_date.timestamp())}"
        
        # Get dropoff probabilities for this user
        probs = get_dropoff_probabilities(platform, segment)
        
        # Walk through event sequence
        current_stage = 0
        while current_stage < len(event_sequence):
            event = event_sequence[current_stage]
            
            # Check if user drops off here
            if random.random() < probs.get(event, 0.1):
                # User abandons here
                events.append({
                    'user_id': user_id,
                    'session_id': session_id,
                    'event_time': session_date + timedelta(minutes=current_stage * 2),
                    'event_name': 'abandon',
                    'platform': platform,
                    'segment': segment
                })
                break
            else:
                # User performs this event
                events.append({
                    'user_id': user_id,
                    'session_id': session_id,
                    'event_time': session_date + timedelta(minutes=current_stage * 2),
                    'event_name': event,
                    'platform': platform,
                    'segment': segment
                })
                
                # Special: if group_order_click, add extra events
                if event == 'group_order_click':
                    # Add number of friends invited
                    friends_invited = random.randint(1, 4)
                    for f in range(friends_invited):
                        events.append({
                            'user_id': user_id,
                            'session_id': session_id,
                            'event_time': session_date + timedelta(minutes=current_stage * 2 + 1 + f),
                            'event_name': f'invite_sent_to_friend_{f+1}',
                            'platform': platform,
                            'segment': segment
                        })
                
                current_stage += 1
    
    return events

# ============================================
# STEP 4: Generate Events for ALL Users
# ============================================

print("🔄 Generating events for 100,000 users... (this will take 1-2 minutes)")

all_events = []
count = 0

for idx, row in users.iterrows():
    user_events = generate_user_events(
        user_id=row['user_id'],
        platform=row['platform'],
        segment=row['user_segment'],
        signup_date=row['signup_date']
    )
    all_events.extend(user_events)
    count += 1
    
    # Progress indicator
    if count % 10000 == 0:
        print(f"   Processed {count} users...")

print(f"✅ Generated {len(all_events)} events")

# Convert to DataFrame
events_df = pd.DataFrame(all_events)

# ============================================
# STEP 5: Add Timestamps Properly
# ============================================

events_df['event_time'] = events_df['event_time'].apply(
    lambda x: x.strftime('%Y-%m-%d %H:%M:%S')
)

print("\n📊 Sample Events:")
print(events_df.head(20))

# ============================================
# STEP 6: Save Data
# ============================================

users.to_csv('users.csv', index=False)
events_df.to_csv('events.csv', index=False)

print("\n✅ Data saved successfully!")
print(f"   Users: {len(users)}")
print(f"   Events: {len(events_df)}")

# ============================================
# STEP 7: Quick Analysis to Verify Patterns
# ============================================

print("\n📊 Quick Funnel Analysis:")

# Calculate funnel drop-offs
funnel_stages = ['app_open', 'search', 'restaurant_view', 'group_order_click', 'invite_friend', 'checkout', 'order_complete']

for stage in funnel_stages:
    users_at_stage = events_df[events_df['event_name'] == stage]['user_id'].nunique()
    pct = (users_at_stage / num_users) * 100
    print(f"   {stage:20s}: {users_at_stage:>8,} users ({pct:5.1f}%)")

# Check platform differences
print("\n📊 Platform-wise Group Order Click Rate:")
for platform in ['iOS', 'Android', 'Web']:
    users_on_platform = users[users['platform'] == platform]['user_id'].nunique()
    clicked = events_df[(events_df['platform'] == platform) & (events_df['event_name'] == 'group_order_click')]['user_id'].nunique()
    pct = (clicked / users_on_platform) * 100 if users_on_platform > 0 else 0
    print(f"   {platform:10s}: {clicked:>8,} / {users_on_platform:>8,} users ({pct:5.1f}%)")

print("\n📊 Platform-wise Invite Friend Rate:")
for platform in ['iOS', 'Android', 'Web']:
    users_on_platform = users[users['platform'] == platform]['user_id'].nunique()
    invited = events_df[(events_df['platform'] == platform) & (events_df['event_name'] == 'invite_friend')]['user_id'].nunique()
    pct = (invited / users_on_platform) * 100 if users_on_platform > 0 else 0
    print(f"   {platform:10s}: {invited:>8,} / {users_on_platform:>8,} users ({pct:5.1f}%)")
