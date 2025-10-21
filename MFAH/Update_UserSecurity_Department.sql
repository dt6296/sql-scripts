




SELECT * FROM UserSecurity WHERE UserID = 373


SELECT 
u.UserID,
u.Login,
u.IsDisabled

FROM Users AS u

WHERE u.IsDisabled = 0


SELECT d.DepartmentID, d.Department, d.MainTableID,
t.TableName
FROM Departments AS d
INNER JOIN DDTables AS t ON d.MainTableID = t.TableID
WHERE d.MainTableID = 47		-- Exhibitions
AND d.DepartmentID = 176		-- Restricted


SELECT us.* , sg.SecurityGroup
FROM UserSecurity  AS us
INNER JOIN SecurityGroups AS sg ON us.SecurityGroupID = sg.SecurityGroupID
WHERE UserID = 373
AND DepartmentID = 176

SELECT * FROM Departments WHERE Department LIKE '%Restricted%'
SELECT * FROM SecurityGroups WHERE SecurityGroup = 'Restricted'
SELECT * FROM DDTables WHERE TableID = 47  --Exhibitions
/*

SELECT * FROM SecurityGroups 
SELECT * FROM Departments WHERE DepartmentID = 176

MainTableID = 47		--	Exhibitions

SecurityGroupID = 73	--	Exhibitions - View Only
SecurityGroupID = 69	--	Restricted
SecurityGroupID = 56	--	18-SYSTEM ADMINISTRATORS
SecurityGroupID = 0		--	System Administrator
SecurityGroupID = 76	--	Exhibitions - Full Rights

DepartmentID = 176		--	Restricted



*/


SELECT 
u.UserID,
u.Login,
u.IsDisabled,
us.SecurityGroupID,
sg.SecurityGroup,
d.MainTableID,
t.TableName,
us.DepartmentID,
d.Department

FROM Users AS u
INNER JOIN UserSecurity AS us ON u.UserID = us.UserID --AND us.DepartmentID = 176
INNER JOIN SecurityGroups AS sg ON us.SecurityGroupID = sg.SecurityGroupID
INNER JOIN Departments AS d ON us.DepartmentID = d.DepartmentID
INNER JOIN DDTables AS t ON d.MainTableID = t.TableID

WHERE u.IsDisabled = 0
AND us.DepartmentID = 176				--	Restricted
AND us.SecurityGroupID NOT IN (0,56)	--	System Administrator
AND u.Login IN
(
'droldan',
'mguerrero',
'bgonzalez',
'kcrain',
'jbakke',
'agreene',
'kweber',
'alett',
'cdacus',
'hkaurisch',
'dwoodall',
'lminton',
'kwillis',
'mleal',
'jgillies',
'iseyb',
'tdubrock',
'ttan',
'mrendall'
)


SELECT * FROM SecurityGroups


--UPDATE UserSecurity SET SecurityGroupID = 76
--SELECT *
FROM Users AS u
INNER JOIN UserSecurity AS us ON u.UserID = us.UserID
WHERE u.IsDisabled = 0
AND us.DepartmentID = 176				--	Restricted
AND us.SecurityGroupID NOT IN (0,56)	--	System Administrator

AND u.Login IN
(
'droldan',
'mrguerrero',
'bgonzalez',
'kcrain',
'jbakke',
'agreene',
'kweber',
'alett',
'cdacus',
'hkaurisch',
'dwoodall',
'lminton',
'kwillis',
'mleal',
'jgillies',
'iseyb',
'tdubrock',
'ttan',
'mrendall'
)


----------------------------------------------------------------------------------------------------------------	4/23/2019

SELECT * FROM Departments WHERE Department = 'Registrars - Image' -- DepartmentID = 254
SELECT * FROM Departments WHERE Department = 'Curatorial - Image' -- DepartmentID = 204

SELECT * FROM SecurityGroups WHERE SecurityGroup = 'Media - View Only'			-- SecurityGroupID = 81
SELECT * FROM SecurityGroups WHERE SecurityGroup = 'Media - View Only - Dt'		-- SecurityGroupID = 82
SELECT * FROM SecurityGroups WHERE SecurityGroup = 'Media - View Only - DtDo'	-- SecurityGroupID = 83

