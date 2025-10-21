


SELECT COUNT(*) FROM TMSGroups	--	67

SELECT COUNT(*) FROM SecurityGroups	--	36

SELECT 67 * 36	--	2412




  SELECT
  sgx.TMSGroupID,
  tg.GroupName,
  sgx.SecurityGroupID,
  sg.SecurityGroup

  FROM SecurityGroupXref AS sgx
  LEFT OUTER JOIN TMSGroups AS tg ON sgx.TMSGroupID = tg.GroupID
  LEFT OUTER JOIN SecurityGroups AS sg ON sgx.SecurityGroupID = sg.SecurityGroupID





  SELECT
  tg.GroupID,
  tg.GroupName
  FROM TMSGroups AS tg
  ORDER BY tg.GroupID



SELECT        sg.SecurityGroupID, sg.SecurityGroup, sgx.TMSGroupID, tg.GroupName
FROM            SecurityGroups AS sg LEFT OUTER JOIN
                         SecurityGroupXref AS sgx ON sg.SecurityGroupID = sgx.SecurityGroupID RIGHT OUTER JOIN
                         TMSGroups AS tg ON sgx.TMSGroupID = tg.GroupID




--	This is it.

SELECT
sg.SecurityGroup,
tg.GroupID,
tg.GroupName,
sgx.SecurityGroupID
FROM TMSGroups AS tg
CROSS JOIN SecurityGroups AS sg
LEFT OUTER JOIN SecurityGroupXref AS sgx ON tg.GroupID = sgx.TMSGroupID AND sg.SecurityGroupID = sgx.SecurityGroupID
ORDER BY sg.SecurityGroupID, tg.GroupName