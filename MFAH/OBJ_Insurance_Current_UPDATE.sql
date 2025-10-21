-----------	Start here to find the records to update.



SELECT DISTINCT oi.ObjectID, o.ObjectNumber, o.SortNumber
FROM ObjInsurance	AS oi	
INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID

INNER JOIN
(
	SELECT DISTINCT ObjectID
	FROM ObjInsurance			--	76817 Objects have an Insurance Value
	WHERE ValuationPurposeID = 7
)	AS sq ON o.ObjectID = sq.ObjectID

WHERE oi.ValuationPurposeID <> 7
AND oi.IsCurrent = 1						--	 4472 Objects have Current Value that is NOT Insurance AND have Insurance
ORDER BY o.SortNumber, oi.ObjectID, o.ObjectNumber



SELECT COUNT(*) FROM ObjInsurance AS oi WHERE oi.ValuationPurposeID = 7		-- 106118
SELECT COUNT(*) FROM ObjInsurance AS oi WHERE oi.ValuationPurposeID <> 7	--  26542
SELECT COUNT(*) FROM ObjInsurance AS oi WHERE oi.IsCurrent = 1				--  71580
SELECT COUNT(*) FROM ObjInsurance AS oi WHERE oi.IsCurrent <> 1				--  61080

SELECT COUNT(*) FROM ObjInsurance AS oi										-- 132660

SELECT COUNT(*) FROM ObjInsurance AS oi WHERE oi.ValuationPurposeID = 7 AND oi.IsCurrent = 1	-- 65715
SELECT COUNT(*) FROM ObjInsurance AS oi WHERE oi.ValuationPurposeID = 7 AND oi.IsCurrent <> 1	-- 40403
SELECT COUNT(*) FROM ObjInsurance AS oi WHERE oi.ValuationPurposeID <> 7 AND oi.IsCurrent = 1	--  5865
SELECT COUNT(*) FROM ObjInsurance AS oi WHERE oi.ValuationPurposeID <> 7 AND oi.IsCurrent <> 1	-- 20677





 
------------ !!!  These are the NON-INSURANCE values to UNCHECK as current	!!!

SELECT oi.ObjInsuranceID, oi.ObjectID, o.ObjectNumber, oi.IsCurrent, oi.ValuationPurposeID, oi.ValueISODate, oi.CurrencyValue, oi.EnteredDate, oi.LoginID, oi.ValueNotes
FROM ObjInsurance	AS oi	--	132660 ObjInsurance Records
INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID

INNER JOIN
(
	SELECT DISTINCT ObjectID
	FROM MFAHv_OBJ_Value_AllRecords			--	79249 Objects have an Obj Value
	WHERE ValuationPurposeID = 7			--  76817 Objects have an INSURANCE value
)	AS sq ON o.ObjectID = sq.ObjectID		-- 129943 OI records belonging to Objects with Insurance Value (some Insurance, some not)

WHERE oi.ValuationPurposeID <> 7			--  23825
AND oi.IsCurrent = 1						--	 4472 Objects have Current Value that is NOT Insurance AND have Insurance Value
ORDER BY o.SortNumber, oi.ObjectID, o.ObjectNumber





------------ !!!  These are the INSURANCE values to CHECK as current	!!!		--	4387

SELECT sq.ObjInsuranceID, sq.ObjectID, o.ObjectNumber, sq.IsCurrent, sq.ValuationPurposeID, sq.ValueISODate, sq.CurrencyValue, sq.EnteredDate, sq.LoginID, sq.ValueNotes, sq.RankByDate
FROM
(
	SELECT 
	ObjectID,
	ObjInsuranceID,
	IsCurrent,
	ValuationPurposeID,
	CurrencyValue,
	ValueISODate,
	EnteredDate,
	LoginID,
	ValueNotes,
	RANK() OVER(PARTITION BY ObjectID ORDER BY ValueISODate DESC,EnteredDate DESC,ObjInsuranceID DESC) AS RankByDate
	FROM ObjInsurance
	WHERE ValuationPurposeID = 7		--106118
	--AND ValueISODate IS NOT NULL	-- Because values without dates were being selected, original data suggests dated value is "current."	88067 --106118
)	AS sq
INNER JOIN Objects AS o ON sq.ObjectID = o.ObjectID
WHERE sq.RankByDate = 1					-- 76817
AND sq.ObjectID IN
(
	SELECT DISTINCT oi.ObjectID--, o.ObjectNumber, o.SortNumber
	FROM ObjInsurance	AS oi	--	79249 Objects have an Insurance Value
	INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID

	INNER JOIN
	(
		SELECT DISTINCT ObjectID
		FROM ObjInsurance			--	79249 Objects have an Insurance Value
		WHERE ValuationPurposeID = 7
	)	AS sq ON o.ObjectID = sq.ObjectID

	WHERE oi.ValuationPurposeID <> 7
	AND oi.IsCurrent = 1						--	 4472 Objects have Current Value that is NOT Insurance AND have Insurance
	AND oi.ValueISODate IS NOT NULL				--	 4471
	--ORDER BY o.SortNumber, ov.ObjectID, o.ObjectNumber
)
--AND sq.ObjectID IN (4890,12827,14514,26593,26815,33007,43380)
ORDER BY o.SortNumber													-- 4386



