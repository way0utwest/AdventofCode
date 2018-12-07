-- drop  TABLE Day1_Frequency
--CREATE TABLE Day1_Frequency
--( Day1Key INT IDENTITY(1,1)
--, RawData VARCHAR(10)
--, Frequency INT
--)
--GO
--SET IDENTITY_INSERT dbo.Day1_Frequency ON
--INSERT dbo.Day1_Frequency
--( Day1Key,
--    RawData,
--    Frequency
--)
--VALUES
--(0,'0', 0)
--SET IDENTITY_INSERT dbo.Day1_Frequency Off
--GO
--INSERT dbo.Day1_Frequency
--(
--    RawData
--)
--SELECT  REPLACE(a.Item, CHAR(10), '')
--FROM	OPENROWSET(BULK 'C:\Users\way0u\Source\Repos\AdventofCode\2018\Day1\input.txt', SINGLE_CLOB) dt(FileData)
-- CROSS APPLY [dbo].[DelimitedSplit8K](dt.FileData, CHAR(13)) a
-- ORDER BY a.ItemNumber

-- GO
-- UPDATE dbo.Day1_Frequency
--  SET Frequency = CONVERT(INT, RawData)
--GO
--DELETE dbo.Day1_Frequency WHERE RawData = ''

--go
WITH LoopCTE(n)
AS
(SELECT n = ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
 FROM (VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (0) ) a(n)
 CROSS JOIN (VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (0) ) b(n)
 CROSS JOIN (VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (0) ) c(n)
)
, DataCTE (n, Day1Key, Frequency)
AS
( SELECT l.n,
		f.Day1Key,
        f.Frequency
 FROM dbo.Day1_Frequency f
 CROSS JOIN LoopCTE l
), calcCTE (n, Day1Key, Frequency, newfreq, rn)
AS
(
 SELECT 0, 0, 0, 0, 0
 UNION all
 SELECT d.n,
		d.Day1Key,
        d.Frequency
		,newfreq = (SUM(d.Frequency) OVER (ORDER BY d.n, d.Day1Key ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) 
		,rn = ROW_NUMBER() OVER (ORDER BY d.n, d.Day1Key) 
 FROM DataCTE d
 )
 SELECT  TOP 1 c.newfreq, COUNT(c.newfreq), MIN(c.rn), MAX(c.rn)
  FROM calcCTE c
  GROUP BY c.newfreq
  HAVING COUNT(c.newfreq) > 1 AND MIN(c.rn) <> MAX(c.rn)
 ORDER BY MAX(c.rn) asc



