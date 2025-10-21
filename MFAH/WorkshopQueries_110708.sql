SELECT DISTINCT a0108.ObjectID, a0108.ObjectNumber, a0108.DepartmentID SecurityCategoryID, a0108.SortNumber 
FROM [TMS]..Objects a0108
INNER JOIN [TMS]..Departments a0108a0039 ON a0108.DepartmentID = a0108a0039.DepartmentID
INNER JOIN [TMS]..Classifications a0108a0010 ON a0108.ClassificationID = a0108a0010.ClassificationID
WHERE ((a0108.ObjectID > -1 AND (a0108a0039.DepartmentID = 9 AND a0108a0010.ClassificationID = 6 AND a0108.DateBegin >= 1495 AND a0108.DateEnd <= 1605) AND a0108.ObjectStatusID = 2 AND a0108.IsVirtual = 0) AND a0108.IsTemplate = 0)
ORDER BY a0108.SortNumber ASC


SELECT DISTINCT a0108.ObjectID, a0108.ObjectNumber, a0108.DepartmentID SecurityCategoryID, a0108.SortNumber 
FROM [TMS]..Objects a0108
INNER JOIN [TMS]..ConXrefs a0108a0222 ON a0108.ObjectID = a0108a0222.ID
INNER JOIN [TMS]..Roles a0108a0222a0149 ON a0108a0222.RoleID = a0108a0222a0149.RoleID
WHERE ((a0108.ObjectID > -1 AND (a0108a0222a0149.Role = 'Donor') AND a0108.IsVirtual = 0) AND a0108.IsTemplate = 0 AND a0108a0222a0149.RoleTypeID = 2)
ORDER BY a0108.SortNumber ASC



--without parenthesis
SELECT DISTINCT a0108.ObjectID, a0108.ObjectNumber, a0108.DepartmentID SecurityCategoryID, a0108.SortNumber 
FROM [TMS]..Objects a0108
INNER JOIN [TMS]..Departments a0108a0039 ON a0108.DepartmentID = a0108a0039.DepartmentID
INNER JOIN [TMS]..ConXrefs a0108a0222 ON a0108.ObjectID = a0108a0222.ID
INNER JOIN [TMS]..Constituents a0108a0222a0023 ON a0108a0222.ConstituentID = a0108a0222a0023.ConstituentID
INNER JOIN [TMS]..Roles a0108a0222a0149 ON a0108a0222.RoleID = a0108a0222a0149.RoleID
INNER JOIN [TMS]..ObjAccession a0108a0089 ON a0108.ObjectID = a0108a0089.ObjectID
WHERE 
(
	(a0108.ObjectID > -1 AND 
		(a0108a0039.DepartmentID = 20 OR a0108a0039.DepartmentID = 2 AND 
			(a0108a0222a0023.DisplayName LIKE '%night%' OR a0108a0222a0023.DisplayName LIKE '%great%')
		 AND a0108a0089.AccessionISODate >= '2000-01-01' AND a0108a0222a0149.Role = 'Event')
	 AND a0108.IsVirtual = 0)
AND a0108.IsTemplate = 0 AND a0108a0222a0149.RoleTypeID = 2)
	  
ORDER BY a0108.SortNumber ASC


--with parenthesis
SELECT DISTINCT a0108.ObjectID, a0108.ObjectNumber, a0108.DepartmentID AS SecurityCategoryID, a0108.SortNumber
FROM         Objects AS a0108 INNER JOIN
                      Departments AS a0108a0039 ON a0108.DepartmentID = a0108a0039.DepartmentID INNER JOIN
                      ConXrefs AS a0108a0222 ON a0108.ObjectID = a0108a0222.ID INNER JOIN
                      Constituents AS a0108a0222a0023 ON a0108a0222.ConstituentID = a0108a0222a0023.ConstituentID INNER JOIN
                      Roles AS a0108a0222a0149 ON a0108a0222.RoleID = a0108a0222a0149.RoleID INNER JOIN
                      ObjAccession AS a0108a0089 ON a0108.ObjectID = a0108a0089.ObjectID
