-- 1. Identify Users by Location
-- Write a query to find all posts made by users in specific locations such as
-- 'Agra', 'Maharashtra', and 'West Bengal'.

SELECT p.location, p.*
FROM users u LEFT JOIN post p
ON u.user_id = p.user_id
WHERE p.location IN ('agra', 'maharashtra', 'west bengal')
ORDER BY p.location; 

-- 2. Determine the Most Followed Hashtags
-- Write a query to list the top 5 most-followed hashtags on the platform.

SELECT h.hashtag_name,COUNT(f.follower_id) AS Total_Follower
FROM hashtags h 
JOIN hashtag_follow hf
ON h.hashtag_id = hf.hashtag_id
JOIN users u
ON hf.user_id = u.user_id
JOIN follows f
ON u.user_id = f.follower_id
GROUP BY hashtag_name
ORDER BY Total_Follower DESC
LIMIT 5;

-- 3. Find the Most Used Hashtags
-- Identify the top 10 most-used hashtags in posts.

SELECT h.hashtag_name, COUNT(pt.post_id) AS number_of_times_used
FROM hashtags h 
JOIN post_tags pt
ON h.hashtag_id = pt.hashtag_id
GROUP BY h.hashtag_name
ORDER BY number_of_times_used DESC
LIMIT 10;

-- 