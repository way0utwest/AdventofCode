CREATE TABLE [2021].Day2
( Day2Key INT NOT NULL IDENTITY(1,1) 
, Depth INT)
GO
CREATE TABLE [2021].Stage2
( Depth INT)
GO
CREATE INDEX Stage2PK ON [2021].Stage2(depth)
GO
BULK INSERT [2021].Stage2 FROM 'E:\Documents\git\AdventofCode\2021\Day1\input.txt' WITH ( ROWTERMINATOR = '\n',ERRORFILE = 'E:\Documents\git\AdventofCode\2021\day1\myRubbishData.log' )
GO
INSERT [2021].Day2
(
    Depth
)SELECT s.Depth FROM [2021].Stage2 AS s
GO