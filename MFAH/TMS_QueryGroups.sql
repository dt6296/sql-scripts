



SELECT
qg.ModuleID,
lmn.ModuleLabel AS QueryGroup,
qg.QueryGroupID,
lqgn.LocalGroupName,
qg.QueryAssistant,
qg.PublicQueryAsst,
qg.AdvancedQuery,
qgcx.ColumnID,
lcn.ColumnLabel,
ltn.TableLabel AS LocalTableName,
ht.TableName

FROM		DDQueryGroups		AS qg
INNER JOIN	DDLocalQGNames		AS lqgn	ON qg.QueryGroupID = lqgn.QueryGroupID	AND lqgn.LanguageID = 1
INNER JOIN	DDModules			AS qgm	ON qg.ModuleID = qgm.ModuleID
INNER JOIN	DDLocalModuleNames	AS lmn	on qgm.ModuleID = lmn.ModuleID			AND lmn.LanguageID = 1
INNER JOIN	DDQGColXrefs		AS qgcx	ON qg.QueryGroupID = qgcx.QueryGroupID
INNER JOIN  DDLocalColumnNames	AS lcn	ON qgcx.ColumnID = lcn.ColumnID			AND lcn.LanguageID = 1
INNER JOIN	DDHierarchy			AS h	ON qgcx.HierarchyID = h.HierarchyID
INNER JOIN	DDTables			AS ht	ON h.TableID = ht.TableID
INNER JOIN	DDLocalTableNames	AS ltn	ON h.TableID = ltn.TableID				AND ltn.LanguageID = 1

ORDER BY lmn.ModuleLabel, lqgn.LocalGroupName, lcn.ColumnLabel






















