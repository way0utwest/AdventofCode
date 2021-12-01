--CREATE TABLE Day7
--(   maintext      VARCHAR(500)
--  , bag_color     VARCHAR(30)
--  , containedbags VARCHAR(200));
--GO

--INSERT dbo.Day7
--    (maintext)
--VALUES
--    ('light red bags contain 1 bright white bag, 2 muted yellow bags.')
--  , ('dark orange bags contain 3 bright white bags, 4 muted yellow bags.')
--  , ('bright white bags contain 1 shiny gold bag.')
--  , ('muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.')
--  , ('shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.')
--  , ('dark olive bags contain 3 faded blue bags, 4 dotted black bags.')
--  , ('vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.')
--  , ('faded blue bags contain no other bags.')
--  , ('dotted black bags contain no other bags.');
-- GO

SELECT
    SUBSTRING (maintext, 1, CHARINDEX ('bags', maintext, 1) - 2)
   , SUBSTRING (maintext, 
                CHARINDEX ('contain', maintext) + 8
			  , (CHARINDEX (' ', maintext, (CHARINDEX ('contain', maintext) + 8))
				- (CHARINDEX ('contain', maintext) + 8))
 				) AS BagCount
   , SUBSTRING( 
               TRIM (SUBSTRING (maintext, CHARINDEX ('contain', maintext, 1) + 8, CHARINDEX ('bag', maintext, CHARINDEX ('contain', maintext)))),
			   1, 
			   CHARINDEX (' ', TRIM (SUBSTRING (maintext, CHARINDEX ('contain', maintext, 1) + 8, CHARINDEX ('bag', maintext, CHARINDEX ('contain', maintext)))))
			   ) AS bag1count
   , SUBSTRING( 
               TRIM (SUBSTRING (maintext, CHARINDEX ('contain', maintext, 1) + 8, CHARINDEX ('bag', maintext, CHARINDEX ('contain', maintext)))),
			   CHARINDEX (' ', TRIM (SUBSTRING (maintext, CHARINDEX ('contain', maintext, 1) + 8, CHARINDEX ('bag', maintext, CHARINDEX ('contain', maintext)))))
			   ,CHARINDEX ('bag', TRIM (SUBSTRING (maintext, CHARINDEX ('contain', maintext, 1) + 8, CHARINDEX ('bag', maintext, CHARINDEX ('contain', maintext)))))-2
			   ) AS bag1color
   , CHARINDEX (' ', maintext, (CHARINDEX ('contain', maintext) + 8)) AS SpaceAfterContain
   , (CHARINDEX (' ', maintext, (CHARINDEX ('contain', maintext) + 8))
				- (CHARINDEX ('contain', maintext) + 8)) AS lengthcounter
   , CHARINDEX ('contain', maintext) + 8 AS EndOfContain
   , CHARINDEX ('bag', maintext, CHARINDEX ('contain', maintext)) AS BagAfterContain
   , TRIM (SUBSTRING (maintext, CHARINDEX ('contain', maintext, 1) + 8, CHARINDEX ('bag', maintext, CHARINDEX ('contain', maintext))))
   , TRIM (SUBSTRING (maintext, CHARINDEX ('contain', maintext, 1) + 8, CHARINDEX (',', maintext, CHARINDEX ('contain', maintext))))
   , SUBSTRING (maintext, CHARINDEX ('contain', maintext, 1) + 8, CHARINDEX ('bag', maintext, CHARINDEX ('contain', maintext)) - CHARINDEX ('contain', maintext, 1) + 8)
FROM Day7;
GO
--CREATE TABLE Day7_Bags
--( BagColor VARCHAR(50)
--, ContainedBag VARCHAR(50)
--, BagCount TINYINT
--)
--GO
