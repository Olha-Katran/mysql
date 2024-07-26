SELECT 
	persons.id AS 'ID',
    persons.first_name AS 'First name',
    persons.last_name AS 'Last name',
    SUM(movies.budget) AS 'Total movies budget'
FROM persons
JOIN movie_characters ON persons.id = movie_characters.person_id
JOIN movies ON movie_characters.movie_id = movies.id
GROUP BY persons.id;    