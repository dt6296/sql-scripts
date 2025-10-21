/* TEST System */


-- So much rigamarole!  Go to the bottom, it's very simple, actually.		3/20/2017



SELECT COUNT(*) FROM ObjInsurance AS oi WHERE oi.ValuationPurposeID = 7		-- 104865
SELECT COUNT(*) FROM ObjInsurance AS oi WHERE oi.ValuationPurposeID <> 7	--  26702
SELECT COUNT(*) FROM ObjInsurance AS oi WHERE oi.IsCurrent = 1				--  70567
SELECT COUNT(*) FROM ObjInsurance AS oi WHERE oi.IsCurrent <> 1				--  61000


SELECT COUNT(*) FROM ObjInsurance AS oi WHERE oi.ValuationPurposeID = 7 AND oi.IsCurrent = 1	-- 64544
SELECT COUNT(*) FROM ObjInsurance AS oi WHERE oi.ValuationPurposeID = 7 AND oi.IsCurrent <> 1	-- 40321
SELECT COUNT(*) FROM ObjInsurance AS oi WHERE oi.ValuationPurposeID <> 7 AND oi.IsCurrent = 1	--  6023
SELECT COUNT(*) FROM ObjInsurance AS oi WHERE oi.ValuationPurposeID <> 7 AND oi.IsCurrent <> 1	-- 20679


SELECT COUNT(*) FROM ObjInsurance AS oi										-- 131567	-- 132747







-- This is the first set I work with, just those objects for which there is only one OI record.
SELECT ObjectID, COUNT(*) AS Occurrences
FROM ObjInsurance
GROUP BY ObjectID
HAVING COUNT(*) = 1		--  46269 OBJ with COUNT(OI) = 1


-- This is the second set I work with, all objects for which there are more than one OI record
SELECT ObjectID, COUNT(*) AS Occurrences
FROM ObjInsurance
GROUP BY ObjectID
HAVING COUNT(*) > 1		--  31967 OBJ with COUNT(OI) > 1

						--  78236 OBJ Total

						-- In the end, I should have 78236 objects with one OI where type = Insurance and IS Current.



-- Objects with only ONE OI record

SELECT oi.ObjInsuranceID, oi.ObjectID, o.ObjectNumber, oi.IsCurrent, oi.ValuationPurposeID, oi.ValueISODate, oi.CurrencyValue, oi.EnteredDate, oi.LoginID, oi.ValueNotes
FROM ObjInsurance	AS oi	--	131567 ObjInsurance Records
INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID
WHERE oi.ObjectID IN
(
	SELECT	ObjectID--,COUNT(*) AS Occurrences
	FROM ObjInsurance
	GROUP BY ObjectID
	HAVING COUNT(*) = 1				--  46269 OBJ with COUNT(OI) = 1
)									--  46269 OI records

--AND oi.ValuationPurposeID = 7 AND oi.IsCurrent = 1		--	38420 OI records = INS, = Current
--AND oi.ValuationPurposeID = 7 AND oi.IsCurrent <> 1		--	 5695 OI records = INS, <> Current	-- check IsCurrent
--AND oi.ValuationPurposeID <> 7 AND oi.IsCurrent = 1		--	 1119 OI records <> INS, = Current
AND oi.ValuationPurposeID <> 7 AND oi.IsCurrent <> 1		--	 1035 OI records <> INS, <> Current	-- check IsCurrent
															--	46269 OI records



-- Remaining OI records belonging to OBJs with multiple OI records

SELECT oi.ObjInsuranceID, oi.ObjectID, o.ObjectNumber, oi.IsCurrent, oi.ValuationPurposeID, oi.ValueISODate, oi.CurrencyValue, oi.EnteredDate, oi.LoginID, oi.ValueNotes
FROM ObjInsurance	AS oi	--	131567 ObjInsurance Records
INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID
WHERE oi.ObjectID IN
(
	SELECT	ObjectID--,COUNT(*) AS Occurrences
	FROM ObjInsurance
	GROUP BY ObjectID
	HAVING COUNT(*) > 1				--  31967 OBJ with COUNT(OI) > 1
)									--  85298 OI records of OBJ with COUNT(OI) > 1

									-- 131567 TOTAL OI records

