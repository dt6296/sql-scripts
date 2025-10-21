/*

This query finds objects on loan during a specified period.
From: https://stackoverflow.com/questions/325933/determine-whether-two-date-ranges-overlap

	(StartA <= EndB) AND (EndA >= StartB)
	
	A		= Loan Period
	B		= May 2019

	StartA	= LoanBeginDate
	EndA	= LoanEndDate

	StartB	= 2019-05-01
	EndB	= 2019-05-31
		
*/


DECLARE	@StartB VARCHAR(10),
		@EndB	VARCHAR(10)

SET		@StartB	= '2019-05-01'
SET		@EndB	= '2019-05-31'

SELECT
o.ObjectID, o.ObjectNumber, l.LoanNumber, l.BeginISODate AS LoanBegin, l.EndISODate AS LoanEnd, l.LoanIn
FROM	LoanObjXrefs	AS lox
INNER JOIN Objects AS o ON lox.ObjectID = o.ObjectID
INNER JOIN Loans AS l ON lox.LoanID = l.LoanID

INNER JOIN -- Loans that overlap with a specific date range.
(
	SELECT 
	l.LoanID
	FROM Loans AS l
	WHERE CASE WHEN l.BeginISODate <= @EndB AND l.EndISODate >= @StartB THEN 1 ELSE 0 END = 1
	AND LoanIn = 0	--	Outgoing Loans
)	AS ol ON lox.LoanID = ol.LoanID

INNER JOIN	-- Objects in those loans.
(
	SELECT
	o.ObjectID
	FROM Objects AS o
	WHERE o.ObjectStatusID = 2	--	Accessioned Objects
	AND o.DepartmentID = 10		--	American Art
)	AS oo ON lox.ObjectID = oo.ObjectID

















