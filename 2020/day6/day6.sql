/*
DROP TABLE Day6
GO
CREATE TABLE Day6 
(LineKey INT NOT NULL IDENTITY(1,1) CONSTRAINT Day6PK PRIMARY KEY
, LineVal VARCHAR(100)
)
GO
TRUNCATE TABLE dbo.Day6
GO
CREATE VIEW Day6_Load
AS
SELECT dgo.LineVal
 FROM dbo.Day6 AS dgo
go
BULK INSERT dbo.Day6_Load
FROM 'E:\Documents\git\AdventofCode\2020\Day6\Day6_data.txt' WITH ( ROWTERMINATOR = '\n',ERRORFILE = 'E:\Documents\git\AdventofCode\2020\Day6\myRubbishData.log' )
GO
SELECT * FROM Day6
GO


CREATE TABLE Day6_Groups
( GroupKey INT NOT NULL IDENTITY(1,1) CONSTRAINT Day6GroupPK PRIMARY KEY
, groupanswers VARCHAR(1000)
)
GO

DECLARE pcurs CURSOR FOR SELECT lineval FROM Day6 ORDER BY linekey;
DECLARE
    @val VARCHAR(1000) = ''
  , @groups VARCHAR(1000);
OPEN pcurs;
FETCH NEXT FROM pcurs
INTO @val;
SET @groups = '';
WHILE @@FETCH_STATUS = 0
BEGIN
    IF @val > ''
        SELECT @groups += ' ' + @val;
    ELSE
    BEGIN
        INSERT dbo.Day6_Groups (groupanswers) VALUES (@groups);
        SET @groups = '';
    END;
    FETCH NEXT FROM pcurs
    INTO @val;
END;
    INSERT dbo.Day6_Groups(groupanswers) VALUES (@groups);
DEALLOCATE pcurs;
GO
UPDATE dbo.Day6_Groups
 SET groupanswers = REPLACE(groupanswers, ' ', '')
GO
 
SELECT * FROM Day6_Groups;
GO
*/
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
-- Need to total the unique answers
-- string split each row and get distinct values.
/*
ALTER TABLE dbo.Day6_Groups ADD deduppedanswers VARCHAR(500)
go
-- Use the dedup function for strings to remove duplicates
UPDATE dbo.Day6_Groups
 SET deduppedanswers =  DBO.REMOVE_DUPLICATE_INSTR(1,groupanswers)
GO
*/
-- sum the length of the de-duped answers
SELECT SUM(LEN(dg.deduppedanswers)) FROM dbo.Day6_Groups AS dg



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


/*
-- We now need to find duplicates, so we reload data, separating each group by a comma.
CREATE TABLE Day6_Part2
( groupid INT NOT NULL IDENTITY CONSTRAINT Day62PK PRIMARY KEY
, Groupanswers VARCHAR(500)
)
DECLARE pcurs CURSOR FOR SELECT lineval FROM Day6 ORDER BY linekey;
DECLARE
    @val VARCHAR(1000) = ''
  , @groups VARCHAR(1000);
OPEN pcurs;
FETCH NEXT FROM pcurs
INTO @val;
SET @groups = '';
WHILE @@FETCH_STATUS = 0
BEGIN
    IF @val > ''
        SELECT @groups += ',' + @val;
    ELSE
    BEGIN
        INSERT dbo.Day6_Part2 (groupanswers) VALUES (@groups);
        SET @groups = '';
    END;
    FETCH NEXT FROM pcurs
    INTO @val;
END;
    INSERT dbo.Day6_Part2(groupanswers) VALUES (@groups);
DEALLOCATE pcurs;

GO
UPDATE dbo.Day6_Part2
 SET Groupanswers = SUBSTRING(Groupanswers, 2, LEN(Groupanswers))
GO
*/
;WITH cteGroups (groupid, item)
AS
(
SELECT dp.groupid, dsk.Item FROM dbo.Day6_Part2 AS dp
  CROSS APPLY dbo.DelimitedSplit8K(dp.Groupanswers, ',') AS dsk
)
--SELECT cteGroups.item
--, LAG(cteGroups.item, 1, NULL) OVER (PARTITION BY cteGroups.groupid ORDER BY item)
--, cteGroups.groupid
-- FROM cteGroups

, cteStrings (string1, string2, groupid)
AS
( SELECT cteGroups.item
, LAG(cteGroups.item, 1, NULL) OVER (PARTITION BY cteGroups.groupid ORDER BY item)
, cteGroups.groupid
 FROM cteGroups
 )
, cteResult( groupid, string1, string2, result)
AS (
select groupid
	, String1
    , String2
    , Result = sum(CharCount)
from
(
    select s.string1
        , String2
        , Charcount = max(case when CHARINDEX(substring(String2, t.N, 1), String1, 0) > 0 then 1 else 0 end)
		, groupid
    from cteStrings AS s
    join cteTally t on t.N <= len(String2)
	WHERE string2 IS NOT null
    group by groupid
	    , String1
        , String2
        , substring(String2, t.N, 1)
) x
group by groupid
		, String1
        , String2
)
, cteMin (groupid, minvalue)
AS (
SELECT groupid, MIN(result) 
 FROM cteResult
 GROUP BY groupid
 )
 SELECT SUM(minvalue)
  FROM cteMin

