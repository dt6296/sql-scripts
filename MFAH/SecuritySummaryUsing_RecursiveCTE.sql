/*

WITH RecursiveCTE AS
(
	SELECT 1 AS Level, h1.HierarchyID, h1.HierarchyID AS ParentID
	FROM DDHierarchy AS h1
	WHERE h1.ParentID IS NULL
	
	UNION ALL
	SELECT RCTE.Level + 1 AS Level, h2.HierarchyID, h2.ParentID 
	FROM DDHierarchy AS h2
	INNER JOIN RecursiveCTE AS RCTE ON h2.ParentID = RCTE.HierarchyID
)

SELECT RecursiveCTE.HierarchyID, RecursiveCTE.ParentID, RecursiveCTE.Level, SecurityData.* FROM RecursiveCTE

*/




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
SELECT myCTE.*, SecurityData.*  FROM myCTE


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


WHERE 
sghx.SecurityGroupID = 39

AND (lmn.LanguageID = 1 OR lmn.LanguageID IS NULL)
AND (lhn.LanguageID = 1 OR lhn.LanguageID IS NULL)
AND (ltn.LanguageID = 1 OR ltn.LanguageID IS NULL)
)
AS SecurityData ON SecurityData.HID = myCTE.HierarchyID


WHERE HierarchyID = 94 or ParentID IN (94,1335,1387,2020,13698,16864,15026,16170)

ORDER BY Level, TableLabel

