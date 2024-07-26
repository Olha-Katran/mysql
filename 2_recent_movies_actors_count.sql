SELECT 
	movies.id AS 'ID',
    movies.title AS 'Title',
    COUNT(movie_characters.person_id) AS 'Actors count'
FROM movies
LEFT JOIN movie_characters ON movies.id = movie_characters.movie_id
WHERE movies.release_date >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR)
GROUP BY movies.id;     