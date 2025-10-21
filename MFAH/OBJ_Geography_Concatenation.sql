USE [TMS]
GO

/****** Object:  View [dbo].[MFAHv_OBJ_Geography]    Script Date: 10/13/2014 10:27:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO










--CREATE VIEW [dbo].[MFAHv_OBJ_Geography] AS

/*

MFAHv_OBJ_Geography
Custom MFAH View

Created:		5/23/2014	Dave Thompson
Description:	
This query provides all Object-Geography records for each Object record,
and concatenates political geography, physical geography, and full geography
for display.

Updated:		6/30/2014	Dave Thompson
							Added RTRIM function to concatenated geography to prevent
							spaces from appearing where they shouldn't.
							Added GeoCodeLabelDisplay.
*/

SELECT
/*
og.ObjGeographyID,
og.ObjectID,
og.GeoCodeID,
gc.GeoCode,
UPPER(gc.GeoCode)		AS GeoCodeLabel,
ISNULL(UPPER(gc.GeoCode),'Place') AS GeoCodeLabelDisplay,

-----Political Geography

og.Nation				AS FormerEmpire,
og.Country				AS NationCountry,
og.PoliticalRegion		AS NationCountyHistOccAuto,
og.State				AS AmericanState,
og.County				AS CountyNonUSStateDeptProv,
og.City					AS InhabitedPlace,
og.Township				AS NeighborhoodDistrict,
og.RegionalCorp			AS NYCBorough,
og.VillageCorporation	AS UnitaryAuthority,
og.MapReferenceNumber	AS StreetNumber,
*/

SUBSTRING(

	CASE WHEN RTRIM(og.Nation)				IS NULL THEN '' ELSE RTRIM(og.Nation)			+ ', '	END
+	CASE WHEN RTRIM(og.Country)				IS NULL THEN '' ELSE RTRIM(og.Country)			+ ', '	END
+	CASE WHEN RTRIM(og.PoliticalRegion)		IS NULL THEN '' ELSE RTRIM(og.PoliticalRegion)	+ ', '	END	
+	CASE WHEN RTRIM(og.State)				IS NULL THEN '' ELSE RTRIM(og.State)			+ ', '	END
+	CASE WHEN RTRIM(og.County)				IS NULL THEN '' ELSE RTRIM(og.County)			+ ', '	END
+	CASE WHEN RTRIM(og.City)				IS NULL THEN '' ELSE RTRIM(og.City)				+ ', '	END
+	CASE WHEN RTRIM(og.Township)			IS NULL THEN '' ELSE RTRIM(og.Township)			+ ', '	END
+	CASE WHEN RTRIM(og.RegionalCorp)		IS NULL THEN '' ELSE RTRIM(og.RegionalCorp)		+ ', '	END
+	CASE WHEN RTRIM(og.VillageCorporation)	IS NULL THEN '' ELSE RTRIM(og.VillageCorporation)	+ ', '	END
+	CASE WHEN RTRIM(og.MapReferenceNumber)	IS NULL THEN '' ELSE RTRIM(og.MapReferenceNumber)	+ ', '	END
,1
, LEN(
	CASE WHEN RTRIM(og.Nation)				IS NULL THEN '' ELSE RTRIM(og.Nation)			+ ', '	END
+	CASE WHEN RTRIM(og.Country)				IS NULL THEN '' ELSE RTRIM(og.Country)			+ ', '	END
+	CASE WHEN RTRIM(og.PoliticalRegion)		IS NULL THEN '' ELSE RTRIM(og.PoliticalRegion)	+ ', '	END	
+	CASE WHEN RTRIM(og.State)				IS NULL THEN '' ELSE RTRIM(og.State)			+ ', '	END
+	CASE WHEN RTRIM(og.County)				IS NULL THEN '' ELSE RTRIM(og.County)			+ ', '	END
+	CASE WHEN RTRIM(og.City)				IS NULL THEN '' ELSE RTRIM(og.City)				+ ', '	END
+	CASE WHEN RTRIM(og.Township)			IS NULL THEN '' ELSE RTRIM(og.Township)			+ ', '	END
+	CASE WHEN RTRIM(og.RegionalCorp)		IS NULL THEN '' ELSE RTRIM(og.RegionalCorp)		+ ', '	END
+	CASE WHEN RTRIM(og.VillageCorporation)	IS NULL THEN '' ELSE RTRIM(og.VillageCorporation)	+ ', '	END
+	CASE WHEN RTRIM(og.MapReferenceNumber)	IS NULL THEN '' ELSE RTRIM(og.MapReferenceNumber)	+ ', '	END
)-1
) AS PoliticalGeography,

