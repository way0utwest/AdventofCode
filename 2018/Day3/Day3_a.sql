--CREATE TABLE Day3
--( rawdata VARCHAR(200)
--)
--GO
--INSERT Day3
--SELECT 
-- s.value
-- --t.cleandata, markers.*, finaldata.*, (markers.sizesplit - markers.FabricStart -2)
-- FROM OPENROWSET(BULK 'E:\Documents\GitHub\AdventofCode\2018\Day3\input.txt', SINGLE_CLOB) AS oro(ClaimData)
-- CROSS APPLY STRING_SPLIT(oro.ClaimData, CHAR(13)) AS s
--GO
--DELETE day3 WHERE rawdata = char(10)
--SELECT 
-- *
-- FROM day3
-- GO
-- ALTER TABLE dbo.Day3 ADD ClaimNumber INT, claimstartx SMALLINT, claimstarty SMALLINT, claimwidth SMALLINT, slaimheight SMALLINT
GO
-- update table
--UPDATE day3
--SET ClaimNumber = SUBSTRING(rawData, CHARINDEX('#', rawData)+1, CHARINDEX('@', rawData) - CHARINDEX('#', rawData)-2),
--claimstartx = SUBSTRING(rawData, CHARINDEX('@', rawData) + 2, CHARINDEX(',', rawData) - CHARINDEX('@', rawData) - 2 ),
--claimstarty = SUBSTRING(rawData, CHARINDEX(',', rawData) + 1, CHARINDEX(':', rawData) - CHARINDEX(',', rawData) - 1 ),
--claimwidth = SUBSTRING( rawData, CHARINDEX(':', rawData) + 2, CHARINDEX('x', rawData) - CHARINDEX(':', rawData) - 2 ),
--slaimheight = SUBSTRING(rawData, CHARINDEX('x', rawData) + 1, 4 )

--;
--GO
--EXEC sp_rename @objname = 'dbo.Day3.slaimheight', @newname = 'claimheight', @objtype = 'column'
--GO
CREATE OR ALTER PROCEDURE Day3a
AS
BEGIN
    DECLARE @i INT = 1;

WITH cteCalc
as
(
SELECT 
  t.n AS x
, t2.n AS y
, COUNT(*) AS z
 FROM day3 a
 INNER JOIN dbo.Tally t
  ON t.n BETWEEN a.claimstartx + 1 AND (a.claimstartx + a.claimwidth)
   INNER JOIN dbo.Tally t2
  ON t2.n BETWEEN a.claimstarty + 1 AND (a.claimstarty + a.claimheight)
  GROUP BY t.n,t2.n
  )
  SELECT @i = COUNT(*)
   FROM cteCalc
   WHERE z > 1
RETURN @i
END