--AND oi.ValuationPurposeID = 7 AND oi.IsCurrent = 1		--	26124 OI records = INS, = Current
--AND oi.ValuationPurposeID = 7 AND oi.IsCurrent <> 1		--	34626 OI records = INS, <> Current
--AND oi.ValuationPurposeID <> 7 AND oi.IsCurrent = 1		--	 4904 OI records <> INS, = Current	 -- uncheck IsCurrent
AND oi.ValuationPurposeID <> 7 AND oi.IsCurrent <> 1		--	19644 OI records <> INS, <> Current
															--	85298 OI records





----------------------------------------







-- OI records for Objects with multiple OI records, at least one of which is Insurance
SELECT * 
FROM 
(
	SELECT RANK() OVER(PARTITION BY oi.ObjectID ORDER BY oi.ValueISODate DESC,oi.EnteredDate DESC,oi.ObjInsuranceID DESC) AS RankByDate,
	oi.ObjectID, o.ObjectNumber, oi.ValuationPurposeID, oi.IsCurrent, o.SortNumber
	FROM ObjInsurance AS oi
	INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID
	WHERE oi.ObjectID IN
	(
		SELECT ObjectID--,COUNT(*) AS Occurrences
		FROM ObjInsurance
		GROUP BY ObjectID
		HAVING COUNT(*) > 1				--  31967 OBJ with COUNT(OI) > 1
	)									--  85298 OI records of OBJ with COUNT(OI) > 1
	AND oi.ValuationPurposeID = 7			--  60750 OI = Insurance

	-- Excluding any Object with a non-Insurance value
	AND oi.ObjectID NOT IN
	(
		SELECT ObjectID
		FROM ObjInsurance
		WHERE ValuationPurposeID <> 7	-- 26702 non-insurance OI records
	) --26561 OI records

	-- Excluding any Object with a Current value
	AND oi.ObjectID NOT IN
	(
		SELECT ObjectID
		FROM ObjInsurance
		WHERE IsCurrent = 1
	) --1264 OI records
) AS sq
WHERE sq.RankByDate = 1				--631 OI records -- check IsCurrent		???
ORDER BY sq.SortNumber



------------------------


SELECT oi.ObjInsuranceID, oi.ObjectID, o.ObjectNumber, oi.IsCurrent, oi.ValuationPurposeID, oi.ValueISODate, oi.CurrencyValue, oi.EnteredDate, oi.LoginID, oi.ValueNotes
FROM ObjInsurance	AS oi	--	131567 ObjInsurance Records
INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID
WHERE oi.ObjectID IN
(
	SELECT	ObjectID--,COUNT(*) AS Occurrences
	FROM ObjInsurance
	GROUP BY ObjectID
	HAVING COUNT(*) > 1				--  31967 OBJ with COUNT(OI) > 1
)									--  85298 OI records of OBJ with COUNT(OI) > 1

									-- 131567 TOTAL OI records
AND oi.ValuationPurposeID <> 7 AND oi.IsCurrent = 1		--	 4904 OI records <> INS, = Current
AND oi.ObjectID NOT IN
(
	SELECT ObjectID
	FROM ObjInsurance
	WHERE ValuationPurposeID = 7
)													--272 rows -- uncheck IsCurrent		???  See below !



----------------------------------------------
-- rethink, trying to dissect the 85298 (where OBJ has >1 OI record) into those with INS value, and those without INS value


SELECT oi.ObjInsuranceID, oi.ObjectID, o.ObjectNumber, oi.IsCurrent, oi.ValuationPurposeID, oi.ValueISODate, oi.CurrencyValue, oi.EnteredDate, oi.LoginID, oi.ValueNotes
FROM ObjInsurance	AS oi	--	131567 ObjInsurance Records
INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID
WHERE oi.ObjectID IN
(
	SELECT	ObjectID--,COUNT(*) AS Occurrences
	FROM ObjInsurance
	GROUP BY ObjectID
	HAVING COUNT(*) > 1				--  31967 OBJ with COUNT(OI) > 1
)									--  85298 OI records of OBJ with COUNT(OI) > 1



SELECT ObjectID
FROM ObjInsurance
WHERE ValuationPurposeID = 7		-- 104865 OI records - verified


SELECT DISTINCT ObjectID
FROM ObjInsurance
WHERE ValuationPurposeID = 7		-- 75808 OBJ records






