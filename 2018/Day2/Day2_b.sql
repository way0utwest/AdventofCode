-- Load Data
--DROP TABLE dbo.Day2
--CREATE TABLE dbo.Day2
--( Boxnumber INT
--, boxid VARCHAR(100)
--)
--GO
--INSERT dbo.Day2 (boxnumber,boxid)
--SELECT  ca1.ItemNumber,
--        ca2.Item
--FROM    OPENROWSET(BULK 'e:\Documents\GitHub\AdventofCode\2018\Day2\input.txt', SINGLE_CLOB) dt(FileData)
--CROSS APPLY dbo.Split(dt.FileData, CHAR(10)) ca1
--CROSS APPLY (VALUES(REPLACE(ca1.Item, CHAR(13), ''))) ca2(Item);
GO
CREATE OR ALTER PROCEDURE Day2b
  @r VARCHAR(50) out
AS
BEGIN

WITH Tens    (N) AS (SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL 
                     SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL
                     SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1),
     Hundreds(N) AS (SELECT 1 FROM Tens t1, Tens t2),
     Millions(N) AS (SELECT 1 FROM Hundreds t1, Hundreds t2, Hundreds t3),
     Tally   (N) AS (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) FROM Millions),
cte1 AS
(
    SELECT  ItemNumber =Boxnumber, Item = boxid, LEN(boxid) AS DataSize
    FROM    Day2 
), cte2 AS
(
    SELECT  ca.N,
            -- get the letters before "N"
            CASE WHEN N > 1 
                 THEN SUBSTRING(cte1.Item, 1, N-1) 
                 ELSE '' 
            END + 
            -- get the letters after "N"
            CASE WHEN N < cte1.DataSize 
                 THEN SUBSTRING(cte1.Item, N+1, cte1.DataSize) 
                 ELSE '' 
            END AS CommonLtrs
    FROM    cte1
    -- for each row, just use the #s for the # of letters in that row
    CROSS APPLY (SELECT TOP (DataSize) N FROM Tally ORDER BY N) ca
)
SELECT  @r = cte2.CommonLtrs
FROM    cte2
GROUP BY N, CommonLtrs
HAVING COUNT(*) > 1;

RETURN

END
GO
CREATE OR ALTER PROCEDURE tsqltests.[test Day2b]
AS
BEGIN
    ---------------
    -- Assemble
    ---------------
    DECLARE
        @expected VARCHAR(26) = 'fgij',
        @actual   VARCHAR(26);

	EXEC tsqlt.faketable @TableName = 'Day2', @SchemaName = 'dbo';
	INSERT dbo.Day2 (Boxnumber, boxid) VALUES
(1, 'abcde'),
(2, 'fghij'),
(3, 'klmno'),
(4, 'pqrst'),
(5, 'fguij'),
(6, 'axcye'),
(7, 'wvxyz')

 --   CREATE TABLE #Expected
	--( MyID INT
	--)
	--INSERT #Expected (MyID) 
	--VALUES (0)

	--SELECT TOP 0
	--INTO #Actual
	--FROM #Expected

    ---------------
    -- Act
    ---------------
    EXEC dbo.Day2a @actual;

    ---------------
    -- Assert    
    ---------------
    EXEC tSQLt.AssertEquals
        @Expected = @expected,
        @Actual = @actual,
        @Message = N'An incorrect checksum calculation occurred.';
END;
GO
EXEC tsqlt.run 'tsqltests.[test Day2a]';
GO

DECLARE @i VARCHAR(50)
EXEC dbo.Day2b @i out
SELECT @i