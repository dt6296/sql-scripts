


USE OCM_Staging
SELECT DisplayNameDate, ObjectCount, LastName, FirstName FROM Constituent WHERE DisplayName LIKE '%Cunningham%'
UNION
SELECT DisplayNameDate, ObjectCount, LastName, FirstName  FROM Constituent WHERE DisplayName LIKE '%Rovner%'
UNION
SELECT DisplayNameDate, ObjectCount, LastName, FirstName  FROM Constituent WHERE DisplayName LIKE '%Kuhn%'
UNION
SELECT DisplayNameDate, ObjectCount, LastName, FirstName  FROM Constituent WHERE DisplayName LIKE '%Lisette%'
UNION
SELECT DisplayNameDate, ObjectCount, LastName, FirstName  FROM Constituent WHERE DisplayName LIKE '%Misrach%'
ORDER BY LastName, FirstName




USE TMS
SELECT c_DisplayName, COUNT(DISTINCT o_ObjectID)
FROM MFAHv_OBJ_Constituent AS oc
INNER JOIN MFAHv_OBJ AS o ON oc.o_ObjectID = o.ObjectID
WHERE 
(
c_DisplayName LIKE '%Cunningham%' OR
c_DisplayName LIKE '%Rovner%' OR
c_DisplayName LIKE '%Kuhn%' OR
c_DisplayName LIKE '%Lisette%' OR
c_DisplayName LIKE '%Misrach%'
)
AND cx_RoleTypeID = 1		-- Object-Related Constituents
AND o.ObjectStatusID = 2	-- Accessioned Objects
AND o.WebsiteApproved = 1	-- Approved for Website
GROUP BY c_DisplayName,can_LastName,can_FirstName
ORDER BY can_LastName,can_FirstName




USE TMS
SELECT COUNT(DISTINCT o.ObjectID),c.DisplayName
FROM Objects AS o
INNER JOIN ConXrefs AS cx ON cx.ID = o.ObjectID AND cx.TableID = 108
INNER JOIN ConXrefDetails AS cxd ON cx.ConXrefID = cxd.ConXrefID
INNER JOIN Constituents AS c ON cxd.ConstituentID = c.ConstituentID
WHERE cx.RoleTypeID = 1		-- Object-Related Constituents
AND o.ObjectStatusID = 2	-- Accessioned Objects
AND o.PublicAccess = 1		-- Approved for Web
AND
(
c.DisplayName LIKE '%Cunningham%' OR
c.DisplayName LIKE '%Rovner%' OR
c.DisplayName LIKE '%Kuhn%' OR
c.DisplayName LIKE '%Lisette%' OR
c.DisplayName LIKE '%Misrach%'
)
GROUP BY c.DisplayName,c.LastName,c.FirstName
ORDER BY c.LastName,c.FirstName


--------------------------------- ON MFAH-SQL3 ---------------------------------------------------



-- By Constituent

USE OCM
SELECT DisplayNameDate, ObjectCount, LastName, FirstName FROM Constituent WHERE DisplayName LIKE '%Cunningham%'
UNION
SELECT DisplayNameDate, ObjectCount, LastName, FirstName  FROM Constituent WHERE DisplayName LIKE '%Rovner%'
UNION
SELECT DisplayNameDate, ObjectCount, LastName, FirstName  FROM Constituent WHERE DisplayName LIKE '%Heinrich%'
UNION
SELECT DisplayNameDate, ObjectCount, LastName, FirstName  FROM Constituent WHERE DisplayName LIKE '%Lisette%'
UNION
SELECT DisplayNameDate, ObjectCount, LastName, FirstName  FROM Constituent WHERE DisplayName LIKE '%Misrach%'
ORDER BY LastName, FirstName



-- By ObjectMaker

USE OCM
SELECT COUNT(*), DisplayName FROM ObjectMaker WHERE DisplayName LIKE '%Cunningham%' GROUP BY DisplayName 
UNION
SELECT COUNT(*), DisplayName FROM ObjectMaker WHERE DisplayName LIKE '%Rovner%' GROUP BY DisplayName 
UNION
SELECT COUNT(*), DisplayName FROM ObjectMaker WHERE DisplayName LIKE '%Heinrich%' GROUP BY DisplayName 
UNION
SELECT COUNT(*), DisplayName FROM ObjectMaker WHERE DisplayName LIKE '%Lisette%' GROUP BY DisplayName 
UNION
SELECT COUNT(*), DisplayName FROM ObjectMaker WHERE DisplayName LIKE '%Misrach%' GROUP BY DisplayName 
ORDER BY DisplayName


-- By ConstituentName

USE OCM
SELECT COUNT(*), om.DisplayName FROM ConstituentName AS cn INNER JOIN ObjectMaker AS om ON cn.NameID = om.NameID WHERE om.DisplayName LIKE '%Cunningham%' GROUP BY om.DisplayName
UNION
SELECT COUNT(*), om.DisplayName FROM ConstituentName AS cn INNER JOIN ObjectMaker AS om ON cn.NameID = om.NameID WHERE om.DisplayName LIKE '%Rovner%' GROUP BY om.DisplayName
UNION
SELECT COUNT(*), om.DisplayName FROM ConstituentName AS cn INNER JOIN ObjectMaker AS om ON cn.NameID = om.NameID WHERE om.DisplayName LIKE '%Heinrich%' GROUP BY om.DisplayName
UNION
SELECT COUNT(*), om.DisplayName FROM ConstituentName AS cn INNER JOIN ObjectMaker AS om ON cn.NameID = om.NameID WHERE om.DisplayName LIKE '%Lisette%' GROUP BY om.DisplayName
UNION
SELECT COUNT(*), om.DisplayName FROM ConstituentName AS cn INNER JOIN ObjectMaker AS om ON cn.NameID = om.NameID WHERE om.DisplayName LIKE '%Misrach%' GROUP BY om.DisplayName
ORDER BY om.DisplayName


