/*
-- testing setup
CREATE TABLE Day2
( datavalue varchar(100))
GO
go
select * from Day2
*/
-- setup
TRUNCATE TABLE dbo.Day2
GO
BULK INSERT dbo.Day2 
FROM 'E:\Documents\git\AdventofCode\2020\Day2\Day2_data.txt' WITH ( ROWTERMINATOR = '\n',ERRORFILE = 'E:\Documents\git\AdventofCode\2020\Day2\myRubbishData.log' )

GO
SELECT * FROM day2
GO
ALTER TABLE day2 ADD lowerbound tinyint, upperbound tinyint
ALTER TABLE day2 ADD letter CHAR(1), pwd VARCHAR(50)
GO
SELECT
   datavalue
 , CHARINDEX(':', datavalue)
 , CHARINDEX(' ', datavalue)
 , lowerbound, upperbound, letter, pwd
 FROM dbo.Day2 
 go
-- load data 
UPDATE day2
 SET lowerbound = SUBSTRING(datavalue, 1, CHARINDEX('-', datavalue)-1)
   , upperbound = SUBSTRING(datavalue, CHARINDEX('-', datavalue)+1, CHARINDEX(' ', datavalue)-CHARINDEX('-', datavalue)-1)
   , letter = SUBSTRING(datavalue, CHARINDEX(' ', datavalue)+1, 1)
   , pwd = SUBSTRING(datavalue, CHARINDEX(':', datavalue)+2, 50)
GO

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

WITH cteSolution
AS
(
SELECT letter, 
pwd
, LEN(d.pwd) - LEN( REPLACE(pwd, d.letter, '')) AS occ
, CASE WHEN LEN(d.pwd) - LEN( REPLACE(pwd, d.letter, '')) >= d.lowerbound
    AND LEN(d.pwd) - LEN( REPLACE(pwd, d.letter, '')) <= d.upperbound
	then 1
	ELSE 0
	END AS valid
 FROM dbo.Day2 AS d
 )
 SELECT * FROM cteSolution
 WHERE valid=1
 GO

 


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


WITH cteSolution
AS (   SELECT
            CASE
                WHEN SUBSTRING(pwd, d.lowerbound, 1) = d.letter THEN
                    1
                ELSE
                    0
            END AS firstvalid
          , CASE
                WHEN SUBSTRING(pwd, d.upperbound, 1) = d.letter THEN
                    1
                ELSE
                    0
            END AS secondvalid
       FROM dbo.Day2 AS d)
SELECT COUNT(*)
FROM   cteSolution
WHERE  cteSolution.firstvalid + cteSolution.secondvalid = 1;









/*
drop table Day2
*/


