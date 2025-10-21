/*

mfahv_TMS_DDInfo

TMS Data Dictionary Information
Custom MFAH View

Author:			Dave Thompson
Last Updated:	5/28/13

Description:	Pulls column descriptions and types by TMS module and table.
				Basis for constructing the Local TMS Data Dictionary that includes local Data Standards.

*/

SELECT
m.ModuleID,
m.MainTableID,
CASE WHEN m.ModuleID IS NULL THEN 'System' ELSE mt.TableName END AS Module,
t.TableID,
t.TableName,
t.PKColumnID,
t.PKColumnName,
t.MainDataColumnID,
t.MainDataColName,
c.ColumnID,
c.ColumnName,
c.AuthorityTableID,
c.IsIdentity,
c.Type,
c.VarFix,
c.Length,
c.Nullable,
c.AuditTrail,
c.Description,
lc.ColumnLabel,
lc.Customized,
lc.HelpText,
CASE WHEN lc.Customized = 1 THEN lc.HelpText ELSE c.Description END as DisplayDescription,
c.Type + ' (' + CAST(c.Length AS VARCHAR(10)) + ')' AS TypeLength,
CASE WHEN c.AuditTrail = 1 THEN 'Audited' ELSE '' END AS Audited,
mfah.ForWebsite,
mfah.WebDisplay,
mfah.WebIndex

FROM 
DDTables AS t
LEFT OUTER JOIN	DDModules			AS m	ON t.ModuleType		= m.ModuleID
LEFT OUTER JOIN	DDTables			AS mt	ON m.MainTableID	= mt.TableID
INNER JOIN		DDColumns			AS c	ON t.TableID		= c.PhysTableID
LEFT OUTER JOIN	DDLocalColumnNames	AS lc	ON c.ColumnID		= lc.ColumnID
LEFT OUTER JOIN mfaht_TMS_DataDictionary_Local AS mfah ON c.ColumnID = mfah.ColumnID

WHERE	lc.LanguageID = 1			--English