SELECT oi.ObjInsuranceID, oi.ObjectID, o.ObjectNumber, oi.IsCurrent, oi.ValuationPurposeID, oi.ValueISODate, oi.CurrencyValue, oi.EnteredDate, oi.LoginID, oi.ValueNotes
FROM ObjInsurance	AS oi	--	131567 ObjInsurance Records
INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID
WHERE oi.ObjectID IN
(
	SELECT	ObjectID--,COUNT(*) AS Occurrences
	FROM ObjInsurance
	GROUP BY ObjectID
	HAVING COUNT(*) > 1				--  31967 OBJ with COUNT(OI) > 1
)									--  85298 OI records of OBJ with COUNT(OI) > 1
AND oi.ObjectID IN
(
	SELECT ObjectID
	FROM ObjInsurance
	WHERE ValuationPurposeID = 7		-- 104865 OI records - verified

)										--    84735 records
--AND oi.ValuationPurposeID = 7 AND oi.IsCurrent = 1		--	26124 OI records = INS, = Current
--AND oi.ValuationPurposeID = 7 AND oi.IsCurrent <> 1		--	34626 OI records = INS, <> Current
--AND oi.ValuationPurposeID <> 7 AND oi.IsCurrent = 1		--	 4632 OI records <> INS, = Current	
--AND oi.ValuationPurposeID <> 7 AND oi.IsCurrent <> 1		--	19353 OI records <> INS, <> Current





SELECT oi.ObjInsuranceID, oi.ObjectID, o.ObjectNumber, oi.IsCurrent, oi.ValuationPurposeID, oi.ValueISODate, oi.CurrencyValue, oi.EnteredDate, oi.LoginID, oi.ValueNotes
FROM ObjInsurance	AS oi	--	131567 ObjInsurance Records
INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID
WHERE oi.ObjectID IN
(
	SELECT	ObjectID--,COUNT(*) AS Occurrences
	FROM ObjInsurance
	GROUP BY ObjectID
	HAVING COUNT(*) > 1				--  31967 OBJ with COUNT(OI) > 1
)									--  85298 OI records of OBJ with COUNT(OI) > 1
AND oi.ObjectID NOT IN
(
	SELECT ObjectID
	FROM ObjInsurance
	WHERE ValuationPurposeID = 7		-- 104865 OI records - verified
)										--    563 records
--AND oi.ValuationPurposeID = 7 AND oi.IsCurrent = 1		--      0 OI records = INS, = Current
--AND oi.ValuationPurposeID = 7 AND oi.IsCurrent <> 1		--      0 OI records = INS, <> Current
--AND oi.ValuationPurposeID <> 7 AND oi.IsCurrent = 1		--    272 OI records <> INS, = Current	
AND oi.ValuationPurposeID <> 7 AND oi.IsCurrent <> 1		--	  291 OI records <> INS, <> Current




SELECT oi.ObjInsuranceID, oi.ObjectID, o.ObjectNumber, oi.IsCurrent, oi.ValuationPurposeID, oi.ValueISODate, oi.CurrencyValue, oi.EnteredDate, oi.LoginID, oi.ValueNotes
FROM ObjInsurance	AS oi	--	131567 ObjInsurance Records
INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID
WHERE oi.ObjectID IN
(
	SELECT	ObjectID--,COUNT(*) AS Occurrences
	FROM ObjInsurance
	GROUP BY ObjectID
	HAVING COUNT(*) > 1				--  31967 OBJ with COUNT(OI) > 1
)									--  85298 OI records of OBJ with COUNT(OI) > 1
AND oi.ObjectID IN
(
SELECT ObjectID
FROM ObjInsurance
WHERE IsCurrent = 1					-- 83156
)
--AND oi.ValuationPurposeID = 7 AND oi.IsCurrent = 1		--   26124 OI records = INS, = Current
--AND oi.ValuationPurposeID = 7 AND oi.IsCurrent <> 1		--   32814 OI records = INS, <> Current ???
--AND oi.ValuationPurposeID <> 7 AND oi.IsCurrent = 1		--    4904 OI records <> INS, = Current	
--AND oi.ValuationPurposeID <> 7 AND oi.IsCurrent <> 1		--	 19314 OI records <> INS, <> Current ???




