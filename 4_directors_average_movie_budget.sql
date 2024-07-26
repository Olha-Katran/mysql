SELECT 
	persons.id AS 'Director ID',
    CONCAT(persons.first_name, ' ', persons.last_name) AS 'Director name',
    AVG(movies.budget) AS 'Average budget'
FROM persons
JOIN movies ON persons.id = movies.director_id
GROUP BY persons.id;    