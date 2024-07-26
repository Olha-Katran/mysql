SELECT
    movies.id AS movie_id,
    movies.title AS title,
    movies.release_date AS release_date,
    movies.duration AS duration,
    movies.description AS description,
    JSON_OBJECT(
        'id', files.id,
        'file_name', files.file_name,
        'mime_type', files.mime_type,
        's3_key', files.s3_key,
        'url', files.url
    ) AS poster,
    JSON_OBJECT(
        'id', director.id,
        'first_name', director.first_name,
        'last_name', director.last_name
    ) AS director
FROM
    movies
    JOIN files ON movies.poster_file_id = files.id
    JOIN persons AS director ON movies.director_id = director.id
    JOIN movie_genres ON movies.id = movie_genres.movie_id
    JOIN genres ON movie_genres.genre_id = genres.id
WHERE
    movies.country_id = 1
    AND movies.release_date >= '2022-01-01'
    AND movies.duration > 135
    AND genres.name IN ('Action', 'Drama')
GROUP BY
    movies.id;
