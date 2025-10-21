/*



THIS DIDN'T QUITE WORK, SEE MFAHv_EXH_VENUE_LOAN_Object






SELECT
v.LoanNumber,
v.Lender,
v.ObjectNumber,
v.Venue,
v.Title,
v.Dated,
ot.Medium,
ot.Dimensions,
v.ReportedValue AS Value

FROM
(
	SELECT DISTINCT

	l.LoanNumber,
	can.DisplayName AS Lender,
	o.ObjectID,
	o.ObjectNumber,
	c.DisplayName	AS Venue,
	o.Title,
	o.Dated,

	ov.ReportedValue,
	ov.ReportedValueType

	FROM MFAHv_EXH AS e
	LEFT OUTER JOIN ExhLoanXrefs	AS elx	ON e.ExhibitionID = elx.ExhibitionID
	LEFT OUTER JOIN MFAHv_LOAN		AS l	ON elx.LoanID = l.LoanID
	LEFT OUTER JOIN ConXrefs		AS cx	ON l.PrimaryConXrefID = cx.ConXrefID
	LEFT OUTER JOIN ConXrefDetails	AS cxd	ON cx.ConXrefID = cxd.ConXrefID
	LEFT OUTER JOIN ConAltNames		AS can	ON cxd.NameID = can.AltNameId
	LEFT OUTER JOIN LoanObjXrefs	AS lox	ON l.LoanID = lox.LoanID
	LEFT OUTER JOIN ExhVenuesXrefs	AS evx	ON e.ExhibitionID = evx.ExhibitionID
	LEFT OUTER JOIN Constituents	AS c	ON evx.ConstituentID = c.ConstituentID
	LEFT OUTER JOIN ExhVenObjXrefs	AS evox	ON evx.ExhVenueXrefID = evox.ExhVenueXrefID
	LEFT OUTER JOIN MFAHv_OBJ		AS o	ON evox.ObjectID = o.ObjectID
											AND	lox.ObjectID = o.ObjectID
	LEFT OUTER JOIN MFAHv_OBJ_Value	AS ov	ON o.ObjectID = ov.ObjectID

	WHERE e.ExhibitionID = 679
	AND o.ObjectNumber IS NOT NULL

)	AS v
LEFT OUTER JOIN MFAHv_OBJ AS ot ON v.ObjectID = ot.ObjectID

ORDER BY 
v.LoanNumber,
v.Lender,
v.Venue,
v.ObjectNumber


*/




SELECT
v.LoanID,
v.LoanNumber,
v.LenderID,
v.Lender,
v.LenderAlphaSort,
v.ObjectNumber,
v.VenueID,
v.Venue,
c.can_DisplayName AS Artist,
v.Title,
v.Dated,
ot.Medium,
ot.Dimensions,
v.ReportedValue AS Value

FROM
(
	SELECT DISTINCT

	l.LoanID,
	l.LoanNumber,
	can.ConstituentID AS LenderID,
	can.DisplayName AS Lender,
	can.AlphaSort AS LenderAlphaSort,
	o.ObjectID,
	o.ObjectNumber,
	c.ConstituentID AS VenueID,
	c.DisplayName	AS Venue,
	o.Title,
	o.Dated,

	ov.ReportedValue,
	ov.ReportedValueType

	FROM MFAHv_EXH AS e
	LEFT OUTER JOIN ExhLoanXrefs	AS elx	ON e.ExhibitionID = elx.ExhibitionID
	LEFT OUTER JOIN MFAHv_LOAN		AS l	ON elx.LoanID = l.LoanID
	
	LEFT OUTER JOIN ConXrefs		AS cx	ON l.PrimaryConXrefID = cx.ConXrefID
	LEFT OUTER JOIN ConXrefDetails	AS cxd	ON cx.ConXrefID = cxd.ConXrefID
	LEFT OUTER JOIN ConAltNames		AS can	ON cxd.NameID = can.AltNameId
	LEFT OUTER JOIN LoanObjXrefs	AS lox	ON l.LoanID = lox.LoanID
	LEFT OUTER JOIN ExhVenuesXrefs	AS evx	ON e.ExhibitionID = evx.ExhibitionID
	LEFT OUTER JOIN Constituents	AS c	ON evx.ConstituentID = c.ConstituentID
	LEFT OUTER JOIN ExhVenObjXrefs	AS evox	ON evx.ExhVenueXrefID = evox.ExhVenueXrefID
	LEFT OUTER JOIN MFAHv_OBJ		AS o	ON evox.ObjectID = o.ObjectID
											AND	lox.ObjectID = o.ObjectID
	LEFT OUTER JOIN MFAHv_OBJ_Value	AS ov	ON o.ObjectID = ov.ObjectID

	WHERE e.ExhibitionID = 679
	AND o.ObjectNumber IS NOT NULL
	AND c.ConstituentID = 8726

)	AS v
LEFT OUTER JOIN MFAHv_OBJ AS ot ON v.ObjectID = ot.ObjectID
LEFT OUTER JOIN 
(
	SELECT
	oc.o_ObjectID,
	oc.can_DisplayName
	FROM MFAHv_OBJ_Constituent	AS	oc
	WHERE oc.o_ObjectID IN
	(SELECT ObjectID FROM ExhObjXrefs WHERE ExhibitionID = 679)
	AND cx_RoleID = 1
) as c ON v.ObjectID = c.o_ObjectID


WHERE v.VenueID = 8726 -- Grey Art Gallery, NYU

ORDER BY 
v.LoanNumber,
v.Lender,
v.Venue,
v.ObjectNumber





