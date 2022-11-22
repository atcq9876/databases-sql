-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE albums RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO albums (title, release_year, artist_id) VALUES ('Doolittle', '1989', '1');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Surfer Rosa', '1988', '1');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Waterloo', '1972', '2');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Super Trouper', '1980', '2');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Bossanova', '1990', '1');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Lover', '2019', '3');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Folklore', '2020', '3');
INSERT INTO albums (title, release_year, artist_id) VALUES ('I Put a Spell on You', '1965', '4');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Baltimore', '1978', '4');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Here Comes the Sun', '1971', '4');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Fodder on My Wings', '1982', '4');
-- Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.
