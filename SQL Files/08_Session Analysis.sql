USE new_project;

-- building session duration table

SELECT
    session_id,
    user_id,
    MIN(event_time) AS session_start,
    MAX(event_time) AS session_end,
    DATEDIFF(
        minute,
        MIN(event_time),
        MAX(event_time)
    ) AS duration_minutes
FROM events
GROUP BY
    session_id,
    user_id;

    -- average session duration

WITH sessions AS (

SELECT
    session_id,
    user_id,
    DATEDIFF(
        minute,
        MIN(event_time),
        MAX(event_time)
    ) AS duration_minutes
FROM events
GROUP BY
    session_id,
    user_id

)

SELECT
    AVG(duration_minutes)
FROM sessions;

