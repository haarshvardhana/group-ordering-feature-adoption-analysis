# Group Ordering Feature Analytics

## Overview
Group Ordering is a collaborative, high-engagement feature designed to allow multiple users to pool items into a single, shared checkout cart. 

This project maps and analyzes the entire user behavior lifecycle from initial organic discovery to final order completion. By combining systematic data engineering, sequential SQL query pipelines, and high-impact Tableau dashboards, this analysis uncovers critical conversion bottlenecks, evaluates rolling cohort retention patterns, and isolates structural performance variations across different platforms and user demographics.

**Tools:** PostgreSQL, SQL, Python (Pandas/NumPy), Tableau

---

## Dataset & Technical Infrastructure
The core analysis is built on a high-velocity product event stream tracking end-to-end user navigation journeys over a 60-day post-signup window.

### Dataset Scale & Impact
*   **`users.csv` ($100,000$ Rows | $5$ Columns):** Full user master database detailing cohort onboarding timelines (`signup_date`), regional markets (`city`), hardware ecosystems (`platform`), and engagement classifications (`user_segment`).
*   **`events.csv` (~2.1M + Granular Rows):** Comprehensive behavioural transaction ledger capturing session-level clickstreams (`session_id`), timestamped activities (`event_time`), and operational abandonments (`abandon`) across all $100,000$ users.

### Key Event Lifecycle
*   **`restaurant_view`:** The primary discovery layer where users browse menu options.
*   **`group_order_click`:** The active configuration trigger where a user initiates a shared ordering session.
*   **`invite_sent_to_friend_*`:** Collaborative communication events logging downstream shared interactions.
*   **`checkout`:** Order aggregation and billing initialization.
*   **`order_complete`:** Successful payment confirmation and conversion fulfillment.

---

## Overall Feature Adoption
This layer establishes market penetration metrics by cleanly segmenting feature-aware users from those who navigate standard individual checkout funnels.

<img width="1335" height="675" alt="07_feature_impact" src="https://github.com/user-attachments/assets/c4a9beb2-9de3-42b7-b339-b023803be2d1" />

*_Figure 1: High-Level Market Penetration, Feature Adopters vs. Non-Adopters._*

### Key Findings
*   **Exceptional Feature Penetration:** Feature discovery is incredibly successful, achieving an overall adoption rate of **$82.6\%$** ($82,611$ unique users out of the $100,000$ total pool).
*   **Minimal Blind Spots:** Only **$17.4\%$** ($17,389$ users) navigated the app without testing or opening a group ordering workflow.
*   **Strategic Vector Shift:** Because the acquisition and discovery loops are heavily optimized, top-of-funnel marketing expansions yield diminishing returns. Growth strategy must pivot entirely to down-funnel mid-journey retention.

### Business Interpretation
The feature has crossed the critical threshold from a niche tool to a core app behavior. Because discovery is functional, your immediate engineering and product capital should shift away from visibility mechanics and focus entirely on helping users navigate through social coordination barriers.

---

## Feature Adoption Funnel
To dissect step-by-step performance drop-offs, user sessions were compiled into an ordered progression mapping sequential journey commitment.

<img width="2884" height="1440" alt="01_feature_adoption_funnel" src="https://github.com/user-attachments/assets/38a20a3b-bf44-4297-852f-d5e7611805c3" />

*_Figure 2: End-to-End User Journey Progression Funnel with Volumetric and Step Conversion Rates._*

### Funnel Journey
$$\text{Restaurant View} \longrightarrow \text{Group Order Click} \longrightarrow \text{Invite Sent To Friend} \longrightarrow \text{Checkout} \longrightarrow \text{Order Complete}$$

