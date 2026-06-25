USE new_project;

-- checking adoption by segment

SELECT
    u.user_segment,
    COUNT(DISTINCT e.user_id) AS adopters
FROM users u
JOIN events e
    ON u.user_id = e.user_id
WHERE e.event_name = 'group_order_click'
GROUP BY u.user_segment
ORDER BY adopters DESC;

-- total users by segment

SELECT
    user_segment,
    COUNT(*) AS users
FROM users
GROUP BY user_segment;

-- adoption rate by segment

WITH segment_users AS (

    SELECT
        user_segment,
        COUNT(*) AS total_users
    FROM users
    GROUP BY user_segment

),

segment_adopters AS (

    SELECT
        u.user_segment,
        COUNT(DISTINCT e.user_id) AS adopters
    FROM users u
    JOIN events e
        ON u.user_id = e.user_id
    WHERE e.event_name = 'group_order_click'
    GROUP BY u.user_segment

)

SELECT
    s.user_segment,
    s.total_users,
    a.adopters,
    ROUND(
        (a.adopters * 100.0) / s.total_users,
        2
    ) AS adoption_rate
FROM segment_users s
LEFT JOIN segment_adopters a
    ON s.user_segment = a.user_segment;
