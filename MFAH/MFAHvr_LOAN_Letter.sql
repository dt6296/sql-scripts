











SELECT
l.LoanID,
l.LoanNumber,
lox.LenderObjectNumber,
l.LoanIn,
l.LoanStatusID,
ls.LoanStatus,
lcx.ConstituentID,
lcx.RoleID,
r.Role,
c.DisplayName,
c.FirstName,
c.LastName,
o.TitleDateDisplay,
om.DisplayName

FROM		Loans							AS l
INNER JOIN	LoanObjXrefs					AS lox	ON l.LoanID = lox.LoanID
INNER JOIN	MFAHv_OBJ						AS o	ON lox.ObjectID = o.ObjectID
INNER JOIN	LoanConXrefs					AS lcx	ON l.LoanID = lcx.LoanID
INNER JOIN	LoanStatuses					AS ls	ON l.LoanStatusID = ls.LoanStatusID
INNER JOIN	Constituents					AS c	ON lcx.ConstituentID = c.ConstituentID
INNER JOIN	Roles							AS r	ON lcx.RoleID = r.RoleID
INNER JOIN	MFAHv_OBJ_Maker_FirstDisplayed	AS om	ON o.ObjectID = om.ObjectID
INNER JOIN	MFAHv_OBJ_Constituent			AS oc	ON om.ObjectID = oc.o_ObjectID AND om.ConstituentID = oc.c_ConstituentID

WHERE	lcx.RoleID = 428
AND		l.LoanNumber LIKE 'OL.%'

ORDER BY l.LoanID












