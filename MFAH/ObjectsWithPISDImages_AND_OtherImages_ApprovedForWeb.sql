







SELECT DISTINCT
om.ObjectID, om.ObjectNumber, o.Department, o.SortNumber
FROM MFAHv_OBJ_Media AS om
LEFT OUTER JOIN MFAHv_OBJ AS o ON om.ObjectID = o.ObjectID
WHERE om.DepartmentID = 240
AND om.ApprovedForWeb = 1

AND om.ObjectID IN
(
	SELECT DISTINCT
	om.ObjectID
	FROM MFAHv_OBJ_Media AS om
	WHERE om.DepartmentID <> 240
	AND om.ApprovedForWeb = 1 
)

ORDER BY o.Department, o.SortNumber








