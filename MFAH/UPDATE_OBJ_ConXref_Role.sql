




SELECT * FROM Roles  WHERE RoleTypeID = 1

19 = Owner
413 = Maker



SELECT
o.ObjectID,
o.ObjectNumber,
oc.*

FROM Objects AS o
INNER JOIN MFAHv_OBJ_Constituent AS oc ON o.ObjectID = oc.o_ObjectID

WHERE ObjectNumber LIKE 'EX.2016.DE.%'
AND oc.cx_RoleID = 31	-- Source



--UPDATE ConXrefs SET RoleID = 19
--SELECT cx.* FROM ConXrefs AS cx
WHERE TableID = 108
AND ID IN 
(
	SELECT
	o.ObjectID
	FROM Objects AS o
	INNER JOIN MFAHv_OBJ_Constituent AS oc ON o.ObjectID = oc.o_ObjectID
	WHERE ObjectNumber LIKE 'EX.2016.DE.%'
	AND oc.cx_RoleID = 31	-- Source
)
AND RoleID = 31



---------------------------------------------------------------
SELECT * FROM Roles  WHERE RoleTypeID = 1
413 = Maker

SELECT * FROM Packages WHERE Name LIKE '2019-05-29  Dave%'

SELECT
o.ObjectID,
o.ObjectNumber,
oc.*

FROM Objects AS o
INNER JOIN MFAHv_OBJ_Constituent AS oc ON o.ObjectID = oc.o_ObjectID

WHERE ObjectID IN (SELECT ID FROM PackageList WHERE PackageID = 242405)
AND oc.cx_RoleTypeID = 1	-- Acquisition Related
AND oc.cx_Displayed = 1
AND oc.cx_DisplayOrder = 1



--UPDATE ConXrefs SET RoleID = 413
--SELECT cx.* FROM ConXrefs AS cx
WHERE TableID = 108
AND ID IN 
(
	SELECT
	o.ObjectID
	FROM Objects AS o
	INNER JOIN MFAHv_OBJ_Constituent AS oc ON o.ObjectID = oc.o_ObjectID
	WHERE ObjectID IN (SELECT ID FROM PackageList WHERE PackageID = 242405)
)
AND RoleTypeID = 1	-- Acquisition Related
AND Displayed = 1
AND DisplayOrder = 1

