

/*

MFAH Constituent Data

*/




SELECT
u.UserID,
u.Login,
u.SecurityGroupID,
sg.SecurityGroup,
u.EnteredDate,
u.IsDisabled,
CASE WHEN u.IsDisabled = 1 THEN 'Deactivated' ELSE 'Active' END AS IsDisabled_Display,
u.DisplayName,
u.ConstituentID
FROM Users AS u
LEFT OUTER JOIN SecurityGroups AS sg ON u.SecurityGroupID = sg.SecurityGroupID
WHERE u.Login = 'dthompson';



SELECT 
c.ConstituentID,
c.DisplayName,
c.FirstName,
c.LastName,
c.AlphaSort,
c.Position,
c.Institution,
c.IsStaff,
CASE WHEN c.IsStaff = 1 THEN 'Staff' ELSE 'Other' END AS IsStaff_Display
FROM Constituents AS c
WHERE c.ConstituentID = 29872;


SELECT
cp.ConstituentID,
cp.PhoneTypeID,
pt.PhoneType,
cp.Description,
cp.PhoneNumber
FROM ConPhones AS cp
LEFT OUTER JOIN PhoneTypes AS pt ON cp.PhoneTypeID = pt.PhoneTypeID
WHERE cp.PhoneTypeID = 7
AND cp.ConstituentID = 29872;


SELECT
ce.ConstituentID,
ce.EMailTypeID,
et.EMailType,
ce.EMailAddress
FROM ConEMail AS ce
LEFT OUTER JOIN EMailTypes AS et ON ce.EMailTypeID = et.EMailTypeID
WHERE ce.EmailTypeID = 2
AND ce.ConstituentID = 29872;


--SELECT * FROM UserFields WHERE ContextID = 40
/*

	UserFieldID	UserFieldName
	306			MFAH Employee
	307			MFAH Volunteer
	308			MFAH Intern / Fellow

*/

SELECT 
d.ID AS ConstituentID,
d.ContextID,
d.UserFieldID,
d.UserFieldName AS MFAH_Relationship,
d.FieldValue AS MFAH_Status,
d.ValueDate AS MFAH_StatusDate,
d.ValueRemarks AS MFAH_StatusRemarks
FROM
(
	SELECT ufx.ID, ufx.ContextID, ufx.UserFieldID, uf.UserFieldName, ufx.FieldValue, ufx.ValueDate, ufx.ValueRemarks, RANK() OVER(PARTITION BY ID ORDER BY ufx.ValueDate DESC) AS RankByDate
	FROM UserFieldXrefs AS ufx
	LEFT OUTER JOIN UserFields AS uf ON ufx.UserFieldID = uf.UserFieldID
	WHERE ufx.UserFieldID IN (306,307,308) 
	AND ufx.ValueDate <= GETDATE()
) AS d
WHERE d.ID = 29872
AND d.RankByDate = 1;



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
FROM		UserSecurity		AS us
INNER JOIN	SecurityGroups		AS sg	ON	us.SecurityGroupID = sg.SecurityGroupID
INNER JOIN	Departments			AS d	ON	us.DepartmentID = d.DepartmentID
INNER JOIN	Users				AS u	ON	us.UserID = u.UserID
INNER JOIN	DDModules			AS ddm	ON	d.MainTableID = ddm.MainTableID
INNER JOIN	DDTables			AS ddt	ON	ddm.MainTableID = ddt.TableID
WHERE us.UserID > -1
AND u.Login IN ('dthompson')
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
u.IsDisabled
FROM Users AS u
INNER JOIN SecurityGroups AS sg ON u.SecurityGroupID = sg.SecurityGroupID
WHERE u.Login IN ('dthompson');
