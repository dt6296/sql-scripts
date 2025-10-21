











SELECT * FROM StatusFlags WHERE ObjectID = 23172




SELECT * 
--DELETE
FROM StatusFlags 
WHERE ObjectID IN
(
	SELECT 
	sf.ObjectID
	FROM StatusFlags AS sf
	WHERE FlagID = 1
	GROUP BY sf.ObjectID
	HAVING COUNT(*) > 1
	-- 28 rows
)
AND FlagID = 1
AND StatusFlagID IN
(
	SELECT MIN(StatusFlagID)
	FROM StatusFlags
	WHERE FlagID = 1
	GROUP BY ObjectID
	HAVING COUNT(*) > 1
)


ORDER BY EnteredDate DESC





SELECT MIN(StatusFlagID)
FROM StatusFlags
WHERE FlagID = 1
GROUP BY ObjectID
HAVING COUNT(*) > 1








SELECT * 
--DELETE
FROM StatusFlags 
WHERE ObjectID IN
(
	SELECT 
	sf.ObjectID
	FROM StatusFlags AS sf
	WHERE FlagID = 24
	GROUP BY sf.ObjectID
	HAVING COUNT(*) > 1
	-- 90 rows
)
AND FlagID = 24
AND LoginID <> 'dthompson'
ORDER BY EnteredDate DESC



SELECT * FROM StatusFlags WHERE LoginID = 'dthompson' AND EnteredDate BETWEEN '2015-01-29 00:00' AND '2015-01-29 23:59'



