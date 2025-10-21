

/*
Dave – would you be able to help Selina move the curatorial report info from the virtual record (TR:594-605-2020) 
to the individual records (2020.300 through 2020.311) so we can delete the virtual?


SELECT ObjectID FROM Objects WHERE ObjectNumber = 'TR:594-605-2020'
147733

SELECT ObjectID, ObjectNumber FROM Objects WHERE ObjectNumber LIKE '2020.30%'
147721
147722
147723
147724
147725
147726
147727
147728
147729
147730

SELECT ObjectID, ObjectNumber FROM Objects WHERE ObjectNumber IN ('2020.310','2020.311')	-- 147721
147731
147732
*/

--SELECT * FROM Objects WHERE ObjectID IN (SELECT Item FROM dbo.MFAHfx_SplitMultiValue('147731,147732',','))


--SELECT Item FROM dbo.MFAHfx_SplitMultiValue_INT('147721,147722,147723,147724,147725,147726,147727,147728,147729,147730,147731,147732',',')


BEGIN
--DECLARE @Source	INT
--DECLARE @Target VARCHAR(500)

--SET @Source = 147733
--SET @Target = '147721,147722,147723,147724,147725,147726,147727,147728,147729,147730,147731,147732'

SELECT
o.ObjectID,
o.ObjectNumber,
o.RelatedWorks,
o.Inscribed,
o.Markings,
o.Provenance,
o.Exhibitions,
o.PubReferences,
o.Bibliography,
o.CatRais,

oc.LongText1		AS Importance,
oc.LongText2		AS Description,
oc.LongText3		AS Style,
oc.LongText4		AS IconographicTreatment,
oc.ShortText3		AS [Function],
oc.ShortText4		AS Condition,
oc.Flag3			AS Ancient,
oc.Flag4			AS Buried,
oc.LongText5		AS OutsideAdvice,
oc.ShortText5		AS Price,
oc.LongText6		AS Negotiations,
oc.Flag5			AS HasAddlExp,
oc.Flag6			AS HasNoAddlExp,
oc.ShortText6		AS AddlExpSummary,
oc.LongText8		AS AddlExpDetail,
oc.ShortText2		AS TotalExpenses,
oc.ShortText7		AS FabricationExpenses,
oc.ShortText9		AS FundingSourcesSummary,
oc.LongText7		AS FundingSourcesDetail,
oc.ShortText8		AS ExhibitionPlans,
oc.ShortText9		AS PublishingPlans,
oc.ShortText10		AS OtherComments,

oa.AcquisitionTerms,
oa.ValuationNotes,
oa.Source,
oa.AcqJustification


FROM Objects AS o
INNER JOIN ObjContext AS oc ON o.ObjectID = oc.ObjectID
INNER JOIN ObjAccession AS oa ON o.ObjectID = oa.ObjectID

WHERE o.ObjectID IN 
--(SELECT Item FROM dbo.MFAHfx_SplitMultiValue(@Target,','))
(SELECT ID FROM PackageList WHERE PackageID = 325497)
END
GO



BEGIN

DECLARE @Source	INT
DECLARE @Target VARCHAR(500)
SET @Source = 110421
SET @Target = '139947'

SELECT * FROM ObjContext AS t WHERE t.ObjectID IN (SELECT Item FROM dbo.MFAHfx_SplitMultiValue(@Target,','))
END
GO



BEGIN	-- ____________________________________________________BEGIN UPDATE SCRIPT ObjContext

DECLARE @Source	INT
DECLARE @Target VARCHAR(500)
--Salvin Photographs
--SET @Source = 147733
--SET @Target = '147721,147722,147723,147724,147725,147726,147727,147728,147729,147730,147731,147732'

--Lurie Gift
SET @Source = 147432
SET @Target = '146141,146145,146137,146138,146139,146140,146142,146143,146144,146146,146147,146148'

--Test Records
--SET @Source = 110421
--SET @Target = '139950,139947'

