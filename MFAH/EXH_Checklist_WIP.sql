DECLARE @TMSReportID		VARCHAR(50)
--DECLARE @ExhibitionID		INT
DECLARE @VenueID			INT
DECLARE @IncludedExcluded	INT
DECLARE @VirtualPhysical	INT

SET @TMSReportID			= '05906F124E7C48BF8362D8FBCA220E47' -- Godzilla!
--SET @ExhibitionID			= 836	-- Godzilla!
--SET @VenueID				= 0		-- MFAH ALL WORKS
--SET @VenueID				= 20496 -- MAM RIO TESTDAVE ONLY
SET @VenueID				= 23288	-- PHILBROOK REAL WORKS
SET @IncludedExcluded		= 1
SET @VirtualPhysical		= 1


SELECT
o.ObjectNumber,
ot.Title,
'',
e.ExhibitionID, 
e.ExhMnemonic,
evx.ConstituentID,
evx.Mnemonic AS ExhVenueMnemonic,
CASE WHEN @IncludedExcluded = 2 THEN 2 ELSE
	CASE WHEN evox.ObjectID IS NULL THEN 0 ELSE 1 END END AS IncludedInVenue,
CASE WHEN evox.ObjectID IS NULL THEN 'Not Included' ELSE 'Included' END AS IncludedInVenueDisplay,

CASE WHEN @VirtualPhysical = 2 THEN 2 ELSE o.IsVirtual END AS VirtualOrPhysical,

evox.Approved,
evox.Displayed,
CASE WHEN evox.ObjectID IS NULL THEN 99999 ELSE 1 END AS MajorGroup,
CASE WHEN evox.ObjectID IS NULL THEN 'not included' ELSE ISNULL(eox.Section,'') END AS Section, 
CASE WHEN evox.ObjectID IS NULL THEN 'not included' ELSE ISNULL(eox.Segment,'') END AS Segment, 
CASE WHEN evox.ObjectID IS NULL THEN 'not included' ELSE ISNULL(eox.CaseNumber,'') END AS CaseGalleryNumber,
CASE WHEN evox.ObjectID IS NULL THEN 'not included' ELSE ISNULL(CAST(eox.SequenceNumber AS VARCHAR(10)),'0') END AS SequenceNumber, 
eox.ObjectID,
eox.Remarks,

l.LoanID, 
l.LoanNumber,
l.SortNumber	AS LoanSortNumber,
ls.LoanStatus,
l.PrimaryLender,
l.PrimaryLenderAlphaSort,
l.PrimaryLenderCountry,
los.LoanObjectStatus,

o.ObjectNumber, 
o.SortNumber,
o.IsVirtual,
d.Department,
dp.DepartmentPublic, 
c.Classification, 
oc.PrepositionalOrPrefix_CultureSchoolName_Suffix_Date AS ArtistMaker,
ot.Title,
o.Dated, 
o.Medium, 
o.Dimensions,
o.CreditLine

FROM			Exhibitions				AS e 
LEFT OUTER JOIN	ExhObjXrefs				AS eox		ON	e.ExhibitionID = eox.ExhibitionID 
LEFT OUTER JOIN	ExhObjLoanObjXrefs		AS eolox	ON	eox.ExhObjXrefID = eolox.ExhObjXrefID
LEFT OUTER JOIN	LoanObjXrefs			AS lox		ON	eolox.LoanObjXrefID = lox.LoanObjXrefID 
LEFT OUTER JOIN	MFAHv_LOAN				AS l		ON	lox.LoanID = l.LoanID 
LEFT OUTER JOIN LoanStatuses			AS ls		ON	l.LoanStatusID = ls.LoanStatusID
LEFT OUTER JOIN LoanObjStatuses			AS los		ON	lox.LoanObjectStatusID = los.LoanObjectStatusID
LEFT OUTER JOIN ExhVenuesXrefs			AS evx		ON	e.ExhibitionID = evx.ExhibitionID
LEFT OUTER JOIN ExhVenObjXrefs			AS evox		ON	evx.ExhVenueXrefID = evox.ExhVenueXrefID
													AND	eox.ObjectID = evox.ObjectID
