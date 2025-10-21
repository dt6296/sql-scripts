USE [TMS]
GO

/****** Object:  View [dbo].[vListViewObjects]    Script Date: 02/11/2014 13:38:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--CREATE VIEW [dbo].[vListViewObjects] AS
SELECT DISTINCT

uf.UserFieldName,
ufx.FieldValue,
ufva.UserFieldValue,

O.ObjectID AS ID,
O.ObjectNumber,
O.SortNumber,
D.Mnemonic,
CL.Classification,
OC.Culture,
OC.Period,
SUBSTRING(ISNULL(CXS.ForwardDisplay, dbo.ConAltNames.DisplayName), 1, 255) AS DisplayName,
SUBSTRING(ISNULL(CXS.InvertedDisplay, dbo.ConAltNames.AlphaSort), 1, 255) AS AlphaSort,
O.ObjectName,
OT.Title,
O.Dated,
O.DateBegin,
SUBSTRING(O.Medium, 1, 255) AS Medium,
SUBSTRING(O.Dimensions, 1, 255) AS Dimensions,
SUBSTRING(O.Description, 1, 255) AS Description,
SUBSTRING(O.CreditLine, 1, 255) AS CreditLine


FROM dbo.Objects							AS O 
INNER JOIN	dbo.Departments					AS D	ON O.DepartmentID = D.DepartmentID
INNER JOIN	dbo.vListViewClassifications	AS CL	ON	O.ClassificationID = CL.ClassificationID
INNER JOIN	dbo.ObjContext					AS OC	ON	O.ObjectID = OC.ObjectID
LEFT OUTER JOIN	dbo.ObjTitles				AS OT	ON	O.ObjectID = OT.ObjectID
													AND	OT.Displayed = 1
													AND	OT.DisplayOrder = 1
LEFT OUTER JOIN	dbo.ConXrefSets				AS CXS	ON	O.ObjectID = CXS.ID
													AND	CXS.TableID = 108
													AND	CXS.AttributeStatusID = 0
LEFT OUTER JOIN	dbo.ConXrefs
INNER JOIN	dbo.ConXrefDetails						ON	dbo.ConXrefs.ConXrefID = dbo.ConXrefDetails.ConXrefID
													AND	dbo.ConXrefDetails.UnMasked = 1
INNER JOIN	dbo.ConAltNames							ON	dbo.ConXrefDetails.NameID = dbo.ConAltNames.AltNameId 
													ON	O.ObjectID = dbo.ConXrefs.ID
													AND	dbo.ConXrefs.TableID = 108
													AND	dbo.ConXrefs.RoleTypeID = 1
													AND	dbo.ConXrefs.DisplayOrder = 1
													AND	dbo.ConXrefs.Displayed = 1
													
LEFT OUTER JOIN dbo.UserFieldXrefs			AS ufx	ON	O.ObjectID = ufx.ID
													AND	ufx.ContextID = 1
LEFT OUTER JOIN dbo.UserFields				AS uf	ON	ufx.UserFieldID = uf.UserFieldID
													AND uf.ContextID = 1
													AND	uf.UserFieldID = 30
LEFT OUTER JOIN dbo.UserFieldValueAuthority	AS ufva	ON	uf.UserFieldID = ufva.UserFieldID


WHERE O.ObjectID IN (48123,110421,119208,78829,33653,19195,22428,2324,32835,1388,29874,84131,5410,109944,95424,71013,12379,3370,4858,1093,1442,1614,1723,6115,59856,34748,12479,10894,65393,90429,77456,114330,115845)	--test records
ORDER BY O.ObjectID


--Put in some sort of message for object with multiple FF records.



--GO





SELECT * FROM UserFields WHERE UserFieldName = 'Application Section'

SELECT * FROM DDContexts WHERE ContextID IN (1,9)


SELECT
ufx.UserFieldGroupID,
ufg.GroupName,
ufx.UserFieldXrefID,
ufx.UserFieldID,
ufx.FieldValue,
uf.UserFieldName,
uf.UserFieldType,
uf.ContextID,
ddc.Context,
ufx.ID
 
FROM UserFieldXrefs AS ufx
INNER JOIN UserFields AS uf ON ufx.UserFieldID = uf.UserFieldID
INNER JOIN UserFieldGroups AS ufg ON ufx.UserFieldGroupID = ufg.UserFieldGroupID
INNER JOIN DDContexts aS ddc ON uf.ContextID = ddc.ContextID

WHERE ufx.UserFieldID IN (52)


--DELETE FROM UserFieldXrefs WHERE UserFieldID IN (52)

SELECT * FROM UserFieldXrefs WHERE UserFieldID = 53



SELECT * FROM UserFields WHERE UserFieldName LIKE 'ICAA%'



SELECT * FROM UserFieldXrefs WHERE UserFieldID IN (87,88)


SELECT TOP 100 * FROM UserFields ORDER BY EnteredDate DESC



