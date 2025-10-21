


SELECT
Login + '@mfah.org; ' AS Email
FROM Users
WHERE IsDisabled = 0
AND DisplayName LIKE '%,%'



SELECT * FROM Users WHERE IsDisabled = 0 ORDER BY DisplayName


SELECT DisplayName, DomainName, Login FROM Users WHERE IsDisabled = 0
ORDER BY DisplayName

--UPDATE Users
SET IsDisabled = 1
WHERE IsDisabled = 0 AND DisplayName LIKE '%2017%'
AND Login NOT IN ('astanford','lwalsh','tkubala')