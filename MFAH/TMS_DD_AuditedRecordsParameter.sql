USE [TMS]
GO

/****** Object:  StoredProcedure [dbo].[mfahsp_TMS_DDInfo]    Script Date: 11/01/2013 15:41:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






/*

mfahsp_TMS_DDInfo

TMS Data Dictionary Information
Custom MFAH Stored Procedure

Author:			Dave Thompson
Last Updated:	11/01/13

Description:	Pulls column descriptions and types by TMS module and table.
				Basis for constructing the Local TMS Data Dictionary that includes local Data Standards.
				Based on view mfahv_TMS_DDInfo.
				Attempting to parameterize to choose if selecting just audited or all recors.

*/
ALTER PROCEDURE [dbo].[mfahsp_TMS_DDInfo] 

@Audited	VARCHAR(5)

AS
BEGIN

	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
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
	CASE WHEN c.AuditTrail = 1 THEN 'Audited' ELSE '*' END AS Audited,
	mfah.ForWebsite,
	mfah.WebDisplay,
	mfah.WebIndex,
	mfah.WebDisplaySRS,
	mfah.InfoType,
	mfah.LocalNotes,
	mfah.Website,
	mfah.WebsiteDisplay,
	mfah.WebsiteIndex,
	mfah.WebsiteDisplaySRS

	FROM 
	DDTables AS t
	LEFT OUTER JOIN	DDModules			AS m	ON t.ModuleType		= m.ModuleID
	LEFT OUTER JOIN	DDTables			AS mt	ON m.MainTableID	= mt.TableID
	INNER JOIN		DDColumns			AS c	ON t.TableID		= c.PhysTableID
	LEFT OUTER JOIN	DDLocalColumnNames	AS lc	ON c.ColumnID		= lc.ColumnID
	LEFT OUTER JOIN mfaht_TMS_DataDictionary_Local AS mfah ON c.ColumnID = mfah.ColumnID

	WHERE	lc.LanguageID = 1			--English
	AND		ISNULL(c.AuditTrail,0) != CASE WHEN @Audited = 'false' THEN 0 ELSE 999999999 END
	--AND c.AuditTrail = CASE WHEN @Audited = 'true' THEN 1 ELSE  END
	--AND c.AuditTrail != CASE WHEN @Audited = 'false' THEN 0 ELSE 1 END
	
END



GO


EXEC mfahsp_TMS_DDInfo 'false'