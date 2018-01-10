-- Brute force MD5 calculation
WITH    cteCalc ( n )
          AS (
               SELECT n = ROW_NUMBER() OVER ( ORDER BY (
                                                         SELECT NULL
                                                       ) )
                FROM sys.columns a
                    CROSS JOIN sys.columns b
             ) ,
        cteHash ( n, hashstring, hashvalue )
          AS (
               SELECT cteCalc.n
                  , 'iwrupvqb' + CAST(n AS VARCHAR(10))
                  , [hash] = master.dbo.fn_varbintohexstr(HASHBYTES('MD5',
                                                              'iwrupvqb'
                                                              + CAST(n AS VARCHAR(10))))
                FROM cteCalc
             )
    SELECT TOP 1 n
          , [hashstring]
          , [hashvalue]
        FROM cteHash
        WHERE SUBSTRING(hashvalue, 3, 5) = '00000'
        ORDER BY n;


