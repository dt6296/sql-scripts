



SELECT
l.LoanID,
l.LoanNumber,
l.LoanPurposeID,
cx.ID,
cx.RoleID,
r.Role,
cxd.ConstituentID,
can.DisplayName

FROM Loans AS l
INNER JOIN ConXrefs AS cx ON l.LoanID = cx.ID AND TableID = 81
INNER JOIN Roles AS r ON cx.RoleID = r.RoleID
INNER JOIN ConXrefDetails AS cxd ON cx.ConXrefID = cxd.ConXrefID
INNER JOIN ConAltNames AS can ON cxd.ConstituentID = can.ConstituentID

WHERE l.LoanID = 8887
AND cx.RoleID = 428
AND cxd.UnMasked = 1
