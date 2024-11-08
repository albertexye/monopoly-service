--
-- This SQL script builds a monopoly database, deleting any pre-existing version.
--
-- @author Alex Ye
-- @version Fall, 2024
--

-- Drop previous versions of the tables if they they exist, in reverse order of foreign keys.
DROP TABLE IF EXISTS PlayerGameProperty;
DROP TABLE IF EXISTS PlayerGameHouse;
DROP TABLE IF EXISTS PlayerGameHotel;
DROP TABLE IF EXISTS PlayerGame;
DROP TABLE IF EXISTS Game;
DROP TABLE IF EXISTS Player;

-- Create the schema.
CREATE TABLE Game (
	ID   integer   PRIMARY KEY,
	time timestamp NOT NULL
	);

CREATE TABLE Player (
	ID           integer     PRIMARY KEY, 
	emailAddress varchar(50) NOT NULL,
	name         varchar(50)
	);

CREATE TABLE PlayerGame (
	gameID        integer REFERENCES Game(ID), 
	playerID      integer REFERENCES Player(ID),
	cash          integer,
	pieceLocation integer,
	score         integer
	);

CREATE TABLE PlayerGameProperty (
	gameID           integer REFERENCES Game(ID),
	playerID         integer REFERENCES Player(ID),
	propertyLocation integer NOT NULL
	);

CREATE TABLE PlayerGameHouse (
	gameID        integer REFERENCES Game(ID),
	playerID      integer REFERENCES Player(ID),
	houseLocation integer NOT NULL
	);

CREATE TABLE PlayerGameHotel (
	gameID        integer REFERENCES Game(ID),
	playerID      integer REFERENCES Player(ID),
	hotelLocation integer NOT NULL
	);

-- Allow users to select data from the tables.
GRANT SELECT ON Game               TO PUBLIC;
GRANT SELECT ON Player             TO PUBLIC;
GRANT SELECT ON PlayerGame         TO PUBLIC;
GRANT SELECT ON PlayerGameProperty TO PUBLIC;
GRANT SELECT ON PlayerGameHouse    TO PUBLIC;
GRANT SELECT ON PlayerGameHotel    TO PUBLIC;

-- Add sample records.
--          Game         ID          TIME
INSERT INTO Game VALUES ( 1, '2006-06-28 13:20:00');
INSERT INTO Game VALUES ( 2, '2024-10-30 15:41:30');
INSERT INTO Game VALUES ( 3, '2024-10-30 18:02:22');

--          Player         ID         EMAIL          NAME
INSERT INTO Player VALUES ( 1, 'tea@gmail.com',     'Ocya');
INSERT INTO Player VALUES ( 2, 'cat@proton.me',     'Neko');
INSERT INTO Player VALUES ( 3, 'flower@icloud.com', 'Hana');
INSERT INTO Player VALUES ( 4, 'rock@calvin.edu',   'Seki');
INSERT INTO Player VALUES ( 5, 'noname@gmail.com'         );
INSERT INTO Player VALUES ( 6, 'king@qq.com',   'The King');

--          PlayerGame         GID PID CASH  LOCATION SCORE
-- The first game. 
INSERT INTO PlayerGame VALUES ( 1,  1,   64,      1,    5);
INSERT INTO PlayerGame VALUES ( 1,  2,  128,      1,    8);
INSERT INTO PlayerGame VALUES ( 1,  3,  256,      2,   13);
INSERT INTO PlayerGame VALUES ( 1,  4,  512,      3,   21);

-- The second game.
INSERT INTO PlayerGame VALUES ( 2,  1, 1024,      2,   11);
INSERT INTO PlayerGame VALUES ( 2,  2, 2048,      3,   13);
INSERT INTO PlayerGame VALUES ( 2,  3, 4096,      5,   17);
INSERT INTO PlayerGame VALUES ( 2,  4, 8192,      7, 2001);

-- the third game.
INSERT INTO PlayerGame VALUES ( 3,  3, 1024,      2,   1);
INSERT INTO PlayerGame VALUES ( 3,  4, 2048,      3,   3);
INSERT INTO PlayerGame VALUES ( 3,  5, 4096,      5,   7);
INSERT INTO PlayerGame VALUES ( 3,  6, 8192,      7, 201);

--          PlayerGameProperty         GID PID LOCATION
-- At the beginning of the game, there's only one property. 
INSERT INTO PlayerGameProperty VALUES ( 2,  1,    1);

--          PlayerGameHouse         GID PID LOCATION
-- At the beginning of the game, there's only one property. 
INSERT INTO PlayerGameHouse VALUES ( 2,  2,     3);

--          PlayerGameHotel         GID PID LOCATION
-- At the beginning of the game, but people like hotels over houses. 
INSERT INTO PlayerGameHotel VALUES ( 2,  3,     5);
INSERT INTO PlayerGameHotel VALUES ( 2,  4,     7);


-- Queries
-- Retrieve a list of all the games, ordered by date with the most recent game coming first.
-- SELECT * FROM Game ORDER BY time ASC;

-- Retrieve all the games that occurred in the past week.
-- SELECT * FROM Game WHERE time >= NOW() - INTERVAL '7 days';

-- Retrieve a list of players who have (non-NULL) names.
-- SELECT * FROM Player WHERE name IS NOT NULL;

-- Retrieve a list of IDs for players who have some game score larger than 2000.
-- SELECT playerID FROM PlayerGame WHERE score > 2000;

-- Retrieve a list of players who have GMail accounts.
-- SELECT * FROM Player WHERE emailaddress LIKE '%@gmail.com';

-- Retrieve all “The King”’s game scores in decreasing order.
-- SELECT PlayerGame.score FROM PlayerGame, Player WHERE Player.ID = PlayerGame.playerID AND Player.name = 'The King';

-- Retrieve the name of the winner of the game played on 2006-06-28 13:20:00.
-- SELECT Player.name
--	FROM Player, PlayerGame, Game
--	WHERE
--		Game.time = '2006-06-28 13:20:00' AND
--		Player.ID = PlayerGame.playerID AND
--		Game.ID = PlayerGame.gameID
--	ORDER BY PlayerGame.score
--	DESC LIMIT 1;

-- So what does that P1.ID < P2.ID clause do in the last example query (i.e., the from SQL Examples)?
-- It makes sure the query doesn't do useless repetitive comparisons. 

-- The query that joined the Player table to itself seems rather contrived. Can you think of a realistic situation in which you’d want to join a table to itself?
-- In a to-do list app, a task can contain multiple sub-tasks. In this case, if you want to get all tasks under one parent task, you have to use self-join. 

