








SELECT DISTINCT
u.Login + '@mfah.org; ' AS email
FROM LoginRecords AS lr
INNER JOIN Users AS u ON lr.LoginID = u.Login
WHERE LogoutTS IS NULL
AND LoginTS >= '2017-06-12'