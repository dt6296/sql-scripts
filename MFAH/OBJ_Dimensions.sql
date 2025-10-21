/*

--Dimensions

--SELECT * FROM Objects WHERE ObjectNumber LIKE '2012.568'



/*

It looks like the display dimensions are already configured for how they should display on
the annual report (as of the 2013 annual report).

*/



SELECT
diex.DimItemElemXrefID,
diex.ID,
diex.ElementID,
diex.Displayed,
diex.Rank,
diex.DisplayDimensions,

de.Element,


--detx.*

dt.DimensionTypeID,
dt.DimensionType,

dut.UnitTypeID,
dut.UnitType,

du1.UnitID,
du1.UnitName,
du1.ConversionFactor,
du1.BaseDenominator,
du1.UnitLabel,

d.*,

ROUND(d.Dimension,1) AS DimensionRounded,

du1.ConversionFactor * d.Dimension,
ROUND(du1.ConversionFactor * d.Dimension,2),
CAST(du1.ConversionFactor * d.Dimension AS INT),
ROUND((du1.ConversionFactor * d.Dimension) -  CAST(du1.ConversionFactor * d.Dimension AS INT), 2),


CASE WHEN 
ROUND((du1.ConversionFactor * d.Dimension) -  CAST(du1.ConversionFactor * d.Dimension AS INT), 2)
= 0 THEN 0 
ELSE 1 / ROUND((du1.ConversionFactor * d.Dimension) -  CAST(du1.ConversionFactor * d.Dimension AS INT), 2) END AS fx1,


CAST(
CASE WHEN 
ROUND((du1.ConversionFactor * d.Dimension) -  CAST(du1.ConversionFactor * d.Dimension AS INT), 2)
= 0 THEN 0 
ELSE 1 / ROUND((du1.ConversionFactor * d.Dimension) -  CAST(du1.ConversionFactor * d.Dimension AS INT), 2) END AS INT
) AS fx2

FROM DimItemElemXrefs				AS diex
LEFT OUTER JOIN DimensionElements	AS de	ON	diex.ElementID = de.ElementID
LEFT OUTER JOIN DimElemTypeXrefs	AS detx	ON	de.ElementID = detx.ElementID
LEFT OUTER JOIN DimensionTypes		AS dt	ON	detx.DimensionTypeID = dt.DimensionTypeID
LEFT OUTER JOIN DimUnitTypes		AS dut	ON	dt.UnitTypeID = dut.UnitTypeID
LEFT OUTER JOIN DimensionUnits		AS du1	ON	detx.PrimaryUnitID = du1.UnitID
LEFT OUTER JOIN Dimensions			AS d	ON	diex.DimItemElemXrefID = d.DimItemElemXrefID
											AND	du1.UnitID = d.PrimaryUnitID
											AND dt.DimensionTypeID = d.DimensionTypeID
LEFT OUTER JOIN Objects				AS o	ON diex.ID = o.ObjectID AND diex.TableID = 108

WHERE diex.TableID = 108
AND dut.UnitTypeID = 1 -- Linear
AND dt.DimensionTypeID IN (5,7)  -- Height, Width

AND diex.ID = 117874


--SELECT * FROM DimensionUnits


*/






--	This closer to the basics of what I need for cm (Bridgeman), need to pivot this w/ DimensionTypes?	--	12/4/2015

SELECT

diex.ID,
diex.DisplayDimensions,

dt.DimensionTypeID,
dt.DimensionType,

dut.UnitType,

de.*,


CAST(ISNULL(ROUND(d.Dimension,1),0) AS DECIMAL (9,1)) AS Dimension_cm


FROM DimItemElemXrefs				AS diex
LEFT OUTER JOIN DimensionElements	AS de	ON	diex.ElementID = de.ElementID
LEFT OUTER JOIN DimElemTypeXrefs	AS detx	ON	de.ElementID = detx.ElementID
LEFT OUTER JOIN DimensionTypes		AS dt	ON	detx.DimensionTypeID = dt.DimensionTypeID
LEFT OUTER JOIN DimUnitTypes		AS dut	ON	dt.UnitTypeID = dut.UnitTypeID
LEFT OUTER JOIN DimensionUnits		AS du1	ON	detx.PrimaryUnitID = du1.UnitID
LEFT OUTER JOIN Dimensions			AS d	ON	diex.DimItemElemXrefID = d.DimItemElemXrefID
											AND	du1.UnitID = d.PrimaryUnitID
											AND dt.DimensionTypeID = d.DimensionTypeID
LEFT OUTER JOIN Objects				AS o	ON	diex.ID = o.ObjectID AND diex.TableID = 108

RIGHT OUTER JOIN DimensionTypes		AS dtx	ON	detx.DimensionTypeID = dtx.DimensionTypeID	

WHERE diex.TableID = 108
AND dut.UnitTypeID = 1	-- Linear			-- I think this covers the DimensionTypeID clause
AND diex.Displayed = 1	-- Displayed
--AND dtx.DimensionTypeID IN (5,7)

--AND dt.DimensionTypeID IN (5,7)				-- Height, Width
--AND dt.DimensionTypeID IN (1,2,3,4,5,6,7)	-- Length, Depth, Diameter, Duration, Height, Weight, Width

AND diex.ID IN (117874,106103,95002)




