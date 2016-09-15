#!/usr/bin/env python
# 
# tournament.py -- implementation of a Swiss-system tournament
#

import psycopg2


def connect():
    """Connect to the PostgreSQL database.  Returns a database connection."""
    return psycopg2.connect("dbname=tournament")


def deleteMatches():
    """Remove all the match records from the database."""
    conn = connect()
    c = conn.cursor()
    q = "DELETE FROM MATCHES;"
    c.execute(q)
    c.close()
    conn.commit()
    conn.close()

def deletePlayers():
    """Remove all the player records from the database.
       This has dependencies with Matches and should therefore only be run if
       there are no matches"""
    conn = connect()
    c = conn.cursor()
    q = "DELETE FROM PLAYERS;"
    c.execute(q)
    c.close()
    conn.commit()
    conn.close()


def countPlayers():
    """Returns the number of players currently registered.
       -select count(id) from players
       -Should return int
       -if count is 0, will our query return a 0 or null?
       """
    conn = connect()
    c = conn.cursor()
    q = "select count(id) FROM PLAYERS;"
    c.execute(q)
    res = c.fetchone()
    c.close()
    conn.commit()
    conn.close()
    return int(res[0])


def registerPlayer(name):
    """Adds a player to the tournament database.
  
    The database assigns a unique serial id number for the player.  (This
    should be handled by your SQL database schema, not in your Python code.)
  
    Args:
      name: the player's full name (need not be unique).
    2) If validations pass: Insert into players (name, <other info>) values 
    (<values>)
    """
    conn = connect()
    c = conn.cursor()
    q = "INSERT INTO PLAYERS VALUES (default, %s);"
    data = (name,)
    c.execute(q, data)
    conn.commit()
    conn.close()

def playerStandings():
    """Returns a list of the players and their win records, sorted by wins.

    The first entry in the list should be the player in first place, or a
    player tied for first place if there is currently a tie.

    Returns:
      A list of tuples, each of which contains (id, name, wins, matches):
        id: the player's unique id (assigned by the database)
        name: the player's full name (as registered)
        wins: the number of matches the player has won
        matches: the number of matches the player has played

    -What will happen if the players haven't played any matches yet?

    select p.id, p.name, s.w, (sum s.w s.l) as matches, from pid = sid order by
    s.w desc
    """


def reportMatch(winner, loser):
    """Records the outcome of a single match between two players.

    Args:
      winner:  the id number of the player who won
      loser:  the id number of the player who lost

    Insert into record id of winner, wins +=1 (increment in python and
        re-insert or do via sql) 
    """
 
 
def swissPairings():
    """Returns a list of pairs of players for the next round of a match.
  
    Assuming that there are an even number of players registered, each player
    appears exactly once in the pairings.  Each player is paired with another
    player with an equal or nearly-equal win record, that is, a player
    adjacent to him or her in the standings.
  
    Returns:
      A list of tuples, each of which contains (id1, name1, id2, name2)
        id1: the first player's unique id
        name1: the first player's name
        id2: the second player's unique id
        name2: the second player's name
    """


