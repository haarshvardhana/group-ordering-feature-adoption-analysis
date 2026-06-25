USE new_project;
-- first attempt

SELECT
    event_name,
    COUNT(DISTINCT user_id)
FROM events
WHERE event_name IN (
    'restaurant_view',
    'group_order_click',
    'invite_friend',
    'checkout',
    'order_complete'
)
GROUP BY event_name;

-- realized invite events may have variants

SELECT DISTINCT event_name
FROM events
WHERE event_name ILIKE '%invite%';

-- rebuilt funnel after validation

WITH funnel AS (

SELECT
    event_name,
    COUNT(DISTINCT user_id) AS users
FROM events
WHERE event_name IN (
    'restaurant_view',
    'group_order_click',
    'invite_sent_to_friend_1',
    'checkout',
    'order_complete'
)
GROUP BY event_name

)

SELECT *
FROM funnel;
