


SELECT 
s.DisplayName,
s.IsDisabled,
s.LoginYear,
s.LoginMonth,
s.LoginDayOfMonth,
s.LoginWeekday,
COUNT(s.LoginID)	AS CountLogins,
SUM(s.Duration)		AS SumDuration,
AVG(s.Duration)		AS AvgDuration

FROM
(
		SELECT DISTINCT
		lr.LoginRecordID,
		lr.LoginID,
		u.DisplayName,
		u.IsDisabled,
		sg.SecurityGroup,
		--lr.ComputerID,

		lr.LoginTS,
		DATEPART(YYYY,lr.LoginTS)	AS LoginYear,
		DATEPART(MM,lr.LoginTS)		AS LoginMonth,
		DATEPART(DD,lr.LoginTS)		AS LoginDayOfMonth,
		DATEPART(dw,lr.LoginTS)		AS LoginDayOfWeek,
		DATENAME(dw,lr.LoginTS)		AS LoginWeekday,

		lr.LogoutTS,
		DATEPART(YYYY,lr.LogoutTS)	AS LogoutYear,
		DATEPART(MM,lr.LogoutTS)	AS LogoutMonth,
		DATEPART(DD,lr.LogoutTS)	AS LogoutDayOfMonth,
		DATEPART(dw,lr.LogoutTS)	AS LogoutDayOfWeek,
		DATENAME(dw,lr.LogoutTS)	AS LogoutWeekday,

		DATEDIFF(hour,lr.LoginTS,lr.LogoutTS)	AS Duration,

		lr.EnteredDate

		FROM			LoginRecords	AS lr
		LEFT OUTER JOIN	Users			AS u	ON lr.LoginID = u.Login
		LEFT OUTER JOIN UserSecurity	AS us	ON u.UserID = us.UserID
		LEFT OUTER JOIN SecurityGroups	AS sg	ON us.SecurityGroupID = sg.SecurityGroupID

		WHERE	lr.LogoutTS IS NOT NULL
		--AND		lr.LoginID = 'dthompson'
		--AND lr.ComputerID = 'MFAH-TMS'
		--AND		lr.LogoutTS IS NULL
)	AS s

GROUP BY
s.DisplayName,
s.IsDisabled,
s.LoginYear,
s.LoginMonth,
s.LoginDayOfMonth,
s.LoginWeekday


--SELECT DATEDIFF(day, '2005-12-31 23:59:59.9999999', '2006-01-01 00:00:00.0000000'); 





