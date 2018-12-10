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
 CREATE OR ALTER PROCEDURE Day2a
AS
BEGIN
    DECLARE @i INT = 1;

	WITH myTally(n)
	AS
	(SELECT n = ROW_NUMBER() OVER (ORDER BY (SELECT null))
	 FROM (VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10)) a(n)
	  CROSS JOIN (VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10)) b(n)
	),
	cteLetters (boxnumber, boxid, letter)
	AS
	(SELECT d.Boxnumber, d.boxid, SUBSTRING(d.boxid, t.n, 1)
	 FROM dbo.Day2 AS d
	 CROSS APPLY (SELECT TOP (26) n FROM myTally ORDER BY n) t
	 ),
	 cteCount  (boxnumber, boxid, letter, lettercount)
	 AS
     (SELECT boxnumber, boxid, letter, COUNT(*)
	  FROM cteLetters
	  GROUP BY cteLetters.boxnumber, cteLetters.boxid, cteLetters.letter
	  )
	  , cteSum AS
      ( SELECT boxid, MAX(CASE WHEN cteCount.lettercount = 3 THEN 1 ELSE 0 END) AS triple
	  , MAX(CASE WHEN cteCount.lettercount = 2 THEN 1 ELSE 0 END) AS dbl
	   FROM cteCount
	   GROUP BY cteCount.boxid
	  )
	  SELECT @i = SUM(cteSum.triple) * SUM(dbl)
	   FROM cteSum
    RETURN @i
END
GO
CREATE OR ALTER PROCEDURE tsqltests.[test Day2a]
AS
BEGIN
    ---------------
    -- Assemble
    ---------------
    DECLARE
        @expected INT = 12,
        @actual   INT;

	EXEC tsqlt.faketable @TableName = 'Day2', @SchemaName = 'dbo';
	INSERT dbo.Day2 (Boxnumber, boxid) VALUES
(1, 'abcdef'),
(2, 'bababc'),
(3, 'abbcde'),
(4, 'abcccd'),
(5, 'aabcdd'),
(6, 'abcdee'),
(7, 'ababab')

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
    EXEC @actual = dbo.Day2a;

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
DECLARE @i INT = 0
EXEC @i = dbo.Day2a
SELECT @i