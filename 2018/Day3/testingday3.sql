CREATE OR ALTER PROCEDURE tsqltests.[test Day3a]
AS
BEGIN
    ---------------
    -- Assemble
    ---------------
    DECLARE
        @expected INT = 4,
        @actual   INT;

	EXEC tsqlt.faketable @TableName = 'Day3', @SchemaName = 'dbo';
	INSERT dbo.Day3 (ClaimNumber, claimstartx, claimstarty, claimwidth, claimheight) 
	VALUES
       (1, 1, 3, 4, 4),
       (2, 3, 1, 4, 4 ),
       (3, 5, 5, 2, 2)

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
    EXEC @actual = dbo.Day3a;

    ---------------
    -- Assert    
    ---------------
    EXEC tSQLt.AssertEquals
        @Expected = @expected,
        @Actual = @actual,
        @Message = N'An incorrect claim calculation occurred.';
END;
GO
EXEC tsqlt.run 'tsqltests.[test Day3a]';

/*
Once tests work, run this

DECLARE @i INT = 0;
EXEC @i = dbo.Day3a;
SELECT @i;
*/
go
CREATE OR ALTER PROCEDURE tsqltests.[test Day3b]
AS
BEGIN
    ---------------
    -- Assemble
    ---------------
    DECLARE
        @expected INT = 3,
        @actual   INT;

	EXEC tsqlt.faketable @TableName = 'Day3', @SchemaName = 'dbo';
	INSERT dbo.Day3 (ClaimNumber, claimstartx, claimstarty, claimwidth, claimheight) 
	VALUES
       (1, 1, 3, 4, 4),
       (2, 3, 1, 4, 4 ),
       (3, 5, 5, 2, 2)

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
    EXEC @actual = dbo.Day3b;

    ---------------
    -- Assert    
    ---------------
    EXEC tSQLt.AssertEquals
        @Expected = @expected,
        @Actual = @actual,
        @Message = N'An incorrect claim calculation occurred.';
END;
GO
EXEC tsqlt.run 'tsqltests.[test Day3b]';