SELECT oi.ObjInsuranceID, oi.ObjectID, o.ObjectNumber, oi.IsCurrent, oi.ValuationPurposeID, oi.ValueISODate, oi.CurrencyValue, oi.EnteredDate, oi.LoginID, oi.ValueNotes
FROM ObjInsurance	AS oi	--	131567 ObjInsurance Records
INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID
WHERE oi.ObjectID IN
(
	SELECT	ObjectID--,COUNT(*) AS Occurrences
	FROM ObjInsurance
	GROUP BY ObjectID
	HAVING COUNT(*) > 1				--  31967 OBJ with COUNT(OI) > 1
)									--  85298 OI records of OBJ with COUNT(OI) > 1
AND oi.ObjectID NOT IN
(
SELECT ObjectID
FROM ObjInsurance
WHERE IsCurrent = 1					-- 2142
)
--AND oi.ValuationPurposeID = 7 AND oi.IsCurrent = 1		--      0 OI records = INS, = Current
--AND oi.ValuationPurposeID = 7 AND oi.IsCurrent <> 1		--      1812 OI records = INS, <> Current
--AND oi.ValuationPurposeID <> 7 AND oi.IsCurrent = 1		--    0 OI records <> INS, = Current	
AND oi.ValuationPurposeID <> 7 AND oi.IsCurrent <> 1		--	  330 OI records <> INS, <> Current

------------------------------------

-- So, look for INS values that should be marked Current but aren't...
--Out of this 34,626, I should be able to find the balance?


SELECT * FROM
(
	SELECT RANK() OVER(PARTITION BY oi.ObjectID ORDER BY oi.ValueISODate DESC,oi.EnteredDate DESC,oi.ObjInsuranceID DESC) AS RankByDate,
	oi.ObjInsuranceID, oi.ObjectID, o.ObjectNumber, oi.IsCurrent, oi.ValuationPurposeID, oi.ValueISODate, oi.CurrencyValue, oi.EnteredDate, oi.LoginID, oi.ValueNotes
	FROM ObjInsurance	AS oi	--	131567 ObjInsurance Records
	INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID
	WHERE oi.ObjectID IN
	(
		SELECT	ObjectID--,COUNT(*) AS Occurrences
		FROM ObjInsurance
		GROUP BY ObjectID
		HAVING COUNT(*) > 1				--  31967 OBJ with COUNT(OI) > 1
	)									--  85298 OI records of OBJ with COUNT(OI) > 1
	AND oi.ObjectID IN
	(
		SELECT ObjectID
		FROM ObjInsurance
		WHERE ValuationPurposeID = 7		-- 104865 OI records - verified
	)										--    84735 records
	--AND oi.ValuationPurposeID = 7 AND oi.IsCurrent = 1		--	26124 OI records = INS, = Current
	--AND oi.ValuationPurposeID = 7 AND oi.IsCurrent <> 1		--	34626 OI records = INS, <> Current
	--AND oi.ValuationPurposeID <> 7 AND oi.IsCurrent = 1		--	 4632 OI records <> INS, = Current	
	--AND oi.ValuationPurposeID <> 7 AND oi.IsCurrent <> 1		--	19353 OI records <> INS, <> Current
) AS sq
WHERE RankByDate = 1		-- 24519 OI records



-------------------------------------------------------------------------------
--How about the breakdown of everthing now marked current (and those OBJ that have no Current record)?



SELECT oi.ObjInsuranceID, oi.ObjectID, o.ObjectNumber, oi.IsCurrent, oi.ValuationPurposeID, oi.ValueISODate, oi.CurrencyValue, oi.EnteredDate, oi.LoginID, oi.ValueNotes
FROM ObjInsurance AS oi
INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID
WHERE oi.IsCurrent = 1
AND oi.ObjectID IN
(
		SELECT	ObjectID--,COUNT(*) AS Occurrences
		FROM ObjInsurance
		GROUP BY ObjectID
		HAVING COUNT(*) > 1				--  31967 OBJ with COUNT(OI) > 1
)
	
AND oi.ValuationPurposeID <> 7								--  4904 OI records, as expected

-- I've already dealt with these records, It's the INS values I have to deal with now.



