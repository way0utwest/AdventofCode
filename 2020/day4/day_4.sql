--CREATE TABLE Day4 (LineKey INT NOT NULL IDENTITY(1,1) CONSTRAINT Day4PK PRIMARY KEY
--, LineVal VARCHAR(100)
--)
--GO
--TRUNCATE TABLE dbo.Day4
--GO
--CREATE VIEW Day4_Load
--AS
--SELECT dgo.LineVal
-- FROM dbo.Day4 AS dgo
--go
--BULK INSERT dbo.Day4_Load
--FROM 'E:\Documents\git\AdventofCode\2020\Day4\Day4_data.txt' WITH ( ROWTERMINATOR = '\n',ERRORFILE = 'E:\Documents\git\AdventofCode\2020\Day4\myRubbishData.log' )
--GO

--INSERT dbo.Day4 (LineVal) 
--VALUES ('ecl:gry pid:860033327 eyr:2020 hcl:#fffffd'),
--('byr:1937 iyr:2017 cid:147 hgt:183cm'),
--(''),
--('iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884'),
--('hcl:#cfa07d byr:1929'),
--(''),
--('hcl:#ae17e1 iyr:2013'),
--('eyr:2024'),
--('ecl:brn pid:760753108 byr:1931'),
--('hgt:179cm'),
--(''),
--('hcl:#cfa07d eyr:2025 pid:166559648'),
--('iyr:2011 ecl:brn hgt:59in')

--SELECT * FROM day4 ORDER BY linekey;
--GO
--DROP TABLE Day4_Passport
--go
--CREATE TABLE Day4_Passport
--(PassportKey int not null identity(1,1) constraint Day4PassportPK primary key
--, PassportVal VARCHAR(1000));
--GO
--TRUNCATE TABLE dbo.Day4_Passport
--GO

--DECLARE pcurs CURSOR FOR SELECT lineval FROM day4 ORDER BY linekey;
--DECLARE
--    @val VARCHAR(1000) = ''
--  , @completepassport VARCHAR(1000);
--OPEN pcurs;
--FETCH NEXT FROM pcurs
--INTO @val;
--SET @completepassport = '';
--WHILE @@FETCH_STATUS = 0
--BEGIN
--    IF @val > ''
--        SELECT @completepassport += ' ' + @val;
--    ELSE
--    BEGIN
--        INSERT dbo.Day4_Passport (PassportVal) VALUES (@completepassport);
--        SET @completepassport = '';
--    END;
--    FETCH NEXT FROM pcurs
--    INTO @val;
--END;
--    INSERT dbo.Day4_Passport (PassportVal) VALUES (@completepassport);
--DEALLOCATE pcurs;
--SELECT * FROM day4_passport;

--CREATE FUNCTION [dbo].[DelimitedSplit8K]
----===== Define I/O parameters
--        (@pString VARCHAR(8000), @pDelimiter CHAR(1))
----WARNING!!! DO NOT USE MAX DATA-TYPES HERE!  IT WILL KILL PERFORMANCE!
--RETURNS TABLE WITH SCHEMABINDING AS
-- RETURN
----===== "Inline" CTE Driven "Tally Table" produces values from 1 up to 10,000...
--     -- enough to cover VARCHAR(8000)
--  WITH E1(N) AS (
--                 SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL
--                 SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL
--                 SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1
--                ),                          --10E+1 or 10 rows
--       E2(N) AS (SELECT 1 FROM E1 a, E1 b), --10E+2 or 100 rows
--       E4(N) AS (SELECT 1 FROM E2 a, E2 b), --10E+4 or 10,000 rows max
-- cteTally(N) AS (--==== This provides the "base" CTE and limits the number of rows right up front
--                     -- for both a performance gain and prevention of accidental "overruns"
--                 SELECT TOP (ISNULL(DATALENGTH(@pString),0)) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) FROM E4
--                ),
--cteStart(N1) AS (--==== This returns N+1 (starting position of each "element" just once for each delimiter)
--                 SELECT 1 UNION ALL
--                 SELECT t.N+1 FROM cteTally t WHERE SUBSTRING(@pString,t.N,1) = @pDelimiter
--                ),
--cteLen(N1,L1) AS(--==== Return start and length (for use in substring)
--                 SELECT s.N1,
--                        ISNULL(NULLIF(CHARINDEX(@pDelimiter,@pString,s.N1),0)-s.N1,8000)
--                   FROM cteStart s
--                )
----===== Do the actual split. The ISNULL/NULLIF combo handles the length for the final element when no delimiter is found.
-- SELECT ItemNumber = ROW_NUMBER() OVER(ORDER BY l.N1),
--        Item       = SUBSTRING(@pString, l.N1, l.L1)
--   FROM cteLen l
--;
--GO
WITH myCTE
AS
(
 SELECT  d.PassportKey, d.PassportVal, split.ItemNumber, Item = split.Item
   FROM dbo.Day4_Passport d
  CROSS APPLY dbo.DelimitedSplit8k(d.PassportVal,' ') split
)
, itemcte 
AS
(
SELECT myCTE.PassportKey, myCTE.Item
 FROM myCTE
 WHERE item <> '' AND substring(Item, 1, 3) <> 'cid'
 )
 SELECT itemcte.PassportKey, COUNT(*)
  FROM itemcte
  GROUP BY itemcte.PassportKey
  HAVING COUNT(*) = 7