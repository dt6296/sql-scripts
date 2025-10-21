USE [TMS]
GO

/****** Object:  View [dbo].[vgsrpObjTombstoneD_RO]    Script Date: 05/20/2014 13:36:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vgsrpObjTombstoneD_RO]
AS
SELECT     TOP (100) 
PERCENT
dbo.Objects.ObjectID,
dbo.Objects.ObjectNumber,
dbo.Objects.SortNumber,
dbo.Objects.PhysicalParentID,
(CASE WHEN Objects.PhysicalParentID IS NULL THEN Objects.ObjectID ELSE Objects.PhysicalParentID END) AS ParentID,
(CASE WHEN Objects.PhysicalParentID IS NULL THEN Objects.ObjectNumber ELSE ObjectParent.ObjectNumber END) AS ParentObjectNumber,
(CASE WHEN Objects.PhysicalParentID IS NULL THEN Objects.SortNumber ELSE ObjectParent.SortNumber END) AS ParentSortNumber,
dbo.Objects.DepartmentID, 
dbo.Objects.ObjectStatusID,
dbo.Objects.ClassificationID,
dbo.Objects.ObjectName,
dbo.Objects.Dated,
dbo.Objects.DateBegin,
dbo.Objects.DateEnd, 
dbo.Objects.DateRemarks,
dbo.Objects.DateEffectiveISODate,
dbo.Objects.Medium,
dbo.Objects.Dimensions,
dbo.Objects.CreditLine,
dbo.Objects.Description, 
dbo.ObjTitles.TitleID,
dbo.ObjTitles.Title,
dbo.ObjTitles.Remarks AS TitleRemarks,
dbo.ObjTitles.DateEffectiveISODate AS TitleEffectiveISODate, 
dbo.ConXrefSets.ConXrefSetID,
dbo.ConXrefSets.ForwardDisplay,
dbo.ConXrefSets.InvertedDisplay,
dbo.ConXrefSets.Remarks AS AttributionRemarks, 
dbo.ConXrefSets.DateEffectiveISODate AS AttributionEffectiveISODate,
dbo.ConXrefs.RoleID, dbo.Roles.Role,
dbo.ConXrefDetails.NameID, 
dbo.ConXrefDetails.ConstituentID,
dbo.ConXrefDetails.Prefix,
dbo.ConXrefDetails.Remarks,
dbo.ConXrefDetails.ConStatement,
dbo.ConXrefDetails.Suffix, 
dbo.ConXrefDetails.Amount,
dbo.ConAltNames.LastName,
dbo.ConAltNames.FirstName,
dbo.ConAltNames.NameTitle,
dbo.ConAltNames.Remarks AS AltNameRemarks,
dbo.ConAltNames.MiddleName,
dbo.ConAltNames.Suffix AS AltNameSuffix,
dbo.ConAltNames.CultureGroup,
dbo.ConAltNames.Institution, 
dbo.ConAltNames.NameType,
dbo.ConAltNames.DisplayName,
dbo.ConAltNames.Position,
dbo.ConAltNames.salutation,
dbo.ConAltNames.AlphaSort, 
dbo.Objects.Chat,
dbo.Departments.Department,
dbo.ObjContext.Culture,
dbo.ObjContext.Nationality,
dbo.Objects.Provenance,
dbo.Objects.Signed, 
dbo.Objects.Inscribed,
dbo.Objects.Markings,
dbo.Objects.Notes
                      
FROM dbo.Objects 
LEFT OUTER JOIN	dbo.ObjContext					ON	dbo.Objects.ObjectID = dbo.ObjContext.ObjectID 
LEFT OUTER JOIN	dbo.Departments					ON	dbo.Objects.DepartmentID = dbo.Departments.DepartmentID
LEFT OUTER JOIN dbo.Objects		AS ObjectParent	ON	dbo.Objects.PhysicalParentID = ObjectParent.ObjectID
LEFT OUTER JOIN dbo.ObjTitles					ON	dbo.Objects.ObjectID = dbo.ObjTitles.ObjectID
												AND	dbo.ObjTitles.DisplayOrder = 1
												AND	dbo.ObjTitles.Displayed = 1
LEFT OUTER JOIN	dbo.ConXrefSets					ON	dbo.Objects.ObjectID = dbo.ConXrefSets.ID
												AND dbo.ConXrefSets.TableID = 108
												AND dbo.ConXrefSets.AttributeStatusID = 0
LEFT OUTER JOIN	dbo.ConXrefs
INNER JOIN		dbo.Roles						ON	dbo.ConXrefs.RoleID = dbo.Roles.RoleID
INNER JOIN		dbo.ConXrefDetails				ON	dbo.ConXrefs.ConXrefID = dbo.ConXrefDetails.ConXrefID
												AND dbo.ConXrefDetails.UnMasked = 1
INNER JOIN		dbo.ConAltNames					ON	dbo.ConXrefDetails.NameID = dbo.ConAltNames.AltNameId
												ON	dbo.Objects.ObjectID = dbo.ConXrefs.ID
												AND	dbo.ConXrefs.TableID = 108
												AND	dbo.ConXrefs.RoleTypeID = 1
												AND dbo.ConXrefs.DisplayOrder = 1
												AND dbo.ConXrefs.Displayed = 1

GO
