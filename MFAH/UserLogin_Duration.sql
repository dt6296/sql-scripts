

SELECT COUNT(*) FROM Users WHERE IsDisabled = 0




SELECT
lr.LoginID,
MAX(LogoutTS) AS MAXLogoutTS

FROM LoginRecords AS lr
INNER JOIN Users AS u ON lr.LoginID = u.Login

WHERE u.IsDisabled = 0

GROUP BY lr.LoginID



SELECT * FROM LoginRecords WHERE LoginID = 'rweaver' ORDER BY LoginTS DESC




SELECT
lr.*,
mlo.MAX_LoginTS,
mlo.MAX_LogoutTS,
DATEDIFF(YY,lr.LoginTS,GETDATE()) AS Duration_Years,
DATEDIFF(MM,lr.LoginTS,GETDATE()) AS Duration_Months,
DATEDIFF(DD,lr.LoginTS,GETDATE()) AS Duration_Days,
DATEDIFF(HH,lr.LoginTS,GETDATE()) AS Duration_Hours

FROM LoginRecords AS lr
INNER JOIN Users AS u ON lr.LoginID = u.Login
INNER JOIN
(
	SELECT 
	LoginID,
	MAX(LoginTS) AS MAX_LoginTS,
	MAX(LogoutTS) AS MAX_LogoutTS
	FROM LoginRecords
	GROUP BY LoginID
	--ORDER BY LoginID
)	AS mlo	ON lr.LoginID = mlo.LoginID

WHERE u.IsDisabled = 0
AND lr.LogoutTS IS NULL
AND lr.LoginTS = mlo.MAX_LoginTS
AND lr.LoginTS > mlo.MAX_LogoutTS	
--AND DATEDIFF(HH,lr.LoginTS,GETDATE()) > 24
AND lr.LoginID NOT IN ('gstrauss','MLuntz','sbar-tal','tstephenson','WScheuer')
--AND lr.LoginID = 'dthompson'

ORDER BY 
mlo.MAX_LoginTS,
lr.LoginID,


lr.LoginTS DESC




SELECT * FROM Users WHERE IsDisabled = 0 ORDER BY EnteredDate 




SELECT DISTINCT
u.UserID,
u.DisplayName,
u.EnteredDate,
u.IsDisabled,
u.Login,
mlo.MAX_LoginTS

FROM Users AS u
INNER JOIN LoginRecords AS lr ON u.Login = lr.LoginID
INNER JOIN
(
	SELECT 
	LoginID,
	MAX(LoginTS) AS MAX_LoginTS,
	MAX(LogoutTS) AS MAX_LogoutTS
	FROM LoginRecords
	GROUP BY LoginID
	--ORDER BY LoginID
)	AS mlo	ON lr.LoginID = mlo.LoginID

WHERE u.IsDisabled = 0

ORDER BY mlo.MAX_LoginTS DESC, u.login





