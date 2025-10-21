


-- MFAHv_OBJ_Data_Tombstone


SELECT
o.ObjectID,
o.ObjectNumber,
o.SortNumber,
ISNULL(omf.Role,'') AS Role,
ISNULL(omf.Prepositional,'') AS Prepositional,
ISNULL(omf.Prefix,'') AS Prefix,
omf.DisplayName AS Maker,
omf.DisplayDate AS MakerBio,
ISNULL(omf.Suffix,'') AS Suffix,
oc.Culture,
ott.Title,
o.Dated,
o.DateBegin,
oc.Period,
o.Medium,
o.Dimensions,
o.CreditLine,
o.Description,
o.Chat AS LabelText,
o.ObjectLevelID,
ol.ObjectLevel,
o.ObjectTypeID,
ot.ObjectType,
o.IsVirtual,
o.CuratorApproved,
o.PublicAccess,
o.DepartmentID,
d.Department,
o.ClassificationID,
c.Classification,
o.ObjectStatusID,
os.ObjectStatus,
o.OnView,
te.TextEntry AS WebsiteText,
objr.ObjRightsTypeID,
objrt.ObjRightsType,
objr.Copyright,
objr.CreditLineRepro,
CASE WHEN objr.ObjRightsTypeID = 2 THEN objrt.ObjRightsType	ELSE
CASE WHEN objr.ObjRightsTypeID IN (0,3,4,5) THEN 'Copyright NOT CLEARED for website publication.'	ELSE
ISNULL(objr.CreditLineRepro,'Need copyright statement.')	END END	AS CopyrightStatement,
CASE WHEN objr.ObjRightsTypeID IN (0,1) THEN ISNULL(objr.CreditLineRepro,'')	ELSE 
CASE WHEN objr.ObjRightsTypeID = 2 THEN objrt.ObjRightsType ELSE '' END END AS OnlineCopyrightStatement

FROM Objects AS o
INNER JOIN ObjContext AS oc ON o.ObjectID = oc.ObjectID
INNER JOIN ObjectLevels AS ol ON o.ObjectLevelID = ol.ObjectLevelID
INNER JOIN ObjectTypes AS ot ON o.ObjectTypeID = ot.ObjectTypeID
INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID
INNER JOIN Classifications AS c ON o.ClassificationID = c.ClassificationID
INNER JOIN ObjectStatuses AS os ON o.ObjectStatusID = os.ObjectStatusID
LEFT OUTER JOIN ObjRights AS objr ON o.ObjectID = objr.ObjectID
LEFT OUTER JOIN ObjRightsTypes AS objrt ON objr.ObjRightsTypeID = objrt.ObjRightsTypeID
LEFT OUTER JOIN
(
SELECT
	ObjectID,
	Title,
	RANK() OVER(PARTITION BY ObjectID ORDER BY DisplayOrder) AS RankByDisplayOrder
	FROM ObjTitles
	WHERE Displayed = 1
) AS ott ON o.ObjectID = ott.ObjectID AND ott.RankByDisplayOrder = 1
LEFT OUTER JOIN
(
	SELECT TextEntryID,
	ID AS ObjectID,
	te.EnteredDate,
	RANK() OVER(PARTITION BY ID ORDER BY te.EnteredDate DESC) AS RankByEnteredDate,
	te.TextEntry
	FROM	TextEntries	AS te
	LEFT OUTER JOIN TextTypes	AS tt	ON	te.TextTypeID = tt.TextTypeID
	WHERE tt.TableID = 108		-- Objects
	AND te.TextTypeID = 212		-- Label Text
	AND Purpose = 'OCM'			--'Online Collection Module'
	AND te.TextStatusID = 23	-- 23 = Approved
								-- 16 = Submitted
								-- 22 = To Be Reviewed
) AS te ON te.ObjectID = o.ObjectID
LEFT OUTER JOIN
(
	SELECT cx.ID AS ObjectID, cx.ConXrefID, cx.RoleID, r.Role, cxd.Prefix, cxd.Suffix, r.Prepositional,
	RANK() OVER(PARTITION BY ID ORDER BY DisplayOrder) AS RankByDisplayOrder,
	can.DisplayName,
	c.DisplayDate
	FROM ConXrefs AS cx
	LEFT OUTER JOIN ConXrefDetails	AS cxd	ON	cx.ConXrefID = cxd.ConXrefID
	LEFT OUTER JOIN ConAltNames		AS can	ON	cxd.NameID = can.AltNameId
	LEFT OUTER JOIN Constituents	AS c	ON	cxd.ConstituentID = c.ConstituentID
	LEFT OUTER JOIN Roles			AS r	ON	cx.RoleID = r.RoleID
	WHERE cx.Active = 1		-- Active ConXref
	AND Displayed = 1		-- Displayed ConXref
	AND TableID = 108	
	AND cx.RoleTypeID = 1		-- Object Related ConXref 
	AND cxd.UnMasked = 1
)	AS omf ON o.ObjectID = omf.ObjectID AND omf.RankByDisplayOrder = 1


WHERE o.ObjectNumber LIKE 'TEST.DAVE.%'

ORDER BY o.SortNumber








