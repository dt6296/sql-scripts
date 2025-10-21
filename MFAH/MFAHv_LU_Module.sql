/*

mfahv_LU_Module

TMS Module
Custom MFAH View

Author:			Dave Thompson
Last Updated:	5/28/13

Description:	Provide values for Module Parameters

*/

SELECT DISTINCT
m.ModuleID, CASE WHEN m.ModuleID IS NULL THEN 'System' ELSE mt.TableName END AS Module


FROM 
DDTables AS t
LEFT OUTER JOIN DDModules AS m ON t.ModuleType = m.ModuleID
LEFT OUTER JOIN DDTables AS mt ON m.MainTableID = mt.TableID

GO

