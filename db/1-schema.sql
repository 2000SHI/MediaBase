create table media
(
    id           int unsigned auto_increment
        primary key,
    type         enum ('book', 'movie', 'music', 'tv') not null,
    title        varchar(128)                          not null,
    description  text                                  null,
    release_date date                                  null,
    create_time  timestamp default (now())             not null
);

create index media_type
    on media (type);

create index media_title
    on media (title);

create table book
(
    media_id  int unsigned not null
        primary key,
    publisher varchar(255) null,
    constraint book_ibfk_1
        foreign key (media_id) references media (id)
            on delete cascade
);

create table movie
(
    media_id         int unsigned not null
        primary key,
    duration_minutes int          null,
    rating           varchar(10)  null,
    constraint movie_ibfk_1
        foreign key (media_id) references media (id)
            on delete cascade
);

create table music
(
    media_id         int unsigned not null
        primary key,
    album            varchar(255) null,
    duration_seconds int          null,
    constraint music_ibfk_1
        foreign key (media_id) references media (id)
            on delete cascade
);

create table person
(
    id   int unsigned auto_increment
        primary key,
    name varchar(255) not null,
    bio  text         null,
    constraint name
        unique (name)
);

create table media_person
(
    person_id      int unsigned                                                                               not null,
    media_id       int unsigned                                                                               not null,
    role           enum ('author', 'director', 'writer', 'cast', 'artist', 'composer', 'lyricist', 'creator') not null,
    character_name varchar(50)                                                                                null,
    primary key (person_id, media_id, role),
    constraint media_person_ibfk_1
        foreign key (person_id) references person (id)
            on delete cascade,
    constraint media_person_ibfk_2
        foreign key (media_id) references media (id)
            on delete cascade
);

create table tv
(
    media_id int unsigned not null
        primary key,
    seasons  int          null,
    constraint tv_ibfk_1
        foreign key (media_id) references media (id)
            on delete cascade
);

create table user
(
    id          int unsigned auto_increment
        primary key,
    username    varchar(32) default 'user' not null,
    password    varchar(128)               not null,
    email       varchar(128)               not null,
    avatar      varchar(128)               null,
    create_time timestamp                  not null,
    update_time timestamp                  not null,
    constraint email
        unique (email)
);

create table comment
(
    id       int unsigned auto_increment
        primary key,
    media_id int unsigned null,
    user_id  int unsigned null,
    comment  text         null,
    constraint comment_ibfk_1
        foreign key (media_id) references media (id)
            on delete cascade,
    constraint comment_ibfk_2
        foreign key (user_id) references user (id)
            on delete cascade
);

create index media_id
    on comment (media_id);

create index user_id
    on comment (user_id);

create table rate
(
    media_id int unsigned not null,
    user_id  int unsigned not null,
    score    int          null,
    primary key (media_id, user_id),
    constraint rate_ibfk_1
        foreign key (media_id) references media (id)
            on delete cascade,
    constraint rate_ibfk_2
        foreign key (user_id) references user (id)
            on delete cascade
);

create index user_id
    on rate (user_id);

create table role
(
    user_id int unsigned not null
        primary key,
    role    varchar(16)  null,
    constraint role_ibfk_1
        foreign key (user_id) references user (id)
            on delete cascade
);

