/*
DROP TABLE Day6
GO
CREATE TABLE Day6
(   SeatCode VARCHAR(10)
);
GO
--TRUNCATE TABLE dbo.Day6
--GO
BULK INSERT dbo.Day6
FROM 'E:\Documents\git\AdventofCode\2020\Day6\Day6_data.txt' WITH ( ROWTERMINATOR = '\n',ERRORFILE = 'E:\Documents\git\AdventofCode\2020\Day6\myRubbishData.log' )
GO
SELECT * FROM Day6
GO
-- change to binary
UPDATE dbo.Day6
 SET SeatCode = REPLACE(SeatCode, 'F',0)
UPDATE dbo.Day6
 SET SeatCode = REPLACE(SeatCode, 'B',1)
UPDATE dbo.Day6
 SET SeatCode = REPLACE(SeatCode, 'L',0)
UPDATE dbo.Day6
 SET SeatCode = REPLACE(SeatCode, 'R',1)
GO
SELECT * FROM Day6
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
-- get the seatID
WITH cteAirplane( ROW, seat)
AS
(SELECT 
  (SUBSTRING(d.SeatCode, 1, 1) * 64) +
  (SUBSTRING(d.SeatCode, 2, 1) * 32 ) +
  (SUBSTRING(d.SeatCode, 3, 1) * 16 ) +
  (SUBSTRING(d.SeatCode, 4, 1) * 8 ) +
  (SUBSTRING(d.SeatCode, 5, 1) * 4	) +
  (SUBSTRING(d.SeatCode, 6, 1) * 2	) +
  (SUBSTRING(d.SeatCode, 7, 1) * 1	) AS row,
  (SUBSTRING(d.SeatCode, 8, 1) * 4	)  +
  (SUBSTRING(d.SeatCode, 9, 1) * 2	)  +
  (SUBSTRING(d.SeatCode, 10, 1) * 1	)  AS seat
 FROM dbo.Day6 AS d
 --ORDER BY row desc
 )
 SELECT (row * 8)+seat AS seatID
 FROM cteAirplane
 ORDER BY seatID DESC


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
-- Find the gap

;WITH cteAirplane( seatid)
AS
(SELECT 
  (
   (
    (SUBSTRING(d.SeatCode, 1, 1) * 64) +
    (SUBSTRING(d.SeatCode, 2, 1) * 32 ) +
    (SUBSTRING(d.SeatCode, 3, 1) * 16 ) +
    (SUBSTRING(d.SeatCode, 4, 1) * 8 ) +
    (SUBSTRING(d.SeatCode, 5, 1) * 4	) +
    (SUBSTRING(d.SeatCode, 6, 1) * 2	) +
    (SUBSTRING(d.SeatCode, 7, 1) * 1	)
   ) * 8
   ) +
    (SUBSTRING(d.SeatCode, 8, 1) * 4	)  +
    (SUBSTRING(d.SeatCode, 9, 1) * 2	)  +
    (SUBSTRING(d.SeatCode, 10, 1) * 1	)  AS seatid
 FROM dbo.Day6 AS d
 ), cteValues (SeatID, diff)
AS
(
SELECT seatid, SeatID - LAG(SeatID,1) OVER (ORDER BY SeatID) AS diff
FROM cteAirplane
) 
SELECT *
 FROM cteValues
 WHERE diff > 1
