CREATE DATABASE binary_test;
USE binary_test;

CREATE TABLE files (
	id INT AUTO_INCREMENT PRIMARY KEY,
	file_name VARCHAR(255) NOT NULL,
    mime_type VARCHAR(255) NOT NULL,
    s3_key VARCHAR(255) NOT NULL,
    url VARCHAR(255) NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE users (
	id INT AUTO_INCREMENT PRIMARY KEY,
	username VARCHAR(255) NOT NULL UNIQUE,
	first_name VARCHAR(255) NOT NULL,
	last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    avatar_file_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (avatar_file_id) REFERENCES files(id)
);

CREATE TABLE countries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE genres (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE characters (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description LONGTEXT,
    role ENUM('leading', 'supporting', 'background') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE persons (
	id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    biography LONGTEXT,
    date_of_birth DATE,
    gender ENUM('male', 'female', 'other') NOT NULL,
    country VARCHAR(255),
    primary_photo_file_id INT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,	
    FOREIGN KEY (primary_photo_file_id) REFERENCES files(id)
);

CREATE TABLE movies (
	id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description LONGTEXT,
    budget INT,
    release_date DATE,
    duration INT,
    director_id INT,
    country_id INT,
    poster_file_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (director_id) REFERENCES persons(id),
    FOREIGN KEY (poster_file_id) REFERENCES files(id),
	FOREIGN KEY (country_id) REFERENCES countries(id)
);

CREATE TABLE movie_genres (
	movie_id INT,
    genre_id INT,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (movie_id) REFERENCES movies(id),
	FOREIGN KEY (genre_id) REFERENCES genres(id),
	PRIMARY KEY (movie_id, genre_id)
);

CREATE TABLE movie_characters (
	movie_id INT,
    character_id INT,
    person_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (character_id) REFERENCES characters(id),
    FOREIGN KEY (person_id) REFERENCES persons(id)
);

CREATE TABLE user_favorites (
	user_id INT,
    movie_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    PRIMARY KEY (user_id, movie_id)
);

INSERT INTO files (file_name, mime_type, s3_key, url) VALUES
('avatar1.jpg', 'image/jpeg', 'avatars/avatar1.jpg', 'http://example.com/avatars/avatar1.jpg'),
('avatar2.jpg', 'image/jpeg', 'avatars/avatar2.jpg', 'http://example.com/avatars/avatar2.jpg'),
('avatar3.jpg', 'image/jpeg', 'avatars/avatar3.jpg', 'http://example.com/avatars/avatar3.jpg'),
('avatar4.jpg', 'image/jpeg', 'avatars/avatar4.jpg', 'http://example.com/avatars/avatar4.jpg'),
('avatar5.jpg', 'image/jpeg', 'avatars/avatar5.jpg', 'http://example.com/avatars/avatar5.jpg');

INSERT INTO files (file_name, mime_type, s3_key, url) VALUES
('photo1.jpg', 'image/jpeg', 'photos/photo1.jpg', 'http://example.com/photos/photo1.jpg'),
('photo2.jpg', 'image/jpeg', 'photos/photo2.jpg', 'http://example.com/photos/photo2.jpg'),
('photo3.jpg', 'image/jpeg', 'photos/photo3.jpg', 'http://example.com/photos/photo3.jpg'),
('photo4.jpg', 'image/jpeg', 'photos/photo4.jpg', 'http://example.com/photos/photo4.jpg'),
('photo5.jpg', 'image/jpeg', 'photos/photo5.jpg', 'http://example.com/photos/photo5.jpg');

INSERT INTO files (file_name, mime_type, s3_key, url) VALUES
('poster1.jpg', 'image/jpeg', 'posters/poster1.jpg', 'http://example.com/posters/poster1.jpg'),
('poster2.jpg', 'image/jpeg', 'posters/poster2.jpg', 'http://example.com/posters/poster2.jpg'),
('poster3.jpg', 'image/jpeg', 'posters/poster3.jpg', 'http://example.com/posters/poster3.jpg'),
('poster4.jpg', 'image/jpeg', 'posters/poster4.jpg', 'http://example.com/posters/poster4.jpg'),
('poster5.jpg', 'image/jpeg', 'posters/poster5.jpg', 'http://example.com/posters/poster5.jpg');

INSERT INTO users (username, first_name, last_name, email, password, avatar_file_id) VALUES
('user1', 'John', 'Doe', 'john.doe@example.com', 'password1', 1),
('user2', 'Jane', 'Doe', 'jane.doe@example.com', 'password2', 2),
('user3', 'Alice', 'Smith', 'alice.smith@example.com', 'password3', 3),
('user4', 'Bob', 'Johnson', 'bob.johnson@example.com', 'password4', 4),
('user5', 'Carol', 'Williams', 'carol.williams@example.com', 'password5', 5);

INSERT INTO countries (name) VALUES
('USA'),
('South Korea'),
('Japan');

INSERT INTO genres (name) VALUES
('Action'),
('Comedy'),
('Drama'),
('Horror'),
('Science Fiction');

INSERT INTO characters (name, description, role) VALUES
('Iron Man', 'A wealthy industrialist and inventor who becomes a superhero with a high-tech suit.', 'leading'),
('Black Widow', 'A skilled spy and martial artist who is a member of the Avengers.', 'supporting'),
('Joker', 'A psychopathic criminal mastermind and archenemy of Batman.', 'leading'),
('Harley Quinn', 'A former psychiatrist who becomes the Joker’s partner in crime.', 'supporting'),
('Gollum', 'A creature corrupted by the One Ring, obsessed with reclaiming it.', 'background');

INSERT INTO persons (first_name, last_name, biography, date_of_birth, gender, country, primary_photo_file_id) VALUES
('Tom', 'Hanks', 'An American actor and filmmaker.', '1956-07-09', 'male', 'USA', 1),
('Meryl', 'Streep', 'An American actress known for her versatility.', '1949-06-22', 'female', 'USA', 2),
('Leonardo', 'DiCaprio', 'An American actor and environmental activist.', '1974-11-11', 'male', 'USA', 3),
('Cate', 'Blanchett', 'An Australian actress and theatre director.', '1969-05-14', 'female', 'Australia', 4),
('Idris', 'Elba', 'An English actor, producer, and musician.', '1972-09-06', 'male', 'UK', 5),
('Joss', 'Whedon', 'An American director, producer, and screenwriter.', '1964-06-23', 'male', 'USA', NULL),
('Christopher', 'Nolan', 'A British-American film director, producer, and screenwriter.', '1970-07-30', 'male', 'UK', NULL),
('Bong', 'Joon-ho', 'A South Korean film director and screenwriter.', '1969-09-14', 'male', 'South Korea', NULL),
('Wes', 'Anderson', 'An American film director, producer, and screenwriter.', '1969-05-01', 'male', 'USA', NULL),
('Hayao', 'Miyazaki', 'A Japanese film director, producer, screenwriter, animator, and manga artist.', '1941-01-05', 'male', 'Japan', NULL);

INSERT INTO movies (title, description, budget, release_date, duration, director_id, country_id, poster_file_id) VALUES
('The Avengers', 'A group of superheroes assemble to save the world from an alien invasion.', 220000000, '2012-05-04', 143, 6, 1, 11),
('Inception', 'A skilled thief is given a chance at redemption if he can successfully perform an inception.', 160000000, '2010-07-16', 148, 7, 1, 12),
('Parasite', 'A poor family schemes to become employed by a wealthy family and infiltrate their household.', 11400000, '2019-05-30', 132, 8, 2, 13),
('The Grand Budapest Hotel', 'The misadventures of a hotel concierge and his protégé.', 50000000, '2014-03-28', 99, 9, 1, 14),
('Spirited Away', 'A young girl navigates a world of spirits and magic after her parents are transformed into pigs.', 19000000, '2001-07-20', 125, 10, 3, 15);

INSERT INTO movie_genres (movie_id, genre_id) VALUES
(1, 1),
(1, 5),
(2, 1),
(2, 5),
(3, 3),
(3, 4),
(4, 1),
(4, 2),
(5, 3),
(5, 4);

INSERT INTO movie_characters (movie_id, character_id, person_id) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 3),
(2, 1, 1),
(1, 3, 3);

INSERT INTO user_favorites (user_id, movie_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 1),
(3, 5),
(4, 2),
(4, 3),
(5, 4),
(5, 5);