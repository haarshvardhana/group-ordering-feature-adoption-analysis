USE new_project;
-- first look

SELECT *
FROM users
LIMIT 20;

SELECT *
FROM events
LIMIT 20;

-- checking row counts

SELECT COUNT(*)
FROM users;

SELECT COUNT(*)
FROM events;

-- checking distinct users

SELECT COUNT(DISTINCT user_id)
FROM users;

SELECT COUNT(DISTINCT user_id)
FROM events;

-- checking platforms

SELECT DISTINCT platform
FROM users;

-- checking segments

SELECT DISTINCT user_segment
FROM users;

-- checking event names

SELECT DISTINCT event_name
FROM events
ORDER BY event_name;