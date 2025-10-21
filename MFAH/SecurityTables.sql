




SELECT
SecurityGroupID,
SecurityGroup
FROM SecurityGroups



SELECT
UserID,
Login,
SecurityGroupID,
DisplayName
FROM Users


SELECT
DepartmentID,
Department,
Mnemonic,
MainTableID
FROM Departments
MainTableID = 108	-- Objects
MainTableID = 48	-- Exhibitions
MainTableID = 318	-- Media



SELECT
UserSecurityID,
UserID,
SecurityGroupID,
DepartmentID
FROM UserSecurity
