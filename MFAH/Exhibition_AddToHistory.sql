



SELECT 
e.ObjectID,
CONCAT('"' + e.ExhTitle, + '," ' + e.ConcatVenues + '. (' + e.LoanNumber + ').')
FROM MFAHv_EXH_LOAN_Object AS e
WHERE e.ExhibitionID = 795 --794


