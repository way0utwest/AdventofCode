-- Day 4 part 2
--SELECT top 10
-- *
-- FROM dbo.Day4 AS d

GO

--drop FUNCTION IF EXISTS dbo.CheckAnagram;
GO
--/*
CREATE OR ALTER FUNCTION dbo.CheckAnagram
    (@w1 VARCHAR(50)
	, @w2 VARCHAR(50)
)
RETURNS int
AS
begin

declare @r INT;

WITH Src
AS
(
SELECT T.W1 ,
       T.W2
FROM
(
    VALUES
        (@w1, @w2)
) AS T (W1, W2)
) ,
     Numbered
AS
(
SELECT Src.W1 ,
       Src.W2 ,
       Num = ROW_NUMBER() OVER (ORDER BY (SELECT 1))
FROM Src
) ,
     Splitted
AS
(
SELECT Num ,
       Word1 = W1 ,
       Word2 = W2 ,
       L1 = LEFT(W1, 1) ,
       L2 = LEFT(W2, 1) ,
       W1 = SUBSTRING(W1, 2, LEN(W1)) ,
       W2 = SUBSTRING(W2, 2, LEN(W2))
FROM Numbered
UNION ALL
SELECT Num ,
       Word1 ,
       Word2 ,
       L1 = LEFT(W1, 1) ,
       L2 = LEFT(W2, 1) ,
       W1 = SUBSTRING(W1, 2, LEN(W1)) ,
       W2 = SUBSTRING(W2, 2, LEN(W2))
FROM Splitted
WHERE LEN(W1) > 0
      AND LEN(W2) > 0
) ,
     SplitOrdered
AS
(
SELECT Splitted.Num ,
       Splitted.Word1 ,
       Splitted.Word2 ,
       Splitted.L1 ,
       Splitted.L2 ,
       Splitted.W1 ,
       Splitted.W2 ,
       LNum1 = ROW_NUMBER() OVER (PARTITION BY Num ORDER BY L1) ,
       LNum2 = ROW_NUMBER() OVER (PARTITION BY Num ORDER BY L2)
FROM Splitted
)
SELECT @r =  CASE
                  WHEN COUNT(*) = LEN(S1.Word1)
                       AND COUNT(*) = LEN(S1.Word2) THEN
                      1
                  ELSE
                      0
              END
FROM SplitOrdered AS S1
    JOIN
    SplitOrdered AS S2
        ON S1.L1 = S2.L2
           AND S1.Num = S2.Num
           AND S1.LNum1 = S2.LNum2
GROUP BY S1.Num ,
         S1.Word1 ,
         S1.Word2

IF @r IS NULL 
 SET @r = 0
RETURN @r
end
GO


--*/

SELECT dbo.CheckAnagram('ooii', 'oiii');
GO

CREATE OR ALTER FUNCTION dbo.SplitandCheck
    (@string AS VARCHAR(100))
RETURNS int
AS
BEGIN
DECLARE @r INT = 0;

IF @r = 0
 AND EXISTS(
  SELECT COUNT(*)
  FROM STRING_SPLIT(@string, ' ') AS ss
  GROUP BY ss.value
  HAVING COUNT(*) > 1
 )
 SET @r = 1
ELSE
WITH mycte
AS
(
SELECT checks = CASE WHEN a.value = b.value then 0
       ELSE dbo.CheckAnagram(a.value, b.value)
	   end
FROM STRING_SPLIT(@string, ' ') AS a CROSS JOIN STRING_SPLIT(@string, ' ') AS b
)
SELECT @r = SUM(a.checks)
 FROM mycte a

RETURN @r
END

GO
CREATE OR ALTER PROCEDURE Day4_b
as
BEGIN
    WITH mycte
    AS
    (
    SELECT d.passphrase, IsAnagram = dbo.SplitandCheck(d.passphrase)
     FROM dbo.Day4 AS d 
    )
    SELECT result = COUNT(*)
     FROM mycte
      WHERE mycte.IsAnagram = 0
     GROUP BY mycte.IsAnagram
    
END
-- SELECT 512-269 = 243
go

CREATE OR ALTER PROCEDURE tDay4.[test Day4b sample data]
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
   ('abcde fghij' )
 , ('abcde xyz ecdab')
 , ('a ab abc abd abf abj')
 , ('iiii oiii ooii oooi oooo')
 , ('oiii ioii iioi iiio')

-- SQL Prompt formatting on
   CREATE TABLE #Expected (valid INT);
   INSERT #Expected
   ( valid)
   VALUES
   (3  );
   SELECT *
    INTO #actual
	FROM #Expected AS e
	WHERE 1 = 0;


	-- Act
  INSERT #actual
   EXEC dbo.Day4_b;

	-- Assert
	EXEC tsqlt.AssertEqualsTable @Expected = N'#Expected' ,
	                             @Actual = N'#Actual' ,
	                             @Message = N'Incorrect number of valid passphrases';
	
	
END
GO

EXEC tsqlt.run 'tDay4.[test Day4b sample data]';