SELECT * FROM Users WHERE DisplayName LIKE '%Profile%'
/*
UserID	Login					SecurityGroupID
2648	zCataloguing			111
2649	zConservation			98
2650	zCuratorial				99
2651	zDesign					95
2652	zExhibitions			112
2653	zFullView				96
2654	zGraphicsPublication	95
2655	zHandling				110
2656	zImagingServices		97
2657	zPublicView				95
2658	zRegistration			102
*/

SELECT * FROM Users WHERE UserID IN
(
2648,2650,2651,2654,2657
)


--	Update zProfile users with new security


--UPDATE UserSecurity SET SecurityGroupID = 83	--	Media - View Only - DtDo
--SELECT us.* 
FROM UserSecurity AS us
WHERE us.UserID IN 
(
	2648,	--	zCataloguing
	2650--,	--	zCuratorial
	--2651,	--	zDesign
	--2654,	--	zGraphicsPublication
	--2657	--	zPublicView
)
AND us.DepartmentID = 254	--	Registrars - Image



--UPDATE UserSecurity SET SecurityGroupID = 82	--	Media - View Only - Dt
--SELECT us.* 
FROM UserSecurity AS us
WHERE us.UserID IN 
(
	--2648,	--	zCataloguing
	--2650	--	zCuratorial
	2651,	--	zDesign
	2654,	--	zGraphicsPublication
	2657	--	zPublicView
)
AND us.DepartmentID = 254	--	Registrars - Image


--UPDATE UserSecurity SET SecurityGroupID = 82	--	Media - View Only - Dt
--SELECT us.* 
FROM UserSecurity AS us
WHERE us.UserID IN 
(
	--2648,	--	zCataloguing
	--2650	--	zCuratorial
	2651,	--	zDesign
	2654,	--	zGraphicsPublication
	2657	--	zPublicView
)
AND us.DepartmentID = 204	--	Curatorial - Image


----------------------------------------------------------------------------------------


--	Update Users - Specific user profiles, specific department, specific security group.


--UPDATE UserSecurity SET SecurityGroupID = 82	--	Media - View Only - DtDo
--SELECT us.UserID, us.SecurityGroupID, sg.SecurityGroup, us.DepartmentID, d.Department, u.ConstituentID, c.DisplayName, ufxs.ContextID, ufxs.UserFieldID, ufxs.FieldValue
FROM UserSecurity AS us
INNER JOIN Users AS u ON us.UserID = u.UserID
INNER JOIN SecurityGroups AS sg ON us.SecurityGroupID = sg.SecurityGroupID
INNER JOIN Departments AS d ON us.DepartmentID = d.DepartmentID
INNER JOIN Constituents AS c ON u.ConstituentID = c.ConstituentID
INNER JOIN UserFieldXrefs AS ufxs ON c.ConstituentID = ufxs.ID AND ufxs.UserFieldID = 323 -- Security Profile
--WHERE us.DepartmentID = 254	--	Registrars - Image
WHERE us.DepartmentID = 204 --	Curatorial - Image
AND u.IsDisabled = 0
AND ufxs.FieldValue = 'zPublicView'
--AND us.SecurityGroupID <> 83

AND u.UserID IN
(
SELECT u.UserID
FROM Constituents AS c
INNER JOIN UserFieldXrefs AS ufxs ON c.ConstituentID = ufxs.ID AND ufxs.UserFieldID = 323 -- Security Profile
INNER JOIN Users AS u ON c.ConstituentID = u.ConstituentID
WHERE u.IsDisabled = 0
AND u.UserID <> 3																--	INFORMATION_SCHEMA
AND u.UserID NOT IN (616,617,618,619,620,621,622)								--	IT Training accounts
AND u.UserID <> 800																--	svc-sharepoint
AND u.UserID <> 1213															--	timtest
AND u.UserID <> 1269															--	davettest
AND u.UserID <> 1382															--	SVC-TMS, HTTP Service Account
AND u.UserID NOT IN (1431,1432)													--	Amsys contractors
AND u.UserID <> 1584															--	Taushelitest2
AND u.UserID NOT IN (2648,2649,2650,2651,2652,2653,2654,2655,2656,2657,2658)	--	User Profile Templates
AND u.UserID <> 2659															--	mtest, Matt Test
)