SELECT DISTINCT oi.ObjectID, o.ObjectNumber, o.SortNumber
FROM ObjInsurance AS oi
INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID 
GROUP BY oi.ObjectID, o.ObjectNumber, o.SortNumber
HAVING SUM(CAST(oi.IsCurrent AS INT)) = 0
ORDER BY o.SortNumber										--7669 OBJ have NO current value


SELECT *
FROM
(
	SELECT RANK() OVER(PARTITION BY oi.ObjectID ORDER BY oi.ValueISODate DESC,oi.EnteredDate DESC,oi.ObjInsuranceID DESC) AS RankByDate,
	oi.ObjInsuranceID, oi.ObjectID, o.ObjectNumber, oi.IsCurrent, oi.ValuationPurposeID, oi.ValueISODate, oi.CurrencyValue, oi.EnteredDate, oi.LoginID, oi.ValueNotes
	FROM ObjInsurance	AS oi	--	131567 ObjInsurance Records
	INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID
	WHERE oi.ObjectID IN
	(
		SELECT DISTINCT oi.ObjectID--, o.ObjectNumber, o.SortNumber
		FROM ObjInsurance AS oi
		INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID 
		GROUP BY oi.ObjectID--, o.ObjectNumber, o.SortNumber
		HAVING SUM(CAST(oi.IsCurrent AS INT)) = 0
		--ORDER BY o.SortNumber										--7669 OBJ have NO current value
	)
) AS sq
WHERE RankByDate = 1
AND sq.ObjectID IN
(
		SELECT	ObjectID--,COUNT(*) AS Occurrences
		FROM ObjInsurance
		GROUP BY ObjectID
		HAVING COUNT(*) > 1				--  31967 OBJ with COUNT(OI) > 1
)										--   6730 in COUNT(*) = 1	-- ALREADY ACCOUNTED FOR
										--    939 in COUNT(*) > 1	-- NOT yet accounted for?


----------------------------------------------------------------------------------

--What if I code all the records to what I think I should do with them and see what I've not accounted for?


-- First code according to chart (I,C,1) (I,C',1) (I',C,1) (I',C',1) (I,C,1') (I,C',1') (I',C,1') (I',C',1')




SELECT oi.ObjInsuranceID, oi.ObjectID, o.ObjectNumber, oi.IsCurrent, oi.ValuationPurposeID, oi.ValueISODate, oi.CurrencyValue, oi.EnteredDate, oi.LoginID, oi.ValueNotes,

CASE WHEN oi.ValuationPurposeID = 7 AND oi.IsCurrent = 1 AND oi.ObjectID IN (SELECT ObjectID FROM ObjInsurance GROUP BY ObjectID HAVING COUNT(*) > 1) THEN 'IC1' ELSE
CASE WHEN oi.ValuationPurposeID = 7 AND oi.IsCurrent = 0 AND oi.ObjectID IN (SELECT ObjectID FROM ObjInsurance GROUP BY ObjectID HAVING COUNT(*) > 1) THEN 'IC*1' ELSE
CASE WHEN oi.ValuationPurposeID <> 7 AND oi.IsCurrent = 1 AND oi.ObjectID IN (SELECT ObjectID FROM ObjInsurance GROUP BY ObjectID HAVING COUNT(*) > 1) THEN 'I*C1' ELSE
CASE WHEN oi.ValuationPurposeID <> 7 AND oi.IsCurrent = 0 AND oi.ObjectID IN (SELECT ObjectID FROM ObjInsurance GROUP BY ObjectID HAVING COUNT(*) > 1) THEN 'I*C*1' ELSE

CASE WHEN oi.ValuationPurposeID = 7 AND oi.IsCurrent = 1 AND oi.ObjectID NOT IN (SELECT ObjectID FROM ObjInsurance GROUP BY ObjectID HAVING COUNT(*) > 1) THEN 'IC1*' ELSE
CASE WHEN oi.ValuationPurposeID = 7 AND oi.IsCurrent = 0 AND oi.ObjectID NOT IN (SELECT ObjectID FROM ObjInsurance GROUP BY ObjectID HAVING COUNT(*) > 1) THEN 'IC*1*' ELSE
CASE WHEN oi.ValuationPurposeID <> 7 AND oi.IsCurrent = 1 AND oi.ObjectID NOT IN (SELECT ObjectID FROM ObjInsurance GROUP BY ObjectID HAVING COUNT(*) > 1) THEN 'I*C1*' ELSE
CASE WHEN oi.ValuationPurposeID <> 7 AND oi.IsCurrent = 0 AND oi.ObjectID NOT IN (SELECT ObjectID FROM ObjInsurance GROUP BY ObjectID HAVING COUNT(*) > 1) THEN 'I*C*1*' ELSE

