-- Setup
CREATE DATABASE IF NOT EXISTS socialmedia;
USE socialmedia;

-- Tables
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    email VARCHAR(100),
    full_name VARCHAR(100),
    city VARCHAR(100),
    birth_date DATE,
    joined_date DATE,
    followers_count INT DEFAULT 0,
    following_count INT DEFAULT 0
);

CREATE TABLE posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    content TEXT,
    post_date DATETIME,
    likes_count INT DEFAULT 0,
    comments_count INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    user_id INT,
    content TEXT,
    comment_date DATETIME,
    FOREIGN KEY (post_id) REFERENCES posts(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE likes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    user_id INT,
    liked_date DATETIME,
    FOREIGN KEY (post_id) REFERENCES posts(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE followers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    follower_id INT,
    following_id INT,
    follow_date DATE,
    FOREIGN KEY (follower_id) REFERENCES users(id),
    FOREIGN KEY (following_id) REFERENCES users(id)
);

CREATE TABLE messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT,
    receiver_id INT,
    content TEXT,
    sent_date DATETIME,
    is_read BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (sender_id) REFERENCES users(id),
    FOREIGN KEY (receiver_id) REFERENCES users(id)
);

-- Insert Data
INSERT INTO users (username, email, full_name, city, birth_date, joined_date, followers_count, following_count) VALUES
('alice99', 'alice@email.com', 'Alice Smith', 'Paris', '1999-05-15', '2022-01-10', 1500, 300),
('bob_dev', 'bob@email.com', 'Bob Johnson', 'London', '1995-08-20', '2021-06-15', 3000, 500),
('charlie_x', 'charlie@email.com', 'Charlie Brown', 'Berlin', '2000-03-10', '2023-02-20', 800, 200),
('diana_art', 'diana@email.com', 'Diana Davis', 'Paris', '1998-11-25', '2022-08-05', 5000, 1000),
('eve_codes', 'eve@email.com', 'Eve Wilson', 'London', '1997-07-30', '2021-03-12', 2500, 400),
('frank_music', 'frank@email.com', 'Frank Miller', 'Berlin', '1996-01-18', '2020-11-08', 10000, 800);

INSERT INTO posts (user_id, content, post_date, likes_count, comments_count) VALUES
(1, 'Hello world! My first post!', '2024-01-10 10:00:00', 150, 20),
(2, 'Just deployed my new app!', '2024-01-12 14:30:00', 300, 45),
(3, 'Berlin is amazing today!', '2024-01-15 09:00:00', 80, 10),
(4, 'New artwork coming soon!', '2024-01-18 16:00:00', 500, 80),
(5, 'Learning SQL is so fun!', '2024-02-01 11:00:00', 200, 30),
(6, 'New music track dropping tonight!', '2024-02-05 20:00:00', 1000, 150),
(1, 'Paris sunsets are beautiful!', '2024-02-10 18:00:00', 250, 35),
(2, 'Tips for clean code', '2024-02-15 10:00:00', 400, 60),
(4, 'My latest painting is done!', '2024-02-20 15:00:00', 800, 120),
(5, 'SQL joins explained simply!', '2024-03-01 09:00:00', 350, 55);

INSERT INTO comments (post_id, user_id, content, comment_date) VALUES
(1, 2, 'Welcome to the platform!', '2024-01-10 10:30:00'),
(1, 3, 'Great first post!', '2024-01-10 11:00:00'),
(2, 1, 'Amazing work Bob!', '2024-01-12 15:00:00'),
(4, 5, 'Cannot wait to see it!', '2024-01-18 17:00:00'),
(5, 1, 'SQL is the best!', '2024-02-01 12:00:00'),
(6, 3, 'This track is fire!', '2024-02-05 21:00:00'),
(8, 5, 'Very helpful tips!', '2024-02-15 11:00:00'),
(9, 2, 'Absolutely stunning!', '2024-02-20 16:00:00'),
(10, 3, 'Great explanation!', '2024-03-01 10:00:00');

INSERT INTO likes (post_id, user_id, liked_date) VALUES
(1, 2, '2024-01-10 10:15:00'),
(1, 3, '2024-01-10 10:20:00'),
(2, 1, '2024-01-12 14:45:00'),
(4, 1, '2024-01-18 16:30:00'),
(4, 2, '2024-01-18 17:00:00'),
(5, 2, '2024-02-01 11:30:00'),
(6, 1, '2024-02-05 20:30:00'),
(6, 4, '2024-02-05 21:00:00'),
(9, 5, '2024-02-20 15:30:00'),
(10, 1, '2024-03-01 09:30:00');

INSERT INTO followers (follower_id, following_id, follow_date) VALUES
(1, 2, '2024-01-11'),
(1, 4, '2024-01-12'),
(2, 1, '2024-01-13'),
(3, 2, '2024-01-14'),
(3, 6, '2024-01-15'),
(4, 6, '2024-01-16'),
(5, 2, '2024-01-17'),
(5, 4, '2024-01-18'),
(6, 4, '2024-01-19');

INSERT INTO messages (sender_id, receiver_id, content, sent_date, is_read) VALUES
(1, 2, 'Hey Bob! Love your posts!', '2024-01-15 10:00:00', TRUE),
(2, 1, 'Thanks Alice! Follow me back!', '2024-01-15 10:30:00', TRUE),
(3, 6, 'Frank your music is amazing!', '2024-02-06 09:00:00', TRUE),
(4, 5, 'Eve lets collaborate!', '2024-02-16 14:00:00', FALSE),
(5, 4, 'Diana I love your art!', '2024-02-21 10:00:00', FALSE),
(6, 3, 'Thanks Charlie!', '2024-02-06 10:00:00', TRUE);




-- QUERIES






-- 1. Show all users and their cities
SELECT username, full_name, city FROM users;

-- 2. Show most followed users
SELECT username, followers_count FROM users
ORDER BY followers_count DESC;

-- 3. Show all posts with username
SELECT users.username, posts.content, 
posts.likes_count, posts.post_date
FROM posts
INNER JOIN users ON posts.user_id = users.id;

-- 4. Show most liked posts
SELECT users.username, posts.content, posts.likes_count
FROM posts
INNER JOIN users ON posts.user_id = users.id
ORDER BY posts.likes_count DESC;

-- 5. Show all comments on each post
SELECT posts.content, users.username AS commenter,
comments.content AS comment
FROM comments
INNER JOIN posts ON comments.post_id = posts.id
INNER JOIN users ON comments.user_id = users.id;

-- 6. Show who follows who
SELECT u1.username AS follower, u2.username AS following
FROM followers
INNER JOIN users u1 ON followers.follower_id = u1.id
INNER JOIN users u2 ON followers.following_id = u2.id;

-- 7. Show unread messages
SELECT u1.username AS sender, u2.username AS receiver,
messages.content, messages.sent_date
FROM messages
INNER JOIN users u1 ON messages.sender_id = u1.id
INNER JOIN users u2 ON messages.receiver_id = u2.id
WHERE messages.is_read = FALSE;

-- 8. Count posts per user
SELECT users.username, COUNT(*) AS total_posts
FROM posts
INNER JOIN users ON posts.user_id = users.id
GROUP BY users.username
ORDER BY total_posts DESC;

-- 9. Show users from Paris
SELECT username, full_name, followers_count
FROM users WHERE city = 'Paris';

-- 10. Show total likes per user
SELECT users.username, SUM(posts.likes_count) AS total_likes
FROM posts
INNER JOIN users ON posts.user_id = users.id
GROUP BY users.username
ORDER BY total_likes DESC;