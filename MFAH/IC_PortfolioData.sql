







SELECT
o.ObjectID,
CAST (o.ObjectNumber AS VARCHAR(42)) AS ObjectNumber,
--CASE	WHEN o.ObjectStatusID IN (2,27) THEN 1
--		ELSE CASE WHEN o.ObjectStatusID = 3 THEN 2
--		ELSE 5 END END AS ObjectStatusID,
os.ObjectStatus,
d.Department,
dbo.MFAH_Proper(c.Classification),
o.Dated,
o.DateBegin,
o.DateEnd,
o.Medium,
ISNULL(o.State,'') + ISNULL(CAST(o.Edition AS VARCHAR(128)),'') AS StateEdition,
o.Dimensions,
CASE WHEN o.ObjectStatusID = 2 THEN 'The Museum of Fine Arts, Houston. ' + CAST (o.CreditLine AS NVARCHAR(MAX)) ELSE o.CreditLine END AS CRLine,
--Double check Blaffer credit line
oc.Culture,
ISNULL(oc.Style,'') + ISNULL(oc.Period,'') AS StylePeriod,

dbo.MFAHfx_ConcatMakers(o.ObjectID,'') AS Makers,
dbo.MFAHfx_ConcatTitles(o.ObjectID,'') AS Titles,

CASE WHEN o.ObjectStatusID IN (2,27) THEN 'The Museum of Fine Arts, Houston' ELSE '' END AS Repository,
CASE WHEN o.ObjectStatusID IN (2,27) THEN 'Houston, Texas' ELSE '' END AS Location,
'The Museum of Fine Arts, Houston' AS Source,

			/*
			ISNULL(ot1.Title,'')		AS Title1,
			ISNULL(ot2.Title,'')		AS Title2,
			ISNULL(ot3.Title,'')		AS Title3,
			ISNULL(om1.Role,'')						AS Role1,
			ISNULL(om1.cx_Prepositional,'')			AS Prepositional1,
			ISNULL(om1.cxd_Prefix,'')				AS Prefix1,
			ISNULL(om1.can_DisplayName,'')			AS DisplayName1,
			ISNULL(om1.cxd_Suffix,'')				AS Suffix1,
			ISNULL(om1.DisplayName,'')				AS Artist1,
			ISNULL(om2.Role,'')						AS Role2,
			ISNULL(om2.cx_Prepositional,'')			AS Prepositional2,
			ISNULL(om2.cxd_Prefix,'')				AS Prefix2,
			ISNULL(om2.can_DisplayName,'')			AS DisplayName2,
			ISNULL(om2.cxd_Suffix,'')				AS Suffix2,
			ISNULL(om2.DisplayNameCultureDate,'')	AS Artist2,
			ISNULL(om3.Role,'')						AS Role3,
			ISNULL(om3.cx_Prepositional,'')			AS Prepositional3,
			ISNULL(om3.cxd_Prefix,'')				AS Prefix3,
			ISNULL(om3.can_DisplayName,'')			AS DisplayName3,
			ISNULL(om3.cxd_Suffix,'')				AS Suffix3,
			ISNULL(om3.DisplayNameCultureDate,'')	AS Artist3,
			*/

ISNULL(ort.ObjRightsType,'')			AS ObjRightsType,
ISNULL(dbo.MFAHfx_OBJ_CopyrightStmt(o.ObjectID),'') AS CopyrightStatement,
ISNULL(dbo.MFAHfx_OBJ_CopyrightStmt_OCM(o.ObjectID),'') AS OCMCopyrightStatement,
dbo.MFAHfx_ConcatRightsConstituents(ocr.ObjectID,'') AS RightsConstituent

FROM			Objects							AS o
LEFT OUTER JOIN Departments						AS d	ON o.DepartmentID = d.DepartmentID
LEFT OUTER JOIN Classifications					AS c	ON o.ClassificationID = c.ClassificationID
LEFT OUTER JOIN ObjContext						AS oc	ON o.ObjectID = oc.ObjectID
LEFT OUTER JOIN ObjRights						AS ocr	ON o.ObjectID = ocr.ObjectID
LEFT OUTER JOIN ObjRightsTypes					AS ort	ON ocr.ObjRightsTypeID = ort.ObjRightsTypeID
LEFT OUTER JOIN ObjectStatuses					AS os	ON o.ObjectStatusID = os.ObjectStatusID

			/*
			LEFT OUTER JOIN MFAHv_OBJ_Title_First3Displayed	AS ot1 ON o.ObjectID = ot1.ObjectID
																	AND ot1.RankByDisplayOrder = 1
														
			LEFT OUTER JOIN MFAHv_OBJ_Title_First3Displayed	AS ot2 ON o.ObjectID = ot2.ObjectID
																	AND ot2.RankByDisplayOrder = 2
														
			LEFT OUTER JOIN MFAHv_OBJ_Title_First3Displayed	AS ot3 ON o.ObjectID = ot3.ObjectID
																	AND ot3.RankByDisplayOrder = 3
														
														
			LEFT OUTER JOIN MFAHv_OBJ_Maker_First3Displayed	AS om1 ON o.ObjectID = om1.ObjectID
																	AND om1.RankByDisplayOrder = 1														
														
			LEFT OUTER JOIN MFAHv_OBJ_Maker_First3Displayed	AS om2 ON o.ObjectID = om2.ObjectID
																	AND om2.RankByDisplayOrder = 2	

			LEFT OUTER JOIN MFAHv_OBJ_Maker_First3Displayed	AS om3 ON o.ObjectID = om3.ObjectID
																	AND om3.RankByDisplayOrder = 3															
			*/

WHERE o.ObjectID IN

(
	SELECT DISTINCT --at.*,
	at.ObjectID
	FROM AuditTrail AS at 
	WHERE at.EnteredDate > '2015-05-19 00:00'
	OR (at.EnteredDate > '2015-05-19 00:00' AND CAST(at.Explanation AS VARCHAR(100)) = '108')
	AND at.ModuleID = 1	--ORDER BY at.ObjectID
) 

--AND o.ObjectStatusID IN (2,27)


--SELECT Explanation FROM AuditTrail WHERE EnteredDate > '2015-04-20 00:00' AND Explanation IS NOT NULL


------------------------------------------------------------------------------------------------------------------------------
/*


SELECT DISTINCT
at.ObjectID, at.*
FROM AuditTrail AS at 

LEFT OUTER JOIN
(
SELECT
o.ObjectID,
o.ObjectNumber,
o.Dated,
o.Medium,
o.Dimensions,
o.CreditLine
FROM Objects AS o
) AS obj	ON at.ObjectID = obj.ObjectID

WHERE at.EnteredDate > '2015-02-09 00:00'
AND at.ModuleID = 1
AND obj.ObjectID IS NULL

ORDER BY at.ObjectID


select * from objects where ObjectID = 83614
mhershon
2015-02-09 13:51:25.157
ConXRefs

SELECT * FROM ConXrefDetails WHERE EnteredDate > '2015-02-09 00:00'

SELECT * FROM ConXrefSets WHERE EnteredDate > '2015-02-09 00:00'

SELECT * FROM ConXrefs WHERE EnteredDate > '2015-02-09 00:00'
and TableID = 108 

SELECT * FROM ConXrefs WHERE LoginID = 'mhershon'


SELECT MAX(ObjectID) FROM Objects





SELECT * FROM ObjectStatuses




*/




