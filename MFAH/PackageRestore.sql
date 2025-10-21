/*

--------------------------------------------------------------------------------------------GO TO START BELOW

SELECT * FROM TMS.dbo.Packages WHERE Owner = 'rdunham'

SELECT * FROM TMS.dbo.PackageList WHERE PackageID IN
(SELECT PackageID FROM TMS.dbo.Packages WHERE Owner = 'cstrauss' AND PackageID = 17297)



INSERT INTO TMS.dbo.Packages
SELECT 
Name,
Notes,
Owner,
PackageType,
Global,
Locked,
BitmapName,
LoginID,
EnteredDate,
PublicAccess,
MoveAssistant,
DisplayRecID,
TableID
FROM TMS_150330_1500.dbo.Packages WHERE Owner = 'rdunham' AND PackageID = 12048

SELECT * FROM TMS_150415_0900.dbo.Packages WHERE Owner = 'relliot'



INSERT INTO TMS.dbo.PackageList
(PackageID, ID, MainData, OrderPos, LoginID, EnteredDate, Notes, TableID)
SELECT
17297,
ID,
MainData,
OrderPos,
LoginID,
EnteredDate,
Notes,
TableID
FROM TMS_150330_1500.dbo.PackageList WHERE PackageID = 13464



SELECT * FROM TMS_150330_1500.dbo.PackageList WHERE PackageID = 13464



---------------------------------------------------------------------------------------------------


INSERT INTO TMS.dbo.Packages
SELECT PackageID,
Name,
Notes,
Owner,
PackageType,
Global,
Locked,
BitmapName,
LoginID,
EnteredDate,
PublicAccess,
MoveAssistant,
DisplayRecID,
TableID
FROM TMS_150330_1500.dbo.Packages WHERE Owner = 'rdunham' AND PackageID IN
(
12048,
7365,
7367,
8595,
8619,
8873,
9200,
12339,
12466,
12468,
12527,
12706,
12901,
13373,
13421,
13431,
13474,
13681,
13682,
13687,
13756,
13826,
13941,
13959,
14016,
14516,
14537,
14557,
14559,
14624,
14626,
14677,
7315,
7498,
7517,
7655,
7671,
7702,
7756,
7785,
8069,
8070,
8073,
8286,
8339,
8489,
8618,
8621,
8847,
8851,
8917,
8983,
8984,
9246,
9660,
9661,
9797,
9798,
10315,
10368,
10370,
10379,
10393,
10397,
10481,
10510,
10516,
10756,
10974,
11151,
11353,
11481,
11512,
11567,
11568,
11595,
11596,
11966,
11998,
12030,
12036,
12043,
12132,
12179,
12229,
12246,
12584,
12760,
12762,
12869,
12884,
12978,
13005,
13006,
13007,
13016,
13102,
13108,
13252,
13352,
13401,
13491,
13493,
13494,
13518,
13530,
13531,
13572,
13593,
13602,
13624,
13626,
13866,
13946,
13950,
13964,
13965,
13982,
14034,
14051,
14099,
14129,
14155,
14334,
14411,
14472,
14545,
14627,
14723
)

SELECT * FROM TMS.dbo.Packages WHERE Owner = 'rdunham'





SELECT 
p.PackageID,
p.Name,
pr.OLDPackageID,
pl.*

FROM TMS.dbo.Packages AS p
INNER JOIN TMS.dbo.PackageRestore AS pr ON p.PackageID = pr.NEWPackageID
INNER JOIN TMS_150330_1500.dbo.PackageList AS pl ON pr.OldPackageID = pl.PackageID





--INSERT INTO TMS.dbo.PackageList
(PackageID, ID, MainData, OrderPos, LoginID, EnteredDate, Notes, TableID)
SELECT
p.PackageID, --pr.OLDPackageID,
pl.ID,
pl.MainData,
pl.OrderPos,
pl.LoginID,
pl.EnteredDate,
pl.Notes,
pl.TableID
FROM TMS.dbo.Packages AS p
INNER JOIN TMS.dbo.PackageRestore AS pr ON p.PackageID = pr.NEWPackageID
INNER JOIN TMS_150330_1500.dbo.PackageList AS pl ON pr.OldPackageID = pl.PackageID





--UPDATE Packages
SET Owner = 'lrosenblum'
WHERE Owner = 'rdunham'




SELECT * FROM TMS.dbo.Packages WHERE Owner = 'jsawhill'

---------------------------------------------------------------------------------------------------


SELECT * FROM Packages WHERE Owner = 'mmckee'

--DELETE FROM Packages WHERE Owner = 'mcramirez'



--DELETE FROM Packages WHERE PackageID IN
(
16710
)
---------------------------------------------------------------------------------------------------


--SELECT * FROM TMS_150330_1500.dbo.Packages WHERE PackageID IN

--INSERT INTO TMS.dbo.Packages
SELECT --PackageID,
Name,
Notes,
Owner,
PackageType,
Global,
Locked,
BitmapName,
LoginID,
EnteredDate,
PublicAccess,
MoveAssistant,
DisplayRecID,
TableID

FROM TMS_150330_1500.dbo.Packages WHERE PackageID IN
(
9516,
9857,
10706,
10849,
10852,
10857,
10858,
10871,
10874,
10879,
10886,
11005,
11092,
11098,
11108,
11308,
11309,
11668,
11672
)


SELECT * FROM Packages WHERE Owner = 'jsawhill'


--INSERT INTO TMS.dbo.PackageList
(PackageID, ID, MainData, OrderPos, LoginID, EnteredDate, Notes, TableID)
SELECT
17559,
ID,
MainData,
OrderPos,
LoginID,
EnteredDate,
Notes,
TableID
FROM TMS_150330_1500.dbo.PackageList WHERE PackageID = 11672


*/



