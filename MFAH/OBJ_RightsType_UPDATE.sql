/*








SELECT * FROM Departments

DepartmentID = 112  -- Asian Art, Glassell Collection, 294 records

SELECT
o.ObjectID,
o.ObjectNumber,
o.DepartmentID,
d.Department

FROM			Objects		AS o
LEFT OUTER JOIN	Departments	AS d	ON o.DepartmentID = d.DepartmentID


SELECT
COUNT(o.ObjectID),
o.DepartmentID,
d.Department
FROM			Objects		AS o
LEFT OUTER JOIN	Departments	AS d	ON o.DepartmentID = d.DepartmentID
GROUP BY o.DepartmentID, d.Department
ORDER BY o.DepartmentID





SELECT * FROM ObjRightsTypes

ObjRightsTypeID = 2  -- Public Domain



SELECT
o.ObjectID,
o.ObjectNumber,
os.ObjectStatus,
--o.DepartmentID,
d.Department,
--ocr.ObjRightsTypeID,
ort.ObjRightsType

FROM			Objects			AS o
LEFT OUTER JOIN	Departments		AS d	ON o.DepartmentID = d.DepartmentID
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID
LEFT OUTER JOIN ObjRightsTypes	AS ort	ON ocr.ObjRightsTypeID = ort.ObjRightsTypeID
LEFT OUTER JOIN ObjectStatuses	AS os	ON o.ObjectStatusID = os.ObjectStatusID

WHERE	o.DepartmentID IN (15,131,111,132,6,134,16,136,113,137,121,138,3,140,1,145,20,156)

AND ocr.ObjRightsTypeID IS NOT NULL AND ocr.ObjRightsTypeID NOT IN(0,2)

ORDER BY ocr.ObjRightsTypeID



SELECT
COUNT(o.ObjectID) AS ObjectID,
d.Department,
os.ObjectStatus,
ocr.ObjRightsTypeID,
ort.ObjRightsType

FROM			Objects			AS o
LEFT OUTER JOIN	Departments		AS d	ON o.DepartmentID = d.DepartmentID
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID
LEFT OUTER JOIN ObjRightsTypes	AS ort	ON ocr.ObjRightsTypeID = ort.ObjRightsTypeID
LEFT OUTER JOIN ObjectStatuses	AS os	ON o.ObjectStatusID = os.ObjectStatusID

WHERE	o.DepartmentID IN (15,131,111,132,6,134,16,136,113,137,121,138,3,140,1,145,20,156)

GROUP BY
d.Department,
os.ObjectStatus,
ocr.ObjRightsTypeID,
ort.ObjRightsType


SELECT
o.ObjectID,
o.ObjectNumber,
ocr.ObjRightsTypeID
FROM			Objects			AS o
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID
WHERE	o.DepartmentID IN (15,131,111,132,6,134,16,136,113,137,121,138,3,140,1,145,20,156)

--UPDATE ObjRights          --344 only.  :(
--SET ObjRightsTypeID = 2
--SELECT
--o.ObjectID,
--ocr.ObjRightsTypeID
FROM			Objects			AS o
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID
WHERE	o.DepartmentID IN (15,131,111,132,6,134,16,136,113,137,121,138,3,140,1,145,20,156) --24438
AND (ObjRightsTypeID IS NULL)




---------------------------------------------------------------------------------------------------------

SELECT
o.ObjectID,
ocr.ObjRightsTypeID
FROM			Objects			AS o
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID
WHERE	o.DepartmentID IN (15,131,111,132,6,134,16,136,113,137,121,138,3,140,1,145,20,156) --24438
AND (ObjRightsTypeID IS NULL)


--INSERT INTO ObjRights (ObjectID, ObjRightsTypeID, LoginID, EnteredDate)
SELECT 
o.ObjectID,
2,
'dthompson',
GETDATE()
FROM			Objects			AS o
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID
WHERE	o.DepartmentID IN (15,131,111,132,6,134,16,136,113,137,121,138,3,140,1,145,20,156) --24438
AND (ObjRightsTypeID IS NULL)


(24093 row(s) affected)
*/






-----------------------------------------------------------------------------Asian Art, Glassell Collection
-----------------------------------------------------------------------------Object Rights Type Update			7/7/2015

SELECT
o.ObjectID,
o.ObjectNumber,
ocr.ObjRightsTypeID
FROM			Objects			AS o
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID
WHERE	o.DepartmentID IN (112)

-- 4 populated, 3 = 2 (Public Domain), 1 = 0 (not entered)

--UPDATE ObjRights          --1 only. 
--SET ObjRightsTypeID = 2
--SELECT
--o.ObjectID,
--ocr.ObjRightsTypeID
FROM			Objects			AS o
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID
WHERE	o.DepartmentID IN (112) --294
AND (ObjRightsTypeID = 0) --1

--(1 row(s) affected)




-----------------------------------------------------------------------------Asian Art, Glassell Collection
-----------------------------------------------------------------------------Object Rights Type INSERT			7/7/2015



