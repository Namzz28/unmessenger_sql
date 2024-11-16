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

-- 4. Identify the Most Inactive User
-- Write a query to find users who have never made any posts on the
-- platform.

SELECT u.username
FROM users u
WHERE u.user_id NOT IN
(SELECT p.user_id
FROM post p);

-- 5. Identify the Posts with the Most Likes
-- Write a query to find the posts that have received the highest number of
-- likes.

SELECT post_id, COUNT(post_id) AS number_of_likes
FROM post_likes
GROUP BY post_id
ORDER BY number_of_likes DESC
LIMIT 1;

-- 6. Calculate Average Posts per User
-- Write a query to determine the average number of posts made by users.

SELECT COUNT(post_id)/ COUNT(DISTINCT(user_id)) AS average_posts_per_user
FROM post;

-- 7. Track the Number of Logins per User
-- Write a query to track the total number of logins made by each user.

SELECT u.user_id, COUNT(l.login_id) AS number_of_logins
FROM users u
JOIN login l 
ON u.user_id = l.user_id
GROUP BY u.user_id
ORDER BY u.user_id;

-- 8. Identify a User Who Liked Every Single Post
-- Write a query to find any user who has liked every post on the platform.

SELECT u.username
FROM users u
JOIN post_likes pl
ON u.user_id = pl.user_id
GROUP BY pl.user_id
HAVING COUNT(DISTINCT(u.user_id)) = COUNT(pl.post_id);

-- There is no user who has liked every single post.

-- 9. Find Users Who Never Commented
-- Write a query to find users who have never commented on any post.

SELECT u.username
FROM users u
WHERE u.user_id 
NOT IN(SELECT c.user_id
FROM comments c);

-- 10. Identify a User Who Commented on Every Post
-- Write a query to find any user who has commented on every post on the
-- platform. 

SELECT u.username
FROM users u
JOIN comments c
ON u.user_id = c.user_id
GROUP BY c.user_id
HAVING COUNT(DISTINCT(c.user_id))= COUNT(c.comment_id);

-- 11. Identify Users Not Followed by Anyone
-- Write a query to find users who are not followed by any other users.

SELECT u.username
FROM users u
JOIN follows f
ON u.user_id = f.followee_id
GROUP BY f.followee_id
HAVING COUNT(f.follower_id) = 0;

-- 12. Identify Users Who Are Not Following Anyone
-- Write a query to find users who are not following anyone.

SELECT u.username
FROM users u
JOIN follows f
ON u.user_id = f.follower_id
GROUP BY f.follower_id
HAVING COUNT(f.followee_id) = 0;

-- 13. Find Users Who Have Posted More than 5 Times
-- Write a query to find users who have made more than five posts.

SELECT u.username, COUNT(p.post_id) AS `Number of Posts`
FROM users u
JOIN post p
ON u.user_id = p.user_id
GROUP BY u.username
HAVING COUNT(p.post_id) > 5;

-- 14. Identify Users with More than 40 Followers
-- Write a query to find users who have more than 40 followers.

SELECT u.username, f.follower_id
FROM users u
JOIN follows f
ON u.user_id = f.follower_id
GROUP BY u.username
HAVING f.follower_id > 40;

-- 15. Search for Specific Words in Comments
-- Write a query to find comments containing specific words like "good" or
-- "beautiful."

SELECT comment_text
FROM comments
WHERE comment_text LIKE '%good%'
OR comment_text LIKE '%beautiful%';

-- 16. Identify the Longest Captions in Posts
-- Write a query to find the posts with the longest captions.

SELECT caption, LENGTH(caption) AS `Length of Caption`
FROM post
ORDER BY `Length of Caption` DESC
LIMIT 5;
