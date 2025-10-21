




SELECT
*
FROM Constituents
WHERE Approved = 1	--21 rows


--UPDATE Constituents
SET Approved = 0
WHERE Approved = 1		--(21 row(s) affected)



SELECT 
*
FROM Constituents
WHERE IsPrivate = 1		--2 rows

--UPDATE Constituents
SET IsPrivate = 0
WHERE IsPrivate = 1		--(2 row(s) affected)