USE new_project;
-- hypothesis:
-- power users should adopt more often

SELECT
    u.user_segment,
    COUNT(DISTINCT e.user_id) AS adopters
FROM users u
JOIN events e
    ON u.user_id = e.user_id
WHERE e.event_name = 'group_order_click'
GROUP BY u.user_segment
ORDER BY adopters DESC;