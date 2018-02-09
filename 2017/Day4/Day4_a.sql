--CREATE TABLE Day4
--(
--    passphrase VARCHAR(100)
--)
--GO
--INSERT dbo.Day4
--(
--    passphrase
--)
--VALUES
--   ('aa bb cc dd ee' )
-- , ('aa bb cc dd aa')
-- , ('aa bb cc dd aaa')
--GO
--CREATE FUNCTION dbo.words
--    (@input AS VARCHAR(100))
--RETURNS TABLE
--AS
--RETURN ( SELECT value FROM STRING_SPLIT(@input, ' ') AS ss )
--GO
--TRUNCATE TABLE day4
--GO
--BULK INSERT dbo.Day4 FROM 'e:\Documents\GitHub\AdventofCode\2017\Day4\Day4_Input.txt'
--GO
--SELECT 
-- *
-- FROM dbo.Day4 AS d

-- GO
/*************************************************************************************/
-- Part 1
/*************************************************************************************/
CREATE OR ALTER PROCEDURE Day4_a
AS
BEGIN
    WITH ctePass
    AS
    (
    SELECT d.passphrase ,
           ss.value ,
           cnt = COUNT(*)
    FROM Day4 AS d
        CROSS APPLY dbo.words(d.passphrase) AS ss
    --WHERE d.passphrase = 'aa bb cc dd ee'
    GROUP BY d.passphrase ,
             ss.value
    HAVING COUNT(*) > 1
    ) ,
         cteCount
    AS
    (
    SELECT total = COUNT(*)
    FROM Day4
    ) ,
         cteUnique
    AS
    (
    SELECT ctePass.passphrase ,
           cnt = COUNT(cnt)
    FROM ctePass
    GROUP BY ctePass.passphrase
    )
    SELECT result = COUNT(*)
    FROM cteUnique ,
         cteCount
    GROUP BY cteCount.total;


END;

GO
/****************************************************************************************
*****************************************************************************************
             TEST
*****************************************************************************************
*****************************************************************************************/
EXEC tsqlt.NewTestClass @ClassName = N'tDay4';
GO
CREATE OR ALTER PROCEDURE tDay4.[test Day4a sample data]
AS
BEGIN
    -- Assemble
	EXEC tsqlt.FakeTable @TableName = N'Day4';
	
	INSERT dbo.Day4
(
    passphrase
)
-- SQL Prompt formatting off
VALUES
   ('aa bb cc dd ee' )
 , ('aa bb cc dd aa')
 , ('aa bb cc dd aaa')

-- SQL Prompt formatting on
   CREATE TABLE #Expected (valid INT);
   INSERT #Expected
   ( valid)
   VALUES
   (1  );
   SELECT *
    INTO #actual
	FROM #Expected AS e
	WHERE 1 = 0;


	-- Act
  INSERT #actual
   EXEC dbo.Day4_a;

	-- Assert
	EXEC tsqlt.AssertEqualsTable @Expected = N'#Expected' ,
	                             @Actual = N'#Actual' ,
	                             @Message = N'Incorrect number of valid passphrases';
	
	
END
GO

EXEC tsqlt.run 'tDay4.[test Day4a sample data]';
