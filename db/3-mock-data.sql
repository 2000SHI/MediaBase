-- book
INSERT INTO media (type, title)
WITH RECURSIVE nums AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM nums
    WHERE n < 100
)
SELECT 'book', CONCAT('book', n)
FROM nums;

INSERT INTO book (media_id, publisher)
SELECT id, 'mock publisher'
FROM media WHERE title LIKE 'book%';

-- movie
INSERT INTO media (type, title)
WITH RECURSIVE nums AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM nums
    WHERE n < 100
)
SELECT 'movie', CONCAT('movie', n)
FROM nums;

INSERT INTO movie (media_id, duration_minutes, rating)
SELECT id, FLOOR(RAND() * (61) + 90), 'Not Rated'
FROM media WHERE title LIKE 'movie%';

-- music
INSERT INTO media (type, title)
WITH RECURSIVE nums AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM nums
    WHERE n < 100
)
SELECT 'music', CONCAT('music', n)
FROM nums;

INSERT INTO music (media_id, album, duration_seconds)
SELECT id, 'mock album', FLOOR(RAND() * (301) + 120)
FROM media WHERE title LIKE 'music%';

-- tv
INSERT INTO media (type, title)
WITH RECURSIVE nums AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM nums
    WHERE n < 100
)
SELECT 'tv', CONCAT('tv', n)
FROM nums;

INSERT INTO tv (media_id, seasons)
SELECT id, FLOOR(RAND() * 10) + 1
FROM media WHERE title LIKE 'tv%';