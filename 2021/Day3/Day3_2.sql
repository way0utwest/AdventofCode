USE AdventofCode;
GO

/*
drop table if exists [2021].Day3_test
go
CREATE TABLE [2021].Day3_test
( DiagnosticBit CHAR(5))
GO
INSERT [2021].Day3_Test
(
    DiagnosticBit
)
VALUES
('00100'),
('11110'),
('10110'),
('10111'),
('10101'),
('01111'),
('00111'),
('11100'),
('10000'),
('11001'),
('00010'),
('01010')
GO
*/

-- load in part 1

--- function

CREATE OR ALTER FUNCTION [dbo].[BinaryToDecimal]
(@Input VARCHAR(255))
RETURNS BIGINT
AS
BEGIN
    DECLARE @Cnt TINYINT = 1;
    DECLARE @Len TINYINT = LEN (@Input);
    DECLARE @Output BIGINT = CAST(SUBSTRING (@Input, @Len, 1) AS BIGINT);
    WHILE (@Cnt < @Len)
    BEGIN
        SET @Output = @Output + POWER (CAST(SUBSTRING (@Input, @Len - @Cnt, 1) * 2 AS BIGINT), @Cnt);
        SET @Cnt = @Cnt + 1;
    END;
    RETURN @Output;
END;
GO

--part 2
DECLARE
    @o2gen VARCHAR(12)
  , @c02scrubber VARCHAR(12)
  , @i INT = 1
  , @onebit INT
  , @zerobit INT
  , @end TINYINT
  , @result VARCHAR(12) = ''
  , @remaining INT
  , @debug int = 0;
SELECT d.DiagnosticBit INTO #Day3Tmp FROM [2021].Day3 AS d;
SET @end =
    (SELECT TOP 1 LEN (DiagnosticBit) FROM #Day3Tmp);
WHILE @i < @end
BEGIN
    SELECT
         @onebit = SUM (CASE
                            WHEN SUBSTRING (dt.DiagnosticBit, @i, 1) = 1 THEN
                                1
                            ELSE
                                0
                        END)
       , @zerobit = SUM (CASE
                             WHEN SUBSTRING (dt.DiagnosticBit, @i, 1) = 1 THEN
                                 0
                             ELSE
                                 1
                         END)
    FROM #Day3Tmp AS dt;
    IF @onebit >= @zerobit
    BEGIN
        -- more 1s
        SELECT @result += '1';
        DELETE #Day3Tmp WHERE SUBSTRING (DiagnosticBit, @i, 1) = '0';
    -- more 1s
    END;
    ELSE
    BEGIN
        -- more 0s
        SELECT @result += '0';
        DELETE #Day3Tmp WHERE SUBSTRING (DiagnosticBit, @i, 1) = '1';
    -- more 0s
    END;

    SELECT @remaining = COUNT (*) FROM #Day3Tmp AS dt;

    IF @remaining = 2
    BEGIN
        SELECT @o2gen = dt.DiagnosticBit
        FROM   #Day3Tmp AS dt
        WHERE  SUBSTRING (dt.DiagnosticBit, @i + 1, 1) = '1';
        SELECT @i = @end;
    END
	else
    IF @remaining = 1
    BEGIN
        SELECT @o2gen = dt.DiagnosticBit FROM #Day3Tmp AS dt;
        SELECT @i = @end;
    END;
	IF @debug = 1
SELECT
    @i AS i
  , @result AS result
  , @remaining AS cntremain
  , @onebit AS onebit
  , @zerobit AS zerobit
  , @o2gen AS o2;
    SELECT @i += 1;
-- outer loop    
END;
SELECT @result, @o2gen, dbo.BinaryToDecimal (@o2gen);
DROP TABLE #Day3Tmp;
GO

DECLARE
    @o2gen VARCHAR(12)
  , @c02scrubber VARCHAR(12)
  , @i INT = 1
  , @onebit INT
  , @zerobit INT
  , @end TINYINT
  , @result VARCHAR(12) = ''
  , @remaining INT
  , @debug INT = 0;
SELECT d.DiagnosticBit INTO #Day3Tmp FROM [2021].Day3 AS d;
SET @end =
    (SELECT TOP 1 LEN (DiagnosticBit) FROM #Day3Tmp);
WHILE @i < @end
BEGIN
    SELECT
         @onebit = SUM (CASE
                            WHEN SUBSTRING (dt.DiagnosticBit, @i, 1) = 1 THEN
                                1
                            ELSE
                                0
                        END)
       , @zerobit = SUM (CASE
                             WHEN SUBSTRING (dt.DiagnosticBit, @i, 1) = 1 THEN
                                 0
                             ELSE
                                 1
                         END)
    FROM #Day3Tmp AS dt;
    IF @onebit >= @zerobit
    BEGIN
        -- more 1s
        SELECT @result += '1';
        DELETE #Day3Tmp WHERE SUBSTRING (DiagnosticBit, @i, 1) = '1';
    -- more 1s
    END;
    ELSE
    BEGIN
        -- more 0s
        SELECT @result += '0';
        DELETE #Day3Tmp WHERE SUBSTRING (DiagnosticBit, @i, 1) = '0';
    -- more 0s
    END;

    SELECT @remaining = COUNT (*) FROM #Day3Tmp AS dt;

    IF @remaining = 2
    BEGIN
        SELECT @c02scrubber = dt.DiagnosticBit
        FROM   #Day3Tmp AS dt
        WHERE  SUBSTRING (dt.DiagnosticBit, @i + 1, 1) = '0';
        SELECT @i = @end;
    END
	ELSE
    IF @remaining = 1
    BEGIN
        SELECT @c02scrubber = dt.DiagnosticBit FROM #Day3Tmp AS dt;
        SELECT @i = @end;
    END;
	IF @debug = 1
    SELECT
        @i AS i
      , @result AS result
      , @remaining AS cntremain
      , @onebit AS onebit
      , @zerobit AS zerobit
      , @c02scrubber AS co2;
    SELECT @i += 1;
-- outer loop    
END;
SELECT @result, @c02scrubber, dbo.BinaryToDecimal (@c02scrubber);
DROP TABLE #Day3Tmp;

/*
   SELECT * FROM [2021].Day3 AS d
    WHERE d.DiagnosticBit like '0111011111%'

SELECT * FROM [2021].Day3 AS d
  WHERE d.DiagnosticBit like '10001000001%'
                              100010000011
DROP TABLE IF EXISTS [2021].Day3_2
go
CREATE TABLE [2021].Day3_2
( bit1 CHAR(12),
 bit2 CHAR(12)
)
GO
INSERT [2021].Day3_2
(
    bit1,
    bit2
)
SELECT d.DiagnosticBit, d.DiagnosticBit
 FROM [2021].Day3 AS d
-- GO
--TRUNCATE TABLE [2021].Day3_2

select * from [2021].day3 where diagnosticbit like '010101011011'
SELECT dbo.BinaryToDecimal('110011000000')
-- first result:  1371
SELECT dbo.BinaryToDecimal('100011101010')
-- 3264

select 3264 * 1371
SELECT 1919 * 2179
*/
GO