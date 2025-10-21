SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

WITH myCTE
AS
(
	SELECT 1 AS Level, parent.HierarchyID, parent.ParentID
	FROM DDHierarchy AS parent
	WHERE parent.ParentID IS NULL
	
	UNION ALL
	
	SELECT rCTE.Level + 1 AS Level, child.HierarchyID, child.ParentID
	FROM DDHierarchy AS child
	INNER JOIN myCTE AS rCTE ON child.ParentID = rCTE.HierarchyID
	WHERE child.ParentID IS NOT NULL
)
SELECT myCTE.* FROM myCTE
INNER JOIN myCTE AS rCTE ON myCTE.HierarchyID = rCTE.ParentID

AND myCTE.HierarchyID = 163 




, SecurityData.*  FROM myCTE

INNER JOIN
(
SELECT  
sghx.SecurityGroupID,
sg.SecurityGroup,
m.ModuleID,
m.MainTableID,
mt.TableName AS Module,
lmn.ModuleLabel,
sghx.HierarchyID AS HID,
lhn.HierarchyLabel,
h.TableID,
h.HierarchyRoot,
h.ParentID AS PID,
t.TableName AS [Table],
ltn.TableLabel,
sghx.Addable,
sghx.Deletable,
sghx.Editable,
sghx.Viewable,
h.ShowInHierView

FROM SecGrpHierXref AS sghx			--1,944,045 records
LEFT OUTER JOIN SecurityGroups AS sg ON sghx.SecurityGroupID = sg.SecurityGroupID
LEFT OUTER JOIN DDHierarchy AS h ON sghx.HierarchyID = h.HierarchyID
LEFT OUTER JOIN DDLocalHierNames AS lhn ON h.HierarchyID = lhn.HierarchyID
LEFT OUTER JOIN DDTables AS t ON h.TableID = t.TableID
LEFT OUTER JOIN	DDLocalTableNames AS ltn ON t.TableID = ltn.TableID
LEFT OUTER JOIN DDModules AS m ON t.ModuleType = m.ModuleID
LEFT OUTER JOIN DDLocalModuleNames AS lmn ON m.ModuleID = lmn.ModuleID
LEFT OUTER JOIN DDTables AS mt ON m.MainTableID = mt.TableID

WHERE sghx.SecurityGroupID = 53  --@SecurityGroup

--AND ltn.TableLabel = 'Loans'
/*
AND h.HierarchyRoot IN
(
	SELECT HierarchyRoot FROM DDHierarchy 
	WHERE LEFT(HierarchyRoot,5) IN 
	(
		SELECT 'a00' + CAST(TableID AS VARCHAR(3)) FROM DDHierarchy
		WHERE ParentID IS NULL))

-- I THINK I NEED A FUNCTION FOR THIS.
-- I think this is in the right direction, but the TableLable throws things off.
-- I now think I have to deal with the recursive relationships.  :(
*/

AND (lmn.LanguageID = 1 OR lmn.LanguageID IS NULL)
AND (lhn.LanguageID = 1 OR lhn.LanguageID IS NULL)
AND (ltn.LanguageID = 1 OR ltn.LanguageID IS NULL)
)
AS SecurityData ON SecurityData.HID = myCTE.HierarchyID



/*

SELECT h.HierarchyRoot
FROM DDHierarchy AS h
WHERE h.HierarchyRoot IN
(
	SELECT HierarchyRoot FROM DDHierarchy
	--WHERE HierarchyRoot LIKE (SELECT ('a00' + CAST(81 AS VARCHAR(3))) '%')	--	22
	--WHERE HierarchyRoot LIKE 'a0081%'											--	4090
	WHERE LEFT(HierarchyRoot,5) LIKE (SELECT ('a00' + CAST(81 AS VARCHAR(3))))	--	4090 !!!
)


SELECT h.HierarchyRoot
FROM DDHierarchy AS h
WHERE h.HierarchyRoot IN
(
	SELECT HierarchyRoot FROM DDHierarchy 
	WHERE LEFT(HierarchyRoot,5) LIKE (SELECT 'a00' + CAST(TableID AS VARCHAR(3)) ))		-- 99 (tables 23, 47, and 81)



--  ************************  !!!!!!!!!!!!!!!!   *****************

SELECT h.HierarchyRoot
FROM DDHierarchy AS h
WHERE h.HierarchyRoot IN
(
	SELECT HierarchyRoot FROM DDHierarchy 
	WHERE LEFT(HierarchyRoot,5) IN 
	(
		SELECT 'a00' + CAST(TableID AS VARCHAR(3)) FROM DDHierarchy
		WHERE ParentID IS NULL))	-- 99 (tables 23, 47, and 81)		--9708 (tables 23, 47, and 81)
	
*/

		
	
