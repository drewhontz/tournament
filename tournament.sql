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

-- Left joins the players id & name columns with the sum of instances where
-- player's id is in the matches.winner column for total wins. Also looks 
-- for sum of instances where players id is in any column of matches to
-- determine total number of matches 
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