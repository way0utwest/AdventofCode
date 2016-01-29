SET STATISTICS IO ON
SET STATISTICS TIME ON
GO
DECLARE @a DATETIME = GETDATE();

WITH cteTen(n)      AS ( SELECT 1 FROM (VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (0)) a(n))
   , cteHundreds(n) AS ( SELECT 1 FROM cteTen a, cteTen b)
   , cteMillions(n) AS ( SELECT 1 FROM cteHundreds a, cteHundreds b, cteHundreds c)
   , cteTally ( n )
    AS (
       SELECT n = ROW_NUMBER() OVER ( ORDER BY (
                                                SELECT NULL
                                                ) )
        FROM cteMillions
      ) 
, cteHash ( n, hashvalue )
   AS (
       SELECT n
            , hb.hashvalue
            FROM cteTally
			CROSS APPLY (SELECT HASHBYTES('MD5', 'iwrupvqb' + CONVERT(VARCHAR(15), n))) AS hb(hashvalue)
         -- CROSS APPLY (SELECT HASHBYTES('MD5', 'iwrupvqb' + CONVERT(VARCHAR(15), N))) AS ca(HashResult)
       )
    SELECT 
			h.n
          , h.[hashvalue]
        FROM cteHash h
        WHERE LEFT(CONVERT(VARCHAR(50), h.hashvalue, 2), 5) = REPLICATE('0', 5)
		ORDER BY h.n;

SELECT 'Time' = DATEDIFF(SECOND, @a, GETDATE());

-- No TOP
-- query time: 125s
-- Stats time: 110,016ms   124860ms

-- TOP
-- query time: 45
-- Stats time: 39,532ms

-- cross apply + no top
-- query time: 3
-- Stats time: 2172

-- cross apply + top
-- query time: 1
-- Stats time: 734
