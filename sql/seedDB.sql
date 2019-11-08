TRUNCATE USERS;
TRUNCATE ALBUMS;
TRUNCATE IMAGES;

-- ALTER SEQUENCE USERS.user_id RESTART WITH 1;
-- ALTER SEQUENCE ABLUMS.album_id RESTART WITH 1;
-- ALTER SEQUENCE IMAGES.image_id RESTART WITH 1;

INSERT INTO albums
    (album_title, album_description, album_is_public, album_cover_image, user_id)
VALUES
    ('Test', 'Testing album', '1', 'https://i.imgur.com/QDS5SM8.jpg', 1);
INSERT INTO albums
    (album_title, album_description, album_is_public, album_cover_image, user_id)
VALUES
    ('Test2', 'Testing album2', '1', 'https://i.imgur.com/QDS5SM8.jpg', 1);
INSERT INTO albums
    (album_title, album_description, album_is_public, album_cover_image, user_id)
VALUES
    ('Test3', 'Testing album3', '1', 'https://i.imgur.com/QDS5SM8.jpg', 2);
INSERT INTO albums
    (album_title, album_description, album_is_public, album_cover_image, user_id)
VALUES
    ('Test4', 'Testing private album', '0', 'https://i.imgur.com/QDS5SM8.jpg', 2);


INSERT INTO users
    (username,password,email)
VALUES
    ('admin', 'admin', 'e@m.ail');
INSERT INTO users
    (username,password,email)
VALUES
    ('test1', 'testpassword', 'e@m.ail');
INSERT INTO users
    (username,password,email)
VALUES
    ('test2', 'testpassword', 'a@m.ail');
INSERT INTO users
    (username,password,email)
VALUES
    ('test3', 'testpassword', 'b@m.ail');
INSERT INTO users
    (username,password,email)
VALUES
    ('test4', 'testpassword', 'c@m.ail');


INSERT INTO images
    (image_title, image_url, image_description, album_id, user_id)
VALUES
    ('Test1', 'https://i.imgur.com/QDS5SM8.jpg', 'Test Image', 1, 1);
INSERT INTO images
    (image_title, image_url, image_description, album_id, user_id)
VALUES
    ('Test2', 'https://i.imgur.com/QDS5SM8.jpg', 'Test Image', 1, 1);
INSERT INTO images
    (image_title, image_url, image_description, album_id, user_id)
VALUES
    ('Test3', 'https://i.imgur.com/QDS5SM8.jpg', 'Test Image', 3, 2);
INSERT INTO images
    (image_title, image_url, image_description, album_id, user_id)
VALUES
    ('Test3', 'https://i.imgur.com/QDS5SM8.jpg', 'Test Image Different Album', 2, 1);