-- Objects with insurance values only, but none checked current


SELECT DISTINCT oi.ObjectID,o.ObjectNumber,COUNT(*) AS RecordCount
FROM ObjInsurance AS oi
INNER JOIN Objects AS o ON oi.ObjectID = o.ObjectID
GROUP BY oi.ObjectID,o.ObjectNumber
HAVING AVG(oi.ValuationPurposeID) = 7	-- Insurance Value
AND SUM(CAST(oi.IsCurrent AS INT)) = 0	-- None checked current		6326



------------ !!!  These are the INSURANCE values to CHECK as current	!!!

SELECT sq.ObjInsuranceID, sq.ObjectID, o.ObjectNumber, sq.IsCurrent, sq.ValuationPurposeID, sq.ValueISODate, sq.CurrencyValue, sq.EnteredDate, sq.LoginID, sq.ValueNotes, sq.RankByDate
FROM
(
	SELECT 
	ObjectID,
	ObjInsuranceID,
	IsCurrent,
	ValuationPurposeID,
	CurrencyValue,
	ValueISODate,
	EnteredDate,
	LoginID,
	ValueNotes,
	RANK() OVER(PARTITION BY ObjectID ORDER BY ValueISODate DESC,EnteredDate DESC,ObjInsuranceID DESC) AS RankByDate
	FROM ObjInsurance
	WHERE ValuationPurposeID = 7	--106118
	--AND ValueISODate IS NOT NULL	-- Because values without dates were being selected, original data suggests dated value is "current." commented out b/c most don't have dates.
)	AS sq
INNER JOIN Objects AS o ON sq.ObjectID = o.ObjectID
WHERE sq.RankByDate = 1				--76817
AND sq.ObjectID IN
(
	SELECT DISTINCT oi.ObjectID--,o.ObjectNumber,COUNT(*) AS RecordCount
	FROM ObjInsurance AS oi
	INNER JOIN Objects AS o ON oi.ObjectID = o.ObjectID
	GROUP BY oi.ObjectID,o.ObjectNumber
	HAVING AVG(oi.ValuationPurposeID) = 7	-- Insurance Value
	AND SUM(CAST(oi.IsCurrent AS INT)) = 0	-- None checked current					6326
)
--AND sq.ObjectID IN (4890,12827,14514,26593,26815,33007,43380)
ORDER BY o.SortNumber


--------------	Stop here.




--------------	Update Queries !!!!!!!!!!!!!!!!!!!!!!!!!!!

------------ !!!  These are the NON-INSURANCE values to UNCHECK as current	!!!

--UPDATE ObjInsurance SET IsCurrent = 0
WHERE ObjInsuranceID IN

(
	SELECT DISTINCT oi.ObjInsuranceID
	FROM ObjInsurance	AS oi	--	5867 Objects have Current Value that is NOT Insurance Value
	INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID

	INNER JOIN
	(
		SELECT DISTINCT ObjectID
		FROM MFAHv_OBJ_Value_AllRecords			--	76672 Objects have an Insurance Value
		WHERE ValuationPurposeID = 7
	)	AS sq ON o.ObjectID = sq.ObjectID

	WHERE oi.ValuationPurposeID <> 7
	AND oi.IsCurrent = 1						--	 4471 Objects have Current Value that is NOT Insurance AND have Insurance Value
)




------------ !!!  These are the INSURANCE values to CHECK as current	!!!


--UPDATE ObjInsurance SET IsCurrent = 0
WHERE ObjInsuranceID IN
(
	SELECT sq.ObjInsuranceID
	FROM
	(
		SELECT 
		ObjectID,
		ObjInsuranceID,
		IsCurrent,
		ValuationPurposeID,
		CurrencyValue,
		ValueISODate,
		EnteredDate,
		LoginID,
		ValueNotes,
		RANK() OVER(PARTITION BY ObjectID ORDER BY ValueISODate DESC,EnteredDate DESC,ObjInsuranceID DESC) AS RankByDate
		FROM ObjInsurance
		WHERE ValuationPurposeID = 7
	)	AS sq
	INNER JOIN Objects AS o ON sq.ObjectID = o.ObjectID
	WHERE sq.RankByDate = 1
	AND sq.ObjectID IN
	(
		SELECT DISTINCT oi.ObjectID
		FROM ObjInsurance	AS oi	--	5867 Objects have Current Value that is NOT Insurance Value
		INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID

		INNER JOIN
		(
			SELECT DISTINCT ObjectID
			FROM ObjInsurance			--	76672 Objects have an Insurance Value
			WHERE ValuationPurposeID = 7
		)	AS sq ON o.ObjectID = sq.ObjectID

		WHERE oi.ValuationPurposeID <> 7
		AND oi.IsCurrent = 1						--	 4471 Objects have Current Value that is NOT Insurance AND have Insurance
	)
)








