--CREATE VIEW [dbo].[MFAHv_OBJ_PackageList] AS
/*

MFAHv_OBJ_PackageList
Custom MFAH View

Author:		Dave Thompson
Created:	5/28/2014

Description:	
This just returns the OBJECT Package and List information that I think I'll
use for multiple reports.

Updated:	

*/

SELECT
p.PackageID,
p.TableID,
p.Name			AS PackageName,
p.[Owner]		AS PackageOwner,
p.Notes			AS PackageNotes,
pl.ID			AS ObjectID,
pl.MainData		AS ObjectNumber,
pl.OrderPos,
pl.Notes		AS ObjectNotes,
pl.EnteredDate	AS ObjectAdded,
pl.LoginID

FROM [Packages]			AS p
INNER JOIN PackageList	AS pl	ON p.PackageID	= pl.PackageID

WHERE	p.TableID	=	108		--Objects Table
AND		p.PackageID	=	15732	--PISD_ObjectReview
--						14311	--LTA/MS

