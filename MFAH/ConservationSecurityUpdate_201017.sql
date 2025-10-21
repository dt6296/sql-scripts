

-- Conservation Security Update 10/17/2020 1:00 PM


-- Construct EXEC Statements

SELECT
'EXEC CopyTMSUserSecurity ' + CAST(s.UserID AS NVARCHAR(4)) + ',' + CAST(t.UserID AS NVARCHAR(4)) + ';' 

FROM (SELECT UserID FROM Users WHERE Login = 'zConservation') AS s
CROSS JOIN
(SELECT UserID FROM Users WHERE SecurityGroupID = (SELECT SecurityGroupID FROM Users WHERE Login = 'zConservation')) AS t
 
 WHERE s.UserID <> t.UserID
 
 -- zConservation
EXEC CopyTMSUserSecurity 2649,1077;
EXEC CopyTMSUserSecurity 2649,1078;
EXEC CopyTMSUserSecurity 2649,1079;
EXEC CopyTMSUserSecurity 2649,1080;
EXEC CopyTMSUserSecurity 2649,1081;
EXEC CopyTMSUserSecurity 2649,1083;
EXEC CopyTMSUserSecurity 2649,1085;
EXEC CopyTMSUserSecurity 2649,1088;
EXEC CopyTMSUserSecurity 2649,1089;
EXEC CopyTMSUserSecurity 2649,1258;
EXEC CopyTMSUserSecurity 2649,1355;
EXEC CopyTMSUserSecurity 2649,1372;
EXEC CopyTMSUserSecurity 2649,1512;
EXEC CopyTMSUserSecurity 2649,1565;
EXEC CopyTMSUserSecurity 2649,2639;
EXEC CopyTMSUserSecurity 2649,2640;
EXEC CopyTMSUserSecurity 2649,2673;
EXEC CopyTMSUserSecurity 2649,2680;
EXEC CopyTMSUserSecurity 2649,2685;
EXEC CopyTMSUserSecurity 2649,2763;
EXEC CopyTMSUserSecurity 2649,2765;

-- zHandling
EXEC CopyTMSUserSecurity 2655,1510;
EXEC CopyTMSUserSecurity 2655,1046;
EXEC CopyTMSUserSecurity 2655,1427;