-- Table definitions for the tournament project. Minus the Create DB statement

CREATE TABLE PLAYERS (
	id serial primary key not null,
	name text not null
);

CREATE TABLE MATCHES (
	id serial primary key not null,
	player1 integer references PLAYERS(id),
	player2 integer references PLAYERS(id)
);

CREATE VIEW RESULTS AS SELECT ID, PLAYER1 AS WINNER FROM MATCHES;


-- This gets a little sloppy but the view standings is formed by 2 left outer
-- joins of players.id & players.name where the first outer join is on the count 
-- where the player's id is in the results.winner column. The second left outer
-- join then takes place with the count of total (matches.id) to determine the 
-- total number of matches
CREATE VIEW STANDINGS AS SELECT players.id, name,
    count(results.winner) AS wins,
    (SELECT count(matches.id) FROM matches
	WHERE players.id = matches.player1
	OR players.id = matches.player2) AS matches
    FROM players
    LEFT OUTER JOIN results ON players.id = results.winner
    LEFT OUTER JOIN matches ON matches.id = results.id
    GROUP BY players.id, results.winner
    ORDER BY wins DESC;
