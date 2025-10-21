



/*

SELECT * FROM MFAHv_OBJ_Value
WHERE ObjectNumber LIKE '2014.24.%'
ORDER BY SortNumber

SELECT * FROM MFAHv_OBJ_Related
WHERE ObjectNumber LIKE '2014.24.%'
ORDER BY SortNumber

--What if I changed the RelPosition calculation to make crates and accessories a 3 or something?

*/


SELECT

	obr.ObjectID,
	obr.RelPosition,
	obr.RelationFocus,
	obr.RelationTarget,
	obr.RelatedObjectID,

	o.ObjectID,
	o.IsVirtual,
	o.IsVirtualDisplay,
	o.ObjectCount,
	o.SortNumber,
	o.ObjectNumber,
	o.DisplayAccessionNumber,
	o.ObjectLevelID,
	o.ObjectLevel,
	o.ObjectTypeID,
	o.ObjectType,
	o.ObjectStatusID,
	o.ObjectStatus,
	o.ObjectStatusDisplay,

	o.DepartmentID,
	o.Department,
	o.Title,
	o.Dated,
	o.TitleDateDisplay,
	o.Culture,
	o.CreditLine,
	
	o.ThumbBlob,

--Acquisition Information

	o.ApprovalISODate1,
	o.AccessionMethodID,
	o.AccessionMethod,
	o.AccessionISODate,
	o.AccessionMethodDisplay,

	o.Acquired_FY,
	o.Acquired_FQ,
	o.Acquired_FM,
	
--Valuation Information

	ov.PurchaseValueationPurposeID,
	ov.PurchaseValuationPurpose,
	ov.PurchaseValueISODate,
	ov.PurchaseValue,
	ov.PurchaseCurrency,
	ov.PurchaseNotes,

	ov.InsuranceValueationPurposeID,
	ov.InsuranceValuationPurpose,
	ov.InsuranceValueISODate,
	ov.InsuranceValue,
	ov.InsuranceCurrency,
	ov.InsuranceNotes,
	
	ov.ReportedValue,
	ov.ReportedValueNotes	
	

	
FROM MFAHv_OBJ AS o
LEFT OUTER JOIN MFAHv_OBJ_Value		AS ov	ON o.ObjectID = ov.ObjectID
LEFT OUTER JOIN MFAHv_OBJ_Related	AS obr	ON o.ObjectID = obr.ObjectID

LEFT OUTER JOIN
(SELECT ObjectID, AVG(ObjectLevelID) AS AVG_ObjectLevelID FROM MFAHv_OBJ_Related GROUP BY ObjectID) AS aol ON ov.ObjectID = aol.ObjectID


WHERE	o.ObjectStatusID IN (2,27,5,0,3,30)	-- 2 = Accessioned Objects, 
											--27 = Blaffer Accessions (so we can run the report for both) 4/10/2014
											-- 5 = Commodity
											-- 0 = (Unknown) because some aren't categorized
											-- 3 = Deaccessioned
											--30 = FOR TESTING ONLY 

AND		o.ObjectLevelID NOT IN (13)			--	Components (8/18/2014)
AND		o.ObjectTypeID NOT IN (6,8)			--	Accessories and Crates (8/14/2014)

AND		ISNULL(obr.RelPosition,0) < 2		--To pull the "parent" objects in sets, series, portfolios, etc.

--AND		obr.ObjectTypeID NOT IN (8)			--	OBJ_Related records where Related Object is a Crate, but excludes ANYTHING with a crate.

AND		(ISNULL(aol.AVG_ObjectLevelID,0) = ISNULL(obr.ObjectLevelID,0))	---8/14/2014 12:05


