SELECT 
	users.id AS 'ID',
    users.username AS 'Username',
    GROUP_CONCAT(user_favorites.movie_id) AS 'Favorite movie IDs'
FROM users
LEFT JOIN user_favorites ON users.id = user_favorites.user_id
GROUP BY users.id;    