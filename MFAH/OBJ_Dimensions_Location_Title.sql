

/*

Written 1/23/17 to export for Malcolm Daniel

*/



SELECT
sq.ID,
o.SortNumber,
o.ObjectNumber,
dbo.MFAHFX_Proper(REPLACE(REPLACE(REPLACE(o.Title,CHAR(10),''),CHAR(09),''),CHAR(13),'')) AS Title,

CAST(ROUND(SUM(Image_Height / 2.54),2) AS DECIMAL (9,2))	AS	Image_Height_in,
CAST(ROUND(SUM(Image_Width / 2.54),2) AS DECIMAL (9,2))		AS	Image_Width_in,
CAST(ROUND(SUM(Image_Height),2) AS DECIMAL (9,1))			AS	Image_Height_cm,
CAST(ROUND(SUM(Image_Width),2) AS DECIMAL (9,1))			AS	Image_Width_cm,

CAST(ROUND(SUM(Sheet_Height / 2.54),2) AS DECIMAL (9,2))	AS	Sheet_Height_in,
CAST(ROUND(SUM(Sheet_Width / 2.54),2) AS DECIMAL (9,2))		AS	Sheet_Width_in,
CAST(ROUND(SUM(Sheet_Height),2) AS DECIMAL (9,1))			AS	Sheet_Height_cm,
CAST(ROUND(SUM(Sheet_Width),2) AS DECIMAL (9,1))			AS	Sheet_Width_cm,

ol.CurLocationString

FROM

(
	SELECT
	diex.TableID,
	diex.ID,

	CASE WHEN diex.ElementID = 4 THEN dH.EnteredDate ELSE 0 END AS Sheet_Height,
	CASE WHEN diex.ElementID = 4 THEN dW.EnteredDate ELSE 0 END AS Sheet_Width,
	CASE WHEN diex.ElementID = 15 THEN dH.EnteredDate ELSE 0 END AS Image_Height,
	CASE WHEN diex.ElementID = 15 THEN dW.EnteredDate ELSE 0 END AS Image_Width

	FROM			DimItemElemXrefs	AS diex
	LEFT OUTER JOIN	Dimensions2			AS dH		ON diex.DimItemElemXrefID = dH.DimItemElemXrefID	AND	dH.DimensionTypeID = 5
	LEFT OUTER JOIN	Dimensions2			AS dW		ON diex.DimItemElemXrefID = dW.DimItemElemXrefID	AND	dW.DimensionTypeID = 7
	LEFT OUTER JOIN	Dimensions2			AS dDia		ON diex.DimItemElemXrefID = dDia.DimItemElemXrefID	AND	dDia.DimensionTypeID = 3
	LEFT OUTER JOIN	Dimensions2			AS dD		ON diex.DimItemElemXrefID = dD.DimItemElemXrefID	AND	dD.DimensionTypeID = 2
	LEFT OUTER JOIN	Dimensions2			AS dCir		ON diex.DimItemElemXrefID = dCir.DimItemElemXrefID	AND	dCir.DimensionTypeID = 12
	LEFT OUTER JOIN DimensionElements	AS de		ON	diex.ElementID = de.ElementID

	WHERE	diex.TableID = 108
	AND diex.ElementID IN (4,15)
	AND diex.ID IN (SELECT ID FROM PackageList WHERE PackageID = 111722)
)	AS sq

LEFT OUTER JOIN Objects AS o ON sq.ID = o.ObjectID
LEFT OUTER JOIN MFAHv_OBJ_Location_ActiveComponent_First AS ol ON o.ObjectID = ol.ObjectID

GROUP BY sq.ID, o.ObjectNumber, o.SortNumber, o.Title, ol.CurLocationString

ORDER BY o.SortNumber




GO


