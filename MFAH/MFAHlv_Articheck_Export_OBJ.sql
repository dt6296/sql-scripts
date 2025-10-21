










SELECT 
o.ObjectNumber															AS id,
o.ObjectID																AS [alt id],
''																		AS [alt id2],
''																		AS [alt id3],
''																		AS lender,
oc.CultureSchoolName_Suffix_Date										AS artist,
ot.Title																AS title,
o.Dated																	AS [date of creation],
o.Medium																AS media,
CAST(ISNULL(ROUND(dW.EnteredDate * .39370,3,1),0)	AS DECIMAL (9,2))	AS Width,
CAST(ISNULL(ROUND(dH.EnteredDate * .39370,3,1),0)	AS DECIMAL (9,2))	AS Height,
CAST(ISNULL(ROUND(dD.EnteredDate * .39370,3,1),0)	AS DECIMAL (9,2))	AS Depth,
'inches'											AS units

FROM MFAHv_OBJ AS o

INNER JOIN		MFAHv_OBJ_Maker_FirstDisplayed	AS om	ON o.ObjectID = om.ObjectID
INNER JOIN		MFAHv_OBJ_Constituent			AS oc	ON om.ConXrefID = oc.cx_ConXrefID
INNER JOIN		MFAHv_OBJ_Title_FirstDisplayed	AS ot	ON o.ObjectID = ot.ObjectID
LEFT OUTER JOIN	DimItemElemXrefs				AS diex	ON o.ObjectID = diex.ID								AND diex.TableID = 108
LEFT OUTER JOIN	Dimensions2						AS dH	ON diex.DimItemElemXrefID = dH.DimItemElemXrefID	AND	dH.DimensionTypeID = 5
LEFT OUTER JOIN	Dimensions2						AS dW	ON diex.DimItemElemXrefID = dW.DimItemElemXrefID	AND	dW.DimensionTypeID = 7
LEFT OUTER JOIN	Dimensions2						AS dDia	ON diex.DimItemElemXrefID = dDia.DimItemElemXrefID	AND	dDia.DimensionTypeID = 3
LEFT OUTER JOIN	Dimensions2						AS dD	ON diex.DimItemElemXrefID = dD.DimItemElemXrefID	AND	dD.DimensionTypeID = 2
LEFT OUTER JOIN	Dimensions2						AS dCir	ON diex.DimItemElemXrefID = dCir.DimItemElemXrefID	AND	dCir.DimensionTypeID = 12
LEFT OUTER JOIN DimensionElements				AS de	ON	diex.ElementID = de.ElementID

WHERE	diex.TableID = 108
AND		diex.Rank = 1


AND o.ObjectID = 110421




--CAST(ISNULL(ROUND(20.995 * .39370,2,1),0) AS DECIMAL (9,2)) AS Width