USE new_project;

-- wanted to identify highly engaged users

WITH user_activity AS (

    SELECT
        user_id,
        COUNT(*) AS total_events,
        COUNT(DISTINCT session_id) AS total_sessions
    FROM events
    GROUP BY user_id

)

SELECT *
FROM user_activity
LIMIT 20;

-- checking completed orders per user

WITH order_summary AS (

    SELECT
        user_id,
        COUNT(*) AS completed_orders
    FROM events
    WHERE event_name = 'order_complete'
    GROUP BY user_id

)

SELECT *
FROM order_summary
ORDER BY completed_orders DESC
LIMIT 20;

-- identifying feature adopters

WITH feature_users AS (

    SELECT DISTINCT user_id
    FROM events
    WHERE event_name = 'group_order_click'

)

SELECT COUNT(*)
FROM feature_users;

-- first version of user classification

WITH user_activity AS (

    SELECT
        user_id,
        COUNT(*) AS total_events,
        COUNT(DISTINCT session_id) AS total_sessions
    FROM events
    GROUP BY user_id

),

order_summary AS (

    SELECT
        user_id,
        COUNT(*) AS completed_orders
    FROM events
    WHERE event_name = 'order_complete'
    GROUP BY user_id

),

feature_users AS (

    SELECT DISTINCT user_id
    FROM events
    WHERE event_name = 'group_order_click'

)

SELECT

    a.user_id,

    a.total_events,

    a.total_sessions,

    COALESCE(o.completed_orders,0) AS completed_orders,

    CASE
        WHEN f.user_id IS NOT NULL
        THEN 1
        ELSE 0
    END AS adopted_feature

FROM user_activity a

LEFT JOIN order_summary o
    ON a.user_id = o.user_id

LEFT JOIN feature_users f
    ON a.user_id = f.user_id;

-- building product health labels

WITH user_activity AS (

    SELECT
        user_id,
        COUNT(*) AS total_events,
        COUNT(DISTINCT session_id) AS total_sessions
    FROM events
    GROUP BY user_id

),

order_summary AS (

    SELECT
        user_id,
        COUNT(*) AS completed_orders
    FROM events
    WHERE event_name = 'order_complete'
    GROUP BY user_id

),

feature_users AS (

    SELECT DISTINCT user_id
    FROM events
    WHERE event_name = 'group_order_click'

)

SELECT

    a.user_id,

    a.total_events,

    a.total_sessions,

    COALESCE(o.completed_orders,0) AS completed_orders,

    CASE

        WHEN
            a.total_events >= 100
            AND COALESCE(o.completed_orders,0) >= 5
        THEN 'Power User'

        WHEN
            a.total_events >= 50
            AND COALESCE(o.completed_orders,0) >= 2
        THEN 'Healthy User'

        WHEN
            a.total_events < 20
        THEN 'At Risk'

        ELSE 'Regular User'

    END AS user_health

FROM user_activity a

LEFT JOIN order_summary o
    ON a.user_id = o.user_id;

-- users who adopted feature
-- and actually completed orders

WITH feature_users AS (

    SELECT DISTINCT user_id
    FROM events
    WHERE event_name = 'group_order_click'

),

completed_orders AS (

    SELECT
        user_id,
        COUNT(*) AS orders_completed
    FROM events
    WHERE event_name = 'order_complete'
    GROUP BY user_id

)

SELECT

    f.user_id,

    orders_completed,

    CASE
        WHEN orders_completed >= 5
        THEN 'Feature Champion'

        WHEN orders_completed >= 1
        THEN 'Feature User'

        ELSE 'Feature Trial User'

    END AS feature_segment

FROM feature_users f

LEFT JOIN completed_orders c
    ON f.user_id = c.user_id;

-- final business summary

WITH user_classification AS (

    SELECT

        user_id,

        COUNT(*) AS total_events,

        COUNT(DISTINCT session_id) AS sessions,

        SUM(
            CASE
                WHEN event_name = 'order_complete'
                THEN 1
                ELSE 0
            END
        ) AS orders

    FROM events

    GROUP BY user_id

)

SELECT

    CASE

        WHEN total_events >= 100
            THEN 'Power User'

        WHEN total_events >= 50
            THEN 'Healthy User'

        WHEN total_events < 20
            THEN 'At Risk'

        ELSE 'Regular User'

    END AS user_segment,

    COUNT(*) AS users,

    AVG(sessions) AS avg_sessions,

    AVG(orders) AS avg_orders

FROM user_classification

GROUP BY user_segment

ORDER BY users DESC;

