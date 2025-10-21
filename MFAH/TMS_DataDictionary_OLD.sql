


SELECT * FROM [MFAH-TMS].TMS.dbo.DDTables
WHERE TableName = 'Objects'



SELECT * FROM [MFAH-TMS].TMS.dbo.DDColumns WHERE PhysTableID = 108

1231

SELECT * FROM [MFAH-TMS].TMS.dbo.DDLocalColumnNames
WHERE LanguageID = 1
AND Customized = 1


---------------------------------------------------------------------------------------------------


SELECT
t.TableID, t.TableName, t.PKColumnID, t.PKColumnName, t.MainDataColumnID, t.MainDataColName,
c.ColumnID, c.ColumnName, c.AuthorityTableID, c.IsIdentity, c.Description,
lc.ColumnLabel, lc.Customized, lc.HelpText

FROM DDTables AS t
INNER JOIN DDColumns AS c ON t.TableID = c.PhysTableID
LEFT OUTER JOIN DDLocalColumnNames AS lc ON c.ColumnID = lc.ColumnID

WHERE lc.LanguageID = 1			--English
AND lc.Customized = 1			--Customized Fields
AND ColumnName != ColumnLabel	--Relabeled Fields

-------------------


SELECT
m.ModuleID, m.MainTableID, CASE WHEN m.ModuleID IS NULL THEN 'System' ELSE mt.TableName END AS Module,
t.TableID, t.TableName, t.PKColumnID, t.PKColumnName, t.MainDataColumnID, t.MainDataColName,
c.ColumnID, c.ColumnName, c.AuthorityTableID, c.IsIdentity, c.Description,
lc.ColumnLabel, lc.Customized, lc.HelpText,
CASE WHEN lc.Customized = 1 THEN lc.HelpText ELSE c.Description END as DisplayDescription

FROM 
DDTables AS t
LEFT OUTER JOIN DDModules AS m ON t.ModuleType = m.ModuleID
LEFT OUTER JOIN DDTables AS mt ON m.MainTableID = mt.TableID
INNER JOIN DDColumns AS c ON t.TableID = c.PhysTableID
LEFT OUTER JOIN DDLocalColumnNames AS lc ON c.ColumnID = lc.ColumnID

WHERE lc.LanguageID = 1			--English
AND lc.Customized = 1			--Customized Fields
AND ColumnName != ColumnLabel	--Relabeled Fields

