



SELECT
COUNT(ObjectNumber)	AS RecordCount,
SUM(ReportedValue)	AS ReportedValue
FROM MFAHvr_OBJ_Value_Acquisitions
WHERE ObjectStatusID = 2
AND AccessionMethodID = 2
AND ObjectTypeID NOT IN (6,8)
AND ObjectLevelID <> 13
AND ReportStatus = 1



SELECT
COUNT(ObjectNumber)	AS RecordCount,
SUM(ReportedValue)	AS ReportedValue
FROM MFAHvr_OBJ_Value_Acquisitions_2
WHERE ObjectStatusID = 2
AND AccessionMethodID = 2
AND ObjectTypeID NOT IN (6,8)
AND ObjectLevelID <> 13
AND ReportStatus = 1


SELECT
COUNT(ObjectNumber)	AS RecordCount,
SUM(ReportedValue)	AS ReportedValue
FROM MFAHv_OBJ_Value
WHERE ObjectStatusID = 2
AND AccessionMethodID = 2
AND ObjectTypeID NOT IN (6,8)
AND ObjectLevelID <> 13


SELECT
COUNT(DisplayAccessionNumber)	AS RecordCount,
SUM(InsuranceValue)	AS ReportedValue
FROM MFAHvr_OBJ_Value_Gifts


-- OKAY
SELECT
ObjectID,
ObjectNumber,
COUNT(ObjectNumber)	AS RecordCount,
SUM(ReportedValue)	AS ReportedValue
FROM MFAHvr_OBJ_Value_Acquisitions_2
WHERE ObjectStatusID = 2
AND AccessionMethodID = 2
AND ObjectTypeID NOT IN (6,8)
AND ObjectLevelID <> 13
AND ReportStatus = 1
GROUP BY ObjectID, ObjectNumber, SortNumber
--HAVING COUNT(*) > 1	-- NONE



-- OKAY
SELECT
ObjectID,
ObjectNumber,
COUNT(ObjectNumber)	AS RecordCount,
SUM(ReportedValue)	AS ReportedValue
FROM MFAHvr_OBJ_Value_Acquisitions_2
WHERE ObjectStatusID = 2
AND AccessionMethodID = 2
AND ObjectTypeID NOT IN (6,8)
AND ObjectLevelID <> 13
AND ReportStatus = 1
GROUP BY ObjectID, ObjectNumber, SortNumber
--HAVING COUNT(*) > 1	-- NONE








-- FINAL LIST


SELECT
COUNT(o.ObjectID) AS ObjectCount,
SUM(o.ReportedValue) AS ObjectValue,
o.Donor
FROM
(
	-- ADD DONORS
	SELECT
	ov.ObjectID,
	ov.ObjectNumber,
	COUNT(ov.ObjectNumber)					AS RecordCount,
	SUM(ov.ReportedValue)					AS ReportedValue,
	dbo.MFAHfx_ConcatDonors(ov.ObjectID)	AS Donor

	FROM MFAHvr_OBJ_Value_Acquisitions_2 AS ov
	LEFT OUTER JOIN MFAHv_OBJ_Constituent AS oc ON ov.ObjectID = oc.o_ObjectID AND cx_RoleID = 2

	WHERE ov.ObjectStatusID = 2
	AND ov.AccessionMethodID = 2
	AND ov.ObjectTypeID NOT IN (6,8)
	AND ov.ObjectLevelID <> 13
	AND ov.ReportStatus = 1

	GROUP BY ov.ObjectID, ov.ObjectNumber, ov.SortNumber

	--HAVING COUNT(*) > 1	-- NONE

	--ORDER BY ov.SortNumber
) AS o

GROUP BY o.Donor

HAVING SUM(o.ReportedValue) >= 1000000

ORDER BY o.Donor