### Key Findings
*   **Strong Initial Interest:** Out of $96,958$ users viewing active restaurant layouts, **$85.2\%$** seamlessly opt into initiating a team order ($82,611$ users).
*   **Frictionless Invite Launch:** Exactly **$100\%$** of users who initiate a group order configuration advance to fire off outbound social invitations to friends.
*   **The Critical Drop-Off:** A massive conversion canyon appears post-invitation, where active group sessions collapse before successfully reaching the `checkout` milestone ($43,172$ users).
*   **Elite Terminal Conversion:** Once a group cart bypasses the coordination phase and enters `checkout`, conversion velocity spikes to **$94.4\%$**, translating directly to $40,744$ completed orders.

### Business Interpretation
The data safely rules out early-stage disinterest or broken entry points—top-of-funnel adoption is exceptionally strong. The terminal stage also confirms that the transactional checkout interface is clear and highly functional. The core friction point is a social coordination wall: group checkouts collapse when carts wait for multiple people to finish choosing their food.

---

## Leakage Analysis
Isolating specific transaction drop-offs highlights exactly where operational revenue evaporates mid-session.

<img width="1342" height="668" alt="02_Largest Funnel Drop-Offs" src="https://github.com/user-attachments/assets/1f5a145d-1d08-406d-a1b4-6fa7c79a5fba" />

*_Figure 3: Key Conversion Leakage Quantified by Funnel Progression Step._*

### Key Findings
*   **The Invitation-to-Checkout Bottleneck:** The absolute highest point of system leakage occurs directly between sending group invites and initiating checkouts, dropping **$47.70\%$** of active sessions.
*   **Social De-synchronization:** Nearly half of all group configurations break down because the host or participants abandon the app while waiting for mutual cart item aggregation.
*   **Payment Infrastructure Stability:** The minor **$5.60\%$** drop-off between checkout and completion indicates minimal price shock, payment failure, or address verification issues.

### Product Opportunity
Maximizing total order volume does not require expensive user acquisition. Recovering just **$10\%$** of the users trapped in the $47.70\%$ coordination loop would drive immediate, high-margin revenue directly to the bottom line by converting pre-existing, intent-driven traffic.

---

## User Segment Analysis
Cross-referencing core behaviors against historical user profiles reveals distinct differences in feature adoption across customer types.

<img width="1344" height="685" alt="04_Feature Adoption Penetration Rate by User Segment" src="https://github.com/user-attachments/assets/db80584c-fb8f-4228-9e25-e9f3d01ea1e7" />

*_Figure 4: Penetration Rate by Core Engagement Segments._*

### Key Findings
*   **Power User Saturation:** Power Users demonstrate complete behavioral integration, posting an adoption rate of **$99.99\%$**.
*   **Regular User Alignment:** Regular Users mirror this trend closely, adapting to collaborative configurations at a highly reliable **$95.72\%$** adoption rate.
*   **Casual User Chasm:** Casual Users lag noticeably behind at **$68.25\%$** feature adoption, creating a prominent $31.74\%$ behavioral variance gap.

### Business Interpretation
Highly engaged cohorts have organically standardized this feature into their standard dining habits. The long-tail growth target is entirely within the Casual tier. Because Casual users rarely open the app, tailored discovery interfaces and structured rewards are necessary to kickstart their initial collaborative habit loops.

---

## Platform Analysis
Evaluating behavioral data across client device setups helps isolate systemic interface bugs from underlying user habits.

<img width="1107" height="661" alt="05_Feature Adoption Penetration Rate by Platform" src="https://github.com/user-attachments/assets/6d8344c2-c88d-4700-878d-60021281cd29" />

*_Figure 5: Feature Adoption Across Ecosystem Interfaces._*

### Key Findings
*   **Total Ecosystem Parity:** Feature adoption profiles are incredibly flat across all form factors: Web (**$82.71\%$**), Android (**$82.67\%$**), and iOS (**$82.52\%$**).
*   **Universal Interface Core:** Cross-platform variance remains within a fractional $\pm 0.19\%$ margin, establishing that high-level feature discovery is perfectly uniform across all device configurations.

