





SELECT ObjectID, ConstituentID, RoleID, COUNT(*)
FROM MFAHv_OCM_ObjectMaker
GROUP BY ObjectID, ConstituentID, RoleID
HAVING COUNT(*) > 1