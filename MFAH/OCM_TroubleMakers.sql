


-- *****************  This code has been replaced in the view MFAHv_OCM_TroubleMakers   *************************
--                    It took way too long to run MFAHv_OCM_Object and the OCM Load job

-- MFAHv_OBJ

SELECT 
ObjectID, 
ObjectNumber COLLATE SQL_Latin1_General_CP1_CI_AS AS ObjectNumber, 
COUNT(*) AS Records, 
'MFAHv_OBJ'AS Source
FROM MFAHv_OBJ
GROUP BY ObjectID, ObjectNumber
HAVING COUNT(*) > 1

UNION 

--	MFAHv_OCM_Object

/*
SELECT ObjectID, 
AccessionNumber COLLATE SQL_Latin1_General_CP1_CI_AS AS ObjectNumber,
COUNT(*) AS Records, 
'MFAHv_OCM_Object' AS Spource
FROM MFAHv_OCM_Object							--  Circular Reference when used in MFAHv_OCM_Object
GROUP BY ObjectID, AccessionNumber
HAVING COUNT(*) > 1
*/

--Replaced the above with the query below to avoid circular reference to MFAHv_OCM_Object
--Query below is taken directly from MFAHv_OCM_Object

SELECT 
ObjectID,
DisplayAccessionNumber COLLATE SQL_Latin1_General_CP1_CI_AS AS ObjectNumber,
COUNT(*) AS Records, 
'MFAHv_OCM_Object' AS Spource
FROM MFAHv_OBJ	AS o
WHERE o.WebsiteApproved = 1			--(Public Access field)
AND o.ObjectStatusID IN (2,27)		--Accessioned Objects
GROUP BY ObjectID, DisplayAccessionNumber
HAVING COUNT(*) > 1


UNION

--	MFAHv_OCM_ObjectImage

SELECT 
ObjectID, 
ObjectNumber COLLATE SQL_Latin1_General_CP1_CI_AS AS ObjectNumber,
COUNT(*) AS Records,
'MFAHv_OCM_ObjectImage' AS Source
FROM MFAHv_OCM_ObjectImage
GROUP BY ObjectID, ObjectNumber, MediaXrefID, ImageID
HAVING COUNT(*) > 1

UNION

--	MFAHv_OBJ_Image_Primary

SELECT
ObjectID,
ObjectNumber COLLATE SQL_Latin1_General_CP1_CI_AS AS ObjectNumber,
COUNT(*) AS Records,
'MFAHv_OBJ_Image_Primary' AS Source
FROM MFAHv_OBJ_Image_Primary
GROUP BY ObjectID, ObjectNumber
HAVING COUNT(*) > 1

UNION

-- MFAHv_OCM_ObjectMaker

/*
SELECT
om.ObjectID,
o.ObjectNumber,
COUNT(*) AS Records,
'MFAHv_OCM_ObjectMaker' AS Source
FROM MFAHv_OCM_ObjectMaker AS om				-- References MFAHv_OCM_Object, circular reference!
LEFT OUTER JOIN Objects AS o ON om.ObjectID = o.ObjectID
GROUP BY om.ObjectID, o.ObjectNumber, ConstituentID, RoleID, Role
HAVING COUNT(*) > 1
*/

--Replaced the above with the query below to avoid circular reference to MFAHv_OCM_Object
--Query below is taken directly from MFAHv_OCM_ObjectMaker

SELECT
om.ObjectID,
om.ObjectNumber,
COUNT(*) AS Records,
'MFAHv_OCM_ObjectMaker' AS Source
FROM
(
	SELECT DISTINCT
	oc.o_ObjectID			AS ObjectID,
	oc.o_ObjectNumber		AS ObjectNumber,
	oc.cxd_NameID			AS NameID,
	oc.cxd_ConstituentID	AS ConstituentID,
	oc.cx_RoleID			AS RoleID,
	oc.cx_DisplayOrder		AS DisplayOrder,
	oc.cx_Role				AS Role,
	oc.DisplayNameCultureDate,
	oc.DisplayName,
	oc.DisplayCultureDate
	FROM	MFAHv_OBJ_Constituent	AS oc
	WHERE	oc.cx_RoleTypeID = 1
	AND		oc.cx_Displayed = 1
) AS om	--MFAHv_OCM_ObjectMaker

GROUP BY om.ObjectID, om.ObjectNumber, om.ConstituentID, om.RoleID, om.Role
HAVING COUNT(*) > 1














/*



--	MFAHv_OBJ_Image

SELECT
MediaXrefID, ObjectID, ObjectNumber, --RenditionNumber,
COUNT(*) AS Records
FROM MFAHv_OBJ_Image
GROUP BY MediaXrefID, ObjectID, ObjectNumber--, RenditionNumber
HAVING COUNT(*) > 1
ORDER BY ObjectNumber


SELECT * FROM MFAHv_OBJ_Image	-- ImageID = MediaMasterID
WHERE ObjectID = 48081			-- MediaMasterID = 35078 appears 4 times


SELECT * FROM MFAHv_OBJ_Media
WHERE ObjectID = 48081			-- MediaMasterID = 35078 appears 4 times


SELECT * FROM MediaXrefs
--WHERE ID = 48081			-- 5 records, one for each media record in the object-media tab
WHERE MediaMasterID = 35078	-- appears only once in the whole table

SELECT * FROM MediaMaster
WHERE MediaMasterID = 35078  -- 1 record, appears once in MediaXrefs





*/




