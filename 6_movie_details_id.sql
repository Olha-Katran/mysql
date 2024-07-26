SELECT
    movies.id AS movie_id,
    movies.title AS title,
    movies.release_date AS release_date,
    movies.duration AS duration,
    movies.description AS description,
    JSON_OBJECT(
        'id', poster.id,
        'file_name', poster.file_name,
        'mime_type', poster.mime_type,
        's3_key', poster.s3_key,
        'url', poster.url
    ) AS poster,
    JSON_OBJECT(
        'id', director.id,
        'first_name', director.first_name,
        'last_name', director.last_name,
        'photo', JSON_OBJECT(
            'id', director_photo.id,
            'file_name', director_photo.file_name,
            'mime_type', director_photo.mime_type,
            's3_key', director_photo.s3_key,
            'url', director_photo.url
        )
    ) AS director,
    JSON_ARRAYAGG(
        JSON_OBJECT(
            'id', actor.id,
            'first_name', actor.first_name,
            'last_name', actor.last_name,
            'photo', JSON_OBJECT(
                'id', actor_photo.id,
                'file_name', actor_photo.file_name,
                'mime_type', actor_photo.mime_type,
                's3_key', actor_photo.s3_key,
                'url', actor_photo.url
            )
        )
    ) AS actors,
    JSON_ARRAYAGG(
        JSON_OBJECT(
            'id', genres.id,
            'name', genres.name
        )
    ) AS genres
FROM
    movies
    JOIN files AS poster ON movies.poster_file_id = poster.id
    JOIN persons AS director ON movies.director_id = director.id
    LEFT JOIN files AS director_photo ON director.primary_photo_file_id = director_photo.id
    LEFT JOIN movie_characters ON movies.id = movie_characters.movie_id
    LEFT JOIN characters ON movie_characters.character_id = characters.id
    LEFT JOIN persons AS actor ON movie_characters.person_id = actor.id
    LEFT JOIN files AS actor_photo ON actor.primary_photo_file_id = actor_photo.id
    JOIN movie_genres ON movies.id = movie_genres.movie_id
    JOIN genres ON movie_genres.genre_id = genres.id
WHERE
    movies.id = 1
GROUP BY
    movies.id;
