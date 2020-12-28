USE AdventofCode
/*
*************************************************
*************************************************
     Setup
*************************************************
*************************************************
drop table day3
go
drop view day3import
go

CREATE TABLE day3(
rowkey INT NOT NULL IDENTITY(1,1) CONSTRAINT day3pk PRIMARY KEY
, dataval VARCHAR(2000)
)
GO
CREATE VIEW day3import AS
SELECT dataval
 FROM day3
 GO
*/
 
TRUNCATE TABLE dbo.Day3
GO
BULK INSERT dbo.Day3import 
FROM 'E:\Documents\git\AdventofCode\2020\Day3\Day3_data.txt' WITH ( ROWTERMINATOR = '\n',ERRORFILE = 'E:\Documents\git\AdventofCode\2020\Day3\myRubbishData.log' )
GO
SELECT * FROM day3 ORDER BY rowkey
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
DECLARE @right INT = 3,
        @down INT = 1,
		@rows INT,
		@currentrow INT = 1,
		@currentcol int = 1,
		@trees int = 0,
		@width tinyint;

SELECT @rows = MAX(rowkey) FROM day3
SELECT @width = LEN(dataval) FROM day3 WHERE rowkey = 1


WHILE @currentrow <= @rows
 BEGIN
   SELECT @currentcol += @right
   IF @currentcol > @width 
     SELECT @currentcol = @currentcol - @width
   SELECT @currentrow += @down;

   SELECT @trees = @trees + CASE
      WHEN SUBSTRING(dataval, @currentcol, 1) = '#' THEN 1
	  ELSE 0
   end
    FROM day3
	WHERE rowkey = @currentrow
 END
SELECT @trees AS TreeCount
go
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
DECLARE @right INT = 1,
        @down INT = 1,
		@rows INT,
		@currentrow INT = 1,
		@currentcol int = 1,
		@trees1 int = 0,
		@trees2 int = 0,
		@trees3 int = 0,
		@trees4 int = 0,
		@trees5 int = 0,
		@width tinyint;

SELECT @rows = MAX(rowkey) FROM day3
SELECT @width = LEN(dataval) FROM day3 WHERE rowkey = 1


WHILE @currentrow <= @rows
 BEGIN
   SELECT @currentcol += @right
   IF @currentcol > @width 
     SELECT @currentcol = @currentcol - @width
   SELECT @currentrow += @down;

   SELECT @trees1 = @trees1 + CASE
      WHEN SUBSTRING(dataval, @currentcol, 1) = '#' THEN 1
	  ELSE 0
   end
    FROM day3
	WHERE rowkey = @currentrow
 END

 -- Second case
SELECT @currentcol = 1;
SELECT @currentrow = 1;
SELECT @right = 3;
SELECT @down = 1;

WHILE @currentrow <= @rows
 BEGIN
   SELECT @currentcol += @right
   IF @currentcol > @width 
     SELECT @currentcol = @currentcol - @width
   SELECT @currentrow += @down;

   SELECT @trees2 = @trees2 + CASE
      WHEN SUBSTRING(dataval, @currentcol, 1) = '#' THEN 1
	  ELSE 0
   end
    FROM day3
	WHERE rowkey = @currentrow
 END

-- Third case
SELECT @currentcol = 1;
SELECT @currentrow = 1;
SELECT @right = 5;
SELECT @down = 1;

WHILE @currentrow <= @rows
 BEGIN
   SELECT @currentcol += @right
   IF @currentcol > @width 
     SELECT @currentcol = @currentcol - @width
   SELECT @currentrow += @down;

   SELECT @trees3 = @trees3 + CASE
      WHEN SUBSTRING(dataval, @currentcol, 1) = '#' THEN 1
	  ELSE 0
   end
    FROM day3
	WHERE rowkey = @currentrow
 END

-- Fourth case
SELECT @currentcol = 1;
SELECT @currentrow = 1;
SELECT @right = 7;
SELECT @down = 1;

WHILE @currentrow <= @rows
 BEGIN
   SELECT @currentcol += @right
   IF @currentcol > @width 
     SELECT @currentcol = @currentcol - @width
   SELECT @currentrow += @down;

   SELECT @trees4 = @trees4 + CASE
      WHEN SUBSTRING(dataval, @currentcol, 1) = '#' THEN 1
	  ELSE 0
   end
    FROM day3
	WHERE rowkey = @currentrow
 END

-- Fifth case
SELECT @currentcol = 1;
SELECT @currentrow = 1;
SELECT @right = 1;
SELECT @down = 2;

WHILE @currentrow <= @rows
 BEGIN
   SELECT @currentcol += @right
   IF @currentcol > @width 
     SELECT @currentcol = @currentcol - @width
   SELECT @currentrow += @down;

   SELECT @trees5 = @trees5 + CASE
      WHEN SUBSTRING(dataval, @currentcol, 1) = '#' THEN 1
	  ELSE 0
   end
    FROM day3
	WHERE rowkey = @currentrow
 END

SELECT @trees1,
@trees2,
@trees3,
@trees4, @trees5,
@trees1 *@trees2 *  @trees3* @trees4 *@trees5 AS TreeCount












/*
drop table Day3
*/


