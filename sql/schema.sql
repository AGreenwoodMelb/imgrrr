-- DROP DATABASE IF EXISTS imgrrrdb;

-- CREATE DATABASE imgrrrdb;

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS  albums;
DROP TABLE IF EXISTS  images;

CREATE TABLE users
(
    user_id SERIAL PRIMARY KEY,
    username TEXT,
    password TEXT,
    email TEXT
);


CREATE TABLE albums
(
    album_id SERIAL PRIMARY KEY,
    album_title TEXT,
    album_description TEXT,
    album_is_public BIT,
    album_cover_image TEXT,
    user_id BIGINT
);

CREATE TABLE images
(
    image_id SERIAL PRIMARY KEY,
    image_title TEXT,
    image_url TEXT,
    image_description TEXT,
    album_id BIGINT
    
    -- May remove later
    ,
    user_id BIGINT
    --
);


