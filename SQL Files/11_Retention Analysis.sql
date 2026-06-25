USE new_project;

-- checking date range first

SELECT
    MIN(event_time) AS first_event,
    MAX(event_time) AS last_event
FROM events;

-- how many active days do we have

SELECT
    COUNT(DISTINCT DATE(event_time)) AS active_days
FROM events;

-- checking daily active users

SELECT
    DATE(event_time) AS activity_date,
    COUNT(DISTINCT user_id) AS dau
FROM events
GROUP BY DATE(event_time)
ORDER BY activity_date;

-- wanted to see if feature users are actually more active

WITH feature_users AS (

    SELECT DISTINCT user_id
    FROM events
    WHERE event_name = 'group_order_click'

)

SELECT
    COUNT(*) AS feature_users
FROM feature_users;

-- checking how many events feature users generate

WITH feature_users AS (

    SELECT DISTINCT user_id
    FROM events
    WHERE event_name = 'group_order_click'

)

SELECT
    AVG(user_events) AS avg_events_per_user
FROM (

    SELECT
        e.user_id,
        COUNT(*) AS user_events
    FROM events e
    JOIN feature_users f
        ON e.user_id = f.user_id
    GROUP BY e.user_id

);

-- comparing against non feature users

WITH feature_users AS (

    SELECT DISTINCT user_id
    FROM events
    WHERE event_name = 'group_order_click'

),

non_feature_users AS (

    SELECT DISTINCT user_id
    FROM users
    WHERE user_id NOT IN (
        SELECT user_id
        FROM feature_users
    )

)

SELECT
    AVG(user_events) AS avg_events_per_user
FROM (

    SELECT
        e.user_id,
        COUNT(*) AS user_events
    FROM events e
    JOIN non_feature_users n
        ON e.user_id = n.user_id
    GROUP BY e.user_id

);

-- are users coming back after first interaction?

WITH first_activity AS (

    SELECT
        user_id,
        MIN(DATE(event_time)) AS first_day
    FROM events
    GROUP BY user_id

)

SELECT
    COUNT(DISTINCT e.user_id) AS returned_users
FROM events e
JOIN first_activity f
    ON e.user_id = f.user_id
WHERE DATE(e.event_time) > f.first_day;

-- feature users returning

WITH feature_users AS (

    SELECT DISTINCT user_id
    FROM events
    WHERE event_name = 'group_order_click'

),

first_activity AS (

    SELECT
        user_id,
        MIN(DATE(event_time)) AS first_day
    FROM events
    GROUP BY user_id

)

SELECT
    COUNT(DISTINCT e.user_id) AS returned_users
FROM events e
JOIN first_activity f
    ON e.user_id = f.user_id
JOIN feature_users fu
    ON e.user_id = fu.user_id
WHERE DATE(e.event_time) > f.first_day;

-- first attempt at day 7 retention

WITH first_visit AS (

    SELECT
        user_id,
        MIN(DATE(event_time)) AS signup_day
    FROM events
    GROUP BY user_id

)

SELECT
    COUNT(DISTINCT e.user_id) AS retained_users
FROM events e
JOIN first_visit f
    ON e.user_id = f.user_id
WHERE DATEDIFF(
        day,
        f.signup_day,
        DATE(e.event_time)
      ) = 7;

-- checking day 1 retention too

WITH first_visit AS (

    SELECT
        user_id,
        MIN(DATE(event_time)) AS signup_day
    FROM events
    GROUP BY user_id

)

SELECT
    COUNT(DISTINCT e.user_id) AS retained_users
FROM events e
JOIN first_visit f
    ON e.user_id = f.user_id
WHERE DATEDIFF(
        day,
        f.signup_day,
        DATE(e.event_time)
      ) = 1;

-- hypothesis:
-- users who try group ordering
-- should come back more often

WITH feature_users AS (

    SELECT DISTINCT user_id
    FROM events
    WHERE event_name = 'group_order_click'

),

first_visit AS (

    SELECT
        user_id,
        MIN(DATE(event_time)) AS signup_day
    FROM events
    GROUP BY user_id

)

SELECT
    COUNT(DISTINCT e.user_id) AS retained_users
FROM events e
JOIN first_visit f
    ON e.user_id = f.user_id
JOIN feature_users fu
    ON e.user_id = fu.user_id
WHERE DATEDIFF(
        day,
        f.signup_day,
        DATE(e.event_time)
      ) = 7;

-- who are the power users?

SELECT
    user_id,
    COUNT(*) AS total_events
FROM events
GROUP BY user_id
ORDER BY total_events DESC
LIMIT 100;

-- creating rough power user buckets

WITH user_activity AS (

    SELECT
        user_id,
        COUNT(*) AS total_events
    FROM events
    GROUP BY user_id

)

SELECT
    CASE
        WHEN total_events >= 100 THEN 'Power User'
        WHEN total_events >= 50 THEN 'Regular User'
        ELSE 'Casual User'
    END AS user_type,

    COUNT(*) AS users

FROM user_activity
GROUP BY user_type;

-- are power users adopting group ordering?

WITH user_activity AS (

    SELECT
        user_id,
        COUNT(*) AS total_events
    FROM events
    GROUP BY user_id

),

segments AS (

    SELECT
        user_id,

        CASE
            WHEN total_events >= 100 THEN 'Power User'
            WHEN total_events >= 50 THEN 'Regular User'
            ELSE 'Casual User'
        END AS user_type

    FROM user_activity

)

SELECT
    s.user_type,
    COUNT(DISTINCT e.user_id) AS adopters
FROM events e
JOIN segments s
    ON e.user_id = s.user_id
WHERE event_name = 'group_order_click'
GROUP BY s.user_type;


