



--	Object Packages
---------------------------------------------------------------------------------------------------


/*
SELECT
p.*
FROM Packages AS p
WHERE p.Name LIKE '%P&D%'
ORDER BY p.Name
*/
---------------------------------------------------------------------------------------------------

--Objects in TMS Data Cleanup (packages submitted by Curatorial)

SELECT
pl.PackageListID,
p.PackageType,
pl.PackageID,
p.Name,
p.Notes,
p.Owner,
p.EnteredDate,
pl.ID,
pl.MainData

FROM PackageList AS pl
INNER JOIN Packages AS p ON pl.PackageID = p.PackageID

WHERE pl.TableID = 108
AND pl.PackageID IN
(
	14402,
	12200,
	14594,
	14616,
	14617,
	14618,
	14543,
	14614,
	14613,
	15064,
	15065,
	15071,
	14793,
	14795,
	14559
)


---------------------------------------------------------------------------------------------------

SELECT *
FROM Packages

--UPDATE Packages
--SET Notes = 'TMS Data Cleanup - Stage 1'
WHERE PackageID IN
(
14402,
12200,
14594,
14616,
14617,
14618,
14543,
14614,
14613
)

SELECT *
FROM Packages

--UPDATE Packages
--SET Notes = 'TMS Data Cleanup - Stage 2'
WHERE PackageID IN
(
15064,
15065,
15071,
14793,
14795,
14559
)


---------------------------------------------------------------------------------------------------


SELECT * FROM FlagLabels WHERE FlagID IN (20,21)
-- 20 = Website I
-- 21 = Website II
-- 19 = For Website




SELECT sf.* FROM StatusFlags AS sf WHERE sf.LoginID = 'dthompson'


SELECT
pl.PackageListID,
pl.PackageID,
pl.ID,
pl.MainData

FROM PackageList AS pl

WHERE pl.TableID = 108
AND pl.PackageID IN
(
	14402,
	12200,
	14594,
	14616,
	14617,
	14618,
	14543,
	14614,
	14613
)

--Insert Status Flag for Stage I Objects

--INSERT StatusFlags (ObjectID, FlagID, OnOff, LoginID)
SELECT
ID			AS ObjectID,
20			AS	FlagID,
1			AS OnOff,
'dthompson'	AS LoginID

FROM PackageList
WHERE TableID = 108
AND PackageID IN		--4850 records
(
	14402,
	12200,
	14594,
	14616,
	14617,
	14618,
	14543,
	14614,
	14613
)
--(4850 row(s) affected)



--Insert Status Flag for Stage II Objects

--INSERT StatusFlags (ObjectID, FlagID, OnOff, LoginID)
SELECT
ID			AS ObjectID,
21			AS	FlagID,
1			AS OnOff,
'dthompson'	AS LoginID

FROM PackageList
WHERE TableID = 108
AND PackageID IN		--7984 records
(
	15064,
	15065,
	15071,
	14793,
	14795,
	14559
)
--(7984 row(s) affected)




--Double-check work

SELECT
pl.PackageListID,
p.PackageType,
pl.PackageID,
p.Name,
p.Notes,
p.Owner,
p.EnteredDate,
pl.ID,
pl.MainData,
o.ObjectNumber,
sf.FlagID,
fl.FlagLabel

FROM PackageList		AS pl
INNER JOIN Packages		AS p	ON pl.PackageID = p.PackageID
INNER JOIN Objects		AS o	ON pl.ID = o.ObjectID
INNER JOIN StatusFlags	AS sf	ON o.ObjectID = sf.ObjectID AND sf.FlagID IN (21,20)
INNER JOIN FlagLabels	AS fl	ON sf.FlagID = fl.FlagID

WHERE pl.TableID = 108
AND pl.PackageID IN
(
	14402,
	12200,
	14594,
	14616,
	14617,
	14618,
	14543,
	14614,
	14613,
	15064,
	15065,
	15071,
	14793,
	14795,
	14559
)


SELECT COUNT(*), ObjectID 
FROM StatusFlags 
WHERE FlagID IN (20,21) 
GROUP BY ObjectID HAVING COUNT(*)>1

--69.23 is in two packages, 3 or 4 others just had duplicates, I fixed through UI.



SELECT * FROM StatusFlags WHERE FlagID = 19 -- 4681 records

--UPDATE StatusFlags
SET OnOff = 0
WHERE FlagID = 19

--(4861 row(s) affected)


--DELETE FROM StatusFlags
WHERE FlagID = 19

--(4861 row(s) affected)