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
WITH cteBits (a, b, c, d, e, f, g, h)
AS (SELECT CAST(SUBSTRING(DiagnosticBit, 1, 1) AS TINYINT) AS a,
           CAST(SUBSTRING(DiagnosticBit, 2, 1) AS TINYINT) AS b,
           CAST(SUBSTRING(DiagnosticBit, 3, 1) AS TINYINT) AS c,
           CAST(SUBSTRING(DiagnosticBit, 4, 1) AS TINYINT) AS d,
           CAST(SUBSTRING(DiagnosticBit, 5, 1) AS TINYINT) AS e,
           CAST(SUBSTRING(DiagnosticBit, 6, 1) AS TINYINT) AS f,
           CAST(SUBSTRING(DiagnosticBit, 7, 1) AS TINYINT) AS g,
           CAST(SUBSTRING(DiagnosticBit, 8, 1) AS TINYINT) AS h
    FROM [2021].Day3),
     cteSum (cnt)
AS (SELECT COUNT(*)
    FROM [2021].Day3 AS d)
, cteByte ( g1, g2, g3, g4, g5, g6, g7, g8, e1, e2, e3, e4, e5, e6, e7, e8) 
AS
(
SELECT CASE WHEN (SUM(b.a) > (s.cnt/2)) THEN 1 ELSE 0 end AS a1,
       CASE WHEN (SUM(b.a) < (s.cnt/2)) THEN 0 ELSE 1 end AS a0,
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
       s.cnt - SUM(b.h) AS h0
FROM cteBits b
, cteSum s
  GROUP BY s.cnt
)
SELECT *
   FROM cteByte