
--	LOAN_OL_AGENDA


---------------------------------------------------------------------------------------------------	Exhibition Venues/Dates

SELECT
ev.ExhibitionID,
ev.ConstituentID,
ev.VenueID,
ev.DisplayName,
ev.VenueBeginDate,
ev.VenueEndDate,
ev.DisplayOrder

FROM MFAHv_EXH_Venue AS ev

WHERE ev.ExhibitionID = 836

---------------------------------------------------------------------------------------------------	Exhibition Loan Object

SELECT
le.LoanID,
le.ExhibitionID,
e.ExhTitle,
le.LoanNumber,
l.LoanIn,
l.LoanRole,
l.PrimaryLoanConstituentID,
l.PrimaryLoanConstituent,
lo.ObjectID,
lo.LoanObjStatus

FROM MFAHv_LOAN_EXH AS le
INNER JOIN Exhibitions AS e ON le.ExhibitionID = e.ExhibitionID
INNER JOIN MFAHv_LOAN AS l ON le.LoanID = l.LoanID
INNER JOIN MFAHv_LOAN_OBJ AS lo ON le.LoanID = lo.LoanID

WHERE le.LoanID = 12149