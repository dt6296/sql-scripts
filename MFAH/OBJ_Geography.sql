USE [TMS]
GO

/****** Object:  View [dbo].[MFAHv_OCM_Object-GeographyDisplayed]    Script Date: 03/14/2014 12:26:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







--alter VIEW [dbo].[MFAHv_OBJ_Geography]
--AS

/*

MFAHv_OBJ_Geography
Custom MFAH View

Author:			Dave Thompson
Created:		5/23/2014


Description:	
This query provides all Object-Geography records for each Object record,
and concatenates political geography, physical geography, and full geography
for display.

Updated:	

*/

SELECT

og.ObjGeographyID,
og.ObjectID,
og.GeoCodeID,
gc.GeoCode,
UPPER(gc.GeoCode)		AS GeoCodeLabel,

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

	CASE WHEN og.Nation				IS NULL THEN '' ELSE ', ' + og.Nation END
+	CASE WHEN og.Country			IS NULL THEN '' ELSE og.Country END
+	CASE WHEN og.PoliticalRegion	IS NULL THEN '' ELSE ', ' + og.PoliticalRegion END	
+	CASE WHEN og.State				IS NULL THEN '' ELSE ', ' + og.State END
+	CASE WHEN og.County				IS NULL THEN '' ELSE ', ' + og.County END
+	CASE WHEN og.City				IS NULL THEN '' ELSE ', ' + og.City END
+	CASE WHEN og.Township			IS NULL THEN '' ELSE ', ' + og.Township END
+	CASE WHEN og.RegionalCorp		IS NULL THEN '' ELSE ', ' + og.RegionalCorp END
+	CASE WHEN og.VillageCorporation	IS NULL THEN '' ELSE ', ' + og.VillageCorporation END
+	CASE WHEN og.MapReferenceNumber	IS NULL THEN '' ELSE ', ' + og.MapReferenceNumber END
AS PoliticalGeography,

-----Physical Geography

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

	CASE WHEN og.Continent		IS NULL THEN '' ELSE og.Continent END
+	CASE WHEN og.SubContinent	IS NULL THEN '' ELSE ', ' + og.SubContinent END
+	CASE WHEN og.Region			IS NULL THEN '' ELSE ', ' + og.Region END
+	CASE WHEN og.SubRegion		IS NULL THEN '' ELSE ', ' + og.SubRegion END
+	CASE WHEN og.River			IS NULL THEN '' ELSE ', ' + og.River END
+	CASE WHEN og.CulturalRegion	IS NULL THEN '' ELSE ', ' + og.CulturalRegion END
+	CASE WHEN og.Locale			IS NULL THEN '' ELSE ', ' + og.Locale END
+	CASE WHEN og.Locus			IS NULL THEN '' ELSE ', ' + og.Locus END
+	CASE WHEN og.Excavation		IS NULL THEN '' ELSE ', ' + og.Excavation END
+	CASE WHEN og.Building		IS NULL THEN '' ELSE ', ' + og.Building END
AS PhysicalGeography,

-----Full Geography

	CASE WHEN og.Continent			IS NULL THEN '' ELSE og.Continent END
+	CASE WHEN og.SubContinent		IS NULL THEN '' ELSE ', ' + og.SubContinent END
+	CASE WHEN og.Region				IS NULL THEN '' ELSE ', ' + og.Region END
+	CASE WHEN og.SubRegion			IS NULL THEN '' ELSE ', ' + og.SubRegion END
+	CASE WHEN og.River				IS NULL THEN '' ELSE ', ' + og.River END
+	CASE WHEN og.CulturalRegion		IS NULL THEN '' ELSE ', ' + og.CulturalRegion END
+	CASE WHEN og.Locale				IS NULL THEN '' ELSE ', ' + og.Locale END
+	CASE WHEN og.Locus				IS NULL THEN '' ELSE ', ' + og.Locus END
+	CASE WHEN og.Excavation			IS NULL THEN '' ELSE ', ' + og.Excavation END
+	CASE WHEN og.Building			IS NULL THEN '' ELSE ', ' + og.Building END
+	CASE WHEN og.Nation				IS NULL THEN '' ELSE ', ' + og.Nation END
+	CASE WHEN og.Country			IS NULL THEN '' ELSE ', ' + og.Country END
+	CASE WHEN og.PoliticalRegion	IS NULL THEN '' ELSE ', ' + og.PoliticalRegion END	
+	CASE WHEN og.State				IS NULL THEN '' ELSE ', ' + og.State END
+	CASE WHEN og.County				IS NULL THEN '' ELSE ', ' + og.County END
+	CASE WHEN og.City				IS NULL THEN '' ELSE ', ' + og.City END
+	CASE WHEN og.Township			IS NULL THEN '' ELSE ', ' + og.Township END
+	CASE WHEN og.RegionalCorp		IS NULL THEN '' ELSE ', ' + og.RegionalCorp END
+	CASE WHEN og.VillageCorporation	IS NULL THEN '' ELSE ', ' + og.VillageCorporation END
+	CASE WHEN og.MapReferenceNumber	IS NULL THEN '' ELSE ', ' + og.MapReferenceNumber END
AS FullGeography

FROM ObjGeography AS og
LEFT OUTER JOIN GeoCodes AS gc ON og.GeoCodeID = gc.GeoCodeID


WHERE og.ObjectID IN (110421, 2)


GO

/*
SELECT 
c.ColumnID,
c.ColumnName,
lcn.ColumnLabel

FROM
DDColumns AS c
LEFT OUTER JOIN DDLocalColumnNames AS lcn ON c.ColumnID = lcn.ColumnID AND c.PhysTableID = 21

WHERE lcn.Customized = 1
AND lcn.LanguageID = 1
*/