--UPDATE t
SET 
t.LongText1		= s.LongText1,
t.LongText2		= s.LongText2,
t.LongText3		= s.LongText3,
t.LongText4		= s.LongText4,
t.ShortText3	= s.ShortText3,
t.ShortText4	= s.ShortText4,
t.Flag3			= s.Flag3,
t.Flag4			= s.Flag4,
t.LongText5		= s.LongText5,
t.ShortText5	= s.ShortText5,
t.LongText6		= s.LongText6,
t.Flag5			= s.Flag5,
t.Flag6			= s.Flag6,
t.ShortText6	= s.ShortText6,
t.LongText8		= s.LongText8,
t.ShortText2	= s.ShortText2,
t.ShortText7	= s.ShortText7,
t.LongText7		= s.LongText7,
t.ShortText8	= s.ShortText8,
t.ShortText9	= s.ShortText9,
t.ShortText10	= s.ShortText10
--SELECT s.LongText1, t.LongText1, s.LongText2, t.LongText2
FROM ObjContext AS t
CROSS JOIN ObjContext AS s
WHERE s.ObjectID IN (@Source)
AND t.ObjectID IN (SELECT Item FROM dbo.MFAHfx_SplitMultiValue(@Target,','))
END
GO -- ________________________________________________________ END UPDATE SCRIPT ObjContext





BEGIN	-- ____________________________________________________BEGIN UPDATE SCRIPT ObjAccession

DECLARE @Source	INT
DECLARE @Target VARCHAR(500)
--Salvin Photographs
--SET @Source = 147733
--SET @Target = '147721,147722,147723,147724,147725,147726,147727,147728,147729,147730,147731,147732'

--Lurie Gift
SET @Source = 147432
SET @Target = '146141,146145,146137,146138,146139,146140,146142,146143,146144,146146,146147,146148'

--Test Records
--SET @Source = 110421
--SET @Target = '139950,139947'

--SELECT t.AcquisitionTerms,t.ValuationNotes,t.[Source],t.AcqJustification

--UPDATE t
SET 
t.AcquisitionTerms	= s.AcquisitionTerms,
t.ValuationNotes	= s.ValuationNotes,
t.[Source]			= s.[Source],
t.AcqJustification	= s.AcqJustification

FROM ObjAccession AS t
CROSS JOIN ObjAccession AS s
WHERE s.ObjectID IN (@Source)
AND t.ObjectID IN (SELECT Item FROM dbo.MFAHfx_SplitMultiValue(@Target,','))
END
GO -- ________________________________________________________ END UPDATE SCRIPT ObjAccession






BEGIN	-- ____________________________________________________BEGIN UPDATE SCRIPT Objects

DECLARE @Source	INT
DECLARE @Target VARCHAR(500)

--Salvin Photographs
--SET @Source = 147733
--SET @Target = '147721,147722,147723,147724,147725,147726,147727,147728,147729,147730,147731,147732'

--Lurie Gift
SET @Source = 147432
SET @Target = '146141,146145,146137,146138,146139,146140,146142,146143,146144,146146,146147,146148'

--Test Records
--SET @Source = 110421
--SET @Target = '139950,139947'

/*
SELECT 
s.Provenance,s.Markings,s.Inscribed,s.Exhibitions,s.CatRais,s.RelatedWorks,s.PubReferences,s.Bibliography,
t.Provenance,t.Markings,t.Inscribed,t.Exhibitions,t.CatRais,t.RelatedWorks,t.PubReferences,t.Bibliography
*/

--UPDATE t
SET 
t.Provenance		= s.Provenance,
--t.Marks				= s.Markings,
--t.Inscribed			= s.Inscribed,
t.Exhibitions		= s.Exhibitions,
--t.CatRais			= s.CatRais,
--t.RelatedWorks		= s.RelatedWorks,
t.PubReferences		= s.PubReferences,
t.Bibliography		= s.Bibliography


FROM Objects AS t
CROSS JOIN Objects AS s
WHERE s.ObjectID IN (@Source)
AND t.ObjectID IN (SELECT Item FROM dbo.MFAHfx_SplitMultiValue(@Target,','))
END
GO -- ________________________________________________________ END UPDATE SCRIPT Objects



/* Lurie Gift

The virtual is TR:150-161-2020 and they need to go into 2020.270, 2020.271, and 2020.314 through 2020.323.


SELECT ObjectID,ObjectNumber FROM Objects WHERE ObjectNumber = 'TR:150-161-2020'

SELECT ObjectID,ObjectNumber FROM Objects WHERE ObjectNumber BETWEEN '2020.270' AND '2020.271'
SELECT ObjectID,ObjectNumber FROM Objects WHERE ObjectNumber BETWEEN '2020.314' AND '2020.323'

*/


