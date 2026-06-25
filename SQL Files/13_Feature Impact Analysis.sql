USE new_project;

-- trying to compare engagement

WITH feature_users AS (

    SELECT DISTINCT user_id
    FROM events
    WHERE event_name = 'group_order_click'

),

user_activity AS (

    SELECT
        user_id,
        COUNT(*) AS total_events
    FROM events
    GROUP BY user_id

)

SELECT
    'Feature User' AS user_group,
    AVG(total_events) AS avg_events
FROM user_activity
WHERE user_id IN (
    SELECT user_id
    FROM feature_users
)

UNION ALL

SELECT
    'Non Feature User' AS user_group,
    AVG(total_events) AS avg_events
FROM user_activity
WHERE user_id NOT IN (
    SELECT user_id
    FROM feature_users
);

-- maybe adopters simply spend more time in the app

WITH feature_users AS (

    SELECT DISTINCT user_id
    FROM events
    WHERE event_name = 'group_order_click'

),

user_sessions AS (

    SELECT
        user_id,
        COUNT(DISTINCT session_id) AS total_sessions
    FROM events
    GROUP BY user_id

)

SELECT
    'Feature User' AS user_group,
    AVG(total_sessions) AS avg_sessions
FROM user_sessions
WHERE user_id IN (
    SELECT user_id
    FROM feature_users
)

UNION ALL

SELECT
    'Non Feature User' AS user_group,
    AVG(total_sessions) AS avg_sessions
FROM user_sessions
WHERE user_id NOT IN (
    SELECT user_id
    FROM feature_users
);

-- do adopters complete more orders?

WITH feature_users AS (

    SELECT DISTINCT user_id
    FROM events
    WHERE event_name = 'group_order_click'

),

orders AS (

    SELECT
        user_id,
        COUNT(*) AS completed_orders
    FROM events
    WHERE event_name = 'order_complete'
    GROUP BY user_id

)

SELECT
    'Feature User' AS user_group,
    AVG(completed_orders)
FROM orders
WHERE user_id IN (
    SELECT user_id
    FROM feature_users
)

UNION ALL

SELECT
    'Non Feature User' AS user_group,
    AVG(completed_orders)
FROM orders
WHERE user_id NOT IN (
    SELECT user_id
    FROM feature_users
);

-- hypothesis:
-- power users may be skewing results

SELECT
    u.user_segment,

    COUNT(DISTINCT e.user_id) AS adopters

FROM users u
JOIN events e
    ON u.user_id = e.user_id

WHERE e.event_name = 'group_order_click'

GROUP BY u.user_segment;

-- first pass at adoption rates

WITH segment_totals AS (

    SELECT
        user_segment,
        COUNT(*) AS users
    FROM users
    GROUP BY user_segment

),

segment_adopters AS (

    SELECT
        u.user_segment,
        COUNT(DISTINCT u.user_id) AS adopters
    FROM users u
    JOIN events e
        ON u.user_id = e.user_id
    WHERE e.event_name = 'group_order_click'
    GROUP BY u.user_segment

)

SELECT
    t.user_segment,
    t.users,
    a.adopters,

    ROUND(
        a.adopters * 100.0 / t.users,
        2
    ) AS adoption_rate

FROM segment_totals t
JOIN segment_adopters a
    ON t.user_segment = a.user_segment;

-- looking at platform distribution

SELECT
    platform,
    COUNT(DISTINCT user_id) AS adopters
FROM events
WHERE event_name = 'group_order_click'
GROUP BY platform;

-- comparing adopter vs non adopter platforms

WITH feature_users AS (

    SELECT DISTINCT user_id
    FROM events
    WHERE event_name = 'group_order_click'

)

SELECT
    platform,

    CASE
        WHEN user_id IN (
            SELECT user_id
            FROM feature_users
        )
        THEN 'Adopter'
        ELSE 'Non Adopter'
    END AS adopter_flag,

    COUNT(*) AS users

FROM users

GROUP BY
    platform,
    adopter_flag;


-- how long after signup do users try the feature?

WITH first_seen AS (

    SELECT
        user_id,
        MIN(DATE(event_time)) AS first_activity
    FROM events
    GROUP BY user_id

),

feature_click AS (

    SELECT
        user_id,
        MIN(DATE(event_time)) AS first_feature_click
    FROM events
    WHERE event_name = 'group_order_click'
    GROUP BY user_id

)

SELECT

    AVG(

        DATEDIFF(
            day,
            first_activity,
            first_feature_click
        )

    ) AS avg_days_to_adoption

FROM first_seen f
JOIN feature_click c
    ON f.user_id = c.user_id;

