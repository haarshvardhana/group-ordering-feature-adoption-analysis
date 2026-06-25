USE new_project;
WITH ordered_events AS (

SELECT
    user_id,
    event_time,
    event_name,

    LEAD(event_name) OVER(
        PARTITION BY user_id
        ORDER BY event_time
    ) AS next_event

FROM events

)

SELECT
    event_name,
    next_event,
    COUNT(*) AS transitions
FROM ordered_events
GROUP BY
    event_name,
    next_event
ORDER BY transitions DESC;