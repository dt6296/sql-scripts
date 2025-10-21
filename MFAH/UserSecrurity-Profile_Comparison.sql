
--WIP_od_UserSecurity-Profile_Comparison.rdl



--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
---------------------------------------------------------------------------------------------------------------

SELECT

us.UserSecurityID,
us.SecurityGroupID,
sg.SecurityGroup,
us.DepartmentID,
d.Department,
ddm.ModuleID,
ddt.TableName,
us.UserID,
u.DisplayName,
u.Login,
u.IsDisabled,
u.ConstituentID

FROM		UserSecurity		AS us
INNER JOIN	SecurityGroups		AS sg	ON	us.SecurityGroupID = sg.SecurityGroupID
INNER JOIN	Departments			AS d	ON	us.DepartmentID = d.DepartmentID
INNER JOIN	Users				AS u	ON	us.UserID = u.UserID
INNER JOIN	DDModules			AS ddm	ON	d.MainTableID = ddm.MainTableID
INNER JOIN	DDTables			AS ddt	ON	ddm.MainTableID = ddt.TableID

WHERE us.UserID > -1

AND u.Login IN ('ttan')

UNION

SELECT
0 AS UserSecurityID,
u.SecurityGroupID,
sg.SecurityGroup,
0 AS DepartmentID,
'Overall' AS Department,
0 AS ModuleID,
'_Overall' AS TableName,
u.UserID,
u.DisplayName,
u.Login,
u.IsDisabled,
u.ConstituentID

FROM Users AS u
INNER JOIN SecurityGroups AS sg ON u.SecurityGroupID = sg.SecurityGroupID
WHERE u.Login IN ('ttan')


UNION

SELECT

us.UserSecurityID,
us.SecurityGroupID,
sg.SecurityGroup,
us.DepartmentID,
d.Department,
ddm.ModuleID,
ddt.TableName,
us.UserID,
u.DisplayName,
u.Login,
u.IsDisabled,
u.ConstituentID

FROM		UserSecurity		AS us
INNER JOIN	SecurityGroups		AS sg	ON	us.SecurityGroupID = sg.SecurityGroupID
INNER JOIN	Departments			AS d	ON	us.DepartmentID = d.DepartmentID
INNER JOIN	Users				AS u	ON	us.UserID = u.UserID
INNER JOIN	DDModules			AS ddm	ON	d.MainTableID = ddm.MainTableID
INNER JOIN	DDTables			AS ddt	ON	ddm.MainTableID = ddt.TableID


WHERE u.Login IN 
(
	SELECT FieldValue 
	FROM UserFieldXrefs AS ufx
	INNER JOIN Users AS u ON ufx.ID = u.ConstituentID
	WHERE UserFieldID = 323
	AND u.Login IN ('ttan')
)	


SELECT
0 AS UserSecurityID,
u.SecurityGroupID,
sg.SecurityGroup,
0 AS DepartmentID,
'Overall' AS Department,
0 AS ModuleID,
'_Overall' AS TableName,
u.UserID,
u.DisplayName,
u.Login,
u.IsDisabled,
u.ConstituentID

FROM Users AS u
INNER JOIN SecurityGroups AS sg ON u.SecurityGroupID = sg.SecurityGroupID

WHERE u.Login IN 
(
	SELECT FieldValue 
	FROM UserFieldXrefs AS ufx
	INNER JOIN Users AS u ON ufx.ID = u.ConstituentID
	WHERE UserFieldID = 323
	AND u.Login IN ('ttan')
)	

---------------------------------------------------------------------------------------------------------------




SELECT
u.UserSecurityID	AS u_UserSecurityID,
u.SecurityGroupID	AS u_SecurityGroupID,
u.SecurityGroup		AS u_SecurityGroup,
u.DepartmentID		AS u_DepartmentID,
u.Department		AS u_Department,
u.ModuleID			AS u_ModuleID,
u.TableName			AS u_TableName,
u.UserID			AS u_UserID,
u.DisplayName		AS u_DisplayName,
u.Login				AS u_Login,
u.IsDisabled		AS u_IsDisabled,
u.ConstituentID		AS u_ConstituentID,
u.FieldValue		AS u_MFAH_Dept,

p.UserSecurityID	AS p_UserSecurityID,
p.SecurityGroupID	AS p_SecurityGroupID,
p.SecurityGroup		AS p_SecurityGroup,
p.DepartmentID		AS p_DepartmentID,
p.Department		AS p_Department,
p.ModuleID			AS p_ModuleID,
p.TableName			AS p_TableName,
p.UserID			AS p_UserID,
p.DisplayName		AS p_DisplayName,
p.Login				AS p_Login,
p.IsDisabled		AS p_IsDisabled,
p.ConstituentID		AS p_ConstituentID,
p.FieldValue		AS p_MFAH_Dept



