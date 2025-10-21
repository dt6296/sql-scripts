


--	EXH-OBJ

SELECT
e.ExhibitionID, 
ISNULL(eo.Section,'') AS Section, 
ISNULL(eo.Segment,'') AS Segment, 
ISNULL(eo.CaseNumber,'') AS CaseGalleryNumber,
ISNULL(eo.SequenceNumber,0) AS SequenceNumber,
eo.ObjectID

FROM            MFAHv_EXH				AS e 
LEFT OUTER JOIN	MFAHv_EXH_OBJ			AS eo		ON e.ExhibitionID = eo.ExhibitionID 
--LEFT OUTER JOIN	ExhObjLoanObjXrefs		AS eolox	ON eo.ExhObjXrefID = eolox.ExhObjXrefID
--LEFT OUTER JOIN	LoanObjXrefs			AS lox		ON eolox.LoanObjXrefID = lox.LoanObjXrefID 
--LEFT OUTER JOIN	MFAHv_LOAN				AS l		ON lox.LoanID = l.LoanID 
LEFT OUTER JOIN	MFAHv_OBJ_Tombstone2	AS o		ON eo.ObjectID = o.ObjectID
WHERE        (e.ExhibitionID = @ExhibitionID)







--	EXH-LOAN-OBJ

SELECT
e.ExhibitionID, 
l.LoanID, 
ISNULL(l.LoanNumber,'MFAH Object') AS LoanNumber, 
ISNULL(l.SortNumber,'MFAH Object') AS LoanSortNumber, 
l.LoanRole,
l.Mnemonic							AS LoanMnemonic,
ISNULL(l.PrimaryLender,'MFAH') AS PrimaryLoanConstituent, 
ISNULL(l.PrimaryLenderAlphaSort,'MFAH') AS PrimaryLoanConstituentAlphaSort,
l.PrimaryLoanConCountry, 
l.LoanStatusID, 
ISNULL(l.LoanStatus,'N/A') AS LoanStatus,
eo.ObjectID

FROM            MFAHv_EXH				AS e 
LEFT OUTER JOIN	MFAHv_EXH_OBJ			AS eo		ON e.ExhibitionID = eo.ExhibitionID 
LEFT OUTER JOIN	ExhObjLoanObjXrefs		AS eolox	ON eo.ExhObjXrefID = eolox.ExhObjXrefID
LEFT OUTER JOIN	LoanObjXrefs			AS lox		ON eolox.LoanObjXrefID = lox.LoanObjXrefID 
LEFT OUTER JOIN	MFAHv_LOAN				AS l		ON lox.LoanID = l.LoanID 
LEFT OUTER JOIN	MFAHv_OBJ_Tombstone2	AS o		ON eo.ObjectID = o.ObjectID

WHERE        (e.ExhibitionID = 836)