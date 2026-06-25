USE new_project;

-- finding first activity date for each user

WITH first_activity AS (

    SELECT
        user_id,
        MIN(DATE(event_time)) AS cohort_date
    FROM events
    GROUP BY user_id

)

SELECT *
FROM first_activity
LIMIT 20;

-- cohort sizes

WITH first_activity AS (

    SELECT
        user_id,
        MIN(DATE(event_time)) AS cohort_date
    FROM events
    GROUP BY user_id

)

SELECT
    cohort_date,
    COUNT(*) AS users
FROM first_activity
GROUP BY cohort_date
ORDER BY cohort_date;

-- trying to calculate days since first activity

WITH first_activity AS (

    SELECT
        user_id,
        MIN(DATE(event_time)) AS cohort_date
    FROM events
    GROUP BY user_id

)

SELECT
    f.user_id,
    f.cohort_date,
    DATE(e.event_time) AS activity_date,

    DATEDIFF(
        day,
        f.cohort_date,
        DATE(e.event_time)
    ) AS days_after_signup

FROM events e
JOIN first_activity f
    ON e.user_id = f.user_id;

WITH first_activity AS (

    SELECT
        user_id,
        MIN(DATE(event_time)) AS cohort_date
    FROM events
    GROUP BY user_id

)

SELECT
    f.user_id,
    f.cohort_date,
    DATE(e.event_time) AS activity_date,

    DATEDIFF(
        day,
        f.cohort_date,
        DATE(e.event_time)
    ) AS days_after_signup

FROM events e
JOIN first_activity f
    ON e.user_id = f.user_id

WHERE f.user_id IN (
    SELECT user_id
    FROM users
    LIMIT 5
)

ORDER BY
    f.user_id,
    activity_date;


-- counting retained users by cohort and day

WITH first_activity AS (

    SELECT
        user_id,
        MIN(DATE(event_time)) AS cohort_date
    FROM events
    GROUP BY user_id

),

retention_data AS (

    SELECT
        f.user_id,
        f.cohort_date,

        DATEDIFF(
            day,
            f.cohort_date,
            DATE(e.event_time)
        ) AS days_after_signup

    FROM events e
    JOIN first_activity f
        ON e.user_id = f.user_id

)

SELECT
    cohort_date,
    days_after_signup,
    COUNT(DISTINCT user_id) AS retained_users
FROM retention_data
GROUP BY
    cohort_date,
    days_after_signup
ORDER BY
    cohort_date,
    days_after_signup;


-- cohort matrix

WITH first_activity AS (

    SELECT
        user_id,
        MIN(DATE(event_time)) AS cohort_date
    FROM events
    GROUP BY user_id

),

retention_data AS (

    SELECT
        f.user_id,
        f.cohort_date,

        DATEDIFF(
            day,
            f.cohort_date,
            DATE(e.event_time)
        ) AS days_after_signup

    FROM events e
    JOIN first_activity f
        ON e.user_id = f.user_id

)

SELECT
    cohort_date,

    COUNT(DISTINCT CASE
        WHEN days_after_signup = 0
        THEN user_id
    END) AS day_0,

    COUNT(DISTINCT CASE
        WHEN days_after_signup = 1
        THEN user_id
    END) AS day_1,

    COUNT(DISTINCT CASE
        WHEN days_after_signup = 7
        THEN user_id
    END) AS day_7,

    COUNT(DISTINCT CASE
        WHEN days_after_signup = 14
        THEN user_id
    END) AS day_14,

    COUNT(DISTINCT CASE
        WHEN days_after_signup = 30
        THEN user_id
    END) AS day_30

FROM retention_data
GROUP BY cohort_date
ORDER BY cohort_date;

-- checking retention for users who adopted group ordering

WITH feature_users AS (

    SELECT DISTINCT user_id
    FROM events
    WHERE event_name = 'group_order_click'

),

first_activity AS (

    SELECT
        user_id,
        MIN(DATE(event_time)) AS cohort_date
    FROM events
    GROUP BY user_id

),

retention_data AS (

    SELECT
        f.user_id,
        f.cohort_date,

        DATEDIFF(
            day,
            f.cohort_date,
            DATE(e.event_time)
        ) AS days_after_signup

    FROM events e
    JOIN first_activity f
        ON e.user_id = f.user_id
    JOIN feature_users fu
        ON e.user_id = fu.user_id

)

SELECT
    cohort_date,

    COUNT(DISTINCT CASE
        WHEN days_after_signup = 1
        THEN user_id
    END) AS day_1,

    COUNT(DISTINCT CASE
        WHEN days_after_signup = 7
        THEN user_id
    END) AS day_7,

    COUNT(DISTINCT CASE
        WHEN days_after_signup = 30
        THEN user_id
    END) AS day_30

FROM retention_data
GROUP BY cohort_date
ORDER BY cohort_date;

