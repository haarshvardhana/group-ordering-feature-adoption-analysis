USE new_project;

-- how many users abandoned

SELECT
    COUNT(DISTINCT user_id)
FROM events
WHERE event_name = 'abandon';

-- abandonment by segment

SELECT
    u.user_segment,
    COUNT(DISTINCT e.user_id) AS abandoned_users
FROM users u
JOIN events e
    ON u.user_id = e.user_id
WHERE e.event_name = 'abandon'
GROUP BY u.user_segment;

-- abandonment by platform

SELECT
    platform,
    COUNT(DISTINCT user_id) AS abandoned_users
FROM events
WHERE event_name = 'abandon'
GROUP BY platform;

