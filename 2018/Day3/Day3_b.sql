CREATE OR ALTER PROCEDURE Day3b
AS
BEGIN
    DECLARE @i INT = 1;

WITH cteCalc (x, y, z)
AS
(
SELECT 
  t.n AS x
, t2.n AS y
, COUNT(*) AS z
 FROM dbo.day3 a
 INNER JOIN dbo.Tally t
  ON t.n BETWEEN a.claimstartx + 1 AND (a.claimstartx + a.claimwidth)
   INNER JOIN dbo.Tally t2
  ON t2.n BETWEEN a.claimstarty + 1 AND (a.claimstarty + a.claimheight)
  GROUP BY t.n,t2.n
  ), cteResult (claimnumber, claimwidth, claimheight, totalarea)
  AS
  (
  SELECT d.ClaimNumber, d.claimwidth, d.claimheight
  -- , c.z, c.y, c.z
  , SUM(c.z)
   FROM cteCalc c
   INNER JOIN dbo.Day3 AS d
    ON c.x BETWEEN d.claimstartx + 1 AND d.claimstartx + d.claimwidth
    AND  c.y BETWEEN d.claimstarty + 1AND d.claimstarty + d.claimheight 
	GROUP BY d.ClaimNumber, d.claimwidth, d.claimheight
	 HAVING SUM(c.z) = d.claimwidth * d.claimheight
	)
	SELECT cteResult.claimnumber
	FROM cteResult
RETURN @i
END
GO
EXEC tsqlt.run 'tsqltests.[test Day3b]'
/*
If working, run this:
declare @i int = 0
exec Day2b @i output
select @i
*/