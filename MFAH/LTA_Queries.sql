


--	LTA queries -- 12/15/2015



--SELECT * FROM Packages WHERE Name LIKE 'LTA%' AND Owner = 'dthompson'

--	LTA		35781	78
--	LTA1	35773	43
--	LTA2	35264	35

--	Object

	SELECT
	ObjectID,
	AccessionNumber,
	SortNumber,
	ObjectCount,
	ComponentCount,
	Department,
	ObjectStatus,
	Classification,
	ObjectLevel,
	ObjectType,
	Culture,
	DateBegin,
	DateEnd,
	Worktype,
	Dated,
	Medium,
	Dimensions,
	CreditLine,
	Provenance,
	Description,
	Signed,
	Markings,
	Style,
	Movement,
	Nationality,
	Period,
	School,
	Reign,
	Dynasty,
	ObjRightsType,
	'' AS Copyright,
	'' AS Restrictions,
	'' AS CreditLineRepro,
	CopyrightStatement,
	'' AS ViewStatus,
	'' AS DisplayLocation,
	'' AS DisplayRoom,
	'' AS Exhibtions,
	LabelText
	
FROM MFAHv_OCM_Object

WHERE ObjectID IN
(
	SELECT ID FROM PackageList WHERE
	PackageID = 35781 AND  TableID = 108
)




--	ObjectMaker

SELECT
ObjectID,
ConstituentID AS cxd_ConstituentID,
NameID AS cxd_NameID,
Role AS cx_Role,
DisplayOrder AS cx_DisplayOrder,
AlphaSort,
DisplayNameCultureDate AS OCM_DisplayName

FROM MFAHv_OCM_ObjectMaker

WHERE ObjectID IN
(
	SELECT ID FROM PackageList WHERE
	PackageID = 35781 AND  TableID = 108
)



--	ObjectTitle

SELECT
ObjectID,
TitleID,
Title,
TitleType,
Language,
DisplayOrder

FROM MFAHv_OCM_ObjectTitle

WHERE ObjectID IN
(
	SELECT ID FROM PackageList WHERE
	PackageID = 35781 AND  TableID = 108
)


--	Constituent

SELECT DISTINCT
c.ConstituentID,
c.DefaultNameID,
c.FirstName,
c.MiddleName,
c.LastName,
c.DisplayName,
c.AlphaSort,
c.AlphaGroup,
c.DisplayDate,
c.ObjectCount

FROM MFAHv_OCM_Constituent AS c
INNER JOIN MFAHv_OCM_ObjectMaker AS om ON om.ConstituentID = c.ConstituentID

WHERE ObjectID IN
(
	SELECT ID FROM PackageList WHERE
	PackageID = 35781 AND  TableID = 108
)



--	ConstituentName

SELECT DISTINCT
cn.NameID AS AltNameID,
cn.ConstituentID,
cn.FirstName,
cn.MiddleName,
cn.LastName,
cn.DisplayName,
cn.AlphaSort,
cn.AlphaGroup

FROM MFAHv_OCM_ConstituentName AS cn
INNER JOIN MFAHv_OCM_ObjectMaker AS om ON om.ConstituentID = cn.ConstituentID

WHERE ObjectID IN
(
	SELECT ID FROM PackageList WHERE
	PackageID = 35781 AND  TableID = 108
)

ORDER BY ConstituentID, AltNameID


--	ObjectGeography


SELECT
ObjectID,
ObjGeographyID,
GeoCode,
PoliticalGeography,
PhysicalGeography,
PhysicalGeography + ' ' + PoliticalGeography AS FullGeography

FROM MFAHv_OCM_ObjectGeography

WHERE ObjectID IN
(
	SELECT ID FROM PackageList WHERE
	PackageID = 35781 AND  TableID = 108
)



--	ObjectLocation

SELECT
ObjectID,
CurLocationID,
CASE WHEN OnView = 1 THEN 'On view' ELSE 'Not on view' END AS ViewStatus,
DisplayLocation,
DisplayRoom

FROM MFAHv_OCM_ObjectLocation

WHERE ObjectID IN
(
	SELECT ID FROM PackageList WHERE
	PackageID = 35781 AND  TableID = 108
)



--	ObjectImage

SELECT
ImageID				AS Record_ID,
ObjectID,
0					AS Field_ID,
''					AS FieldName,
FullImage			AS FilePath,
FileName,
''					AS Extension,
''					AS RelationshipType,
''					AS CatalogLevel,
ImageTitle			AS Title,
ViewType			AS ImageViewType,
ViewDescription		AS ImageViewDescription,
ImageCopyright		AS RightsText,
ImageStatus,
ImageRank

FROM MFAHv_OCM_ObjectImage

WHERE ObjectID IN
(
	SELECT ID FROM PackageList WHERE
	PackageID = 35781 AND  TableID = 108
)



--	ObjectCollection			-- Records are hard-coded in TLAObjects2?, no Collection table.

SELECT
ObjectID

FROM MFAHv_OCM_ObjectCollection

WHERE ObjectID IN
(
	SELECT ID FROM PackageList WHERE
	PackageID = 35781 AND  TableID = 108
)