









SELECT
ln.LoanID,
ln.LoanNumber,
ln.LoanStatusID,
lns.LoanStatus,
lo.LoanID,
lo.LoanNumber,
lo.LoanStatusID,
los.LoanStatus

FROM TMS.dbo.Loans AS ln
LEFT OUTER JOIN TMS.dbo.LoanStatuses AS lns ON ln.LoanStatusID = lns.LoanStatusID
INNER JOIN TMS_181130.dbo.Loans AS lo ON lo.LoanID = ln.LoanID
LEFT OUTER JOIN TMS_181130.dbo.LoanStatuses AS los ON lo.LoanStatusID = los.LoanStatusID

WHERE ln.LoanStatusID <> lo.LoanStatusID
AND ln.LoanStatusID = 0








Select AuditTrailID, ObjectID as RecordID, TableName, ColumnName, OldValue, NewValue, Explanation, LoginID, EnteredDate

From AuditTrail

Where ModuleID = 5

And TableName <> 'ConXrefs'

And EnteredDate > '2019-01-01'

ORDER BY EnteredDate DESC

Order By ObjectID asc, AuditTrailID desc



SELECT
at.AuditTrailID,
at.ObjectID AS RecordID,
l.LoanNumber,
at.TableName,
at.ColumnName,
at.OldValue,
lso.LoanStatus AS LoanStatus_Old,
at.NewValue,
lsn.LoanStatus AS LoanStatus_New,
at.Explanation,
at.LoginID,
at.EnteredDate

FROM AuditTrail AS at
LEFT OUTER JOIN Loans AS l ON at.ObjectID = l.LoanID
LEFT OUTER JOIN LoanStatuses AS lso ON at.OldValue = lso.LoanStatusID
LEFT OUTEr JOIN LoanStatuses AS lsn ON at.NewValue = lsn.LoanStatusID

WHERE at.ModuleID = 5
AND at.TableName <> 'ConXrefs'
AND at.EnteredDate >= '2019-08-01'
AND at.ColumnName = 'LoanStatus'
AND at.NewValue = 0

ORDER BY at.EnteredDate DESC



SELECT
at.AuditTrailID,
at.ObjectID AS RecordID,
l.LoanNumber,
at.TableName,
at.ColumnName,
at.OldValue,
lso.LoanStatus AS LoanStatus_Old,
at.NewValue,
lsn.LoanStatus AS LoanStatus_New,
at.Explanation,
at.LoginID,
at.EnteredDate

FROM AuditTrail AS at
LEFT OUTER JOIN Loans AS l ON at.ObjectID = l.LoanID
LEFT OUTER JOIN LoanStatuses AS lso ON at.OldValue = lso.LoanStatusID
LEFT OUTEr JOIN LoanStatuses AS lsn ON at.NewValue = lsn.LoanStatusID

WHERE at.ModuleID = 5
AND at.TableName <> 'ConXrefs'
--AND at.EnteredDate >= '2019-08-01'
AND at.ColumnName = 'LoanStatus'
--AND at.NewValue = 0
AND (l.LoanNumber LIKE 'OL.14%' OR l.LoanNumber = 'OL.1293')

ORDER BY at.EnteredDate DESC

--------------------------------------------------------------------------------------------------- 10/2/2019


Select adt.AuditTrailID, adt.ObjectID as RecordID, adt.TableName, adt.ColumnName, adt.OldValue, adt.NewValue, adt.Explanation, adt.LoginID, adt.EnteredDate,
l.LoanNumber

From AuditTrail AS adt
LEFT OUTER JOIN Loans AS l ON adt.ObjectID = l.LoanID

Where adt.ModuleID = 5
And adt.TableName <> 'ConXrefs'
And adt.EnteredDate > '2019-01-01'
AND adt.ColumnName = 'LoanStatus'
AND adt.NewValue = 0
AND l.LoanNumber = 'OL.1367'

Order By adt.ObjectID asc, adt.AuditTrailID desc


SELECT * FROM LoanStatuses


SELECT * FROM AuditTrail WHERE LoginID = 'TKoseki' ORDER BY EnteredDate DESC

---------------------------------------------------------------------------------------------------

SELECT
adt.AuditTrailID,
adt.TableName,
adt.ObjectID AS LoanID,
l.LoanNumber,
adt.ColumnName,
adt.OldValue,
lo.LoanStatus AS LoanStatus_OLD,
adt.NewValue,
ln.LoanStatus AS LoanStatus_NEW,
adt.Explanation,
adt.LoginID,
adt.EnteredDate

FROM AuditTrail AS adt
LEFT OUTER JOIN Loans AS l ON adt.ObjectID = l.LoanID
LEFT OUTER JOIN LoanStatuses AS lo ON adt.OldValue = lo.LoanStatusID
LEFT OUTER JOIN LoanStatuses AS ln ON adt.NewValue = ln.LoanStatusID

WHERE adt.ModuleID = 5
AND adt.TableName <> 'ConXrefs'
AND adt.ColumnName = 'LoanStatus'
AND adt.NewValue = 0
--AND adt.GSRowVersion > (SELECT MAX(MFAH_DBTS) FROM MFAHt_DBTS)
AND adt.EnteredDate > '2019-07-01 00:00:00'

ORDER BY adt.EnteredDate DESC


------------------

SELECT 
adt.* 
FROM AuditTrail AS adt
WHERE adt.LoginID = 'TKoseki'
AND EnteredDate BETWEEN '2019-09-24 00:00:00' AND '2019-09-24 23:59:00'


SELECT
adt.*
FROM AuditTrail AS adt
WHERE EnteredDate BETWEEN '2019-09-24 00:00:00' AND '2019-09-24 23:59:00'
ORDER BY EnteredDate DESC


--------------

EXEC dbo.MFAHsp_LOAN_StatusChangeAlert2
