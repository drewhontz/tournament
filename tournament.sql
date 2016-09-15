-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

CREATE TABLE PLAYERS (
	id serial primary key not null,
	name text not null
);

CREATE TABLE MATCHES (
	id serial primary key not null,
	player1 serial references PLAYERS(id),
	player2 serial references PLAYERS(id)
);

CREATE TABLE RESULTS (
	id serial references MATCHES(id),
	winner serial references PLAYERS(id)
);

-- CREATE VIEW STANDINGS (
-- 	SELECT PLAYERS.id as id,
-- 	PLAYERS.name as name,
-- 	(SELECT count(id) FROM RESULTS WHERE id = winner) as wins,
-- 	(SELECT count(*) FROM MATCHES WHERE id = player1 OR id = player2) as matches,
-- 	FROM PLAYERS as p, MATCHES as m, RESULTS as r;
-- )