



-- Update Object Department based on Object Package


SELECT * FROM Packages WHERE Name LIKE 'Cecily Horton Minitaures 10/2/2018'	-- 208655

SELECT * FROM PackageList WHERE PackageID = 208655

SELECT * FROM Departments WHERE Department LIKE 'Deco%'	-- 2


SELECT
o.ObjectID,
o.ObjectNumber,
o.DepartmentID,
d.Department

FROM Objects AS o 
INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

WHERE o.ObjectID IN
(
	SELECT ID FROM PackageList WHERE PackageID = 208655
)

--UPDATE Objects
SET DepartmentID = 2
WHERE ObjectID IN
(
	SELECT ID FROM PackageList WHERE PackageID = 208655
)



SELECT
o.ObjectID,
o.ObjectNumber,
o.DepartmentID,
d.Department

FROM Objects AS o 
INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

WHERE o.GSRowVersion >
(
SELECT MAX(MFAH_DBTS) FROM MFAHt_DBTS
)
AND o.DepartmentID = 2