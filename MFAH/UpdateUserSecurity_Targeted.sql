






-- This script will update active user's security to match that user's profile security for specified modules if it doens't already match.


--BACKUP DATABASE FIRST!
----------------------------	Pre-Update BACKUP FILE
----------------------------	\\mfah-tms-sql\d$\SQL\Backups\
----------------------------	TMS_Production_201019_1710.bak


--UPDATE UserSecurity SET SecurityGroupID = p.p_SecurityGroupID
--SELECT us.UserSecurityID, us.SecurityGroupID, sg.SecurityGroup, us.DepartmentID, d.Department, p.p_SecurityGroupID, p.p_SecurityGroup, p.p_SecurityProfile, p.p_DepartmentID, p.p_Department
FROM UserSecurity AS us
INNER JOIN MFAHvr_TMS_UserSecurity_Profile_Summary AS p ON us.UserSecurityID = p.u_UserSecurityID
INNER JOIN Departments AS d ON us.DepartmentID = d.DepartmentID
INNER JOIN SecurityGroups AS sg ON us.SecurityGroupID = sg.SecurityGroupID

WHERE us.UserSecurityID IN
(
	SELECT
	u_UserSecurityID
	/*
	u_Login,
	u_DisplayName,
	u_MFAH_Dept,
	u_SecurityGroupID,
	u_SecurityGroup,
	u_Department,
	u_ModuleID,
	u_TableName,
	u_SecurityProfile,
	'',
	p_SecurityGroupID,
	p_SecurityGroup,
	p_Department,
	p_ModuleID,
	p_TableName,
	p_SecurityProfile
	*/

	FROM MFAHvr_TMS_UserSecurity_Profile_Summary
  
	WHERE 		u_IsDisabled = 0
	AND			u_SecurityGroupID <> p_SecurityGroupID
--	AND			u_SecurityGroupID <> 85									
	AND			u_ModuleID IN (9) -- Media Module
	AND			u_DepartmentID IN (199) 								
--	AND			u_SecurityProfile IN ('zCataloguing')
--	AND			u_MFAH_Dept = 'Curatorial'
--	AND			u_Login NOT IN ('hkaurisch','cdacus','jdibley','rdyll','kfletcher','rgomez','agreene','bhouston','slamberti','alett','lolivo','mrayl','mrendall','lreynolds','gschirripa','jtimte','kweber','dwoodall','bcochrane','jevans','jwalls','rperez','jbakke','jlevy','jobsta')

--	ORDER BY u_DisplayName, u_ModuleID, u_SecurityGroup, u_Department
) 

/*

SELECT * FROM Departments WHERE DepartmentID = 296
SELECT * FROM Departments WHERE MainTableID = 318
SELECT * FROM Departments WHERE Department LIKE 'Status - Closed'
SELECT * FROM SecurityGroups WHERE SecurityGroupID = 85
SELECT * FROM DDModules AS m INNER JOIN DDTables AS t ON m.MainTableID = t.TableID WHERE m.ModuleID IN (4)
SELECT * FROM DDModules WHERE ModuleID = 9
SELECT * FROM DDTables WHERE TableID = 318
SELECT COUNT(*) FROM Users WHERE IsDisabled = 0
*/