FROM
(
SELECT

us.UserSecurityID,
us.SecurityGroupID,
sg.SecurityGroup,
us.DepartmentID,
d.Department,
ddm.ModuleID,
ddt.TableName,
us.UserID,
u.DisplayName,
u.Login,
u.IsDisabled,
u.ConstituentID,
ufx.FieldValue

FROM		UserSecurity		AS us
INNER JOIN	SecurityGroups		AS sg	ON	us.SecurityGroupID = sg.SecurityGroupID
INNER JOIN	Departments			AS d	ON	us.DepartmentID = d.DepartmentID
INNER JOIN	Users				AS u	ON	us.UserID = u.UserID
INNER JOIN	DDModules			AS ddm	ON	d.MainTableID = ddm.MainTableID
INNER JOIN	DDTables			AS ddt	ON	ddm.MainTableID = ddt.TableID
LEFT OUTER JOIN UserFieldXrefs	AS ufx	ON	u.ConstituentID = ufx.ID AND ufx.UserFieldID = 322

WHERE us.UserID > -1
AND u.Login IN ('ttan')

UNION

SELECT
0 AS UserSecurityID,
u.SecurityGroupID,
sg.SecurityGroup,
0 AS DepartmentID,
'Overall' AS Department,
0 AS ModuleID,
'_Overall' AS TableName,
u.UserID,
u.DisplayName,
u.Login,
u.IsDisabled,
u.ConstituentID,
ufx.FieldValue

FROM Users AS u
INNER JOIN SecurityGroups AS sg ON u.SecurityGroupID = sg.SecurityGroupID
LEFT OUTER JOIN UserFieldXrefs	AS ufx	ON	u.ConstituentID = ufx.ID AND ufx.UserFieldID = 322

WHERE u.Login IN ('ttan')
) AS u

LEFT OUTER JOIN

(
SELECT
us.UserSecurityID,
us.SecurityGroupID,
sg.SecurityGroup,
us.DepartmentID,
d.Department,
ddm.ModuleID,
ddt.TableName,
us.UserID,
u.DisplayName,
u.Login,
u.IsDisabled,
u.ConstituentID,
ufx.FieldValue

FROM		UserSecurity		AS us
INNER JOIN	SecurityGroups		AS sg	ON	us.SecurityGroupID = sg.SecurityGroupID
INNER JOIN	Departments			AS d	ON	us.DepartmentID = d.DepartmentID
INNER JOIN	Users				AS u	ON	us.UserID = u.UserID
INNER JOIN	DDModules			AS ddm	ON	d.MainTableID = ddm.MainTableID
INNER JOIN	DDTables			AS ddt	ON	ddm.MainTableID = ddt.TableID
LEFT OUTER JOIN UserFieldXrefs	AS ufx	ON	u.ConstituentID = ufx.ID AND ufx.UserFieldID = 322

WHERE u.Login IN 
(
	SELECT FieldValue 
	FROM UserFieldXrefs AS ufx
	INNER JOIN Users AS u ON ufx.ID = u.ConstituentID
	WHERE UserFieldID = 323
	AND u.Login IN ('ttan')
)	

UNION

SELECT
0 AS UserSecurityID,
u.SecurityGroupID,
sg.SecurityGroup,
0 AS DepartmentID,
'Overall' AS Department,
0 AS ModuleID,
'_Overall' AS TableName,
u.UserID,
u.DisplayName,
u.Login,
u.IsDisabled,
u.ConstituentID,
ufx.FieldValue

FROM Users AS u
INNER JOIN SecurityGroups AS sg ON u.SecurityGroupID = sg.SecurityGroupID
LEFT OUTER JOIN UserFieldXrefs	AS ufx	ON	u.ConstituentID = ufx.ID AND ufx.UserFieldID = 322

WHERE u.Login IN 
(
	SELECT FieldValue 
	FROM UserFieldXrefs AS ufx
	INNER JOIN Users AS u ON ufx.ID = u.ConstituentID
	WHERE UserFieldID = 323
	AND u.Login IN ('ttan')
)	
) AS p ON u.DepartmentID = p.DepartmentID
	   AND u.ModuleID = p.ModuleID



	   ------------------------------------------------------------------------------------------------------------



SELECT * FROM UserFields WHERE UserFieldID = 322

SELECT 
UserFieldValueID,
UserFieldID,
UserFieldValue

FROM UserFieldValueAuthority

WHERE UserFieldID = 322



SELECT * FROM UserFields WHERE ContextID = 40



SELECT
u.UserID,
u.Login,
u.DisplayName,
u.ConstituentID,
c.DisplayName,
ufxd.FieldValue AS MFAH_Dept,
ufxs.FieldValue AS SecurityProfile

FROM Users AS u
LEFT OUTER JOIN Constituents AS c ON u.ConstituentID = c.ConstituentID
LEFT OUTER JOIN UserFieldXrefs AS ufxd ON c.ConstituentID = ufxd.ID AND ufxd.UserFieldID = 322
LEFT OUTER JOIN UserFieldXrefs AS ufxs ON c.ConstituentID = ufxs.ID AND ufxs.UserFieldID = 323

WHERE u.IsDisabled = 0
AND u.UserID <> 3				--	INFORMATION_SCHEMA
AND u.UserID NOT IN (616,617,618,619,620,621,622)	-- IT Training
AND u.UserID <> 800				-- svc-sharepoint
AND u.UserID <> 1213			-- TEST ACCOUNT, Tim Luu (IT)
AND u.UserID <> 1269			-- TEST ACCOUNT, Dave Thompson (IT)
AND u.UserID <> 1382			-- HTTP Service Account
AND u.UserID NOT IN (1431,1432) -- Amsys Contractors
AND u.UserID <> 1584			-- Tausheli's test account
AND u.UserID NOT IN (2648,2649,2650,2651,2652,2653,2654,2655,2656,2657,2658) -- User Profile Templates
AND u.UserID <> 2659			-- Matt Test

ORDER BY u.Login