-----Physical Geography
/*
og.Continent			AS ContinentMoon,
og.SubContinent			AS GeneralRegion1,
og.Region				AS GeneralRegion2,
og.SubRegion			AS DestinationRegion,
og.River				AS HistoricalRegion,

og.CulturalRegion		AS Island,
og.Locale				AS WaterFeature,
og.Locus				AS LandFeature,
og.Excavation			AS BldgStructureStreet,
og.Building				AS BldgStructureType,
*/


COALESCE(
SUBSTRING(

	CASE WHEN RTRIM(og.Continent)		IS NULL THEN '' ELSE RTRIM(og.Continent)		+ ', '	END
+	CASE WHEN RTRIM(og.SubContinent)	IS NULL THEN '' ELSE RTRIM(og.SubContinent)		+ ', '	END
+	CASE WHEN RTRIM(og.Region)			IS NULL THEN '' ELSE RTRIM(og.Region)			+ ', '	END
+	CASE WHEN RTRIM(og.SubRegion)		IS NULL THEN '' ELSE RTRIM(og.SubRegion)		+ ', '	END
+	CASE WHEN RTRIM(og.River)			IS NULL THEN '' ELSE RTRIM(og.River)			+ ', '	END
+	CASE WHEN RTRIM(og.CulturalRegion)	IS NULL THEN '' ELSE RTRIM(og.CulturalRegion)	+ ', '	END
+	CASE WHEN RTRIM(og.Locale)			IS NULL THEN '' ELSE RTRIM(og.Locale)			+ ', '	END
+	CASE WHEN RTRIM(og.Locus)			IS NULL THEN '' ELSE RTRIM(og.Locus)			+ ', '	END
+	CASE WHEN RTRIM(og.Excavation)		IS NULL THEN '' ELSE RTRIM(og.Excavation)		+ ', '	END
+	CASE WHEN RTRIM(og.Building)		IS NULL THEN '' ELSE RTRIM(og.Building)			+ ', '	END
,1
, LEN(
	CASE WHEN RTRIM(og.Continent)		IS NULL THEN '' ELSE RTRIM(og.Continent)		+ ', '	END
+	CASE WHEN RTRIM(og.SubContinent)	IS NULL THEN '' ELSE RTRIM(og.SubContinent)		+ ', '	END
+	CASE WHEN RTRIM(og.Region)			IS NULL THEN '' ELSE RTRIM(og.Region)			+ ', '	END
+	CASE WHEN RTRIM(og.SubRegion)		IS NULL THEN '' ELSE RTRIM(og.SubRegion)		+ ', '	END
+	CASE WHEN RTRIM(og.River)			IS NULL THEN '' ELSE RTRIM(og.River)			+ ', '	END
+	CASE WHEN RTRIM(og.CulturalRegion)	IS NULL THEN '' ELSE RTRIM(og.CulturalRegion)	+ ', '	END
+	CASE WHEN RTRIM(og.Locale)			IS NULL THEN '' ELSE RTRIM(og.Locale)			+ ', '	END
+	CASE WHEN RTRIM(og.Locus)			IS NULL THEN '' ELSE RTRIM(og.Locus)			+ ', '	END
+	CASE WHEN RTRIM(og.Excavation)		IS NULL THEN '' ELSE RTRIM(og.Excavation)		+ ', '	END
+	CASE WHEN RTRIM(og.Building)		IS NULL THEN '' ELSE RTRIM(og.Building)			+ ', '	END
)
),',')	AS PhysicalGeography,




