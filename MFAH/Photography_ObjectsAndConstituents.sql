
/*

SELECT 
o.ObjectID,
o.ObjectNumber,
c.cx_Role,
c.DisplayName,
c.c_ConstituentID AS ConstituentID,
ca.StreetLine1,
ca.StreetLine2,
ca.StreetLine3,
ca.City,
ca.State,
ca.ZipCode,
ca.Country,
ca.AddressType

FROM Objects AS o
LEFT OUTER JOIN MFAHv_OBJ_Constituent AS c ON o.ObjectID = c.cx_ID
LEFT OUTER JOIN MFAHv_CON_Address AS ca ON c.c_ConstituentID = ca.ConstituentID
INNER JOIN PackageList  AS pl ON o.ObjectID = pl.ID AND PackageID = 45940			-- Statements exhibition objects

WHERE c.cx_RoleID IN (2,14,16,19,24,41,45,91,143,395,408)	-- funders and donors
OR c.cx_RoleTypeID = 1	-- artists

ORDER BY pl.OrderPos

*/
------------------------------------------------------------------------- Updated to include OBJ Tombstone Info


SELECT 
o.ObjectID,
o.ObjectNumber,

dbo.MFAHfx_ConcatMakers_PrepPrefix_ActiveDisplayed(o.ObjectID) AS Artist,
o.TitleFirstActiveDisplayed AS Title,
REPLACE(REPLACE(REPLACE(o.Dated,CHAR(10),''),CHAR(09),''),CHAR(13),'')	AS Dated,
REPLACE(REPLACE(REPLACE(o.Medium,CHAR(10),''),CHAR(09),''),CHAR(13),'')	AS Medium,
REPLACE(REPLACE(REPLACE(o.Dimensions,CHAR(10),''),CHAR(09),''),CHAR(13),'')	AS Dimensions,
REPLACE(REPLACE(REPLACE(o.CreditLine,CHAR(10),''),CHAR(09),''),CHAR(13),'')	AS CreditLine,
c.cx_Role,
c.DisplayName,
c.c_ConstituentID AS ConstituentID,
ca.StreetLine1,
ca.StreetLine2,
ca.StreetLine3,
ca.City,
ca.State,
ca.ZipCode,
ca.Country,
ca.AddressType

FROM MFAHv_OBJ_Tombstone2 AS o
LEFT OUTER JOIN MFAHv_OBJ_Constituent AS c ON o.ObjectID = c.cx_ID
LEFT OUTER JOIN MFAHv_CON_Address AS ca ON c.c_ConstituentID = ca.ConstituentID
INNER JOIN PackageList  AS pl ON o.ObjectID = pl.ID AND PackageID IN (36144,55181)			-- HOP exhibition objects

WHERE c.cx_RoleID IN (2,11,14,16,18,19,24,31,41,45,47,91,143,233,395,408)	-- funders, donors, sellers, owners, intermediaries
OR c.cx_RoleTypeID IN (1)	-- artists

ORDER BY pl.OrderPos


----------------------------------------------------------------------------------------Onderdonk Lenders


SELECT
o.ObjectID,
o.ObjectNumber,

dbo.MFAHfx_ConcatMakers_PrepPrefix_ActiveDisplayed(o.ObjectID) AS Artist,
o.TitleFirstActiveDisplayed AS Title,
REPLACE(REPLACE(REPLACE(o.Dated,CHAR(10),''),CHAR(09),''),CHAR(13),'')	AS Dated,
REPLACE(REPLACE(REPLACE(o.Medium,CHAR(10),''),CHAR(09),''),CHAR(13),'')	AS Medium,
REPLACE(REPLACE(REPLACE(o.Dimensions,CHAR(10),''),CHAR(09),''),CHAR(13),'')	AS Dimensions,
REPLACE(REPLACE(REPLACE(o.CreditLine,CHAR(10),''),CHAR(09),''),CHAR(13),'')	AS CreditLine,

l.cx_Role,
l.c_ConstituentID,
l.c_DisplayName,
la.AddressType,
la.StreetLine1,
la.StreetLine2,
la.StreetLine3,
la.City,
la.State,
la.ZipCode,
la.Country

FROM MFAHv_OBJ_Tombstone2 AS o

LEFT OUTER JOIN MFAHv_OBJ_Constituent	AS a	ON o.ObjectID = a.cx_ID	AND a.cx_RoleTypeID = 1		-- artist
LEFT OUTER JOIN MFAHv_OBJ_Constituent	AS l	ON o.ObjectID = l.cx_ID	AND l.cx_RoleTypeID = 2
																		AND l.cx_RoleID IN (19,31,36,143)	-- lender
LEFT OUTER JOIN MFAHv_CON_Address		AS la	ON l.c_Constituentid = la.ConstituentID

WHERE a.c_ConstituentID = 5009	-- Julian Onderdonk		54 objects




SELECT * FROM Roles WHERE RoleTypeID = 2
19 -- owner
31 -- source
36 -- collection
143	-- owner anon

