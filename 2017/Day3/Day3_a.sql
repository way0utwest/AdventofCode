-- Day 3 _a


-- Get squares
--WITH myTally(n)
--AS
--(SELECT n = ROW_NUMBER() OVER (ORDER BY (SELECT null))
-- FROM (VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10)) a(n)
--  CROSS JOIN (VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10)) b(n)
--  CROSS JOIN (VALUES (1), (2), (3), (4), (5), (6), (7)) c(n)
--)
--SELECT n, POWER(n, 2)
--FROM myTally
--WHERE POWER(n,2) >= 368078

-- 607


-- Cell 1 IS 304, 304
-- size is 607, 607
-- Test 10x10
--CREATE TABLE Day3
--(RowKey INT IDENTITY(1,1))
--GO
--DECLARE @i INT = 4, @counter INT = 1, @cmd VARCHAR(1000);
--WHILE @counter <= @i
--BEGIN
--    SELECT @cmd = 'alter table Day3 add c' + rtrim(CAST(@counter AS CHAR(4))) + ' int'
--	--PRINT @cmd
--    EXEC(@cmd)
--    SET @counter = @counter + 1;
--END

--GO
-- insert data
-- find center
DECLARE @size INT = 5, @x INT, @y INT, @counter INT = 1, @direction CHAR(1) = 'L', @increment INT = 1;
SET @x = ROUND(@size / 2.0, 0);
set @y = (@size / 2) + 1;
WHILE @counter <= (@size * @size)
BEGIN
    select counter = @counter, x = @x, y = @y, direction = @direction, increment = @increment

    -- Adjust increment if needed
	IF (@counter % @size) = 0
	  SET @increment = @increment + 1;

    IF @direction = 'L'
    BEGIN
        SET @direction = 'D';
        SET @x = @x - (1 * @increment);
    END
	ELSE IF @direction = 'D'
	BEGIN
		SET @direction = 'R';
	    SET @y = @y + (1 * @increment);
	END
    ELSE IF @direction = 'R'
    BEGIN
    	IF (@counter % @size) <> 0
			SET @direction = 'U';
        SET @x = @x + (1 * @increment);
    
    END
	ELSE IF @direction = 'U'
	BEGIN
		SET @direction = 'L';
	    SET @y = @y - (1 * @increment);
	END
    SET @counter= @counter + 1;
END

GO
--SELECT
-- *
-- FROM dbo.Day3 AS d
-- ORDER BY d.RowKey
-- GO
 
 
--DROP TABLE dbo.Day3


GO
-- Math solution from Reddit hints
--declare @n int = 368078, @l int = 607, @right int;
--SELECT @l = CEILING((SQRT(@n) -1) / 2);
--SELECT @right = (2 * (@l * @l)) - (2 * @l + 2);
--select @l + ABS( (@n - @right) % @l)
--SELECT SQRT(368078) / 2
---- layer = 607
--SELECT (368078 - 1) % (2 * 607)
---- 235
--SELECT ABS(235 - 607)
---- 372
--SELECT 372 + 607

