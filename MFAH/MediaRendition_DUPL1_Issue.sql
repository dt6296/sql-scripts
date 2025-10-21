

SELECT * FROM MediaRenditions WHERE RenditionNumber LIKE '%DUPL%'	-- (6075 rows affected)



SELECT * FROM MediaRenditions WHERE RenditionNumber = LEFT(RenditionNumber,LEN(RenditionNumber)-5)



SELECT 
LEFT(RenditionNumber,LEN(RenditionNumber)-5) AS RendNum,
*

FROM MediaRenditions

WHERE RenditionNumber LIKE '%DUPL1'


SELECT
mr1.RenditionID,
mr1.RenditionNumber,
mr2.RenditionID,
mr2.RenditionNumber

FROM MediaRenditions AS mr1
INNER JOIN MediaRenditions AS mr2 ON mr1.RenditionNumber = LEFT(mr2.RenditionNumber,LEN(mr2.RenditionNumber)-5) 

WHERE mr2.RenditionNumber LIKE '%DUPL1'



SELECT
mr1.RenditionID,
mr1.RenditionNumber,
mr2.RenditionID,
mr2.RenditionNumber,
mm.MediaMasterID

FROM MediaRenditions AS mr1
INNER JOIN MediaRenditions AS mr2 ON mr1.RenditionNumber = LEFT(mr2.RenditionNumber,LEN(mr2.RenditionNumber)-5)
INNER JOIN MediaMaster AS mm ON mr2.RenditionID = mm.PrimaryRendID 

WHERE mr2.RenditionNumber LIKE '%DUPL1'


SELECT
mr.RenditionID,
mr.RenditionNumber

FROM MediaRenditions AS mr

WHERE mr.RenditionID NOT IN
(
	SELECT
	mr2.RenditionID

	FROM MediaRenditions AS mr1
	INNER JOIN MediaRenditions AS mr2 ON mr1.RenditionNumber = LEFT(mr2.RenditionNumber,LEN(mr2.RenditionNumber)-5)
	INNER JOIN MediaMaster AS mm ON mr2.RenditionID = mm.PrimaryRendID 

	WHERE mr2.RenditionNumber LIKE '%DUPL1'
)
AND mr.RenditionNumber LIKE '%DUPL1'

--	5626
--	 496
--	6122	


SELECT * FROM Packages WHERE Name = 'RenditionNumber_DUPL1_withMatchingRN' -- PackageID = 265666

--INSERT INTO TMS.dbo.PackageList (PackageID, ID, MainData, OrderPos, LoginID, EnteredDate, Notes, TableID)
SELECT DISTINCT
265666,
mm.MediaMasterID,
mr.RenditionNumber,
ROW_NUMBER() OVER (ORDER BY mr.SortNumber),
'dthompson',
GETDATE(),
NULL,
318

FROM MediaMaster AS mm
LEFT OUTER JOIN MediaRenditions AS mr ON mm.MediaMasterID = mr.MediaMasterID

WHERE mr.RenditionNumber IN

(
	SELECT DISTINCT
	mr2.RenditionNumber
		FROM MediaRenditions AS mr1
		INNER JOIN MediaRenditions AS mr2 ON mr1.RenditionNumber = LEFT(mr2.RenditionNumber,LEN(mr2.RenditionNumber)-5)
		INNER JOIN MediaMaster AS mm ON mr2.RenditionID = mm.PrimaryRendID 
		WHERE mr2.RenditionNumber LIKE '%DUPL1'
)
