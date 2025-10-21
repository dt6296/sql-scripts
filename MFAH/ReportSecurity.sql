
  
SELECT 
sgx.SecGroupXrefID,
sgx.SecurityGroupID,
sg.SecurityGroup,
sgx.TableID,
sgx.ID,
r.ReportName,
r.MenuLabel,
sgx.LoginID,
sgx.EnteredDate

FROM SecGroupXrefs AS sgx
LEFT OUTER JOIN SecurityGroups AS sg ON sgx.SecurityGroupID = sg.SecurityGroupID
LEFT OUTER JOIN Reports AS r ON sgx.ID = r.ReportID


WHERE sgx.LoginID = 'dthompson'
AND sgx.EnteredDate > '2014-11-06'



--WHERE ID = 4363


--WHERE sgx.TableID = 147
--AND sgx.SecurityGroupID = 40

ORDER BY r.MenuLabel, sgx.SecurityGroupID