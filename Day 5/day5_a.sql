--CREATE TABLE Day5 ( teststring VARCHAR(100))
--;
--GO
--DECLARE @cmd VARCHAR(8000) 
--SELECT @cmd = 'BULK insert Day5
--                from ''C:\Users\Steve\Documents\GitHub\AdventofCode\Day 5\input.txt''
--                with ( ROWTERMINATOR = ''' + Char(10) + ''')'
--EXEC(@cmd) 
--go
--SELECT 
-- * FROM dbo.Day5

WITH cteString
AS
(
SELECT   
      teststring
	  , enoughvowels = CASE WHEN LEN( REPLACE( 
                                       REPLACE(
				                        REPLACE( 
						                 REPLACE(
		                                  REPLACE(teststring, 'a', '')
				                         , 'e', '')
							            , 'i', '')
						               , 'o', '')
   	                                  , 'u', '')
					            ) <= (LEN(teststring) - 3)
			THEN 1
			ELSE 0
			END
      , testnoinvalidcharacters = 
	       CASE WHEN LEN( REPLACE(
		                    REPLACE(
		                      REPLACE( 
							    REPLACE(teststring, 'ab', '')
							    , 'cd', '')
  							  , 'pq', '')
						    , 'xy', '')
						)
		             = LEN(teststring)
           THEN 1
		   ELSE 0
		   END
  , hasdoubleletter =
     CASE WHEN LEN(teststring) > LEN(
	                                 REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
	                                 REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
	                                 REPLACE(REPLACE(REPLACE(REPLACE(teststring, 'aa', ''), 'bb', ''), 'cc', ''), 'dd', '')
									 , 'ee', ''), 'ff', ''), 'gg', ''), 'hh', ''), 'ii', ''), 'jj', ''), 'kk', ''), 'll', '')
									 , 'mm', ''), 'nn', ''), 'oo', ''), 'pp', ''), 'qq', ''), 'rr', ''), 'ss', '')
									 , 'tt', ''), 'uu', ''), 'vv', ''), 'ww', ''), 'xx', ''), 'yy', ''), 'zz', '')
	                                )
          THEN 1
          ELSE 0
          end
 FROM Day5
 )
 , cteValid
 AS
 (
 SELECT 
   cteString.teststring
 , cteString.enoughvowels
 , cteString.testnoinvalidcharacters
 , cteString.hasdoubleletter
 , nice = CASE WHEN cteString.enoughvowels +
		             cteString.testnoinvalidcharacters +
					 cteString.hasdoubleletter
					 = 3
		       THEN 1
			   ELSE 0
			   end
  FROM cteString
)
SELECT 
   COUNT(nice)
 FROM cteValid
 WHERE nice = 1



