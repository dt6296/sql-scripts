SELECT
o.ObjectNumber,
at.AuditTrailID,
at.ObjectID,
at.ColumnName,
REPLACE(REPLACE(REPLACE(at.OldValue,CHAR(10),''),CHAR(09),''),CHAR(13),'') AS OldValue,
REPLACE(REPLACE(REPLACE(at.NewValue,CHAR(10),''),CHAR(09),''),CHAR(13),'') AS NewValue,
at.LoginID,
at.EnteredDate
FROM AuditTrail AS at
INNER JOIN Objects AS o ON at.ObjectID = o.ObjectID
WHERE at.LoginID = 'cbellet'
AND at.ColumnName = 'Medium'
AND o.DepartmentID = 9
--AND o.ObjectNumber LIKE '96.38.%'
ORDER BY o.SortNumber, at.EnteredDate
