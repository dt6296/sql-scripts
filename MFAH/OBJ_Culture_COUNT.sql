




SELECT oc.Culture, COUNT(oc.ObjectID)

FROM	ObjContext	AS oc

WHERE oc.Culture IS NOT NULL

GROUP BY oc.Culture







SELECT COUNT(*) AS ObjectCount, Culture--, WebsiteApproved
FROM MFAHv_OBJ
WHERE ObjectStatusID IN (2,27)
AND WebsiteApproved = 1
GROUP BY Culture--, WebsiteApproved
ORDER BY Culture



