















SELECT * FROM AuditTrail 
WHERE TableName = 'Objects'
AND ColumnName = 'Medium'
AND LoginID = 'cbellet'
AND ObjectID IN (4308)




SELECT MIN(EnteredDate) AS EnteredDate
FROM AuditTrail
WHERE TableName = 'Objects'
AND ColumnName = 'Medium'
AND LoginID = 'cbellet'
AND ObjectID IN (4308)
GROUP BY
TableName,
ColumnName,
LoginID,
ObjectID




SELECT * FROM AuditTrail WHERE AuditTrailID IN
(
	SELECT MIN(AuditTrailID) AS AuditTrailID
	FROM AuditTrail
	WHERE TableName = 'Objects'
	AND ColumnName = 'Medium'
	AND LoginID = 'cbellet'
	GROUP BY
	TableName,
	ColumnName,
	LoginID,
	ObjectID
)
ORDER BY ObjectID







SELECT o.ObjectID, o.Medium, f.OldValue
FROM Objects AS o

INNER JOIN
(
SELECT ObjectID, OldValue
FROM PnDMediumFix
WHERE AuditTrailID IN
(
	SELECT MIN(AuditTrailID) AS AuditTrailID
	FROM PnDMediumFix
	WHERE [Update] = 1
	GROUP BY
	ObjectID
)
)AS f ON o.ObjectID = f.ObjectID




----------------------------------------------------QUERY RAN 10/31/16 11:20 AM


--UPDATE Objects
SET Medium = OldValue

--SELECT o.ObjectID, o.Medium, f.OldValue
FROM Objects AS o

INNER JOIN
(
SELECT ObjectID, OldValue
FROM PnDMediumFix
WHERE AuditTrailID IN
(
	SELECT MIN(AuditTrailID) AS AuditTrailID
	FROM PnDMediumFix
	WHERE [Update] = 1
	GROUP BY
	ObjectID
)
)AS f ON o.ObjectID = f.ObjectID



