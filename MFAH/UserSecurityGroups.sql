


SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;


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
u.IsDisabled

SELECT DISTINCT u.Login, u.DisplayName


FROM		UserSecurity		AS us
INNER JOIN	SecurityGroups		AS sg	ON	us.SecurityGroupID = sg.SecurityGroupID
INNER JOIN	Departments			AS d	ON	us.DepartmentID = d.DepartmentID
INNER JOIN	Users				AS u	ON	us.UserID = u.UserID
INNER JOIN	DDModules			AS ddm	ON	d.MainTableID = ddm.MainTableID
INNER JOIN	DDTables			AS ddt	ON	ddm.MainTableID = ddt.TableID

WHERE us.UserID > -1
AND u.IsDisabled = 1
--AND sg.SecurityGroupID < 39
AND sg.SecurityGroupID IN (62,63)

ORDER BY u.Login

--AND u.Login = 'dthompson'


--SELECT COUNT(*) FROM Departments			-- 75
--SELECT COUNT(*) FROM SecurityGroups		-- 46






SELECT * FROM SecurityGroups WHERE SecurityGroupID < 39


