-- Setup
CREATE TABLE [2021].Day2
( Day2Key INT NOT NULL IDENTITY(1,1) 
, Direction VARCHAR(30))
GO
CREATE TABLE [2021].Stage2
( Direction VARCHAR(30))
GO
CREATE INDEX Stage2PK ON [2021].Stage2(Direction)
GO
BULK INSERT [2021].Stage2 FROM 'E:\Documents\git\AdventofCode\2021\Day2\input.txt' WITH ( ROWTERMINATOR = '\n',ERRORFILE = 'E:\Documents\git\AdventofCode\2021\day1\myRubbishData.log' )
GO
INSERT [2021].Day2
(
    Direction
)SELECT s.Direction FROM [2021].Stage2 AS s
GO
-- Part 1

-- test 
/*
WITH cteInput (driveKey, direction)
AS (SELECT a,
           b
    FROM
    (
        VALUES
            (1, 'forward 5'),
            (2, 'down 5'),
            (3, 'forward 8'),
            (4, 'up 3'),
            (5, 'down 8'),
            (6, 'forward 2')
    ) input (a, b) )
, cteMovement (forward, depth)
AS
(
SELECT CASE
           WHEN SUBSTRING(cteInput.direction, 1, 7) = 'forward' THEN
               CAST(REPLACE(cteInput.direction, 'forward ', '') AS INT)
           ELSE
               0
       END AS Forward,
       CASE
           WHEN SUBSTRING(cteInput.direction, 1, 2) = 'up' THEN
       (0 - CAST(REPLACE(cteInput.direction, 'up ', '') AS INT))
           WHEN SUBSTRING(cteInput.direction, 1, 4) = 'down' THEN
       (CAST(REPLACE(cteInput.direction, 'down ', '') AS INT))
           ELSE
               0
       END AS depth
FROM cteInput
)
SELECT SUM(cteMovement.forward) * SUM(cteMovement.depth) AS answer
	  FROM cteMovement
	  */
WITH  cteMovement (forward, depth)
AS
(
SELECT CASE
           WHEN SUBSTRING(d.direction, 1, 7) = 'forward' THEN
               CAST(REPLACE(d.direction, 'forward ', '') AS INT)
           ELSE
               0
       END AS Forward,
       CASE
           WHEN SUBSTRING(d.direction, 1, 2) = 'up' THEN
       (0 - CAST(REPLACE(d.direction, 'up ', '') AS INT))
           WHEN SUBSTRING(d.direction, 1, 4) = 'down' THEN
       (CAST(REPLACE(d.direction, 'down ', '') AS INT))
           ELSE
               0
       END AS depth
FROM [2021].Day2 AS d
)
SELECT SUM(cteMovement.forward) * SUM(cteMovement.depth) AS answer
	  FROM cteMovement
GO

-- part 2
--[2021].Day2
WITH cteInput (Day2Key, direction)
AS (SELECT a,
           b
    FROM
    (
        VALUES
            (1, 'forward 5'),
            (2, 'down 5'),
            (3, 'forward 8'),
            (4, 'up 3'),
            (5, 'down 8'),
            (6, 'forward 2')
    ) input (a, b) )
,
--WITH  
cteMovement (day2key, forward, depth)
AS
(
SELECT d.Day2Key,
       CASE
           WHEN SUBSTRING(d.direction, 1, 7) = 'forward' THEN
               CAST(REPLACE(d.direction, 'forward ', '') AS INT)
           ELSE
               0
       END AS Forward,
       CASE
           WHEN SUBSTRING(d.direction, 1, 2) = 'up' THEN
       (0 - CAST(REPLACE(d.direction, 'up ', '') AS INT))
           WHEN SUBSTRING(d.direction, 1, 4) = 'down' THEN
       (CAST(REPLACE(d.direction, 'down ', '') AS INT))
           ELSE
               0
       END AS depth
FROM [2021].Day2 AS d
),
cteCalc (Day2Key, Forward, Depth, Factor, forwardposition, sumdepth, RunningDepth)
AS
(
SELECT c.day2key,
       c.forward,
	   c.depth,
       CASE WHEN LAG(c.forward, 1, 0) OVER (ORDER BY c.day2key) = 0
             THEN 1
			 ELSE LAG(c.forward, 1, 0) OVER (ORDER BY c.day2key) 
			 END AS factor,
       SUM(c.forward) OVER (ORDER BY c.day2key ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS forwardposition,
       SUM(c.depth) OVER (ORDER BY c.day2key ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sumdepth,
	   (c.forward * SUM(c.depth) OVER (ORDER BY c.day2key ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) AS runningdepth
	  FROM cteMovement c
), cteResult (forwardposition, depth)
AS
(
SELECT DISTINCT LAST_VALUE(cteCalc.forwardposition) OVER (ORDER BY cteCalc.Day2Key ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS forwardposition
, SUM(cteCalc.RunningDepth) OVER (ORDER BY (SELECT NULL)) AS depth
FROM cteCalc
)
SELECT cteResult.forwardposition * cteResult.depth
 FROM cteResult