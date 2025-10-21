USE [TMS]
GO

/****** Object:  View [dbo].[vListViewObjects]    Script Date: 06/24/2014 12:30:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--CREATE VIEW [dbo].[vListViewObjects] AS

SELECT
o.ObjectID AS ID,
o.ObjectNumber,
o.SortNumber,
d.Mnemonic,
lvcl.Classification,
oc.Culture,
oc.Period,
SUBSTRING(ISNULL(cxs.ForwardDisplay,can.DisplayName),1,255)	AS DisplayName,
SUBSTRING(ISNULL(cxs.InvertedDisplay,can.AlphaSort),1,255)	AS AlphaSort,
o.ObjectName,
ot.Title,
o.Dated,
o.DateBegin,
SUBSTRING(o.Medium,1,255)		AS Medium,
SUBSTRING(o.Dimensions,1,255)	AS Dimensions,
SUBSTRING(o.Description,1,255)	AS Description,
SUBSTRING(o.CreditLine,1,255)	AS CreditLine

FROM			Objects						AS o
INNER JOIN		Departments					AS d	ON	o.DepartmentID = d.DepartmentID
INNER JOIN		vListViewClassifications	AS lvcl	ON	o.ClassificationID = lvcl.ClassificationID
INNER JOIN		ObjContext					AS oc	ON	o.ObjectID = oc.ObjectID
LEFT OUTER JOIN	ObjTitles					AS ot	ON	o.ObjectID = ot.ObjectID
													AND	ot.Displayed = 1 
													AND ot.DisplayOrder = 1
LEFT OUTER JOIN	ConXrefSets					AS cxs	ON	o.ObjectID = cxs.ID
													AND cxs.TableID = 108
													AND cxs.AttributeStatusID = 0
LEFT OUTER JOIN	ConXrefs					AS cx
INNER JOIN		ConXrefDetails				AS cxd	ON	cx.ConXrefID = cxd.ConXrefID
													AND	cxd.UnMasked = 1
INNER JOIN		ConAltNames					AS can	ON	cxd.NameID = can.AltNameId
													ON	o.ObjectID = cx.ID
													AND cx.TableID = 108
													AND cx.RoleTypeID = 1
													AND cx.DisplayOrder = 1
													AND cx.Displayed = 1


WHERE o.ObjectID IN
(

	SELECT
	pl.ID
	FROM		PackageList	AS pl
	INNER JOIN	Packages	AS p	ON pl.PackageID = p.PackageID
	WHERE p.PackageID = 15811	
)

ORDER BY o.ObjectID


GO