LEN(
	CASE WHEN RTRIM(og.Continent)		IS NULL THEN '' ELSE RTRIM(og.Continent)		+ ', '	END
+	CASE WHEN RTRIM(og.SubContinent)	IS NULL THEN '' ELSE RTRIM(og.SubContinent)		+ ', '	END
+	CASE WHEN RTRIM(og.Region)			IS NULL THEN '' ELSE RTRIM(og.Region)			+ ', '	END
+	CASE WHEN RTRIM(og.SubRegion)		IS NULL THEN '' ELSE RTRIM(og.SubRegion)		+ ', '	END
+	CASE WHEN RTRIM(og.River)			IS NULL THEN '' ELSE RTRIM(og.River)			+ ', '	END
+	CASE WHEN RTRIM(og.CulturalRegion)	IS NULL THEN '' ELSE RTRIM(og.CulturalRegion)	+ ', '	END
+	CASE WHEN RTRIM(og.Locale)			IS NULL THEN '' ELSE RTRIM(og.Locale)			+ ', '	END
+	CASE WHEN RTRIM(og.Locus)			IS NULL THEN '' ELSE RTRIM(og.Locus)			+ ', '	END
+	CASE WHEN RTRIM(og.Excavation)		IS NULL THEN '' ELSE RTRIM(og.Excavation)		+ ', '	END
+	CASE WHEN RTRIM(og.Building)		IS NULL THEN '' ELSE RTRIM(og.Building)			+ ', '	END
) AS TEST2,



-----Full Geography

	CASE WHEN RTRIM(og.Continent)			IS NULL THEN '' ELSE		RTRIM(og.Continent)				END
+	CASE WHEN RTRIM(og.SubContinent)		IS NULL THEN '' ELSE ', ' + RTRIM(og.SubContinent)			END
+	CASE WHEN RTRIM(og.Region)				IS NULL THEN '' ELSE ', ' + RTRIM(og.Region)				END
+	CASE WHEN RTRIM(og.SubRegion)			IS NULL THEN '' ELSE ', ' + RTRIM(og.SubRegion)				END
+	CASE WHEN RTRIM(og.River)				IS NULL THEN '' ELSE ', ' + RTRIM(og.River)					END
+	CASE WHEN RTRIM(og.CulturalRegion)		IS NULL THEN '' ELSE ', ' + RTRIM(og.CulturalRegion)		END
+	CASE WHEN RTRIM(og.Locale)				IS NULL THEN '' ELSE ', ' + RTRIM(og.Locale)				END
+	CASE WHEN RTRIM(og.Locus)				IS NULL THEN '' ELSE ', ' + RTRIM(og.Locus)					END
+	CASE WHEN RTRIM(og.Excavation)			IS NULL THEN '' ELSE ', ' + RTRIM(og.Excavation)			END
+	CASE WHEN RTRIM(og.Building)			IS NULL THEN '' ELSE ', ' + RTRIM(og.Building)				END
+	CASE WHEN RTRIM(og.Nation)				IS NULL THEN '' ELSE ', ' + RTRIM(og.Nation)				END
+	CASE WHEN RTRIM(og.Country)				IS NULL THEN '' ELSE ', ' + RTRIM(og.Country)				END
+	CASE WHEN RTRIM(og.PoliticalRegion)		IS NULL THEN '' ELSE ', ' + RTRIM(og.PoliticalRegion)		END	
+	CASE WHEN RTRIM(og.State)				IS NULL THEN '' ELSE ', ' + RTRIM(og.State)					END
+	CASE WHEN RTRIM(og.County)				IS NULL THEN '' ELSE ', ' + RTRIM(og.County)				END
+	CASE WHEN RTRIM(og.City)				IS NULL THEN '' ELSE ', ' + RTRIM(og.City)					END
+	CASE WHEN RTRIM(og.Township)			IS NULL THEN '' ELSE ', ' + RTRIM(og.Township)				END
+	CASE WHEN RTRIM(og.RegionalCorp)		IS NULL THEN '' ELSE ', ' + RTRIM(og.RegionalCorp)			END
+	CASE WHEN RTRIM(og.VillageCorporation)	IS NULL THEN '' ELSE ', ' + RTRIM(og.VillageCorporation)	END
+	CASE WHEN RTRIM(og.MapReferenceNumber)	IS NULL THEN '' ELSE ', ' + RTRIM(og.MapReferenceNumber)	END
AS FullGeography

FROM ObjGeography AS og
LEFT OUTER JOIN GeoCodes AS gc ON og.GeoCodeID = gc.GeoCodeID


WHERE og.ObjectID IN (110421, 2, 5273)





GO