SELECT
o.ObjectID,
o.ObjectNumber,
ocr.ObjRightsTypeID
FROM			Objects			AS o
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID
WHERE	o.DepartmentID IN (112)

-- 4 populated,43 = 2 (Public Domain), 290 unpopulated


SELECT
o.ObjectID,
ocr.ObjRightsTypeID
FROM			Objects			AS o
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID
WHERE	o.DepartmentID IN (112)	--294
AND (ObjRightsTypeID IS NULL)	--290


--INSERT INTO ObjRights (ObjectID, ObjRightsTypeID, LoginID, EnteredDate)
SELECT 
o.ObjectID,
2,
'dthompson',
GETDATE()
FROM			Objects			AS o
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID
WHERE	o.DepartmentID IN (112) --294
AND (ObjRightsTypeID IS NULL)	--290

--(290 row(s) affected)




SELECT
o.ObjectID,
o.ObjectNumber,
ocr.ObjRightsTypeID
FROM			Objects			AS o
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID
WHERE	o.DepartmentID IN (112)

-- 294 populated, 294 = 2 (Public Domain)







----------------------------------------------------- UPDATE Status Flags ----------------------------------



SELECT * FROM FlagLabels


SELECT
o.ObjectID,
o.ObjectNumber,
sf.FlagID,
sf.OnOff,
fl.FlagLabel

FROM			Objects			AS o
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID
LEFT OUTER JOIN StatusFlags		AS sf	ON o.ObjectID = sf.ObjectID
LEFT OUTER JOIN FlagLabels		AS fl	ON sf.FlagID = fl.FlagID

WHERE	o.DepartmentID IN (15,131,111,132,6,134,16,136,113,137,121,138,3,140,1,145,20,156) --24438
AND ObjRightsTypeID = 2 
AND sf.FlagID = 1



--INSERT INTO StatusFlags (ObjectID, FlagID, OnOff, LoginID, EnteredDate)
SELECT o.ObjectID, 24, 1, 'dthompson', GETDATE()
FROM			Objects			AS o
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID
WHERE	o.DepartmentID IN (15,131,111,132,6,134,16,136,113,137,121,138,3,140,1,145,20,156) --24439
AND ObjRightsTypeID = 2 







SELECT
o.ObjectID,
o.ObjectNumber,
sf.FlagID,
sf.OnOff,
fl.FlagLabel

--UPDATE StatusFlags  SET OnOff = 0

FROM			Objects			AS o
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID
LEFT OUTER JOIN StatusFlags		AS sf	ON o.ObjectID = sf.ObjectID
LEFT OUTER JOIN FlagLabels		AS fl	ON sf.FlagID = fl.FlagID

WHERE	o.DepartmentID IN (15,131,111,132,6,134,16,136,113,137,121,138,3,140,1,145,20,156) --116
AND ObjRightsTypeID = 2 
AND sf.FlagID = 1





-----------------------------------------------------------------------------Asian Art, Glassell Collection
-----------------------------------------------------------------------------Staus Flag INSERT			7/7/2015



SELECT
o.ObjectID,
o.ObjectNumber,
sf.FlagID,
sf.OnOff,
fl.FlagLabel

FROM			Objects			AS o
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID
LEFT OUTER JOIN StatusFlags		AS sf	ON o.ObjectID = sf.ObjectID
LEFT OUTER JOIN FlagLabels		AS fl	ON sf.FlagID = fl.FlagID

WHERE	o.DepartmentID IN (112) 
AND ObjRightsTypeID = 2 
--AND sf.FlagID = 24 -- 3 records already have this flag ObjectID IN (26509,35633,91831)




--INSERT INTO StatusFlags (ObjectID, FlagID, OnOff, LoginID, EnteredDate)
SELECT DISTINCT o.ObjectID, 24, 1, 'dthompson', GETDATE()
FROM			Objects			AS o
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID
LEFT OUTER JOIN StatusFlags		AS sf	ON o.ObjectID = sf.ObjectID
WHERE	o.DepartmentID IN (112) 
AND ObjRightsTypeID = 2 

--(294 row(s) affected)

--Remove duplicates just created

SELECT * 
--DELETE
FROM StatusFlags WHERE ObjectID IN (26509,35633,91831)
AND FlagID = 24
AND LoginID = 'dthompson'  

---(3 row(s) affected)




-----------------------------------------------------------------------------Update existing ObjRightsType from Package 8/12/2015

SELECT * FROM Packages WHERE Name = 'Artists to be made Public Domain'

--UPDATE Packages 
SET Global = 1 
WHERE PackageID = 17948


SELECT ID FROM PackageList WHERE PackageID = 17948 AND TableID = 108	--3457 objects

SELECT * FROM ObjRightsTypes