WHERE     (a0108.ObjectID > - 1) AND (a0108a0039.DepartmentID = 20 OR
                      a0108a0039.DepartmentID = 2) AND (a0108a0222a0023.DisplayName LIKE '%night%' OR
                      a0108a0222a0023.DisplayName LIKE '%great%') AND (a0108a0089.AccessionISODate >= '2000-01-01') AND (a0108a0222a0149.Role = 'Event') AND 
                      (a0108.IsVirtual = 0) AND (a0108.IsTemplate = 0) AND (a0108a0222a0149.RoleTypeID = 2)
ORDER BY a0108.SortNumber


--second try  (dept and dept)
SELECT DISTINCT a0108.ObjectID, a0108.ObjectNumber, a0108.DepartmentID SecurityCategoryID, a0108.SortNumber 
FROM [TMS]..Objects a0108
INNER JOIN [TMS]..Departments a0108a0039 ON a0108.DepartmentID = a0108a0039.DepartmentID
INNER JOIN [TMS]..ConXrefs a0108a0222 ON a0108.ObjectID = a0108a0222.ID
INNER JOIN [TMS]..Roles a0108a0222a0149 ON a0108a0222.RoleID = a0108a0222a0149.RoleID
INNER JOIN [TMS]..Constituents a0108a0222a0023 ON a0108a0222.ConstituentID = a0108a0222a0023.ConstituentID
INNER JOIN [TMS]..ObjAccession a0108a0089 ON a0108.ObjectID = a0108a0089.ObjectID
WHERE ((a0108.ObjectID > -1 AND ((a0108a0039.DepartmentID = 20 AND a0108a0039.DepartmentID = 2) AND a0108a0222a0149.Role = 'Event' AND (a0108a0222a0023.DisplayName LIKE '%night%' OR a0108a0222a0023.DisplayName LIKE '%great%') AND a0108a0089.AccessionISODate >= '2000-01-01') AND a0108.IsVirtual = 0) AND a0108.IsTemplate = 0 AND a0108a0222a0149.RoleTypeID = 2)
ORDER BY a0108.SortNumber ASC

--third try  (dept and dept)
SELECT DISTINCT a0108.ObjectID, a0108.ObjectNumber, a0108.DepartmentID SecurityCategoryID, a0108.SortNumber 
FROM [TMS]..Objects a0108
INNER JOIN [TMS]..Departments a0108a0039 ON a0108.DepartmentID = a0108a0039.DepartmentID
INNER JOIN [TMS]..ConXrefs a0108a0222 ON a0108.ObjectID = a0108a0222.ID
INNER JOIN [TMS]..Roles a0108a0222a0149 ON a0108a0222.RoleID = a0108a0222a0149.RoleID
INNER JOIN [TMS]..Constituents a0108a0222a0023 ON a0108a0222.ConstituentID = a0108a0222a0023.ConstituentID
INNER JOIN [TMS]..ObjAccession a0108a0089 ON a0108.ObjectID = a0108a0089.ObjectID
WHERE ((a0108.ObjectID > -1 AND ((a0108a0039.DepartmentID = 20 AND a0108a0039.DepartmentID = 2) AND a0108a0222a0149.Role = 'Event' AND (a0108a0222a0023.DisplayName LIKE '%night%' OR a0108a0222a0023.DisplayName LIKE '%great%') AND a0108a0089.AccessionISODate >= '2000-01-01') AND a0108.IsVirtual = 0) AND a0108.IsTemplate = 0 AND a0108a0222a0149.RoleTypeID = 2)
ORDER BY a0108.SortNumber ASC