'Undetermined' END END END END END END END END AS Category

FROM ObjInsurance	AS oi	--	131567 ObjInsurance Records
INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID




----------------------------------------------------------------------------------------------
--			2000.278.85
--																					THIS IS IT!





SELECT oi.ObjInsuranceID, oi.ObjectID, o.ObjectNumber, oi.ValueISODate, oi.CurrencyValue, oi.EnteredDate, oi.LoginID, oi.IsCurrent, oi.ValuationPurposeID, 
CASE WHEN oi.ObjectID IN (SELECT ObjectID FROM ObjInsurance GROUP BY ObjectID HAVING COUNT(*) > 1) THEN 1 ELSE 0 END AS GT1,
CASE WHEN oi.ValuationPurposeID = 7 THEN 1 ELSE 0 END AS IsInsurance--, oi.ValueNotes
FROM ObjInsurance	AS oi	--	131567 ObjInsurance Records
INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID
ORDER BY o.SortNumber


SELECT DISTINCT ObjectID FROM ObjInsurance	--	79260


SELECT * FROM 
(
	SELECT *,
	RANK() OVER(PARTITION BY oi.ObjectID ORDER BY oi.ValueISODate DESC,oi.EnteredDate DESC,oi.ObjInsuranceID DESC) AS RankByDate
	FROM
	(
		SELECT oi.ObjInsuranceID, oi.ObjectID, o.ObjectNumber, oi.ValueISODate, oi.CurrencyValue, oi.EnteredDate, oi.LoginID, oi.IsCurrent, oi.ValuationPurposeID, 
		CASE WHEN oi.ObjectID IN (SELECT ObjectID FROM ObjInsurance GROUP BY ObjectID HAVING COUNT(*) > 1) THEN 1 ELSE 0 END AS GT1
		FROM ObjInsurance	AS oi	--	131567 ObjInsurance Records
		INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID
	) AS oi
	WHERE ValuationPurposeID = 7
) AS sq1										-- 104865 INS values
WHERE RankByDate = 1							--  75808 to mark Current	--76828	--76883



UNION


SELECT * FROM 
(
	SELECT *,
	RANK() OVER(PARTITION BY oi.ObjectID ORDER BY oi.ValueISODate DESC,oi.EnteredDate DESC,oi.ObjInsuranceID DESC) AS RankByDate
	FROM
	(
		SELECT oi.ObjInsuranceID, oi.ObjectID, o.ObjectNumber, oi.ValueISODate, oi.CurrencyValue, oi.EnteredDate, oi.LoginID, oi.IsCurrent, oi.ValuationPurposeID, 
		CASE WHEN oi.ObjectID IN (SELECT ObjectID FROM ObjInsurance GROUP BY ObjectID HAVING COUNT(*) > 1) THEN 1 ELSE 0 END AS GT1
		FROM ObjInsurance	AS oi	--	131567 ObjInsurance Records
		INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID
	) AS oi
	WHERE ValuationPurposeID <> 7				
) AS sq2										--  26702 NON-INS values
WHERE GT1 = 0									--   2154 Single NON-INS values		-- 2161	--2161


UNION


SELECT * FROM 
(
	SELECT *,
	RANK() OVER(PARTITION BY oi.ObjectID ORDER BY oi.ValueISODate DESC,oi.EnteredDate DESC,oi.ObjInsuranceID DESC) AS RankByDate
	FROM
	(
		SELECT oi.ObjInsuranceID, oi.ObjectID, o.ObjectNumber, oi.ValueISODate, oi.CurrencyValue, oi.EnteredDate, oi.LoginID, oi.IsCurrent, oi.ValuationPurposeID, 
		CASE WHEN oi.ObjectID IN (SELECT ObjectID FROM ObjInsurance GROUP BY ObjectID HAVING COUNT(*) > 1) THEN 1 ELSE 0 END AS GT1
		FROM ObjInsurance	AS oi	--	131567 ObjInsurance Records
		INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID
	) AS oi
	WHERE ValuationPurposeID <> 7				
) AS sq2										--  26702 NON-INS values
WHERE GT1 = 1									--  24548 multiple NON-INS values
AND ObjectID NOT IN
(
	SELECT ObjectID FROM ObjInsurance WHERE ValuationPurposeID = 7	--563
)
AND RankByDate = 1													--274		-- 271






