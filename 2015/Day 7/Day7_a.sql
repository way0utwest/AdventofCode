--SELECT
--        instructions
--      , 'AssignedWire' = REVERSE(SUBSTRING(REVERSE(instructions), 1,
--                                           CHARINDEX(' ',
--                                                     REVERSE(instructions))))
--      , 'Firstwire' = SUBSTRING(instructions, 1, CHARINDEX(' ', instructions))
--      , 'Instruction' = CASE WHEN SUBSTRING(instructions,
--                                            CHARINDEX(' ', instructions) + 1,
--                                            CHARINDEX(' ',
--                                                      SUBSTRING(instructions,
--                                                              CHARINDEX(' ',
--                                                              instructions)
--                                                              + 1,
--                                                              LEN(instructions)),
--                                                      CHARINDEX(' ',
--                                                              SUBSTRING(instructions,
--                                                              CHARINDEX(' ',
--                                                              instructions)
--                                                              + 1,
--                                                              LEN(instructions)))
--                                                      - 1)) = 'AND' THEN 'AND'
--                             WHEN SUBSTRING(instructions,
--                                            CHARINDEX(' ', instructions) + 1,
--                                            CHARINDEX(' ',
--                                                      SUBSTRING(instructions,
--                                                              CHARINDEX(' ',
--                                                              instructions)
--                                                              + 1,
--                                                              LEN(instructions)),
--                                                      CHARINDEX(' ',
--                                                              SUBSTRING(instructions,
--                                                              CHARINDEX(' ',
--                                                              instructions)
--                                                              + 1,
--                                                              LEN(instructions)))
--                                                      - 1)) = 'OR' THEN 'OR'
--                             WHEN SUBSTRING(instructions,
--                                            CHARINDEX(' ', instructions) + 1,
--                                            CHARINDEX(' ',
--                                                      SUBSTRING(instructions,
--                                                              CHARINDEX(' ',
--                                                              instructions)
--                                                              + 1,
--                                                              LEN(instructions)),
--                                                      CHARINDEX(' ',
--                                                              SUBSTRING(instructions,
--                                                              CHARINDEX(' ',
--                                                              instructions)
--                                                              + 1,
--                                                              LEN(instructions)))
--                                                      - 1)) = 'RSHIFT'
--                             THEN 'RSHIFT'
--                             WHEN SUBSTRING(instructions,
--                                            CHARINDEX(' ', instructions) + 1,
--                                            CHARINDEX(' ',
--                                                      SUBSTRING(instructions,
--                                                              CHARINDEX(' ',
--                                                              instructions)
--                                                              + 1,
--                                                              LEN(instructions)),
--                                                      CHARINDEX(' ',
--                                                              SUBSTRING(instructions,
--                                                              CHARINDEX(' ',
--                                                              instructions)
--                                                              + 1,
--                                                              LEN(instructions)))
--                                                      - 1)) = 'LSHIFT'
--                             THEN 'LSHIFT'
--                             ELSE '='
--                        END
--      , 'SecondWire' = SUBSTRING(instructions, CHARINDEX('->', instructions)-3, 2)
--    FROM
--        dbo.Circuits
--    WHERE
--        instructions NOT LIKE 'NOT%'
--UNION
--SELECT Instructions
--	, 'AssignedWire' = SUBSTRING(REVERSE(instructions), 1, CHARINDEX(' ', REVERSE(instructions)))
--   , 'FirstWire' = ' '
--   , 'Instruction' = 'NOT'
--   , 'SecondWire' = SUBSTRING(instructions, CHARINDEX(' ', instructions), CHARINDEX('->', instructions)-4)
-- FROM dbo.Circuits
-- WHERE instructions LIKE 'NOT%'
--	ORDER BY instruction, AssignedWire



GO

--WHILE EXISTS(SELECT value FROM dbo.Day7Wires WHERE value IS NULL)
-- BEGIN
-- END
 
GO

WITH cteCircuits
AS
(
SELECT
        instructions
      , 'AssignedWire' = LTRIM(REVERSE(SUBSTRING(REVERSE(instructions), 1,
                                           CHARINDEX(' ',
                                                     REVERSE(instructions)))))
      , 'Firstwire' = SUBSTRING(instructions, 1, CHARINDEX(' ', instructions))
      , 'Instruction' = CASE WHEN SUBSTRING(instructions,
                                            CHARINDEX(' ', instructions) + 1,
                                            CHARINDEX(' ',
                                                      SUBSTRING(instructions,
                                                              CHARINDEX(' ',
                                                              instructions)
                                                              + 1,
                                                              LEN(instructions)),
                                                      CHARINDEX(' ',
                                                              SUBSTRING(instructions,
                                                              CHARINDEX(' ',
                                                              instructions)
                                                              + 1,
                                                              LEN(instructions)))
                                                      - 1)) = 'AND' THEN 'AND'
                             WHEN SUBSTRING(instructions,
                                            CHARINDEX(' ', instructions) + 1,
                                            CHARINDEX(' ',
                                                      SUBSTRING(instructions,
                                                              CHARINDEX(' ',
                                                              instructions)
                                                              + 1,
                                                              LEN(instructions)),
                                                      CHARINDEX(' ',
                                                              SUBSTRING(instructions,
                                                              CHARINDEX(' ',
                                                              instructions)
                                                              + 1,
                                                              LEN(instructions)))
                                                      - 1)) = 'OR' THEN 'OR'
                             WHEN SUBSTRING(instructions,
                                            CHARINDEX(' ', instructions) + 1,
                                            CHARINDEX(' ',
                                                      SUBSTRING(instructions,
                                                              CHARINDEX(' ',
                                                              instructions)
                                                              + 1,
                                                              LEN(instructions)),
                                                      CHARINDEX(' ',
                                                              SUBSTRING(instructions,
                                                              CHARINDEX(' ',
                                                              instructions)
                                                              + 1,
                                                              LEN(instructions)))
                                                      - 1)) = 'RSHIFT'
                             THEN 'RSHIFT'
                             WHEN SUBSTRING(instructions,
                                            CHARINDEX(' ', instructions) + 1,
                                            CHARINDEX(' ',
                                                      SUBSTRING(instructions,
                                                              CHARINDEX(' ',
                                                              instructions)
                                                              + 1,
                                                              LEN(instructions)),
                                                      CHARINDEX(' ',
                                                              SUBSTRING(instructions,
                                                              CHARINDEX(' ',
                                                              instructions)
                                                              + 1,
                                                              LEN(instructions)))
                                                      - 1)) = 'LSHIFT'
                             THEN 'LSHIFT'
                             ELSE '='
                        END
      , 'SecondWire' = SUBSTRING(instructions, CHARINDEX('->', instructions)-3, 2)
    FROM
        dbo.Circuits
    WHERE
        instructions NOT LIKE 'NOT%'
UNION
SELECT Instructions
	, 'AssignedWire' = LTRIM(SUBSTRING(REVERSE(instructions), 1, CHARINDEX(' ', REVERSE(instructions))))
   , 'FirstWire' = ' '
   , 'Instruction' = 'NOT'
   , 'SecondWire' = SUBSTRING(instructions, CHARINDEX(' ', instructions), CHARINDEX('->', instructions)-4)
 FROM dbo.Circuits
 WHERE instructions LIKE 'NOT%'
)
UPDATE dbo.Day7Wires
 SET value = cteCircuits.Firstwire
   FROM cteCircuits
  INNER JOIN dbo.Day7Wires
   ON cteCircuits.AssignedWire = wire
   WHERE cteCircuits.Instruction = '='
  AND ISNUMERIC(cteCircuits.Firstwire) = 1


  