--fourth try  (dept or dept)
SELECT DISTINCT a0108.ObjectID, a0108.ObjectNumber, a0108.DepartmentID SecurityCategoryID, a0108.SortNumber 
FROM [TMS]..Objects a0108
INNER JOIN [TMS]..Departments a0108a0039 ON a0108.DepartmentID = a0108a0039.DepartmentID
INNER JOIN [TMS]..ConXrefs a0108a0222 ON a0108.ObjectID = a0108a0222.ID
INNER JOIN [TMS]..Roles a0108a0222a0149 ON a0108a0222.RoleID = a0108a0222a0149.RoleID
INNER JOIN [TMS]..Constituents a0108a0222a0023 ON a0108a0222.ConstituentID = a0108a0222a0023.ConstituentID
INNER JOIN [TMS]..ObjAccession a0108a0089 ON a0108.ObjectID = a0108a0089.ObjectID
WHERE ((a0108.ObjectID > -1 AND ((a0108a0039.DepartmentID = 20 OR a0108a0039.DepartmentID = 2) AND a0108a0222a0149.Role = 'Event' AND (a0108a0222a0023.DisplayName LIKE '%night%' OR a0108a0222a0023.DisplayName LIKE '%great%') AND a0108a0089.AccessionISODate >= '2000-01-01') AND a0108.IsVirtual = 0) AND a0108.IsTemplate = 0 AND a0108a0222a0149.RoleTypeID = 2)
ORDER BY a0108.SortNumber ASC




--Prints and Drawings
SELECT DISTINCT a0108.ObjectID, a0108.ObjectNumber, a0108.DepartmentID SecurityCategoryID, a0108.SortNumber 
FROM [TMS]..Objects a0108
INNER JOIN [TMS]..Departments a0108a0039 ON a0108.DepartmentID = a0108a0039.DepartmentID
INNER JOIN [TMS]..ObjAccession a0108a0089 ON a0108.ObjectID = a0108a0089.ObjectID
WHERE ((a0108.ObjectID > -1 AND (a0108a0039.DepartmentID = 9 AND a0108a0089.AccessionISODate >= '2010-07-01') AND a0108.ObjectStatusID = 2 AND a0108.IsVirtual = 0) AND a0108.IsTemplate = 0)
ORDER BY a0108.SortNumber ASC


--constituent b.date >= 1950
SELECT DISTINCT a0108.ObjectID, a0108.ObjectNumber, a0108.DepartmentID SecurityCategoryID, a0108.SortNumber 
FROM [TMS]..Objects a0108
INNER JOIN [TMS]..Classifications a0108a0010 ON a0108.ClassificationID = a0108a0010.ClassificationID
INNER JOIN [TMS]..ConXrefs a0108a0327 ON a0108.ObjectID = a0108a0327.ID
INNER JOIN [TMS]..Constituents a0108a0327a0023 ON a0108a0327.ConstituentID = a0108a0327a0023.ConstituentID
WHERE ((a0108.ObjectID > -1 AND (a0108a0010.ClassificationID = 1 AND a0108a0327a0023.BeginDate >= 1950) AND a0108.IsVirtual = 0) AND a0108.IsTemplate = 0 AND a0108a0327.TableID = 108)
ORDER BY a0108.SortNumber ASC

--constiuent object b.date >= 1971
SELECT DISTINCT a0108.ObjectID, a0108.ObjectNumber, a0108.DepartmentID SecurityCategoryID, a0108.SortNumber 
FROM [TMS]..Objects a0108
INNER JOIN [TMS]..Classifications a0108a0010 ON a0108.ClassificationID = a0108a0010.ClassificationID
INNER JOIN [TMS]..ConXrefs a0108a0184 ON a0108.ObjectID = a0108a0184.ID
INNER JOIN [TMS]..Constituents a0108a0184a0023 ON a0108a0184.ConstituentID = a0108a0184a0023.ConstituentID
INNER JOIN [TMS]..Roles a0108a0184a0149 ON a0108a0184.RoleID = a0108a0184a0149.RoleID
WHERE ((a0108.ObjectID > -1 AND (a0108a0010.ClassificationID = 1 AND a0108a0184a0023.BeginDate >= 1971) AND a0108.IsVirtual = 0) AND a0108.IsTemplate = 0 AND a0108a0184a0149.RoleTypeID = 1)
ORDER BY a0108.SortNumber ASC
