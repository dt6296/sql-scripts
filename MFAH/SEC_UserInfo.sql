




SELECT
u.UserID,
u.Login,
u.SecurityGroupID,
sg.SecurityGroup,
u.EnteredDate,
u.IsDisabled,
ISNULL(u.ConstituentID,'') AS ConstituentID,
c.AlphaSort,
c.DisplayName,
c.FirstName,
c.LastName,
c.Position,
c.DisplayName + ', ' + c.Position AS	NameTitle,
c.Institution,
ss.StaffType,
ss.Status,
ss.StatusDate,
ss.StatusRemarks,
sp.SecurityProfile,
sp.SecurityProfileDate,
sp.SecurityRemarks,
ce.EMailType,
ce.EMailAddress,
ce.Description

/*
,
ce.EmailTypeID,
et.EMailType,
ce.Description AS EMailDescription,
ce.EMailAddress,
cp.PhoneTypeID,
pt.PhoneType,
cp.Description AS PhoneDescription,
cp.PhoneNumber
*/

FROM Users AS u
LEFT OUTER JOIN SecurityGroups AS sg ON u.SecurityGroupID = sg.SecurityGroupID
LEFT OUTER JOIN Constituents AS c ON u.ConstituentID = c.ConstituentID
LEFT OUTER JOIN MFAHv_MFAH_Staff_Status AS ss ON c.ConstituentID = ss.ConstituentID
LEFT OUTER JOIN MFAHv_MFAH_Staff_Security AS sp ON c.ConstituentID = sp.ConstituentID
LEFT OUTER JOIN MFAHv_CON_Email AS ce ON u.ConstituentID = ce.ConstituentID AND ce.EmailTypeID = 2
--LEFT OUTER JOIN ConEMail		AS ce	ON c.ConstituentID = ce.ConstituentID AND ce.EMailTypeID = 2									 --	MFAH
--LEFT OUTER JOIN ConPhones		AS cp	ON c.ConstituentID = cp.ConstituentID AND cp.PhoneTypeID = 7 --AND cp.Description = 'office'		--	MFAH
--LEFT OUTER JOIN EMailTypes		AS et	ON ce.EMailTypeID = et.EMailTypeID
--LEFT OUTER JOIN PhoneTypes		AS pt	ON cp.PhoneTypeID = pt.PhoneTypeID

WHERE u.IsDisabled = 0															--	Active Users Only
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

AND ce.EMailAddress IS NOT NULL
--AND ss.StaffType IS NULL

ORDER BY u.Login






--SELECT * FROM Users WHERE UserID IN (2648,2649,2650,2651,2652,2653,2654,2655,2656,2657,2658)



/*
SELECT 
uf.UserFieldID,
uf.UserFieldName,
uf.ContextID,
ddc.Context,
uf.DisplayOrder

FROM UserFields AS uf
LEFT OUTER JOIN DDContexts AS ddc ON uf.ContextID = ddc.ContextID

WHERE uf.ContextID = 40
*/


--SELECT * FROM MFAHv_CON_Email WHERE EmailTypeID = 2 ORDER BY EmailAddress






