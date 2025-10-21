

--4/15/14
--Object Insurance Records, looking counts , related to ranking for multiple records.



SELECT * FROM ObjInsurance WHERE ObjectID IN
(
	SELECT oi.ObjectID, COUNT(oi.ObjectID)
	FROM ObjInsurance AS oi
	LEFT OUTER JOIN Objects AS o ON oi.ObjectID = o.ObjectID
	WHERE oi.ValuationPurposeID = 7
	AND o.ObjectStatusID IN (2,5,27)
	GROUP BY oi.ObjectID
	HAVING SUM(CAST(oi.IsCurrent AS INT)) = 0
)






	SELECT oi.ObjectID, COUNT(oi.ObjectID)
	FROM ObjInsurance AS oi
	LEFT OUTER JOIN Objects AS o ON oi.ObjectID = o.ObjectID
	WHERE oi.ValuationPurposeID = 7
	AND o.ObjectStatusID IN (2,5,27)
	GROUP BY oi.ObjectID
	HAVING SUM(CAST(oi.IsCurrent AS INT)) = 0
	
	
	
	--objects with multiple purchase valuations
	
	SELECT oi.ObjectID, COUNT(oi.ObjectID)
	FROM ObjInsurance AS oi
	LEFT OUTER JOIN Objects AS o ON oi.ObjectID = o.ObjectID
	WHERE oi.ValuationPurposeID = 4
	AND o.ObjectStatusID IN (2,5,27)
	GROUP BY oi.ObjectID
	HAVING COUNT(oi.ObjectID) > 1


