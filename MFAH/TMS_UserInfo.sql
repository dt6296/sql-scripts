


/*	I need to replicate this for department heads (!) and collections committee members (?) */



-- TMS Users FFG

SELECT DISTINCT
ufx.ID as ufx_ID,
u.UserID,
u.Login,
u.ConstituentID,
u.DisplayName AS UserDisplayName,
u.IsDisabled,
u.SecurityGroupID,
sg.SecurityGroup,
ufg.GroupName,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 324)		AS CurrentStatus,
(SELECT ValueDate FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 324)		AS CurrentStatusDate,
(SELECT ValueRemarks FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 324)	AS CurrentStatusRemarks,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 321)		AS UserType,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 322)		AS Department,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 322)		AS Institution,		-- to be deprecated
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 325)		AS Title,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 325)		AS Position,		-- to be deprecated
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 323)		AS SecurityProfile,
c.AlphaSort,
c.DisplayName,
c.DisplayName + ', ' + (SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 325)	AS NameTitle,
c.FirstName,
c.LastName,
e.EmailTypeID,
e.EMailType,
e.EMailAddress,
e.Description AS EMailDescription,
e.EMailAddress + ';' AS EmailAddressForEmailList,
p.PhonetypeID,
p.PhoneType,
p.Description AS PhoneDescription,
p.PhoneNumber

FROM Users AS u
LEFT OUTER JOIN UserFieldXrefs AS ufx ON u.ConstituentID = ufx.ID
INNER JOIN UserFieldGroups AS ufg ON ufx.UserFieldGroupID = ufg.UserFieldGroupID
LEFT OUTER JOIN SecurityGroups AS sg ON u.SecurityGroupID = sg.SecurityGroupID
LEFT OUTER JOIN Constituents AS c ON u.ConstituentID = c.ConstituentID
LEFT OUTER JOIN MFAHv_CON_Email AS e ON c.ConstituentID = e.ConstituentID AND e.EMailTypeID = 2 -- MFAH Email
LEFT OUTER JOIN MFAHv_CON_Phone AS p ON c.ConstituentID = p.ConstituentID AND p.PhonetypeID = 7	-- MFAH Phone 
																			AND (p.Description IS NULL OR p.Description = 'office')

WHERE ufx.UserFieldGroupID = 51	--	TMS User
AND ufx.ContextID = 40			--	CONSTITUENTS
AND u.IsDisabled = 0			--	Current Users Only
AND e.EMailAddress IS NOT NULL

AND u.Login NOT IN ('gtinterow','cshornich','eanyah','apurvis','jvanlohuizen','mmjohnson','bhouston')

AND (SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 324) = 'Active'

--AND (SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 323) = 'zHandling'
--AND (SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 322)	= 'Preparations'
--AND (SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 322) IN ('Curatorial')

ORDER BY  u.DisplayName ASC




