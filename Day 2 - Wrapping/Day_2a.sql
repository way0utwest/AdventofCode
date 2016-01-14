---- create table
--create table Day2_WrappingPresents
--( 
-- dimensions varchar(100)
--)
--go
---- load data
--bulk insert Day2_WrappingPresents
-- from 'C:\Users\Steve\Documents\GitHub\AdventofCode\Day 2 - Wrapping\input.txt'
--go
---- check
---- select * from Day2_WrappingPresents
--go

-- break this down to get the dimensions
with cteSplit (d, el, sw, sh)
as
(
select
   dimensions
 , endlength = charindex('x', dimensions) - 1
 , startwidth = charindex('x', substring(dimensions, charindex('x', dimensions),20)) + charindex('x', dimensions)
 , startheight = len(dimensions) - charindex('x', reverse(dimensions))  + 2
-- , c1 = charindex('x', dimensions)
-- , c2 = charindex('x', dimensions, charindex('x', dimensions)+1) - 
from day2_wrappingpresents d
)
, cteDimensions
as
(select 
   d
   , l = cast(substring(d, 1, el) as int)
   , w = cast(substring(d, sw, sh-sw-1) as int)
   , h = cast(substring(d, sh, len(d)) as int)
 from cteSplit d
)
, cteOrder
as
( select
   d
 , small = case 
            when l <= w and l <= h then l
            when w <= l and w <= h then w
            when h <= l and h <= w then h
		end
 , middle = case 
            when (l >= w and l <= h) or (l <= w and l >= h) then l
            when (w >= l and w <= h) or (w <= l and w >= h) then w
            when (h >= l and h <= w) or (h <= l and h >= w) then h
		end
 , large = case 
            when l >= w and l >= h then l
            when w >= l and w >= h then w
            when h >= l and h >= w then h
		end
  from cteDimensions
)
, cteFinal
as
(
select 
  d
  , area = (2 * small * middle) +
           (2 * small * large) + 
		   (2 * middle * large)
  , slack = (small * middle)
 from cteOrder
)
select
 sum(area + slack)
 from cteFinal


-- drop table Day2_WrappingPresents


