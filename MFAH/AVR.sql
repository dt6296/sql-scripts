
/*

SELECT * FROM DDContexts WHERE ContextID IN (34,58)



SELECT * FROM UserFields WHERE ContextID = 34

SELECT * FROM UserFieldGroups

SELECT
p.ProjectID,
p.ProjectNumber,
p.Department

FROM MFAHv_PRJ AS p

WHERE p.ProjectTypeID = 19 -- Audio/Visual Request



SELECT * FROM MFAHv_PRJ_AVR

*/


-- Exhibition

SELECT
e.ExhibitionID,
e.ExhTitle,
e.DisplayDate

FROM			MFAHv_EXH		AS e

WHERE e.ExhibitionID = 836




SELECT
pe.ProjectID,
pe.ExhibitionID,
pe.ExhTitle,
pe.DisplayDate

FROM			MFAHv_PRJ_EXH		AS pe

WHERE pe.ExhibitionID = 836


-- Exhibition Location

SELECT
e.ExhibitionID,
evx.ConstituentID,
l.LocationString

FROM Exhibitions AS e
INNER JOIN ExhVenuesXrefs AS evx ON e.ExhibitionID = evx.ExhibitionID
INNER JOIN ExhVenLocXrefs AS evlx  ON evx.ExhVenueXrefID = evlx.ExhVenueXrefID
INNER JOIN Locations AS l ON evlx.LocationID = l.LocationID

WHERE e.ExhibitionID = 836




-- Exhibition Constituents

SELECT
ec.ExhibitionID,
ec.RoleID,
ec.Role,
ec.Prepositional,
ec.DisplayName,
ISNULL(p.PhoneNumber,'') AS PhoneNumber,
p.PhoneType,
p.Description

FROM			MFAHv_EXH_CON	AS ec	
LEFT OUTER JOIN MFAHv_CON_Phone AS p	ON ec.ConstituentID = p.ConstituentID
										AND p.PhoneTypeID = 7 AND p.Description = 'office'

WHERE ec.RoleID IN (3,414,510,355,363)  -- RoleTypeID = 3 = "Exhibitions"
AND ec.ExhibitionID = 836




SELECT
c.ProjectID,
'Requested By' AS Role,
c.DisplayName,
c.Position,
c.DisplayName + ', ' + c.Position AS NameTitle

FROM MFAHv_PRJ_Constituent AS c

WHERE 
c.RoleTypeID = 23
AND RoleID = 518
AND	c.ProjectID = @ProjectID











--SELECT * FROM vgsFF_34_57
--SELECT * FROM vgsFF_34_Ungrouped



-- Exhibition Venue FlexFields

SELECT DISTINCT
evx.ExhibitionID,
ufx.ID,

(SELECT dbo.MFAHfx_ISOtoDATETIME(FieldValue) FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 367) AS Installation,
(SELECT ValueDate FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 367) AS Installation_Date,
(SELECT ValueRemarks FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 367) AS Installation_Remarks,

(SELECT dbo.MFAHfx_ISOtoDATETIME(FieldValue) FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 368) AS [Event],
(SELECT ValueDate FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 368) AS Event_Date,
(SELECT ValueRemarks FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 368) AS Event_Remarks,

(SELECT dbo.MFAHfx_ISOtoDATETIME(FieldValue) FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 369) AS Opening,
(SELECT ValueDate FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 369) AS Opening_Date,
(SELECT ValueRemarks FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 369) AS Opening_Remarks,

(SELECT CAST(FieldValue AS MONEY) FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 370) AS Budget,
(SELECT ValueDate FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 370) AS Budget_Date,
(SELECT ValueRemarks FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 370) AS Budget_Remarks,

(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 371) AS FinancialDimensions,
(SELECT ValueDate FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 371) AS FinancialDimensions_Date,
(SELECT ValueRemarks FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 371) AS FinancialDimensions_Remarks,

