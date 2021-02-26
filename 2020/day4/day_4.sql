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
/*************************************************************************************************
                                                                                            
PPPPPPPPPPPPPPPPP                                               tttt                 1111111   
P::::::::::::::::P                                           ttt:::t                1::::::1   
P::::::PPPPPP:::::P                                          t:::::t               1:::::::1   
PP:::::P     P:::::P                                         t:::::t               111:::::1   
  P::::P     P:::::Paaaaaaaaaaaaa  rrrrr   rrrrrrrrr   ttttttt:::::ttttttt            1::::1   
  P::::P     P:::::Pa::::::::::::a r::::rrr:::::::::r  t:::::::::::::::::t            1::::1   
  P::::PPPPPP:::::P aaaaaaaaa:::::ar:::::::::::::::::r t:::::::::::::::::t            1::::1   
  P:::::::::::::PP           a::::arr::::::rrrrr::::::rtttttt:::::::tttttt            1::::l   
  P::::PPPPPPPPP      aaaaaaa:::::a r:::::r     r:::::r      t:::::t                  1::::l   
  P::::P            aa::::::::::::a r:::::r     rrrrrrr      t:::::t                  1::::l   
  P::::P           a::::aaaa::::::a r:::::r                  t:::::t                  1::::l   
  P::::P          a::::a    a:::::a r:::::r                  t:::::t    tttttt        1::::l   
PP::::::PP        a::::a    a:::::a r:::::r                  t::::::tttt:::::t     111::::::111
P::::::::P        a:::::aaaa::::::a r:::::r                  tt::::::::::::::t     1::::::::::1
P::::::::P         a::::::::::aa:::ar:::::r                    tt:::::::::::tt     1::::::::::1
PPPPPPPPPP          aaaaaaaaaa  aaaarrrrrrr                      ttttttttttt       111111111111             

**************************************************************************************************/
/*
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
*/


/*
PPPPPPPPPPPPPPPPP                                               tttt                222222222222222    
P::::::::::::::::P                                           ttt:::t               2:::::::::::::::22  
P::::::PPPPPP:::::P                                          t:::::t               2::::::222222:::::2 
PP:::::P     P:::::P                                         t:::::t               2222222     2:::::2 
  P::::P     P:::::Paaaaaaaaaaaaa  rrrrr   rrrrrrrrr   ttttttt:::::ttttttt                     2:::::2 
  P::::P     P:::::Pa::::::::::::a r::::rrr:::::::::r  t:::::::::::::::::t                     2:::::2 
  P::::PPPPPP:::::P aaaaaaaaa:::::ar:::::::::::::::::r t:::::::::::::::::t                  2222::::2  
  P:::::::::::::PP           a::::arr::::::rrrrr::::::rtttttt:::::::tttttt             22222::::::22   
  P::::PPPPPPPPP      aaaaaaa:::::a r:::::r     r:::::r      t:::::t                 22::::::::222     
  P::::P            aa::::::::::::a r:::::r     rrrrrrr      t:::::t                2:::::22222        
  P::::P           a::::aaaa::::::a r:::::r                  t:::::t               2:::::2             
  P::::P          a::::a    a:::::a r:::::r                  t:::::t    tttttt     2:::::2             
PP::::::PP        a::::a    a:::::a r:::::r                  t::::::tttt:::::t     2:::::2       222222
P::::::::P        a:::::aaaa::::::a r:::::r                  tt::::::::::::::t     2::::::2222222:::::2
P::::::::P         a::::::::::aa:::ar:::::r                    tt:::::::::::tt     2::::::::::::::::::2
PPPPPPPPPP          aaaaaaaaaa  aaaarrrrrrr                      ttttttttttt       22222222222222222222
*/

--WITH myCTE
--AS
--(
-- SELECT  d.PassportKey, d.PassportVal, split.ItemNumber, Item = split.Item
--   FROM dbo.Day4_Passport d
--  CROSS APPLY dbo.DelimitedSplit8k(d.PassportVal,' ') split
--)
--SELECT myCTE.PassportKey, item
--  FROM mycte
-- WHERE item <> ''  


WITH myCTE
AS
(
 SELECT  d.PassportKey, d.PassportVal, split.ItemNumber, Item = split.Item
   FROM dbo.Day4_Passport d
  CROSS APPLY dbo.DelimitedSplit8k(d.PassportVal,' ') split
)
, splitCTE
AS
(SELECT myCTE.PassportKey, item, SUBSTRING(item, 1, 3) AS cat, SUBSTRING(item, 5, LEN(item) - 4) AS catval
  FROM mycte
 WHERE item <> '' AND item <> 'CID' 
 )
 SELECT top 10
  splitCTE.PassportKey, splitCTE.Item, splitCTE.cat, splitCTE.catval
  FROM splitCTE
  

 /*

 
 , cteIyr (pKey)
 AS
 (SELECT dil.PassportKey
 FROM dbo.Day4_ItemList AS dil
 INNER JOIN cteByr ON cteByr.pKey = dil.PassportKey
 WHERE SUBSTRING(Item, 1, 3) = 'iyr'
 AND SUBSTRING(Item, 5, 4) >= 2010
 AND SUBSTRING(Item, 5, 4) <= 2020
 )
 , cteEyr (pKey)
 AS
 (SELECT dil.PassportKey
 FROM dbo.Day4_ItemList AS dil
 INNER JOIN cteIyr r ON r.pKey = dil.PassportKey
 WHERE SUBSTRING(Item, 1, 3) = 'eyr'
 AND SUBSTRING(Item, 5, 4) >= 2020
 AND SUBSTRING(Item, 5, 4) <= 2030
 )
 , cteHgt (pKey)
 AS
 (SELECT dil.PassportKey
 FROM dbo.Day4_ItemList AS dil
 INNER JOIN cteEyr r ON r.pKey = dil.PassportKey
 WHERE SUBSTRING(Item, 1, 3) = 'hgt'
 AND (SUBSTRING(Item, 5, 4) >= 2020 
      AND SUBSTRING(REVERSE(item), 1, 2) = 'ni' 
	  AND SUBSTRING(item, 5, CHARINDEX('in', item) - 6) >= 59
	  AND SUBSTRING(item, 5, CHARINDEX('in', item) - 6) <= 76
-- OR (SUBSTRING(Item, 5, 4) <= 2030)
 )
 )
 SELECT * FROM cteHgt
 */