LEFT OUTER JOIN	[Objects]				AS o		ON	eox.ObjectID = o.ObjectID
LEFT OUTER JOIN Departments				AS d		ON	o.DepartmentID = d.DepartmentID
LEFT OUTER JOIN MFAHt_DepartmentPublic	AS dp		ON	d.DepartmentID = dp.DepartmentID
LEFT OUTER JOIN Classifications			AS c		ON	o.ClassificationID = c.ClassificationID
LEFT OUTER JOIN ConXrefs				AS ocx		ON	eox.ObjectID = ocx.ID
													AND	ocx.TableID = 108
													AND	ocx.RoleTypeID = 1
													AND	ocx.Active = 1
													AND	ocx.Displayed = 1
													AND	ocx.DisplayOrder = 1
LEFT OUTER JOIN ConXrefDetails			AS ocxd		ON	ocx.ConXrefID = ocxd.ConXrefID
													AND	ocxd.UnMasked = 1
LEFT OUTER JOIN MFAHv_OBJ_Constituent	AS oc		ON	ocxd.ConXrefDetailID = oc.ConXrefDetailID
													AND	ocxd.NameID = oc.cxd_NameID
LEFT OUTER JOIN ObjTitles				AS ot		ON	eox.ObjectID = ot.ObjectID
													AND	ot.Active = 1
													AND	ot.Displayed = 1
													AND	ot.DisplayOrder = 1


INNER JOIN
(
	SELECT
	ID,ReportGUID
	FROM WebReportIDs
	
	UNION
	
	SELECT 
	ID,ReportGUID
	FROM ReportIDs
) AS r ON e.ExhibitionID = r.ID

INNER JOIN

(
	(
		SELECT
		o.ObjectID, o.ObjectNumber, o.IsVirtual, o.SortNumber
		FROM Objects AS o
		WHERE o.ObjectID NOT IN (SELECT ObjectID FROM MFAHv_OBJ_Related WHERE RelationshipTypeID IN (0,2))	--30
		--AND	(o.ObjectNumber IN ('2011.646','2016.34','2016.156') OR o.ObjectNumber LIKE '2009.29.%'	OR o.ObjectNumber LIKE 'TEST.DAVE.%')
 
	)

	UNION

	(
		SELECT DISTINCT
		o.ObjectID, o.ObjectNumber, o.IsVirtual, o.SortNumber
		FROM Objects AS o
		LEFT OUTER JOIN MFAHv_OBJ_Related AS r ON o.ObjectID = r.ObjectID
		WHERE CASE WHEN o.ObjectID IN (SELECT ObjectID FROM MFAHv_OBJ_Related) 
					AND r.RelationshipTypeID IN (0,2) THEN 1 ELSE 0 END = 1
		AND CASE WHEN @VirtualPhysical = 2 THEN 2 ELSE 
			CASE WHEN o.IsVirtual = 1 THEN 1 ELSE 0 END END = @VirtualPhysical
		--AND (o.ObjectNumber IN ('2011.646','2016.34','2016.156') OR o.ObjectNumber LIKE '2009.29.%'	OR o.ObjectNumber LIKE 'TEST.DAVE.%')
	)
) AS ro ON o.ObjectID = ro.ObjectID  -- This is where it broke, after commenting out my object selections above.



WHERE r.ReportGUID IN (@TMSReportID)	-- Filter for just the Web/ReportIDs GUID being run.
--AND (e.ExhibitionID = @ExhibitionID)
AND CASE WHEN @IncludedExcluded = 2 THEN 2 ELSE CASE WHEN evox.ObjectID IS NULL THEN 0 ELSE 1 END END = @IncludedExcluded
AND evx.ConstituentID IN (@VenueID)

ORDER BY o.SortNumber




















