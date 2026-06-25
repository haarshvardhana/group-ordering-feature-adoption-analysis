USE new_project;

-- users by platform

SELECT
    platform,
    COUNT(*) AS users
FROM users
GROUP BY platform;

-- feature clicks by platform

SELECT
    platform,
    COUNT(DISTINCT user_id) AS users
FROM events
WHERE event_name = 'group_order_click'
GROUP BY platform;

-- completed orders by platform

SELECT
    platform,
    COUNT(DISTINCT user_id) AS users
FROM events
WHERE event_name = 'order_complete'
GROUP BY platform;

-- comparing full funnel by platform

SELECT
    platform,
    event_name,
    COUNT(DISTINCT user_id) AS users
FROM events
WHERE event_name IN (
    'group_order_click',
    'invite_friend',
    'checkout',
    'order_complete'
)
GROUP BY
    platform,
    event_name
ORDER BY
    platform,
    users DESC;

