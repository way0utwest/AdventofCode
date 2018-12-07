/*
Day 1 

This works better. A second attempt using the data without trying to capture ordering at all.
*/
CREATE TABLE Day1(rawdata VARCHAR(20))
GO
BULK INSERT dbo.Day1 FROM 'C:\Users\way0u\Source\Repos\AdventofCode\2018\Day1\input.txt'
GO
SELECT * FROM dbo.Day1
GO
CREATE TABLE Day1_a(frequency INT)
GO
INSERT dbo.Day1_a
(
    frequency
)
SELECT CAST(rawdata AS int)
FROM dbo.Day1
GO

SELECT SUM(frequency) FROM dbo.Day1_a
GO

