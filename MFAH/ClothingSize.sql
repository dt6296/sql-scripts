



SELECT 
ObjectID,
ObjectNumber,
Department,
ObjectStatus,
Title,
Dimensions 
FROM MFAHv_OBJ
WHERE DepartmentID IN (43,158)
AND Dimensions IS NOT NULL