------------ IGNORE BELOW




-- I'm not sure this is right or that I should start from here.

SELECT
ov.ObjInsuranceID,
ov.ObjectID,
ov.CurrencyValue,
ov.ValueISODate,
ov.ValuationPurposeID,
ov.ValuationPurpose,
ov.Value,
ov.IsCurrent
FROM MFAHv_OBJ_Value_AllRecords AS ov
WHERE ov.ObjectID IN
(
	SELECT ObjectID
	FROM MFAHv_OBJ_Value_AllRecords
	WHERE IsCurrent = 1					--	Records that have a Current valuation
	AND ValuationPurposeID <> 7			--	that is NOT an Insurance Value
)										--	5868 object records
ORDER BY ov.ObjectID,ov.IsCurrent




SELECT * FROM ValuationPurposes

/*
	ValuationPurposeID	ValuationPurpose
	0					(not assigned)
	4					Purchase Price
	7					Insurance Value
	12					3rd Party Appraisal for Indemnity
	13					Value for Indemnity
	14					One Great Night Funded Price
	15					Cost: Shipping/Crating/Import Fees
	17					Cost: Additional Insurance Premium
	19					Cost: Storage Housing
	20					Additional Costs
*/








SELECT DISTINCT ObjectID,*
FROM MFAHv_OBJ_Value_AllRecords			--	76672 Objects have an Insurance Value
WHERE ValuationPurposeID = 7



SELECT DISTINCT ObjectID
FROM MFAHv_OBJ_Value_AllRecords			--	79089 Objects have a Value




SELECT DISTINCT ObjectID
FROM MFAHv_OBJ_Value_AllRecords
GROUP BY ObjectID
HAVING SUM(CAST(IsCurrent AS INT)) = 1	--	71418 Objects HAVE a CURRENT valuation

SELECT DISTINCT ObjectID
FROM MFAHv_OBJ_Value_AllRecords
GROUP BY ObjectID
HAVING SUM(CAST(IsCurrent AS INT)) = 0	--	 7671 Objects DO NOT HAVE a CURRENT valuation
										--	-----
										--	79089 Objects

SELECT DISTINCT ObjectID
FROM MFAHv_OBJ_Value_AllRecords
WHERE ObjectID NOT IN
(
	SELECT DISTINCT ObjectID
	FROM MFAHv_OBJ_Value_AllRecords
	WHERE ValuationPurposeID = 7		--	76654 Objects HAVE Insurance Value
)										--	 2435 Objects DO NOT HAVE Insurance Value
										--	-----
										--	79089 Objects

SELECT DISTINCT ObjectID
FROM MFAHv_OBJ_Value_AllRecords
WHERE ValuationPurposeID = 7			--	76654 Objects HAVE Insurance Value
GROUP BY ObjectID
HAVING COUNT(ObjectID) = 1				--	56143 Objects have SINGLE Insurance Values

SELECT DISTINCT oi.ObjectID, o.ObjectNumber
FROM ObjInsurance AS oi
INNER JOIN Objects AS o ON oi.ObjectID = o.ObjectID
WHERE oi.ValuationPurposeID = 7			--	76644 Objects HAVE Insurance Value
GROUP BY oi.ObjectID, o.ObjectNumber
HAVING COUNT(oi.ObjectID) > 1				--	20511 Objects have MULTIPLE Insurance Values


										--	 2435 Objects DO NOT HAVE Insurance Value, but may or may not have current OTHER value
										--	56143 Objects have SINGLE Insurance Values
										--	20511 Objects have MULTIPLE Insurance Values
										--	----- 
										--	79089 Objects





SELECT
ov.ObjInsuranceID,
ov.ObjectID,
ov.CurrencyValue,
ov.ValueISODate,
ov.ValuationPurposeID,
ov.ValuationPurpose,
ov.Value,
ov.IsCurrent
FROM MFAHv_OBJ_Value_AllRecords AS ov
WHERE ov.ObjectID IN
(
	SELECT DISTINCT ObjectID
	FROM MFAHv_OBJ_Value_AllRecords
	GROUP BY ObjectID
	HAVING SUM(CAST(IsCurrent AS INT)) = 0	--	 7671 Objects DO NOT HAVE a CURRENT valuation  
)
AND ov.ValuationPurposeID = 7				--	 7506 Objects have Insurance Value
ORDER BY ov.ObjectID,ov.IsCurrent



