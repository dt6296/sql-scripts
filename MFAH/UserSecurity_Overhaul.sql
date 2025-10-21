



SELECT * FROM SecurityGroups

SELECT * FROM Users



-- TEMPLATES
SELECT 
u.UserID,
u.Login,
u.SecurityGroupID,
sg.SecurityGroup,
u.DisplayName,
u.ConstituentID

FROM Users AS u
LEFT OUTER JOIN SecurityGroups AS sg ON u.SecurityGroupID = sg.SecurityGroupID

WHERE u.IsDisabled = 0
AND Login LIKE 'z%'
AND UserID > 2647



-- ACTIVE USERS
SELECT 
u.UserID,
u.Login,
u.SecurityGroupID,
sg.SecurityGroup,
u.DisplayName,
u.ConstituentID,
c.DisplayName,
c.Institution,
c.Position

FROM Users AS u
LEFT OUTER JOIN SecurityGroups AS sg ON u.SecurityGroupID = sg.SecurityGroupID
LEFT OUTER JOIN Constituents AS c ON u.ConstituentID = c.ConstituentID

WHERE u.IsDisabled = 0
AND UserID <= 2647


SELECT * FROM Constituents WHERE IsStaff = 1

SELECT * FROM Constituents WHERE IsStaff = 0

SELECT * FROM Constituents WHERE IsStaff IS NULL


-- For adding and linking constituent records.
SELECT
c.IsStaff,
u.UserID,
u.DisplayName,
u.ConstituentID,
c.ConstituentID,
c.DisplayName,
c.Position,
c.Institution

FROM Users AS u
LEFT OUTER JOIN Constituents AS c ON u.ConstituentID = c.ConstituentID

WHERE u.IsDisabled = 0
AND UserID NOT IN (3,616,617,618,619,620,621,622,800,1213,1269,1382,1431,1432,1584)
AND u.DisplayName NOT LIKE 'User Profile%'
AND c.IsStaff IS NULL





--UPDATE Constituents SET IsStaff = 1
--SELECT *
FROM Users AS u
LEFT OUTER JOIN Constituents AS c ON u.ConstituentID = c.ConstituentID
WHERE u.UserID IN
(
	SELECT UserID
	FROM Users
	WHERE IsDisabled = 0
	AND UserID NOT IN (3,616,617,618,619,620,621,622,800,1213,1269,1382,1431,1432,1584,2659)
	AND DisplayName NOT LIKE 'User Profile Template%'
)
AND c.IsStaff IS NULL
--ORDER BY u.Login