-----------------------------------------------  Copied from GS view DimensionsFlat  __________________________




SELECT 
X.DimItemElemXrefID, 
X.TableID, 
X.ID, 
X.ElementID, 
X.Rank, 



dH.Dimension AS Height,
DW.Dimension AS Width, 
DD.Dimension AS Depth, 
DWT.Dimension AS Weight, 
X.Description

FROM DimItemElemXrefs X 
LEFT OUTER JOIN	Dimensions2 DH	ON	X.DimItemElemXrefID = DH.DimItemElemXrefID AND	DH.System = 1
LEFT OUTER JOIN	Dimensions2 DW	ON	X.DimItemElemXrefID = DW.DimItemElemXrefID AND	DW.System = 2
LEFT OUTER JOIN	Dimensions2 DD	ON	X.DimItemElemXrefID = DD.DimItemElemXrefID AND	DD.System = 3
LEFT OUTER JOIN	Dimensions2 DWT	ON	X.DimItemElemXrefID = DWT.DimItemElemXrefID AND	DWT.System = 4

WHERE X.TableID = 108
AND X.Rank = 1
AND X.ID IN (117874,106103,95002)

GO

SELECT * FROM Dimensions2
WHERE DimItemElemXrefID IN (132666,194821,173752)


----------------------------------------------------------- Working Version I created from above *************

----------------------------------------------------------- Used to create MFAHv_OBJ_Dimensions_cm


SELECT
diex.DimItemElemXrefID,
diex.TableID,
diex.ID,
diex.ElementID,
de.Element,
diex.Rank,

CAST(ISNULL(ROUND(dH.EnteredDate,1),0) AS DECIMAL (9,1)) AS Height,
CAST(ISNULL(ROUND(dW.EnteredDate,1),0) AS DECIMAL (9,1)) AS Width,
CAST(ISNULL(ROUND(dDia.EnteredDate,1),0) AS DECIMAL (9,1)) AS Diameter,
CAST(ISNULL(ROUND(dD.EnteredDate,1),0) AS DECIMAL (9,1)) AS Depth,
CAST(ISNULL(ROUND(dCir.EnteredDate,1),0) AS DECIMAL (9,1)) AS Circumference,

STUFF(
CASE WHEN ISNULL(ROUND(dH.EnteredDate,1),0) = 0 THEN ' ' ELSE ISNULL('x ' + CAST(CAST(ISNULL(ROUND(dH.EnteredDate,1),0) AS DECIMAL (9,1)) AS NVARCHAR(10)),'') END +
CASE WHEN ISNULL(ROUND(dW.EnteredDate,1),0) = 0 THEN '' ELSE ISNULL('x' + CAST(CAST(ISNULL(ROUND(dW.EnteredDate,1),0) AS DECIMAL (9,1)) AS NVARCHAR(10)),'') END +
CASE WHEN ISNULL(ROUND(dDia.EnteredDate,1),0) = 0 THEN '' ELSE ISNULL('x' + CAST(CAST(ISNULL(ROUND(dDia.EnteredDate,1),0) AS DECIMAL (9,1)) AS NVARCHAR(10)),'') END +
CASE WHEN ISNULL(ROUND(dD.EnteredDate,1),0) = 0 THEN '' ELSE ISNULL('x' + CAST(CAST(ISNULL(ROUND(dD.EnteredDate,1),0) AS DECIMAL (9,1)) AS NVARCHAR(10)),'') END +
CASE WHEN ISNULL(ROUND(dCir.EnteredDate,1),0) = 0 THEN '' ELSE ISNULL('x' + CAST(CAST(ISNULL(ROUND(dCir.EnteredDate,1),0) AS DECIMAL (9,1)) AS NVARCHAR(10)),'') END,1,2,'') 
AS Dimensions_cm

FROM			DimItemElemXrefs	AS diex
LEFT OUTER JOIN	Dimensions2			AS dH		ON diex.DimItemElemXrefID = dH.DimItemElemXrefID	AND	dH.DimensionTypeID = 5
LEFT OUTER JOIN	Dimensions2			AS dW		ON diex.DimItemElemXrefID = dW.DimItemElemXrefID	AND	dW.DimensionTypeID = 7
LEFT OUTER JOIN	Dimensions2			AS dDia		ON diex.DimItemElemXrefID = dDia.DimItemElemXrefID	AND	dDia.DimensionTypeID = 3
LEFT OUTER JOIN	Dimensions2			AS dD		ON diex.DimItemElemXrefID = dD.DimItemElemXrefID	AND	dD.DimensionTypeID = 2
LEFT OUTER JOIN	Dimensions2			AS dCir		ON diex.DimItemElemXrefID = dCir.DimItemElemXrefID	AND	dCir.DimensionTypeID = 12
LEFT OUTER JOIN DimensionElements	AS de	ON	diex.ElementID = de.ElementID

WHERE	diex.TableID = 108
AND		diex.Rank = 1
AND		diex.ID IN (117874,106103,95002,110421,45831,60091,76946,17311,116879)

/*

SELECT * FROM DimensionTypes

SELECT * FROM DimItemElemXrefs AS diex
LEFT OUTER JOIN	Dimensions2			AS dCir		ON diex.DimItemElemXrefID = dCir.DimItemElemXrefID	AND	dCir.DimensionTypeID = 12
WHERE DimensionTypeID IN (13)

*/