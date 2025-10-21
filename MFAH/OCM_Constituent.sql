




SELECT TOP 100
can.AltNameId,
can.ConstituentID,
can.DisplayName,
can.AlphaSort,
can.EnteredDate,
can.LoginID,
c.DisplayName,
c.AlphaSort

FROM			ConAltNames		AS can
LEFT OUTER JOIN	Constituents	AS c	ON c.ConstituentID = can.ConstituentID

WHERE can.AlphaSort LIKE '%goldschmidt%' OR can.AlphaSort LIKE '%gego%'

ORDER BY c.ConstituentID, can.AlphaSort




SELECT * FROM MFAHv_OCM_ObjectMaker
ORDER BY cxd_ConstituentID, cxd_NameID