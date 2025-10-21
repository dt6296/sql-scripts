

--------------------------------------------------------------------- OBJ_Tombstone

SELECT
o.ObjectID AS ID,
o.ObjectID,
o.ObjectNumber,
o.SortNumber,
dbo.MFAHfx_ConcatMakers_RolePrefix_ActiveDisplayed(o.ObjectID,'') AS ArtistRole,
dbo.MFAHfx_ConcatMakers_PrepPrefix_ActiveDisplayed(o.ObjectID) AS ArtistPrep,
ot.Title,
dbo.MFAHfx_ConcatTitles(o.ObjectID,'') AS Titles,
o.Dated,
o.Medium,
o.Dimensions AS DimensionsDisplayed,
'' AS DimensionsHidden,
o.CreditLine

FROM Objects AS o
LEFT OUTER JOIN ObjTitles AS ot ON o.ObjectID = ot.ObjectID AND ot.DisplayOrder = 1

WHERE o.ObjectNumber LIKE 'TEST.DAVE.%'


--------------------------------------------------------------------- OBJ_Context

SELECT
oc.ObjectID AS ID,
oc.ObjectID,
oc.Culture,
oc.Nationality,
oc.Style,
oc.School,
oc.Dynasty,
oc.Reign,
oc.Movement,
oc.Period,
dbo.MFAHfx_ConcatObjGeography(oc.ObjectID,'') AS Geography,
oc.LongText10 AS Keywords,
oc.ShortText1 AS KeywordNotes

FROM ObjContext AS oc 

WHERE oc.ObjectID = 110421

--------------------------------------------------------------------- OBJ_Documentation

SELECT
o.ObjectID AS ID,
o.ObjectID,
o.Portfolio,
o.State,
o.Edition,
o.Signed,
o.Markings,
o.Inscribed,
o.PaperSupport,
o.Provenance,
o.CatRais,
o.PubReferences,
o.Bibliography,
o.RelatedWorks,
o.Exhibitions,
o.Notes,
o.CuratorialRemarks,
o.Description,
lt.TextEntry,
lt.TextEntryHTML,
'Conservation Notes will go here.' AS ConservationNote

FROM Objects AS o
LEFT OUTER JOIN MFAHv_OBJ_LabelText_eMuseum AS lt	ON o.ObjectID = lt.ID 
													AND lt.TableID = 108

WHERE o.ObjectID = 110421


--------------------------------------------------------------------- OBJ_Administrative

SELECT
o.ObjectID AS ID,
o.ObjectID,
o.ObjectTypeID,
ot.ObjectType,
o.ObjectLevelID,
ol.ObjectLevel,
o.ObjectCount,
'' AS ComponentCount,
o.IsVirtual,
CASE WHEN o.IsVirtual = 1 THEN 'Virtual' ELSE 'Physical' END AS IsVirtualDisplay,
CASE WHEN o.CuratorApproved = 1 THEN 'Yes' ELSE 'No' END AS CuratorApproved,
CASE WHEN o.PublicAccess = 1 THEN 'Yes' ELSE 'No' END AS WebsiteApproved,
o.DepartmentID,
d.Department,
dp.DepartmentPublic AS CollectingArea,
o.ClassificationID,
c.Classification,
CASE WHEN o.OnView = 1 THEN 'Yes' ELSE 'No' END AS OnView,
dbo.MFAHfx_ConcatObjLocation(o.ObjectID) AS CurrentLocation

FROM Objects AS o
INNER JOIN ObjectTypes AS ot ON o.ObjectTypeID = ot.ObjectTypeID
INNER JOIN ObjectLevels AS ol ON o.ObjectLevelID = ol.ObjectLevelID
INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID
INNER JOIN Classifications AS c ON o.ClassificationID = c.ClassificationID
INNER JOIN MFAHt_DepartmentPublic AS dp ON d.DepartmentID = dp.DepartmentID

WHERE o.ObjectNumber LIKE 'TEST.DAVE.%'



--------------------------------------------------------------------- OBJ_Registration

SELECT
o.ObjectID AS ID,
o.ObjectID,
'' AS AlternateNumbers,
'' AS CurrentLocation,
'' AS LocationHistory,
'' AS Origin,
'' AS CurrentValue,
'' AS PurchasePrice,
'' AS OGNFundedPrice,
'' AS AdditionalCosts,
'' AS LoanHistory


FROM Objects AS o

WHERE o.ObjectNumber LIKE 'TEST.DAVE.%' 


--------------------------------------------------------------------- OBJ_Rights

SELECT
o.ObjectID AS ID,
o.ObjectID,
o.ObjRightsTypeID,
o.ObjRightsType,
o.Copyright,
o.Restrictions,
o.CreditLineRepro,
o.CopyrightStatement,
o.OCMCopyrightStatement AS CopyrightStatement_eMuseum,
o.StatusFlags

FROM MFAHv_OBJ_Rights AS o

WHERE o.ObjectID = 110421



