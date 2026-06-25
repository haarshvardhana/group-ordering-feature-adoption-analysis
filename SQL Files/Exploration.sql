USE new_project;

ALTER DATABASE new_proejct RENAME TO new_project;

-- loaded both tables successfully

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

-- seeing if every user exists in events

SELECT
    COUNT(DISTINCT user_id)
FROM events
WHERE user_id NOT IN (
    SELECT user_id
    FROM users
);

-- checking duplicate users

SELECT
    user_id,
    COUNT(*)
FROM users
GROUP BY user_id
HAVING COUNT(*) > 1;

-- checking signup date range

SELECT
    MIN(signup_date),
    MAX(signup_date)
FROM users;

-- checking event date range

SELECT
    MIN(event_time),
    MAX(event_time)
FROM events;

-- looking at platforms

SELECT DISTINCT platform
FROM users;

SELECT DISTINCT platform
FROM events;

-- checking segments

SELECT DISTINCT user_segment
FROM users;

-- event names available

SELECT DISTINCT event_name
FROM events
ORDER BY event_name;

-- event distribution

SELECT
    event_name,
    COUNT(*) AS total_events
FROM events
GROUP BY event_name
ORDER BY total_events DESC;

-- unique users by event

SELECT
    event_name,
    COUNT(DISTINCT user_id) AS users
FROM events
GROUP BY event_name
ORDER BY users DESC;

-- checking if any null event names

SELECT *
FROM events
WHERE event_name IS NULL;

-- checking if user_id missing

SELECT *
FROM events
WHERE user_id IS NULL;

-- checking session ids

SELECT COUNT(DISTINCT session_id)
FROM events;

-- average events per session

SELECT
    AVG(event_count)
FROM (

    SELECT
        session_id,
        COUNT(*) AS event_count
    FROM events
    GROUP BY session_id

);

-- biggest sessions

SELECT
    session_id,
    COUNT(*) AS total_events
FROM events
GROUP BY session_id
ORDER BY total_events DESC
LIMIT 20;

-- events by platform

SELECT
    platform,
    COUNT(*) AS events
FROM events
GROUP BY platform;

-- users by platform

SELECT
    platform,
    COUNT(*) AS users
FROM users
GROUP BY platform;

-- users by segment

SELECT
    user_segment,
    COUNT(*) AS users
FROM users
GROUP BY user_segment;

-- checking city distribution

SELECT
    city,
    COUNT(*) AS users
FROM users
GROUP BY city
ORDER BY users DESC;

-- top cities

SELECT
    city,
    COUNT(*)
FROM users
GROUP BY city
ORDER BY COUNT(*) DESC
LIMIT 10;

-- trying to understand activity levels

SELECT
    user_id,
    COUNT(*) AS total_events
FROM events
GROUP BY user_id
ORDER BY total_events DESC
LIMIT 20;

-- least active users

SELECT
    user_id,
    COUNT(*) AS total_events
FROM events
GROUP BY user_id
ORDER BY total_events ASC
LIMIT 20;

-- average events per user

SELECT
    AVG(event_count)
FROM (

    SELECT
        user_id,
        COUNT(*) AS event_count
    FROM events
    GROUP BY user_id

);

-- checking restaurant views

SELECT
    COUNT(*)
FROM events
WHERE event_name = 'restaurant_view';

-- checking feature clicks

SELECT
    COUNT(*)
FROM events
WHERE event_name = 'group_order_click';

-- checking completed orders

SELECT
    COUNT(*)
FROM events
WHERE event_name = 'order_complete';

-- checking abandons

SELECT
    COUNT(*)
FROM events
WHERE event_name = 'abandon';

-- users who clicked feature

SELECT
    COUNT(DISTINCT user_id)
FROM events
WHERE event_name = 'group_order_click';

-- users who completed orders

SELECT
    COUNT(DISTINCT user_id)
FROM events
WHERE event_name = 'order_complete';

-- first look at invite related events

SELECT DISTINCT event_name
FROM events
WHERE event_name ILIKE '%invite%';

-- how many invite events exist

SELECT
    event_name,
    COUNT(*)
FROM events
WHERE event_name ILIKE '%invite%'
GROUP BY event_name;

-- checking hourly distribution

SELECT
    EXTRACT(HOUR FROM event_time) AS hour_of_day,
    COUNT(*) AS total_events
FROM events
GROUP BY hour_of_day
ORDER BY hour_of_day;

-- daily activity

SELECT
    DATE(event_time) AS activity_date,
    COUNT(*) AS events
FROM events
GROUP BY activity_date
ORDER BY activity_date;

-- daily active users

SELECT
    DATE(event_time) AS activity_date,
    COUNT(DISTINCT user_id) AS dau
FROM events
GROUP BY activity_date
ORDER BY activity_date;

-- checking users with no activity

SELECT
    COUNT(*)
FROM users
WHERE user_id NOT IN (
    SELECT DISTINCT user_id
    FROM events
);

-- checking platform consistency

SELECT
    u.platform,
    COUNT(*)
FROM users u
GROUP BY u.platform;

-- random sample of feature users

SELECT DISTINCT user_id
FROM events
WHERE event_name = 'group_order_click'
LIMIT 50;

-- random sample of completed users

SELECT DISTINCT user_id
FROM events
WHERE event_name = 'order_complete'
LIMIT 50;

-- just exploring event timeline

SELECT
    user_id,
    event_time,
    event_name
FROM events
ORDER BY event_time
LIMIT 100;
