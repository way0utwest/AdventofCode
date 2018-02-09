-- Day 6
CREATE TABLE Day6_test
( CycleKey INT IDENTITY(0,1)
, Bank1 INT
, Bank2 INT
, Bank3 INT
, Bank4 INT)
GO
EXEC tsqlt.NewTestClass @ClassName = N'tDay6';
GO
CREATE OR ALTER PROCEDURE tDay6.[test Day6 initial input]
AS
BEGIN
    ---------------
    -- Assemble
    ---------------
    DECLARE
        @expected INT = 5,
        @actual   int;
    
	EXEC tsqlt.faketable @TableName = 'Day6_Test', @SchemaName = 'dbo', @Identity = 1;
	INSERT Day6_Test (Bank1, Bank2, Bank3, Bank4)
	 VALUES (0, 2, 7, 0)
	



    ---------------
    -- Act
    ---------------
    Exec @actual = dbo.Day6a_test;

    ---------------
    -- Assert    
    ---------------
    EXEC tSQLt.AssertEquals
        @Expected = @expected,
        @Actual = @actual,
        @Message = N'An incorrect calculation occurred.';
END;
GO

-- Solution
CREATE OR ALTER PROCEDURE Day6a_test
AS
BEGIN

    DECLARE @count INT ,
            @loop BIT = 1,
			@max INT,
			@TotalToReDist INT
			, @Blocksperbank INT
			, @CurrentMaxBank int;

    WHILE @loop = 1
    BEGIN
	     -- Get max value in banks
	     SELECT @TotalToReDist = 
		      CASE WHEN Bank1 >= bank2 AND bank1 >= bank3 AND bank1 >= bank4
			     THEN bank1
				 WHEN bank2 > bank1 AND bank2 >= bank3 AND bank2 >= dt.Bank4
				 THEN dt.Bank2
				 WHEN bank3 > bank1 AND bank3 > bank2 AND bank3 >= dt.Bank4
				 THEN dt.Bank3
				 ELSE Bank4
				 END,
				 @CurrentMaxBank = 
		      CASE WHEN Bank1 >= bank2 AND bank1 >= bank3 AND bank1 >= bank4
			     THEN 1
				 WHEN bank2 > bank1 AND bank2 >= bank3 AND bank2 >= dt.Bank4
				 THEN 2
				 WHEN bank3 > bank1 AND bank3 > bank2 AND bank3 >= dt.Bank4
				 THEN 3
				 ELSE 4
				 END
				FROM dbo.Day6_test AS dt
				 WHERE dt.CycleKey = @max;
		  
		  SELECT @Blocksperbank = @TotalToReDist / 4;

		  -- insert the next cycle, 0 for max
		  INSERT dbo.Day6_test
		  (
		      Bank1 ,
		      Bank2 ,
		      Bank3 ,
		      Bank4
		  )
		  SELECT CASE WHEN @CurrentMaxBank = 1
		              THEN 0 ELSE dt.Bank1 end,
                 CASE WHEN @CurrentMaxBank = 2
		              THEN 0 ELSE dt.Bank2 end,
                 CASE WHEN @CurrentMaxBank = 3
		              THEN 0 ELSE dt.Bank3 end,
                 CASE WHEN @CurrentMaxBank = 4
		              THEN 0 ELSE dt.Bank4 end
			FROM dbo.Day6_test AS dt
		  WHERE dt.CycleKey = @max;

		  -- Update the next cycle with new totals
UPDATE dbo.Day6_test
SET Bank1 = CASE
                WHEN @CurrentMaxBank = 1 THEN
                    @Blocksperbank
                ELSE
                    Bank1 + @Blocksperbank
            END
  , Bank2 = CASE
                WHEN @CurrentMaxBank = 2 THEN
                    @Blocksperbank
                ELSE
                    Bank2 + @Blocksperbank
            END
  , Bank3 = CASE
                WHEN @CurrentMaxBank = 3 THEN
                    @Blocksperbank
                ELSE
                    Bank3 + @Blocksperbank
            END
  , Bank4 = CASE
                WHEN @CurrentMaxBank = 4 THEN
                    @Blocksperbank
                ELSE
                    Bank4 + @Blocksperbank
            END
WHERE CycleKey = @max + 1;

        -- If a dupe exists, stop        
        IF EXISTS
        (
            SELECT Bank1 ,
                   Bank2 ,
                   Bank3 ,
                   Bank4 ,
                   COUNT(*)
            FROM dbo.Day6_test AS dt
            GROUP BY dt.Bank1 ,
                     dt.Bank2 ,
                     dt.Bank3 ,
                     dt.Bank4
            HAVING COUNT(*) > 1
        )
            SET @loop = 0;
    END;
    SELECT @count = MAX(CycleKey)
    FROM Day6_test;

    RETURN @count;

END;
GO
EXEC tsqlt.run 'tDay6.[test Day6 initial input]';
