-- Table definitions for the tournament project. Minus the Create DB statement

CREATE TABLE PLAYERS (
	id serial primary key not null,
	name text not null
);

CREATE TABLE MATCHES (
	id serial primary key not null,
	winner integer references PLAYERS(id),
	loser integer references PLAYERS(id)
);

CREATE VIEW RESULTS AS SELECT ID, PLAYER1 AS WINNER FROM MATCHES;


-- This gets a little sloppy but the view standings is formed by 2 left outer
-- joins of players.id & players.name where the first outer join is on the count 
-- where the player's id is in the results.winner column. The second left outer
-- join then takes place with the count of total (matches.id) to determine the 
-- total number of matches
CREATE OR REPLACE VIEW STANDINGS AS
    SELECT  players.id,
            players.name,
            SUM(CASE WHEN players.id = matches.winner THEN 1 ELSE 0 END) AS wins,
            SUM(CASE WHEN players.id = matches.winner OR players.id = matches.loser THEN 1 ELSE 0 END) AS match_count
    FROM players
    LEFT JOIN matches
    ON players.id = matches.winner OR players.id = matches.loser
    GROUP BY players.id
    ORDER BY wins DESC,
             match_count ASC;