-- user
insert into media_base.user (id, username, password, email, avatar, create_time, update_time) values
(1, 'admin', '$2a$10$SedOHTMhAJ1k88FFdg0Kxu7UoDzWD3vsGStj1u.tYkY6OvigN1QkC', 'admin@mediabase.com', null, '2026-03-10 10:16:46', '2026-03-10 10:16:46'),
(2, 'Yuki', '$2a$10$9gVR.kRnnENr8NbvCzPlBe8KZzwCK./U71rphuHgx0tAgPEQu27R6', '18923461402@163.com', 'https://media-base-191022261411.s3.amazonaws.com/6fb38bca-ba3f-4e8a-ab91-2ded72f20eb1_joker.jpg', '2026-01-08 11:27:43', '2026-03-04 10:33:48'),
(3, 'Yongqi', '$2a$10$PFdkZa3PzeLM./DovN06OOLueQOl7GmLea.M6DZm4w2Sm3vSLkFPK', 'yongqi451@gmail.com', null, '2026-01-08 13:10:13', '2026-01-09 00:36:20');

insert into media_base.role (user_id, role) values  (1, 'ADMIN');

-- media
insert into media_base.media (id, type, title, description, release_date, create_time) values
(1, 'book', 'The Catcher in the Rye', 'American coming-of-age novel', '1951-07-16', now()),
(2, 'book', 'Norwegian Wood', '', '1987-09-04', now()),
(3, 'book', 'To Kill a Mockingbird', 'A young girl witnesses racial injustice in the American South.', '1960-07-11', now()),
(4, 'book', '1984', 'A man struggles under a totalitarian regime that controls truth and thought.', '1949-06-08', now()),
(5, 'book', 'To Live', 'A man endures hardship and loss while reflecting on the meaning of life in modern China.', '1993-01-01', now()),
(6, 'book', 'In Search of Lost Time', 'A narrator reflects on memory, art, and society in early 20th century France.', '1913-01-01', now()),
(7, 'book', 'The Moon and Sixpence', 'A stockbroker abandons his life to pursue artistic passion.', '1919-01-01', now()),
(8, 'book', 'The Unbearable Lightness of Being', 'Lives intertwine as characters explore love and existential meaning.', '1984-01-01', now()),
(9, 'book', 'The Adolescent', 'A young man struggles with identity, ambition, and family tensions in Russian society.', '1875-01-01', now()),
(10, 'book', 'A Woman''s Life', 'A woman faces disillusionment as she navigates love, marriage, and societal expectations.', '1883-01-01', now());

insert into media_base.book (media_id, publisher) values
(1, 'Little, Brown and Company'),
(2, 'Kodansha'),
(3, 'J.B. Lippincott & Co.'),
(4, 'Secker & Warburg'),
(5, 'Anchor Books'),
(6, 'Grasset'),
(7, 'William Heinemann'),
(8, 'Gallimard'),
(9, 'The Russian Messenger'),
(10, 'Victor Havard');

insert into media_base.media (id, type, title, description, release_date, create_time) values
(11, 'movie', 'The Hunt', 'A man''s life unravels after a false accusation spreads through his small community', '2012-05-20', now()),
(12, 'movie', 'A Clockwork Orange', 'A violent delinquent undergoes an experimental treatment to curb his behavior', '1971-12-19', now()),
(13, 'movie', 'All Quiet on the Western Front', '', '2022-09-29', now()),
(14, 'movie', 'Annie Hall', 'A comedian reflects on his complex relationship with a free-spirited woman', '1977-04-20', now()),
(15, 'movie', 'Tokyo Story', 'Elderly parents visit their children in the city and confront emotional distance', '1953-11-03', now()),
(16, 'movie', 'Rashomon', 'Conflicting accounts reveal the elusive truth behind a crime', '1950-08-26', now()),
(17, 'movie', 'Life Is Beautiful', 'A father uses humor to shield his son from the horrors of a concentration camp', '1997-12-20', now()),
(18, 'movie', 'Oppenheimer', 'A dramatization of the life story of J. Robert Oppenheimer, the physicist who had a large hand in the development of the atomic bombs that brought an end to World War II.', '2023-07-19', now()),
(19, 'movie', 'Yi Yi', '', '2000-09-20', now()),
(20, 'movie', 'Taxi Driver', '', '1976-02-09', now());

insert into media_base.movie (media_id, duration_minutes, rating) values
(11, 115, 'R'),
(12, 136, 'R'),
(13, 148, 'R'),
(14, 93, 'PG'),
(15, 137, 'Not Rated'),
(16, 88, 'Not Rated'),
(17, 116, 'PG-13'),
(18, 180, 'R'),
(19, 173, 'Not Rated'),
(20, 114, 'R');