--UPDATE ObjInsurance SET IsCurrent = 0									-- (132747 row(s) affected)

--UPDATE ObjInsurance SET IsCurrent = 1 WHERE ObjInsuranceID IN
(
	SELECT ObjInsuranceID FROM 
	(
		SELECT *,
		RANK() OVER(PARTITION BY oi.ObjectID ORDER BY oi.ValueISODate DESC,oi.EnteredDate DESC,oi.ObjInsuranceID DESC) AS RankByDate
		FROM
		(
			SELECT oi.ObjInsuranceID, oi.ObjectID, o.ObjectNumber, oi.ValueISODate, oi.CurrencyValue, oi.EnteredDate, oi.LoginID, oi.IsCurrent, oi.ValuationPurposeID, 
			CASE WHEN oi.ObjectID IN (SELECT ObjectID FROM ObjInsurance GROUP BY ObjectID HAVING COUNT(*) > 1) THEN 1 ELSE 0 END AS GT1
			FROM ObjInsurance	AS oi	--	131567 ObjInsurance Records
			INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID
		) AS oi
		WHERE ValuationPurposeID = 7
	) AS sq1										-- 104865 INS values
	WHERE RankByDate = 1							--  75808 to mark Current  -- DONE
)
-- (76883 row(s) affected)



--UPDATE ObjInsurance SET IsCurrent = 1 WHERE ObjInsuranceID IN
(
	SELECT ObjInsuranceID FROM 
	(
		SELECT *,
		RANK() OVER(PARTITION BY oi.ObjectID ORDER BY oi.ValueISODate DESC,oi.EnteredDate DESC,oi.ObjInsuranceID DESC) AS RankByDate
		FROM
		(
			SELECT oi.ObjInsuranceID, oi.ObjectID, o.ObjectNumber, oi.ValueISODate, oi.CurrencyValue, oi.EnteredDate, oi.LoginID, oi.IsCurrent, oi.ValuationPurposeID, 
			CASE WHEN oi.ObjectID IN (SELECT ObjectID FROM ObjInsurance GROUP BY ObjectID HAVING COUNT(*) > 1) THEN 1 ELSE 0 END AS GT1
			FROM ObjInsurance	AS oi	--	131567 ObjInsurance Records
			INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID
		) AS oi
		WHERE ValuationPurposeID <> 7				
	) AS sq2										--  26702 NON-INS values
	WHERE GT1 = 0									--   2154 Single NON-INS values			-- DONE
)	
-- (2161 row(s) affected)




--UPDATE ObjInsurance SET IsCurrent = 1 WHERE ObjInsuranceID IN
(
	SELECT ObjInsuranceID FROM 
	(
		SELECT *,
		RANK() OVER(PARTITION BY oi.ObjectID ORDER BY oi.ValueISODate DESC,oi.EnteredDate DESC,oi.ObjInsuranceID DESC) AS RankByDate
		FROM
		(
			SELECT oi.ObjInsuranceID, oi.ObjectID, o.ObjectNumber, oi.ValueISODate, oi.CurrencyValue, oi.EnteredDate, oi.LoginID, oi.IsCurrent, oi.ValuationPurposeID, 
			CASE WHEN oi.ObjectID IN (SELECT ObjectID FROM ObjInsurance GROUP BY ObjectID HAVING COUNT(*) > 1) THEN 1 ELSE 0 END AS GT1
			FROM ObjInsurance	AS oi	--	131567 ObjInsurance Records
			INNER JOIN Objects AS o ON o.ObjectID = oi.ObjectID
		) AS oi
		WHERE ValuationPurposeID <> 7				
	) AS sq2										--  26702 NON-INS values
	WHERE GT1 = 1									--  24548 multiple NON-INS values
	AND ObjectID NOT IN
	(
		SELECT ObjectID FROM ObjInsurance WHERE ValuationPurposeID = 7	--563
	)
	AND RankByDate = 1													--274			-- DONE
)
-- (271 row(s) affected)






















