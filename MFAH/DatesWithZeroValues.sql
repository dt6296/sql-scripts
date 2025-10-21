



SELECT * FROM MFAHv_OCM_Object
WHERE DepartmentID = 9
AND DateBegin <= 1550
AND ObjectStatusID = 2


SELECT
ObjectID,
ObjectNumber,
Department,
ObjectStatus,
DateBegin,
DateEnd,
Dated

FROM MFAHv_OCM_Object
WHERE DepartmentID = 9
AND DateBegin <= 1550
AND ObjectStatusID = 2

ORDER BY DateBegin, Dated