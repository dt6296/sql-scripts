


--alter VIEW [dbo].[MFAHvr_OBJ_RecommendationForAcquisition] AS



/*

MFAHvr_OBJ_RecommendationForAcquisition
Custom MFAH View

Created			11/24/2014	Dave Thompson
							I CAST the NVARCHAR(MAX) fields to NTEXT because Crystal XI
							doesn't seem to support the NVARCHAR(MAX) field type.
							NTEXT is to be depricated in a later version of SQL Server,
							so we'll have to move to a newer version of Crystal eventually.
				
*/



SELECT
o.ObjectID,
CAST(o.Provenance AS NTEXT)			AS Provenance,
CAST(o.Exhibitions AS NTEXT)		AS Exhibitions,
CAST(o.PubReferences AS NTEXT)		AS PubReferences,
CAST(o.RelatedWorks AS NTEXT)		AS RelatedWorks,

oa.Initiator,
oa.InitDate,
CAST(oa.AcqJustification AS NTEXT)	AS AcqJustification,
CAST(oa.AcquisitionTerms AS NTEXT)	AS AcquisitionTerms,
CAST(oa.ValuationNotes AS NTEXT)	AS ValuationNotes,
CAST(oa.Source AS NTEXT)			AS Source,
CAST(oa.Remarks AS NTEXT)			AS Remarks,

CAST(oc.LongText1 AS NTEXT)			AS Importance,
CAST(oc.LongText2 AS NTEXT)			AS CompleteDescription,
CAST(oc.LongText3 AS NTEXT)			AS Style,
CAST(oc.LongText4 AS NTEXT)			AS IconographicTreatment,
CAST(oc.LongText5 AS NTEXT)			AS OutsideAdvice,
CAST(oc.LongText6 AS NTEXT)			AS TimeNegotiation,
CAST(oc.LongText7 AS NTEXT)			AS FabricationForDisplay,
CAST(oc.LongText8 AS NTEXT)			AS FundingSources,
CAST(oc.LongText9 AS NTEXT)			AS ExhibitionPlans,
CAST(oc.LongText10 AS NTEXT)		AS PublishingPlans,
CAST(oc.ShortText3 AS NTEXT)		AS FunctionPartWhole,
CAST(oc.ShortText4 AS NTEXT)		AS Condition,
CAST(oc.ShortText5 AS NTEXT)		AS OtherComments,
oc.Flag3							AS Ancient,
oc.Flag4							AS Buried

FROM Objects AS o
INNER JOIN ObjContext AS oc ON o.ObjectID = oc.ObjectID
INNER JOIN ObjAccession AS oa ON o.ObjectID = oa.ObjectID

--WHERE o.ObjectID IN (117048,116893)


GO