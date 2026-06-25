USE new_project;
-- wanted to see overall event distribution

SELECT
    event_name,
    COUNT(*) AS total_events
FROM events
GROUP BY event_name
ORDER BY total_events DESC;

-- unique users per event

SELECT
    event_name,
    COUNT(DISTINCT user_id) AS users
FROM events
GROUP BY event_name
ORDER BY users DESC;

-- checking average events per user

SELECT
    AVG(event_count)
FROM (

    SELECT
        user_id,
        COUNT(*) AS event_count
    FROM events
    GROUP BY user_id

);