### Business Interpretation
Because high-level entry rates are completely uniform across devices, core feature discovery is highly stable. However, note that while *initial discovery entries* match, high-level web users suffer structural drop-offs during downstream coordination loops due to platform-specific friction points built into the data model. Optimization sprints should focus on unified interface designs rather than separate, platform-specific re-engineering.

---

## Cohort Retention Analysis
Tracking rolling user performance across structured weekly/monthly cohorts proves whether the feature delivers sustained, repeatable engagement.

<img width="1387" height="667" alt="03_cohort_retention_heatmap" src="https://github.com/user-attachments/assets/6b2f6c25-6380-4b10-8361-744984d426f8" />

*_Figure 6: Rolling Daily Cohort Retention Matrix Over 60 Post-Signup Active Intervals._*

### Key Findings
*   **Remarkable Cohort Predictability:** Churn pathways show perfect baseline consistency across time. No single onboarding cohort suffers erratic retention plummets or abnormal usage spikes.
*   **Healthy Standard Decay:** Post-onboarding usage charts a smooth, standard retention curve. The absence of sharp drops confirms that the experience lacks hidden friction points or broken software updates.
*   **Sustained Long-Tail Value:** Retention curves level out cleanly over time, proving that group ordering functions as a sticky, high-value habit loop once users successfully navigate their first checkout.

### Business Interpretation
The feature shows strong organic health and predictable customer lifecycles. This highly stable retention backdrop gives product teams the perfect foundation to confidently run deep A/B experimentation without worrying about underlying cohort volatility skewing the metrics.

---

## Executive Summary
*   **High-Impact Market Discovery:** Group Ordering successfully reached an elite **$82.6\%$** overall adoption rate, confirming exceptional layout visibility and feature awareness.
*   **The Invitation-to-Checkout Bottleneck:** System conversion drops severely during the **Invitation-to-Checkout transition phase**, where **$47.70\%$** of open sessions collapse due to asynchronous group coordination friction.
*   **The Casual User Opportunity:** Power ($99.99\%$) and Regular ($95.72\%$) users have completely adopted the feature, positioning **Casual Users ($68.25\%$)** as your highest-upside target for future growth initiatives.
*   **Cross-Platform Consistency:** Initial feature adoption metrics remain entirely uniform across Android, iOS, and Web layouts, pointing toward shared user habits rather than device bugs.
*   **Reliable Long-Term Value:** Cohort retention tracking confirms smooth, predictable usage lifecycles across the board, proving that the tool drives dependable, long-term customer value.

---

## Recommendations

### 1. Introduce Asynchronous Cart Locking & Smart Checkout Timers
To resolve the critical $47.70\%$ invitation-to-checkout drop-off, move away from open-ended, infinite group sessions. Implement automated host checkout triggers, individual participant item-selection countdown alerts, and host-override capabilities ("Lock Cart and Checkout Now") to eliminate coordination delays.

### 2. Launch In-App Dynamic Pushes and Live Activity Status Tracking
Deploy real-time push notifications and interactive OS widgets (e.g., Apple Live Activities) to re-engage participants while they wait for friends to finish adding items. Visually tracking progress (e.g., *"2/4 friends have added their meals!"*) gamifies the waiting period and lowers cart abandonment.

### 3. Deploy Casual-Targeted Onboarding Loops and Threshold Milestones
Bridge the $31.74\%$ usage gap among Casual users by building automated, conditional trigger campaigns. When a casual account approaches standard weekend dinner hours, serve targeted layouts and clear milestone incentives (e.g., *"Order with 2 friends to unlock waived delivery fees"*).

### 4. Create Collaborative Gamification and Shared Checkout Discounts
Design structural financial benefits that naturally reward group order completion over individual ordering methods. Experiment with group-scale milestones, such as unlocking tiered restaurant discounts as more distinct participants join the checkout cart.
