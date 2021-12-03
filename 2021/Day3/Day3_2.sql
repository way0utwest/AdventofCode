/*
CREATE TABLE [2021].Day3
( DiagnosticBit CHAR(s.cnt))
GO
INSERT [2021].Day3
(
    DiagnosticBit
)
VALUES
('00100'),
('11110 '),
('10110 '),
('10111 '),
('10101 '),
('01111 '),
('00111 '),
('11100 '),
('10000 '),
('11001 '),
('00010 '),
('01010')
GO
*/

-- load in part 1

--- function
CREATE OR ALTER FUNCTION [dbo].[BinaryToDecimal]
(
	@Input varchar(255)
)
RETURNS bigint
AS
BEGIN

	DECLARE @Cnt tinyint = 1
	DECLARE @Len tinyint = LEN(@Input)
	DECLARE @Output bigint = CAST(SUBSTRING(@Input, @Len, 1) AS bigint)

	WHILE(@Cnt < @Len) BEGIN
		SET @Output = @Output + POWER(CAST(SUBSTRING(@Input, @Len - @Cnt, 1) * 2 AS bigint), @Cnt)

		SET @Cnt = @Cnt + 1
	END

	RETURN @Output	

END
go
--part 2

WITH cteBits (a, b, c, d, e, f, g, h, i, j, k, l)
AS (SELECT CAST(SUBSTRING(DiagnosticBit, 1, 1) AS TINYINT) AS a,
           CAST(SUBSTRING(DiagnosticBit, 2, 1) AS TINYINT) AS b,
           CAST(SUBSTRING(DiagnosticBit, 3, 1) AS TINYINT) AS c,
           CAST(SUBSTRING(DiagnosticBit, 4, 1) AS TINYINT) AS d,
           CAST(SUBSTRING(DiagnosticBit, 5, 1) AS TINYINT) AS e,
           CAST(SUBSTRING(DiagnosticBit, 6, 1) AS TINYINT) AS f,
           CAST(SUBSTRING(DiagnosticBit, 7, 1) AS TINYINT) AS g,
           CAST(SUBSTRING(DiagnosticBit, 8, 1) AS TINYINT) AS h,
           CAST(SUBSTRING(DiagnosticBit, 9, 1) AS TINYINT) AS i,
           CAST(SUBSTRING(DiagnosticBit, 10, 1) AS TINYINT) AS j,
           CAST(SUBSTRING(DiagnosticBit, 11, 1) AS TINYINT) AS k,
           CAST(SUBSTRING(DiagnosticBit, 12, 1) AS TINYINT) AS l
    FROM [2021].Day3),
     cteSum (cnt)
AS (SELECT COUNT(*)
    FROM [2021].Day3 AS d)
, cteByte ( g1, e1, g2, e2, g3, e3, g4, e4, g5, e5, g6, e6, g7, e7, g8, e8, g9, e9, g10, e10, g11, e11, g12, e12, cnt) 
AS
(
SELECT SUM(b.a) AS a1,
       s.cnt - SUM(b.a) AS a0,
       SUM(b.b) AS b1,
       s.cnt - SUM(b.b) AS b0,
       SUM(b.c) AS c1,
       s.cnt - SUM(b.c) AS c0,
       SUM(b.d) AS d1,
       s.cnt - SUM(b.d) AS d0,
       SUM(b.e) AS e1,
       s.cnt - SUM(b.e) AS e0,
       SUM(b.f) AS f1,
       s.cnt - SUM(b.f) AS f0,
       SUM(b.g) AS g1,
       s.cnt - SUM(b.g) AS g0,
       SUM(b.h) AS h1,
       s.cnt - SUM(b.h) AS h0,
       SUM(b.i) AS i1,
       s.cnt - SUM(b.i) AS i0,
       SUM(b.j) AS j1,
       s.cnt - SUM(b.j) AS j0,
       SUM(b.k) AS k1,
       s.cnt - SUM(b.k) AS k0,
       SUM(b.l) AS l1,
       s.cnt - SUM(b.l) AS l0,
	   s.cnt
FROM cteBits b
, cteSum s
  GROUP BY s.cnt
)
SELECT [dbo].[BinaryToDecimal](
    cast( CASE WHEN g1 > cnt/2 THEN 1 ELSE 0 END as char(1))+
    cast( CASE WHEN g2 > cnt/2 THEN 1 ELSE 0 END as char(1))+
    cast( CASE WHEN g3 > cnt/2 THEN 1 ELSE 0 END as char(1))+
    cast( CASE WHEN g4 > cnt/2 THEN 1 ELSE 0 END as char(1))+
    cast( CASE WHEN g5 > cnt/2 THEN 1 ELSE 0 END as char(1))+
    cast( CASE WHEN g6 > cnt/2 THEN 1 ELSE 0 END as char(1))+
    cast( CASE WHEN g7 > cnt/2 THEN 1 ELSE 0 END as char(1))+
    cast( CASE WHEN g8 > cnt/2 THEN 1 ELSE 0 END as char(1))+
    cast( CASE WHEN g9 > cnt/2 THEN 1 ELSE 0 END as char(1))+
    cast( CASE WHEN g10 > cnt/2 THEN 1 ELSE 0 END AS char(1)) +
    cast( CASE WHEN g11 > cnt/2 THEN 1 ELSE 0 END AS char(1)) +
    cast( CASE WHEN g12 > cnt/2 THEN 1 ELSE 0 END AS char(1)) 
	 ) *
	  [dbo].[BinaryToDecimal](
    cast( CASE WHEN e1 < cnt/2 THEN 0 ELSE 1 END  as char(1)) +
    cast( CASE WHEN e2 < cnt/2 THEN 0 ELSE 1 END  as char(1)) +
    cast( CASE WHEN e3 < cnt/2 THEN 0 ELSE 1 END  as char(1)) +
    cast( CASE WHEN e4 < cnt/2 THEN 0 ELSE 1 END  as char(1)) +
    cast( CASE WHEN e5 < cnt/2 THEN 0 ELSE 1 END  as char(1)) +
    cast( CASE WHEN e6 < cnt/2 THEN 0 ELSE 1 END  as char(1))  +
    cast( CASE WHEN e7 < cnt/2 THEN 0 ELSE 1 END  as char(1))  +
    cast( CASE WHEN e8 < cnt/2 THEN 0 ELSE 1 END  as char(1))  +
    cast( CASE WHEN e9 < cnt/2 THEN 0 ELSE 1 END  as char(1)) 	 +
    cast( CASE WHEN e10 < cnt/2 THEN 0 ELSE 1 END as char(1))   +
    cast( CASE WHEN e11 < cnt/2 THEN 0 ELSE 1 END as char(1))   +
    cast( CASE WHEN e12 < cnt/2 THEN 0 ELSE 1 END as char(1))  
	)
   FROM cteByte