insert into media_base.media (id, type, title, description, release_date, create_time) values
(21, 'music', '十万嬉皮', null, '2010-11-12', now()),
(22, 'tv', 'Breaking Bad', null, '2008-07-15', now());

insert into media_base.music (media_id, album, duration_seconds) values (21, '万能青年旅店', 284);

insert into media_base.tv (media_id, seasons) values  (22, 5);

-- person
insert into media_base.person (id, name, bio) values
(1, 'Vince Gilligan', null),
(2, 'Bryan Cranston', null),
(3, 'Aaron Paul', null),
(4, 'Anna Gunn', null),
(5, '万能青年旅店', null),
(6, '姬赓', null),
(7, '董亚千', null);

insert into media_base.media_person (person_id, media_id, role, character_name) values
(1, 22, 'creator', null),
(2, 22, 'cast', null),
(3, 22, 'cast', null),
(4, 22, 'cast', null),
(5, 21, 'artist', null),
(6, 21, 'lyricist', null),
(7, 21, 'composer', null);

insert into media_base.person (id, name, bio) values
(8, 'J. D. Salinger', 'An American author, 1919 - 2010'),
(9, 'Haruki Murakami', 'Japanese writer'),
(10, 'Harper Lee', 'An American novelist best known for her exploration of racial injustice and moral growth in the American South.'),
(11, 'George Orwell', 'An English writer and critic renowned for his works on totalitarianism, politics, and social oppression.'),
(12, 'Yu Hua', 'A contemporary Chinese author known for portraying ordinary lives amid historical and social upheaval.'),
(13, 'Marcel Proust', 'A French novelist celebrated for his profound reflections on memory, time, and human experience.'),
(14, 'W. Somerset Maugham', 'A British writer famous for his sharp observations of human nature and colonial society.'),
(15, 'Milan Kundera', 'A Czech-born novelist whose works blend philosophy, politics, and intimate human relationships.'),
(16, 'Fyodor Dostoevsky', 'A Russian novelist known for his psychological depth and exploration of morality, faith, and human suffering.'),
(17, 'Guy de Maupassant', 'A French writer celebrated for his realistic fiction and insightful depictions of everyday life.')

insert into media_base.media_person (person_id, media_id, role, character_name) values
(8, 1, 'author', null),
(9, 2, 'author', null),
(10, 3, 'author', null),
(11, 4, 'author', null),
(12, 5, 'author', null),
(13, 6, 'author', null),
(14, 7, 'author', null),
(15, 8, 'author', null),
(16, 9, 'author', null),
(17, 10, 'author', null);

insert into media_base.person (id, name, bio) values
(18, 'Thomas Vinterberg', null),
(19, 'Mads Mikkelsen', null),
(20, 'Stanley Kubrick', null),
(21, 'Malcolm McDowell', null),
(22, 'Edward Berger', null),
(23, 'Woody Allen', null),
(24, 'Yasujirō Ozu', null),
(25, 'Akira Kurosawa', null),
(26, 'Roberto Benigni', null),
(27, 'Christopher Nolan', null),
(28, 'Cillian Murphy', null),
(29, 'Emily Blunt', null),
(30, 'Edward Yang', 'One of the most talented international filmmakers from China'),
(31, 'Nien-Jen Wu', ''),
(32, 'Elaine Jin', ''),
(33, 'Martin Scorsese', null),
(34, 'Robert De Niro', null),
(35, 'Jodie Foster', null);

insert into media_base.media_person (person_id, media_id, role, character_name) values
(18, 11, 'director', null),
(18, 11, 'writer', null),
(19, 11, 'cast', 'Lucas'),
(20, 12, 'director', null),
(20, 12, 'writer', null),
(21, 12, 'cast', 'Alex'),
(22, 13, 'director', null),
(22, 13, 'writer', null),
(23, 14, 'director', null),
(23, 14, 'writer', null),
(23, 14, 'cast', null),
(24, 15, 'director', null),
(25, 16, 'director', null),
(26, 17, 'director', null),
(26, 17, 'cast', 'Guido'),
(27, 18, 'director', null),
(28, 18, 'cast', 'J. Robert Oppenheimer'),
(29, 18, 'cast', 'Kitty Oppenheimer'),
(30, 19, 'director', null),
(30, 19, 'writer', null),
(31, 19, 'cast', null),
(32, 19, 'cast', 'Min-Min'),
(33, 20, 'director', null),
(34, 20, 'cast', 'Travis Bickle'),
(35, 20, 'cast', 'Iris Steensma');

-- review
insert into media_base.rate (media_id, user_id, score) values
(11, 2, 9),
(11, 3, 8),
(1, 2, 9),
(21, 2, 10);

insert into media_base.comment (id, media_id, user_id, comment) values
(1, 21, 2, 'I love this song so much'),
(2, 11, 2, 'I like the ending'),
(3, 11, 3, 'they don''t care about the truth'),
(4, 1, 2, 'A timeless classic');