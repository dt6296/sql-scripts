




/*
SELECT * FROM MFAHv_OBJ_Constituent AS oc


WHERE o_ObjectID IN

--	from Object Package record
(
	SELECT
	pl.ID
	FROM		PackageList	AS pl
	INNER JOIN	Packages	AS p	ON pl.PackageID = p.PackageID
	WHERE p.PackageID = 15012	-- "LTA/MS Nov 2013" 
)
*/


--***********I just edited the GS version of this instead of using this view.


SELECT

elx.ExhLoanXrefID AS ID,
elx.ExhLoanXrefID,

e.ExhibitionID,
e.ExhTitle,
e.ExhMnemonic,

l.LoanID,
l.LoanNumber,
l.SortNumber,
l.LoanPurposeID,
lp.LoanPurpose,
l.LoanIn,
/*
l.BeginISODate,
l.EndISODate,
l.DispBegISODate,
l.DispEndISODate,

l.Contact,
l.IsForeignLender,
l.PrimaryConXrefID,

l.RequestedBy,
l.RequestDate,
l.ApprovedBy,
l.ApprovedDate,

l.LoanStatusID,
ls.LoanStatus,


*/
cxd.ConstituentID,
cxd.AddressID,
c.DisplayName,
ca.StreetLine1,
ca.StreetLine2,
ca.StreetLine3,
ca.City,
ca.State,
ca.CountryID,
ca.ZipCode,
ctry.Country,
ca.DisplayAddress,

rt.RoleType,
r.Role

FROM Exhibitions				AS e
LEFT OUTER JOIN	ExhLoanXrefs	AS elx	ON	e.ExhibitionID = elx.ExhibitionID
LEFT OUTER JOIN Loans			AS l	ON	elx.LoanID = l.LoanID
LEFT OUTER JOIN LoanPurposes	AS lp	ON	l.LoanPurposeID = lp.LoanPurposeID
LEFT OUTER JOIN LoanStatuses	AS ls	ON	l.LoanStatusID = ls.LoanStatusID

LEFT OUTER JOIN ConXrefs		AS cx	ON	l.PrimaryConXrefID = cx.ConXrefID
										AND	cx.TableID = 81
LEFT OUTER JOIN RoleTypes		AS rt	ON	cx.RoleTypeID = rt.RoleTypeID
LEFT OUTER JOIN Roles			AS r	ON	cx.RoleID = r.RoleID

LEFT OUTER JOIN	ConXrefDetails	AS cxd	ON	cx.ConXrefID = cxd.ConXrefID
										AND cxd.AddressID IS NOT NULL
LEFT OUTER JOIN Constituents	AS c	ON	cxd.ConstituentID = c.ConstituentID

LEFT OUTER JOIN	ConAddress		AS ca	ON	c.ConstituentID = ca.ConstituentID
										AND ca.DefaultMailing = 1

LEFT OUTER JOIN	Countries		AS ctry	ON	ca.CountryID = ctry.CountryID


WHERE e.ExhTitle LIKE 'WAR/PHOTO%'		--ExhibitionID = 550

--ORDER BY c.ConstituentID


/*
SELECT * FROM Constituents WHERE ConstituentID = 508776

SELECT * FROM Constituents WHERE DisplayName LIKE '%Alan%Paris%'	ConstituentID = 33416
SELECT * FROM ConXrefs WHERE ID = 33416 
SELECT * FROM ConXrefs WHERE ConXrefID = 508776

SELECT * FROM ConXrefs WHERE TableID = 81 
SELECT * FROM DDTables AS t WHERE t.PhysTableID IN (322,108,81)
*/