--ObjRightsTypeID	ObjRightsType		LoginID		EnteredDate				SysTimeStamp
--0					(not entered)		sa/KEN		1999-02-24 11:28:14.327	0x00000000001DC973
--1					Copyright Protected	dthompson	2014-05-30 10:29:10.240	0x0000000001D62C72
--2					Public Domain		dthompson	2014-05-30 10:30:34.600	0x0000000001D62C73
--3					Orphan				dthompson	2014-05-30 10:30:34.613	0x0000000001D62C74
--4					Needs Research		dthompson	2014-05-30 10:30:34.627	0x0000000001D62C75
--5					Unknown				dthompson	2014-05-30 10:30:34.637	0x0000000001D62C76





SELECT
o.ObjectID,
o.ObjectNumber,
ocr.ObjRightsTypeID

-- 15 populated, 14 = 0 (not entered), 1 = 1 Copyright Protected

--UPDATE ObjRights          --(15 row(s) affected)
--SET ObjRightsTypeID = 2

FROM			Objects			AS o
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID

WHERE	o.ObjectID IN (SELECT ID FROM PackageList WHERE PackageID = 17948 AND TableID = 108) --3457 objects
AND ocr.ObjRightsTypeID IN (0,1) --0 = (not entered), Copyright Protected
--15 rows


-----------------------------------------------------------------------------Insert new ObjRightsType from Package 8/12/2015



SELECT
o.ObjectID,
o.ObjectNumber,
ocr.ObjRightsTypeID
FROM			Objects			AS o
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID
WHERE	o.ObjectID IN (SELECT ID FROM PackageList WHERE PackageID = 17948 AND TableID = 108)


--2		170
--NULL	3287



SELECT
o.ObjectID,
ocr.ObjRightsTypeID
FROM			Objects			AS o
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID
WHERE	o.ObjectID IN (SELECT ID FROM PackageList WHERE PackageID = 17948 AND TableID = 108)
AND (ObjRightsTypeID IS NULL)	--3287


--INSERT INTO ObjRights (ObjectID, ObjRightsTypeID, LoginID, EnteredDate)
SELECT 
o.ObjectID,
2,
'dthompson',
GETDATE()
FROM			Objects			AS o
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID
WHERE	o.ObjectID IN (SELECT ID FROM PackageList WHERE PackageID = 17948 AND TableID = 108)
AND (ObjRightsTypeID IS NULL)	--3287

--(3287 row(s) affected)




SELECT
o.ObjectID,
o.ObjectNumber,
ocr.ObjRightsTypeID
FROM			Objects			AS o
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID
WHERE	o.ObjectID IN (SELECT ID FROM PackageList WHERE PackageID = 17948 AND TableID = 108)

-- 294 populated, 294 = 2 (Public Domain)


--2		3457



-----------------------------------------------------------------------------Staus Flag INSERT from Package 8/12/2015




SELECT
o.ObjectID,
o.ObjectNumber,
sf.FlagID,
sf.OnOff,
fl.FlagLabel

FROM			Objects			AS o
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID
LEFT OUTER JOIN StatusFlags		AS sf	ON o.ObjectID = sf.ObjectID
LEFT OUTER JOIN FlagLabels		AS fl	ON sf.FlagID = fl.FlagID

WHERE	o.ObjectID IN (SELECT ID FROM PackageList WHERE PackageID = 17948 AND TableID = 108)
AND ObjRightsTypeID = 2 AND (sf.FlagID <> 24 OR sf.FlagID IS NULL)





--INSERT INTO StatusFlags (ObjectID, FlagID, OnOff, LoginID, EnteredDate)
SELECT DISTINCT o.ObjectID, 24, 1, 'dthompson', GETDATE()
FROM			Objects			AS o
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID
LEFT OUTER JOIN StatusFlags		AS sf	ON o.ObjectID = sf.ObjectID
LEFT OUTER JOIN FlagLabels		AS fl	ON sf.FlagID = fl.FlagID
WHERE	o.ObjectID IN (SELECT ID FROM PackageList WHERE PackageID = 17948 AND TableID = 108)
AND ObjRightsTypeID = 2 AND (sf.FlagID <> 24 OR sf.FlagID IS NULL)

--(294 row(s) affected)

--Remove duplicates just created

SELECT * 
--DELETE
FROM StatusFlags WHERE ObjectID IN (SELECT ID FROM PackageList WHERE PackageID = 17948 AND TableID = 108)
AND FlagID = 24
--3463

SELECT ObjectID
FROM StatusFlags
WHERE  ObjectID IN (SELECT ID FROM PackageList WHERE PackageID = 17948 AND TableID = 108)
AND FlagID = 24
GROUP BY ObjectID 
HAVING COUNT(ObjectID) > 1


--DELETE FROM StatusFlags WHERE StatusFlagID IN
(

SELECT StatusFlagID FROM StatusFlags WHERE ObjectID IN
(39,1186,1548,2676,11588,11589)

AND LoginID = 'dthompson'
AND EnteredDate > '2015-08-12'

)


SELECT * FROM StatusFlags
WHERE  ObjectID IN (SELECT ID FROM PackageList WHERE PackageID = 17948 AND TableID = 108)
AND FlagID = 24

--3457

--DONE







