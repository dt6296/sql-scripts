USE [TMS]
GO

/****** Object:  View [dbo].[vListViewObjectInfoCurrentLocation]    Script Date: 06/24/2014 12:24:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--CREATE VIEW [dbo].[vListViewObjectInfoCurrentLocation] AS

SELECT
lvo.ID,
oclv.ObjectID
/*
lvo.ObjectNumber,
lvo.SortNumber,
lvo.Mnemonic,
lvo.Classification,
lvo.Culture,
lvo.DisplayName,
lvo.AlphaSort,
lvo.Title,
lvo.Dated,
lvo.Medium,
lvo.Dimensions,
lvo.Description,
oclv.CurSite,
oclv.CurRoom,
oclv.CurUnitType,
oclv.CurUnitNumber,
oclv.CurUnitPosition,
oclv.CurLevel, 
oclv.CurContainer,
oclv.TempText
--mwc.FieldValue
*/

FROM			vListViewObjects		AS lvo
LEFT OUTER JOIN ObjCurLocView			AS oclv	ON	lvo.ID = oclv.ObjectID
--LEFT OUTER JOIN	[mfah_war categories]	AS mwc	ON	lvo.ID = mwc.ID

WHERE	(lvo.ObjectNumber = oclv.ComponentNumber)

AND lvo.ID IN
(

	SELECT
	pl.ID
	FROM		PackageList	AS pl
	INNER JOIN	Packages	AS p	ON pl.PackageID = p.PackageID
	WHERE p.PackageID = 15811	
)


GO
