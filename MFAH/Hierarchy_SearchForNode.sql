



SELECT * FROM SecurityGroups -- 101

SELECT * FROM DDColumns WHERE ColumnName = 'Rank' -- 2874

SELECT * FROM DDSecGrpXref WHERE securityGroupId = 101 and ColumnID = 2874

SELECT * FROM DDTables WHERE TableName = 'MediaXrefs'


SELECT *
FROM DDSecGrpXref AS sgx
INNER JOIN DDHierarchy AS h ON sgx.HierarchyID = h.HierarchyID
WHERE sgx.SecurityGroupId = 101 and sgx.ColumnID = 2874
--AND h.HierarchyID = 1240
AND h.HierarchyRoot = 'a0108'
AND h.TableID = 324



