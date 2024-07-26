# ER Diagram

```mermaid
erDiagram
    FILES {
        int id PK
        string file_name
        string mime_type
        string s3_key
        string url
        timestamp created_at
        timestamp updated_at
    }
    
    USERS {
        int id PK
        string username
        string first_name
        string last_name
        string email
        string password
        int avatar_file_id FK
        timestamp created_at
        timestamp updated_at
    }

    COUNTRIES {
        int id PK
        string name
        timestamp created_at
        timestamp updated_at
    }

    GENRES {
        int id PK
        string name
        timestamp created_at
        timestamp updated_at
    }

    CHARACTERS {
        int id PK
        string name
        longtext description
        enum role
        timestamp created_at
        timestamp updated_at
    }

    PERSONS {
        int id PK
        string first_name
        string last_name
        longtext biography
        date date_of_birth
        enum gender
        string country
        int primary_photo_file_id FK
        timestamp created_at
        timestamp updated_at
    }

    MOVIES {
        int id PK
        string title
        longtext description
        int budget
        date release_date
        int duration
        int director_id FK
        int country_id FK
        int poster_file_id FK
        timestamp created_at
        timestamp updated_at
    }

    MOVIE_GENRES {
        int movie_id PK, FK
        int genre_id PK, FK
        timestamp created_at
        timestamp updated_at
    }

    MOVIE_CHARACTERS {
        int movie_id PK, FK
        int character_id PK, FK
        int person_id PK, FK
        timestamp created_at
        timestamp updated_at
    }

    USER_FAVORITES {
        int user_id PK, FK
        int movie_id PK, FK
        timestamp created_at
        timestamp updated_at
    }

    FILES ||--o{ USERS : "has"
    USERS ||--o{ USER_FAVORITES : "favorites"
    MOVIES ||--o{ USER_FAVORITES : "is favorited by"
    COUNTRIES ||--o{ MOVIES : "belongs to"
    PERSONS ||--o{ MOVIES : "directed by"
    FILES ||--o{ MOVIES : "poster"
    MOVIES ||--o{ MOVIE_GENRES : "has"
    GENRES ||--o{ MOVIE_GENRES : "belongs to"
    MOVIES ||--o{ MOVIE_CHARACTERS : "features"
    CHARACTERS ||--o{ MOVIE_CHARACTERS : "appears in"
    PERSONS ||--o{ MOVIE_CHARACTERS : "portrayed by"
    FILES ||--o{ PERSONS : "has"
    COUNTRIES ||--o{ PERSONS : "belongs to"
