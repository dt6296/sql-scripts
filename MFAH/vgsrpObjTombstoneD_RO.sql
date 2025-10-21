USE [TMS]
GO

/****** Object:  View [dbo].[vgsrpObjTombstoneD_RO]    Script Date: 3/10/2016 9:42:21 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


Create View [dbo].[vgsrpObjTombstoneD_RO] As

Select 
Objects.ObjectID, 
Objects.ObjectNumber, 
Objects.SortNumber, 
Objects.PhysicalParentID,
(CASE WHEN Objects.PhysicalParentID IS NULL THEN Objects.ObjectID ELSE Objects.PhysicalParentID END) AS ParentID,
(CASE WHEN Objects.PhysicalParentID IS NULL THEN Objects.ObjectNumber ELSE ObjectParent.ObjectNumber END) AS ParentObjectNumber,
(CASE WHEN Objects.PhysicalParentID IS NULL THEN Objects.SortNumber ELSE ObjectParent.SortNumber END) AS ParentSortNumber,
Objects.DepartmentID, 
Objects.ObjectStatusID, 
Objects.ClassificationID, 
Objects.ObjectName, 
Objects.Dated,
Objects.DateBegin, 
Objects.DateEnd, 
Objects.DateRemarks, 
Objects.DateEffectiveISODate, 
Objects.Medium,
Objects.Dimensions,
Objects.CreditLine, 
Objects.Description, 

ObjTitles.TitleID, 
ObjTitles.Title,
ObjTitles.Remarks AS TitleRemarks, 
ObjTitles.DateEffectiveISODate AS TitleEffectiveISODate, 

ConXrefSets.ConXrefSetID,
ConXrefSets.ForwardDisplay, 
ConXrefSets.InvertedDisplay, 
ConXrefSets.Remarks AS AttributionRemarks,
ConXrefSets.DateEffectiveISODate AS AttributionEffectiveISODate, 

ConXrefs.RoleID, 
Roles.Role, 

ConXrefDetails.NameID,
ConXrefDetails.ConstituentID, 
ConXrefDetails.Prefix, 
ConXrefDetails.Remarks, 
ConXrefDetails.ConStatement,
ConXrefDetails.Suffix, 
ConXrefDetails.Amount, 

ConAltNames.LastName, 
ConAltNames.FirstName, 
ConAltNames.NameTitle,
ConAltNames.Remarks AS AltNameRemarks, 
ConAltNames.MiddleName, 
ConAltNames.Suffix AS AltNameSuffix,
ConAltNames.CultureGroup, 
ConAltNames.Institution, 
ConAltNames.NameType, 
ConAltNames.DisplayName,
ConAltNames.Position, 
ConAltNames.salutation, 
ConAltNames.AlphaSort

From		Objects
Left Join	Objects ObjectParent	On Objects.PhysicalParentID = ObjectParent.ObjectID
Left Join	ObjTitles				On Objects.ObjectID = ObjTitles.ObjectID 
									AND ObjTitles.DisplayOrder = 1 
									AND ObjTitles.Displayed = 1
Left Join	ConXrefSets				On Objects.ObjectID = ConXrefSets.ID 
									AND ConXrefSets.TableID = 108 
									AND ConXrefSets.AttributeStatusID = 0
Left Join	(
			ConXrefs 
Inner Join	Roles					On ConXrefs.RoleID = Roles.RoleID
Inner Join	ConXrefDetails			On ConXrefs.ConXrefID = ConXrefDetails.ConXrefID AND ConXrefDetails.UnMasked = 1
Inner Join	ConAltNames				On ConXrefDetails.NameID = ConAltNames.AltNameID
			) 
									On Objects.ObjectID = ConXrefs.ID 
									AND ConXrefs.RoleTypeID = 1 
									AND ConXrefs.TableID = 108 
									AND ConXrefs.DisplayOrder = 1 
									AND ConXrefs.Displayed = 1


WHERE Objects.ObjectID = 130056


GO


