

--CreditLine Update Test
--Need linked server connections between servers.
--Tried from MFAH-REPORTS but the MFAH-SQL2 connection no longer works.
--I submitted another request 8/12/13 AM.




SELECT TOP 1000
ic.Image_Local_ID,
ic.Work_Local_ObjectID,
ic.Work_Local_ObjectID_Multiple,
ic.Work_VRA_LocationRefID,
ic.Work_CDWA_CatalogLevel,
ic.Work_CDWA_OwnersCreditLine,
ic.Record_Local_LastUpdatedInCatalogDB,
ic.Record_Local_Created

FROM [MFAH-SQL2].ImageCatalog_Data.dbo.ImageCatalog AS ic
LEFT OUTER JOIN
(
	SELECT 
	at.AuditTrailID, at.ObjectID, at.ModuleID, ddt.TableName AS ModuleName, at.TableName, at.ColumnName,
	at.OldValue, at.NewValue, at.Explanation, at.EnteredDate, at.LoginID, at.Approvals
	FROM [MFAH-TMS].TMS.dbo.AuditTrail AS at
	LEFT OUTER JOIN [MFAH-TMS].TMS.dbo.DDModules AS ddm ON at.ModuleID = ddm.ModuleID
	LEFT OUTER JOIN [MFAH-TMS].TMS.dbo.DDTables AS ddt on ddm.MainTableID = ddt.TableID
	WHERE	ddm.ModuleID IN (0,1,2)										--"System", Objects,  Constituents
	AND		at.TableName IS NOT NULL
	AND		at.ColumnName = 'CreditLine'
	--ORDER BY at.ModuleID, ddt.TableName, at.TableName, at.ColumnName, at.EnteredDate
) AS tms 
		ON	ic.Work_Local_ObjectID = tms.ObjectID
		AND	ic.Record_Local_LastUpdatedInCatalogDB < at.EnteredDate
		





WHERE ic.Work_Local_ObjectID IS NOT NULL
