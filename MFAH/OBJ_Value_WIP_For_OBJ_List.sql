
/*

Working on adding different values and costs to OBJ_List

*/


SELECT
ObjectID,
ReportedValue
FROM MFAHvr_OBJ_Value_Acquisitions

HAVING COUNT(ObjectID) > 1
GROUP BY ObjectID


SELECT SalesOrderID, SUM(LineTotal) AS SubTotal
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING SUM(LineTotal) > 100000.00
ORDER BY SalesOrderID ;


SELECT ObjectID, SUM(ReportedValue) AS Value
FROM MFAHvr_OBJ_Value_Acquisitions
GROUP BY ObjectID
HAVING COUNT(ObjectID) > 1
ORDER BY ObjectID;


SELECT ObjectID, ReportedValue
FROM MFAHvr_OBJ_Value_Acquisitions
GROUP BY ObjectID, ReportedValue
HAVING COUNT(ObjectID) > 1
ORDER BY ObjectID;


SELECT * FROM MFAHvr_OBJ_Value_Acquisitions WHERE ObjectID = 1



SELECT * FROM MFAHv_OBJ_Value_AllRecords
WHERE ObjectID IN
(
	SELECT ObjectID
	FROM MFAHv_OBJ_Value_AllRecords
	GROUP BY ObjectID
	HAVING COUNT(ObjectID) > 1
)


SELECT * FROM ValuationPurposes
SELECT * FROM ObjInsurance WHERE ValuationPurposeID IN (16,17,19)