(SELECT CAST(FieldValue AS DECIMAL) FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 372) AS WorksNeedAVComponent,
(SELECT ValueDate FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 372) AS WorksNeedAVComponent_Date,
(SELECT ValueRemarks FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 372) AS WorksNeedAVComponent_Remarks

FROM ExhVenuesXrefs				AS evx
LEFT OUTER JOIN	UserFieldXrefs	AS ufx	ON evx.ExhVenueXrefID = ufx.ID

WHERE ufx.UserFieldGroupID = 57 -- AV Exhibition Information
AND ufx.ContextID = 34			-- EXHIBITION_VENUE_STATUS
AND evx.ExhibitionID = 836


-- Exhibition-Object FlexFields

SELECT
eox.ExhibitionID AS ID,
eox.ExhibitionID,
e.ExhTitle,
e.DisplayDate,
eox.ObjectID,
ufx.UserFieldID,
CASE WHEN ufx.UserFieldID IN (373,374,375) THEN 2 ELSE 1 END AS OrderPos,
uf.UserFieldName,
CASE WHEN ufx.UserFieldID = 399 AND ufx.FieldValue = 1 THEN 'Yes' ELSE
CASE WHEN ufx.UserFieldID = 399 AND ufx.FieldValue = 0 THEN 'No' ELSE
CASE WHEN ufx.UserFieldID = 373 AND ufx.FieldValue = 1 THEN 'Yes' ELSE
CASE WHEN ufx.UserFieldID = 373 AND ufx.FieldValue = 0 THEN 'No' ELSE 
CASE WHEN  ufx.FieldValue = '(not assigned)' THEN '' ELSE ufx.FieldValue END END END END END AS FieldValue,
ISNULL(ufx.ValueDate,'') AS ValueDate,
ISNULL(ufx.ValueRemarks,'') AS ValueRemarks


FROM ExhObjXrefs			AS eox
INNER JOIN Exhibitions	AS e ON eox.ExhibitionID = e.ExhibitionID
INNER JOIN UserFieldXrefs	AS ufx	ON eox.ExhObjXrefID = ufx.ID
									AND ufx.ContextID = 9
INNER JOIN UserFields		AS uf	ON ufx.UserFieldID = uf.UserFieldID

WHERE ufx.UserFieldGroupID IN (58,63)
AND eox.ExhibitionID = 836



SELECT * FROM UserFields

-- Approval

SELECT
pe.ProjectID AS ID,
pe.ProjectID,
e.ExhibitionID,
ufx.UserFieldID,
CASE WHEN ufx.UserFieldID = 387 THEN uf.UserFieldName ELSE 'Approved By' END AS UserFieldName,
CASE WHEN ufx.UserFieldID = 387 THEN NULL ELSE ufx.FieldValue END AS FieldValue,
CASE WHEN ufx.UserFieldID = 387 THEN ufx.FieldValue ELSE ISNULL(ufx.ValueDate,'') END AS ValueDate,
ISNULL(ufx.ValueRemarks,'') AS ValueRemarks


FROM MFAHv_PRJ_EXH			AS pe
INNER JOIN Exhibitions				AS e			ON pe.ExhibitionID = e.ExhibitionID
INNER JOIN UserFieldXrefs		AS ufx		ON pe.ProjectID = ufx.ID
																	AND ufx.ContextID = 58
INNER JOIN UserFields				AS uf		ON ufx.UserFieldID = uf.UserFieldID

WHERE ufx.UserFieldID IN (385,386,387)
AND e.ExhibitionID = 836

ORDER BY ufx.UserFieldID DESC



-- Project Details

SELECT
p.ProjectID AS ID,
p.ProjectID,
p.Requested,
p.Installation,
p.[Event],
p.Opening,
p.Budget,
p.FinancialDimensions,
p.WorksNeedAVComponent

FROM MFAHv_PRJ_AVR AS p