/*
-- Department Heads FFG

SELECT DISTINCT
ufx.ID as ufx_ID,
u.UserID,
u.Login,
u.ConstituentID,
u.DisplayName AS UserDisplayName,
u.IsDisabled,
--u.SecurityGroupID,
--sg.SecurityGroup,
--ufg.GroupName,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 330)		AS CurrentStatus,
(SELECT ValueDate FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 330)		AS CurrentStatusDate,
(SELECT ValueRemarks FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 330)	AS CurrentStatusRemarks,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 327)		AS UserType,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 329)		AS Department,
--(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 329)		AS Institution,		-- to be deprecated
--(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 327)		AS Title,
--(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 327)		AS Position,	
--(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 329)		AS SecurityProfile,
c.AlphaSort,
c.DisplayName,
c.DisplayName + ', ' + (SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 327) + ', ' + (SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 329)	AS NameTitle,
c.FirstName,
c.LastName,
e.EmailTypeID,
e.EMailType,
e.EMailAddress,
e.Description AS EMailDescription,
e.EMailAddress + ';' AS EmailAddressForEmailList--,
--p.PhonetypeID,
--p.PhoneType,
--p.Description AS PhoneDescription,
--p.PhoneNumber

FROM Users AS u
LEFT OUTER JOIN UserFieldXrefs AS ufx ON u.ConstituentID = ufx.ID
INNER JOIN UserFieldGroups AS ufg ON ufx.UserFieldGroupID = ufg.UserFieldGroupID
LEFT OUTER JOIN SecurityGroups AS sg ON u.SecurityGroupID = sg.SecurityGroupID
LEFT OUTER JOIN Constituents AS c ON u.ConstituentID = c.ConstituentID
LEFT OUTER JOIN MFAHv_CON_Email AS e ON c.ConstituentID = e.ConstituentID AND e.EMailTypeID = 2 -- MFAH Email
--LEFT OUTER JOIN MFAHv_CON_Phone AS p ON c.ConstituentID = p.ConstituentID AND p.PhonetypeID = 7	-- MFAH Phone 

WHERE ufx.UserFieldGroupID = 52	--	FFG Collections Committee
AND ufx.ContextID = 40			--	CONSTITUENTS
AND u.IsDisabled = 0			--	Current Users Only
--AND (p.Description IS NULL OR p.Description = 'office')

AND e.EMailAddress IS NOT NULL

--AND u.Login NOT IN ('gtinterow','wholmes','eanyah','apurvis')

AND (SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 330) = 'Active'

UNION

SELECT DISTINCT
ufx.ID as ufx_ID,
u.UserID,
u.Login,
u.ConstituentID,
u.DisplayName AS UserDisplayName,
u.IsDisabled,
--u.SecurityGroupID,
--sg.SecurityGroup,
--ufg.GroupName,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 334)		AS CurrentStatus,
(SELECT ValueDate FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 334)		AS CurrentStatusDate,
(SELECT ValueRemarks FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 334)	AS CurrentStatusRemarks,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 331)		AS UserType,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 333)		AS Department,
--(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 329)		AS Institution,		-- to be deprecated
--(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 327)		AS Title,
--(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 327)		AS Position,	
--(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 329)		AS SecurityProfile,
c.AlphaSort,
c.DisplayName,
c.DisplayName + ', ' + (SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 331) + ', ' + (SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 333)	AS NameTitle,
c.FirstName,
c.LastName,
e.EmailTypeID,
e.EMailType,
e.EMailAddress,
e.Description AS EMailDescription,
e.EMailAddress + ';' AS EmailAddressForEmailList--,
--p.PhonetypeID,
--p.PhoneType,
--p.Description AS PhoneDescription,
--p.PhoneNumber

FROM Users AS u
LEFT OUTER JOIN UserFieldXrefs AS ufx ON u.ConstituentID = ufx.ID
INNER JOIN UserFieldGroups AS ufg ON ufx.UserFieldGroupID = ufg.UserFieldGroupID
LEFT OUTER JOIN SecurityGroups AS sg ON u.SecurityGroupID = sg.SecurityGroupID
LEFT OUTER JOIN Constituents AS c ON u.ConstituentID = c.ConstituentID
LEFT OUTER JOIN MFAHv_CON_Email AS e ON c.ConstituentID = e.ConstituentID AND e.EMailTypeID = 2 -- MFAH Email
--LEFT OUTER JOIN MFAHv_CON_Phone AS p ON c.ConstituentID = p.ConstituentID AND p.PhonetypeID = 7	-- MFAH Phone 

WHERE ufx.UserFieldGroupID = 53	--	FFG Collections Committee
AND ufx.ContextID = 40			--	CONSTITUENTS
AND u.IsDisabled = 0			--	Current Users Only
--AND (p.Description IS NULL OR p.Description = 'office')

AND e.EMailAddress IS NOT NULL

--AND u.Login NOT IN ('gtinterow','wholmes','eanyah','apurvis')

AND (SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 330) = 'Active'

ORDER BY DisplayName

*/


/*

SELECT ufgx.*, uf.UserFieldName

FROM UserFieldGroupXrefs AS ufgx
INNER JOIN UserFields AS uf ON ufgx.UserFieldID = uf.UserFieldID

WHERE ufgx.UserFieldGroupID IN (52,53)

*/