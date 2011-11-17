-- Maintainer: Maciej Ziarko
-- tested on PostgreSQL 9.1.1
-- Opinions/corrections are welcome :)

-- users table:
CREATE TABLE users (
	username varchar(64) PRIMARY KEY,
	password varchar(64), -- we will protect passwords with sha-256
	email varchar(64),
	first_name varchar(64),
	last_name varchar(64),
	UNIQUE (email)
)

-- bookmarks table:
CREATE TABLE bookmarks (
	id bigserial PRIMARY KEY, -- bigserial is bigint with autoincrement
	owner varchar(64) REFERENCES users(username),
	name varchar(128),
	description varchar(256),
	created timestamp,
	url varchar(256)
)

-- likes table:
CREATE TABLE likes (
	id bigserial PRIMARY KEY,
	username varchar(64) REFERENCES users(username),
	bookmark_id bigint REFERENCES bookmarks(id),
	UNIQUE (username, bookmark_id)
)

-- tags table:
CREATE TABLE tags (
	id bigserial PRIMARY KEY,
	name varchar(64),
	description varchar(128),
	created timestamp
)

-- tags_bookmarks table:
CREATE TABLE tags_bookmarks (
	id bigserial PRIMARY KEY,
	bookmark_id bigint REFERENCES bookmarks(id),
	tag_id bigint REFERENCES tags(id),
	UNIQUE (bookmark_id, tag_id)
)

-- bundles table:
CREATE TABLE bundles (
	id bigserial PRIMARY KEY,
	owner varchar(64) REFERENCES users(username),
	name varchar(64),
	description varchar(128),
	created timestamp
)

-- tags_bundles table:
CREATE TABLE tags_bundles (
	id bigserial PRIMARY KEY,
	bundle_id bigint REFERENCES bundles(id),
	tag_id bigint REFERENCES tags(id),
	UNIQUE(bundle_id, tag_id)
)

-- comments table:
CREATE TABLE comments (
	id bigserial PRIMARY KEY,
	username varchar(64) REFERENCES users(username),
	bookmark_id bigint REFERENCES bookmarks(id),
	created timestamp,
	content varchar(1024)
)
