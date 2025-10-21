




SELECT 
o.ObjectNumber,
o.ObjectStatusID,
at.* 

FROM Objects AS o
LEFT OUTER JOIN AuditTrail AS at ON o.ObjectID = at.ObjectID

--WHERE o.ObjectID = 123359

WHERE (at.TableName = 'ObjAccession'
OR (at.TableName = 'Objects' AND at.ColumnName = 'ObjectStatus'))

AND o.ObjectID = 123359

/*

This doesn't really work because new entries aren't captured in the audit trail.

Plus, it's just too difficult to try to trap so many potential data entry issues in this way.

I think the best approach might be to implement a review process.  Maybe when a table is hit, 
generate a report?  But that seems like a milliion reports.

*/