CREATE TABLE [2021].Day1
( Day1Key INT NOT NULL IDENTITY(1,1) 
, Depth INT)
GO
CREATE TABLE [2021].Stage1
( Depth INT)
GO
CREATE INDEX Stage1PK ON [2021].Stage1(depth)
GO
BULK INSERT [2021].Stage1 FROM 'E:\Documents\git\AdventofCode\2021\Day1\input.txt' WITH ( ROWTERMINATOR = '\n',ERRORFILE = 'E:\Documents\git\AdventofCode\2021\day1\myRubbishData.log' )
GO
INSERT [2021].Day1
(
    Depth
)SELECT s.Depth FROM [2021].Stage1 AS s
GO
SELECT * FROM [2021].Day1 AS d2 ORDER BY d2.Day1Key
GO
WITH cteDepth (Depth)
AS
(
SELECT (LEAD(d.Depth,1,0) OVER (ORDER BY d.Day1Key) - d.Depth) AS change
 FROM [2021].Day1 AS d
 )
 SELECT COUNT(Depth)
  FROM cteDepth
  WHERE cteDepth.Depth > 0
GO
-- Part 2
--WITH cteTest (depth, Day1Key)
--AS (
--SELECT depth, Day1Key
-- FROM ( VALUES (199,1), (200,2), (208,3), (210,4), (200, 5)
--             , (207,6), (240,7), (269,8), (260,9), (263,10)

--      ) a(depth, Day1Key)
--  )
with cteDepth (C1, C2)
AS
(
SELECT (d.Depth + LEAD(d.Depth, 1, 0) OVER (ORDER BY d.Day1Key) + LEAD(d.Depth, 2, 0) OVER (ORDER BY d.Day1Key)) AS change1
     , (LEAD(d.Depth, 1, 0) OVER (ORDER BY d.Day1Key)  + LEAD(d.Depth, 2, 0) OVER (ORDER BY d.Day1Key) + LEAD(d.Depth, 3, 0) OVER (ORDER BY d.Day1Key)) AS change2
FROM [2021].Day1 AS d
 )
 SELECT COUNT(*)
  FROM cteDepth
   WHERE c2 > c1
GO
