-- DAY 5 a
-- drop table Day5
--CREATE TABLE Day5
--( InstructionKey INT IDENTITY(1,1)
--, Instruction INT)
--GO
--CREATE VIEW Day5V
--AS
--SELECT d.Instruction FROM dbo.Day5 AS d
--GO
---- reusable code
/*
 TRUNCATE TABLE dbo.Day5
 BULK INSERT Day5V FROM 'e:\Documents\GitHub\AdventofCode\2017\Day5\Input.txt' WITH (ROWTERMINATOR='\n')
*/
--GO
-- SELECT * FROM dbo.Day5 AS d

--TRUNCATE TABLE dbo.Day5
--INSERT Day5 VALUES (0), (3), (0), (1), (-3)
--GO
--SELECT TOP 10
--    d.InstructionKey ,
--    d.Instruction
--FROM dbo.Day5 AS d;

CREATE OR ALTER PROCEDURE SolveDay5a
as
BEGIN
    DECLARE @end INT ,
            @CurrentInstructionKey INT = 1 ,
            @Instruction INT ,
            @NextInstructionKey INT ,
            @counter INT = 0;
    SELECT @end = MAX(InstructionKey) + 1
    FROM dbo.Day5 AS d;
    
    -- SELECT [end] = @end;
    
    WHILE @CurrentInstructionKey < @end
    BEGIN
        SET @counter = @counter + 1;
        SELECT @Instruction = Instruction
        FROM Day5
        WHERE InstructionKey = @CurrentInstructionKey;
        SELECT @NextInstructionKey = @CurrentInstructionKey + @Instruction;
        UPDATE dbo.Day5
        SET Instruction = Instruction + 1
        WHERE InstructionKey = @CurrentInstructionKey;
        SET @CurrentInstructionKey = @NextInstructionKey;
    --PRINT @CurrentInstruction
    END;
    
    Return @counter     
    
END
	   go
EXEC tsqlt.NewTestClass @ClassName = N'tDay5';
GO
CREATE OR ALTER PROCEDURE tDay5.[test day5 a initial set]
AS
BEGIN

-- Assemble
DECLARE @actual INT = 0, @expected INT = 5;

EXEC tsqlt.FakeTable @TableName = N'Day5' , @Identity = 1
INSERT Day5
VALUES
  (0 ), (3), (0), (1), (-3);

-- Act
EXEC @actual = SolveDay5a;

-- Assert
EXEC tsqlt.AssertEquals @Expected = @expected, @Actual = @actual, @Message = N'Failed to account'

END    
GO
EXEC tsqlt.Run @TestName = N'tDay5.[test day5 a initial set]'

