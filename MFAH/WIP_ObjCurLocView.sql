USE [TMS]
GO

/****** Object:  View [dbo].[ObjCurLocView]    Script Date: 06/24/2014 12:44:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




--CREATE VIEW [dbo].[ObjCurLocView] AS
SELECT

--This is a Gallery Systems view!
--Dave Thompson reordered and reformatted this view for easier reading 12/4/2013

--Object Component
OC.ObjectID,
OC.ComponentID,
OC.ComponentNumber,
OC.HomeLocationID,

--Current Object Location
OL.LocationID			AS CurLocationID,
OL.LocLevel				AS CurLevel,
OL.Sublevel				AS CurSublevel,
OL.SearchContainer		AS CurContainer,
OL.TempFlag,
OL.TempText,
OL.TempTicklerDate,
OL.TransCodeID,
OL.TransDate,
OL.Handler,

--Current Location
L.Site					AS CurSite,
L.Room					AS CurRoom,
L.UnitType				AS CurUnitType,
L.UnitNumber			AS CurUnitNumber,
L.UnitPosition			AS CurUnitPosition,
L.LocationString,		--Dave Thompson added this field 12/5/2013

--Current Crate
CurCr.CrateID			AS CurCrateID,
CurCr.CrateNumber		AS CurCrateNumber,

--Previous Object Location
PrevOL.LocationID		AS PrevLocationID,
PrevOL.Sublevel			AS PrevSublevel,
PrevOL.LocLevel			AS PrevLevel,
PrevOL.SearchContainer	AS PrevContainer,

--Previous Location
PrevL.Site				AS PrevSite,
PrevL.Room				AS PrevRoom,
PrevL.UnitType			AS PrevUnitType,
PrevL.UnitNumber		AS PrevUnitNumber,
PrevL.UnitPosition		AS PrevUnitPostion,

--Previous Crate
PrevCR.CrateID			AS PrevCrateID,
PrevCR.CrateNumber		AS PrevCrateNumber

FROM ObjComponents			AS OC

--Current Info
INNER JOIN	ObjLocations	AS OL		ON OC.CurrentObjLocID = OL.ObjLocationID 
LEFT JOIN	Locations		AS L		ON OL.LocationID = L.LocationID
LEFT JOIN	Crates			AS CurCr	ON OL.CrateID = CurCr.CrateID

--Previous Info
LEFT JOIN	ObjLocations	AS PrevOL	ON OL.PrevObjLocID = PrevOL.ObjLocationID
LEFT JOIN	Locations		AS PrevL	ON PrevOL.LocationID = PrevL.LocationID
LEFT JOIN	Crates			AS PrevCR	ON PrevOL.CrateID = PrevCR.CrateID

WHERE OL.TransCodeID < 4


AND OC.ObjectID IN
(

	SELECT
	pl.ID
	FROM		PackageList	AS pl
	INNER JOIN	Packages	AS p	ON pl.PackageID = p.PackageID
	WHERE p.PackageID = 15811	
)

ORDER BY OC.ObjectID

GO