-------------------------------------------------------------------

--No insurance value
SELECT DISTINCT ObjectID
FROM MFAHv_OBJ_Value_AllRecords
WHERE ObjectID NOT IN
(
	SELECT DISTINCT ObjectID
	FROM MFAHv_OBJ_Value_AllRecords
	WHERE ValuationPurposeID = 7		--	76658 Objects HAVE Insurance Value
)										--	 2435 Objects DO NOT HAVE Insurance Value


-- Can't update these b/c there are no Insurance values to set as Current.



-- Single insurance value

SELECT DISTINCT ObjectID, SUM(CAST(IsCurrent AS INT)) AS SUM_IsCurrent
FROM MFAHv_OBJ_Value_AllRecords
WHERE ValuationPurposeID = 7			--	76658 Objects HAVE Insurance Value
GROUP BY ObjectID
HAVING COUNT(ObjectID) = 1				--	56148 Objects have SINGLE Insurance Values
AND SUM(CAST(IsCurrent AS INT)) = 1		--	46441 Objects HAVE Current record
AND SUM(CAST(IsCurrent AS INT)) = 0		--	 9707 Objects DO NOT HAVE Current Record



-- Multiple insurance values

SELECT DISTINCT ObjectID, SUM(CAST(IsCurrent AS INT)) AS SUM_IsCurrent
FROM MFAHv_OBJ_Value_AllRecords
WHERE ValuationPurposeID = 7			--	76658 Objects HAVE Insurance Value
GROUP BY ObjectID
HAVING COUNT(ObjectID) > 1				--	20511 Objects have MULTIPLE Insurance Values
AND SUM(CAST(IsCurrent AS INT)) = 1		--	19111 Objects HAVE Current record
AND SUM(CAST(IsCurrent AS INT)) = 0		--	 1399 Objects DO NOT HAVE Current Record



















SELECT
ObjectID, ObjInsuranceID, IsCurrent, ValuationPurposeID, ValuationPurpose
FROM MFAHv_OBJ_Value_AllRecords
ORDER BY ObjectID, ObjInsuranceID




SELECT ov.ObjectID, ov.ObjInsuranceID, ov.IsCurrent, ov.ValuationPurposeID, ov.ValuationPurpose, o.ObjectNumber
FROM MFAHv_OBJ_Value_AllRecords AS ov
INNER JOIN Objects AS o ON ov.ObjectID = o.ObjectID 
WHERE EXISTS
(
	SELECT			--	79093 objects
	ObjectID,
	SUM(CASE WHEN ValuationPurposeID = 7 THEN 1 ELSE 0 END) AS CountInsValue,
	SUM(CASE WHEN IsCurrent = 1 THEN ObjInsuranceID ELSE 0 END) AS IsCurrentRecord,
	SUM(CASE WHEN IsCurrent = 1 THEN ValuationPurposeID ELSE 0 END) AS ValPurpose
	FROM MFAHv_OBJ_Value_AllRecords
	GROUP BY ObjectID
)
AND ValuationPurposeID <> 7 AND IsCurrent = 1

ORDER BY ObjectID




	SELECT			--	79093 objects
	ObjectID,
	SUM(CASE WHEN ValuationPurposeID = 7 THEN 1 ELSE 0 END) AS CountInsValue,
	SUM(CASE WHEN IsCurrent = 1 THEN ObjInsuranceID ELSE 0 END) AS CurrentRecordID,
	SUM(CASE WHEN IsCurrent = 1 THEN ValuationPurposeID ELSE 0 END) AS CurrentRecordValPurpose
	FROM ObjInsurance
	GROUP BY ObjectID



SELECT * FROM ObjInsurance AS oi
INNER JOIN 
(	
	SELECT			--	79093 objects
	ObjectID,
	SUM(CASE WHEN ValuationPurposeID = 7 THEN 1 ELSE 0 END) AS CountInsValue,
	SUM(CASE WHEN IsCurrent = 1 THEN ObjInsuranceID ELSE 0 END) AS CurrentRecordID,
	SUM(CASE WHEN IsCurrent = 1 THEN ValuationPurposeID ELSE 0 END) AS CurrentRecordValPurpose
	FROM ObjInsurance
	GROUP BY ObjectID
)	AS sq ON oi.ObjInsuranceID = sq.CurrentRecordID

WHERE sq.CurrentRecordValPurpose = 7




SELECT
oi.* 
FROM ObjInsurance AS oi 
WHERE oi.ObjectID IN (SELECT DISTINCT ObjectID FROM ObjInsurance WHERE ValuationPurposeID = 7)
AND oi.ValuationPurposeID = 7
AND oi.ObjectID = 110421





SELECT * FROM ObjInsurance WHERE ValueISODate IS NOT NULL












