---- create table
create table Day1_Frequency
( 
Day1Key int identity(1,1)
, inputstring varchar(20)
)
go
-- load data
bulk insert Day1_Frequency
from 'e:\Documents\GitHub\AdventofCode\2018\Day1\input.txt'
go
select * 
 from Day1_Frequency