--------------------------------------------------------------------------------------------START

SELECT * FROM TMS.dbo.Packages WHERE LoginID = 'ajiang'	-- 0
SELECT * FROM TMS.dbo.Packages WHERE Owner = 'ajiang'	-- 0



SELECT * FROM TMS_150330_1500.dbo.Packages WHERE LoginID = 'ajiang'		-- 26 Packages

--INSERT INTO TMS.dbo.Packages
SELECT --PackageID,
CASE WHEN Name IN ('P&D IMLS Batch 3','P&D IMLS Batch 4') THEN Name + ' - AJ' ELSE Name END,  --There were duplicate package names
Notes,
Owner,
PackageType,
Global,
Locked,
BitmapName,
LoginID,
EnteredDate,
PublicAccess,
MoveAssistant,
DisplayRecID,
TableID
FROM TMS_150330_1500.dbo.Packages WHERE LoginID = 'ajiang'		-- (26 row(s) affected)



SELECT * FROM TMS.dbo.Packages WHERE LoginID = 'ajiang'	-- 26 Packages
ORDER BY PackageID DESC


--  COPIED old Package IDs and Names to XL spreadsheet, then copied new Package IDs and Names to same spreadsheet
--  Then copied spreadsheet data into TMS.dbo.PackageRestore
--	This maps the old IDs to the new IDs.


--	Check package object counts
SELECT PackageID, COUNT(*) FROM TMS_150330_1500.dbo.PackageList WHERE LoginID = 'ajiang' GROUP BY PackageID ORDER BY PackageID DESC




--INSERT INTO TMS.dbo.PackageList												(2199 row(s) affected)
(PackageID, ID, MainData, OrderPos, LoginID, EnteredDate, Notes, TableID)
SELECT																			--2199 selected
p.PackageID, --pr.OLDPackageID,
pl.ID,
pl.MainData,
pl.OrderPos,
pl.LoginID,
pl.EnteredDate,
pl.Notes,
pl.TableID
FROM TMS.dbo.Packages AS p
INNER JOIN TMS.dbo.PackageRestore AS pr ON p.PackageID = pr.NEWPackageID
INNER JOIN TMS_150330_1500.dbo.PackageList AS pl ON pr.OldPackageID = pl.PackageID


--	Check package object counts
SELECT PackageID, COUNT(*) FROM TMS.dbo.PackageList WHERE LoginID = 'ajiang' GROUP BY PackageID ORDER BY PackageID DESC


--	Change owner from ajiang to lrosenblum

--UPDATE Packages				-- (26 row(s) affected)
SET Owner = 'lrosenblum'
WHERE Owner = 'ajiang'



--	Deleted unwanted packages
--DELETE FROM Packages
WHERE PackageID IN
(
17883,
17882,
17881,
17880,
17879,
17868
)

--(227 row(s) affected)		Package-Objects

--(6 row(s) affected)		Packages


--------------------------------------------------------------------------------------------FINISH