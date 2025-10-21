









SELECT * FROM Roles
WHERE RoleTypeID = 2
ORDER BY Role


SELECT * FROM MFAHv_OBJ_Constituent
WHERE cx_RoleID = 32				-- Honoree
AND cxd_ConstituentID = 1768		-- Anne Tucker		--203


SELECT * FROM MFAHv_OBJ_Constituent
WHERE o_ObjectID IN
(
	SELECT o_ObjectID FROM MFAHv_OBJ_Constituent
	WHERE cx_RoleID = 32				-- Honoree
	AND cxd_ConstituentID = 1768		-- Anne Tucker
)
AND cx_RoleID IN (2,16)				-- Donor, Donor(Anonymous)			--222




SELECT
o.ObjectID,
o.ObjectNumber,
o.SortNumber,
o.ObjectStatus,
o.AccessionISODate

FROM MFAHv_OBJ AS o

WHERE o.ObjectID IN
(
	SELECT o_ObjectID FROM MFAHv_OBJ_Constituent
	WHERE cx_RoleID = 32				-- Honoree
	AND cxd_ConstituentID = 1768		-- Anne Tucker
)




--------------------------------------------------------------------



SELECT 

oc.cxd_ConstituentID,
oc.cxd_NameID,
oc.cx_Role,
oc.DisplayName,
ca.AddressType,
ca.StreetLine1,
ca.StreetLine2,
ca.StreetLine3,
ca.City,
ca.State,
ca.Country,
ca.ZipCode,
ca.DefaultMailing,

oc.o_ObjectID,
oc.o_ObjectNumber,
o.AccessionISODate,
o.AccessionMethod,

REPLACE(REPLACE(
CASE WHEN LEN(dbo.MFAHfx_ConcatMakers_PrepPrefix(o.ObjectID,'')) > 4 THEN
LEFT(dbo.MFAHfx_ConcatMakers_PrepPrefix(o.ObjectID,''),
LEN(dbo.MFAHfx_ConcatMakers_PrepPrefix(o.ObjectID,''))-4) 
ELSE dbo.MFAHfx_ConcatMakers_PrepPrefix(o.ObjectID,'') END	,CHAR(10),''),CHAR(13),'')					AS Artist,

REPLACE(REPLACE(dbo.MFAHfx_ConcatTitles(o.ObjectID,''),CHAR(10),''),CHAR(13),'') AS Title,

o.Dated

FROM MFAHv_OBJ_Constituent AS oc
INNER JOIN MFAHv_CON_Address AS ca ON oc.cxd_ConstituentID = ca.ConstituentID
INNER JOIN MFAHv_OBJ AS o ON oc.o_ObjectID = o.ObjectID
INNER JOIN MFAHv_OBJ_Maker_FirstDisplayed AS omfd ON oc.o_ObjectID = omfd.ObjectID
WHERE o_ObjectID IN
(
	SELECT o_ObjectID FROM MFAHv_OBJ_Constituent
	WHERE cx_RoleID = 32				-- Honoree
	AND cxd_ConstituentID = 1768		-- Anne Tucker
)
AND cx_RoleID IN (2,16)				-- Donor, Donor(Anonymous)			--222

AND ca.DefaultMailing = 1


