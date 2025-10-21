



SELECT
o.ObjectID,
o.ObjectNumber,
o.SortNumber,
lox.LoanObjStatus,
COUNT(lox.LoanObjXrefID) AS Loans

FROM Objects AS o
INNER JOIN LoanObjXrefs AS lox ON o.ObjectID = lox.ObjectID
LEFT OUTER JOIN Loans AS l ON lox.LoanID = l.LoanID

WHERE o.DepartmentID = 11
AND o.ObjectStatusID = 2
AND l.LoanNumber NOT LIKE 'RR%'


GROUP BY
o.ObjectID,
o.ObjectNumber,
o.SortNumber,
lox.LoanObjStatus

ORDER BY COUNT(lox.LoanObjXrefID) DESC,O.SortNumber

