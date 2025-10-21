




SELECT
u.UserID,
u.Login,
u.SecurityGroupID,
u.DisplayName,
sg.SecurityGroup,
us.DepartmentID,
sg.SecurityGroupID

FROM Users AS u
LEFT OUTER JOIN SecurityGroups AS sg ON u.SecurityGroupID = sg.SecurityGroupID
LEFT OUTER JOIN UserSecurity AS us ON u.UserID = us.UserID


WHERE Login IN	('kstrange')

--('owolf','hbrown','wstewart','amgutierrez','jmililo','jeevans')



SELECT * FROM UserSecurity WHERE UserID = 1243
SELECT * FROM Departments --(count = 75 including ID = 0 (not assigned))