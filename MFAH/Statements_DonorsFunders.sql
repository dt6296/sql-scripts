
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


