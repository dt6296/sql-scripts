






SELECT * FROM LoanPurposes





SELECT
COUNT(l.LoanID) AS Frequency,
lp.LoanPurpose,
l.LoanPurposeID
FROM Loans AS l
INNER JOIN LoanPurposes AS lp ON l.LoanPurposeID = lp.LoanPurposeID
GROUP BY 
l.LoanPurposeID,
lp.LoanPurpose
ORDER BY
lp.LoanPurpose





