


--MFAHv_OBJ_FF_Deaccessioning

SELECT
ufx.ID	 AS ObjectID,
ufg.UserFieldGroupID,
ufg.GroupName,
ufgx.DisplayOrder,
uf.UserFieldID,
uf.UserFieldName,
uf.UserFieldType,
ufx.FieldValue,
ufx.ValueDate,
DATEPART(YYYY,ufx.ValueDate)	AS ValueYear,
DATEPART(mm,ufx.ValueDate)		AS ValueMonth,
ufx.ValueRemarks,
ufx.LoginID

--ufva.UserFieldValue -- This gives the available values

FROM		UserFieldXrefs				AS ufx	
INNER JOIN	UserFieldGroupXrefs			AS ufgx	ON	ufx.UserFieldGroupID = ufgx.UserFieldGroupID
												AND	ufx.UserFieldID = ufgx.UserFieldID
INNER JOIN	UserFieldGroups				AS ufg	ON	ufgx.UserFieldGroupID = ufg.UserFieldGroupID
INNER JOIN	UserFields					AS uf	ON	ufgx.UserFieldID = uf.UserFieldID

--LEFT OUTER JOIN UserFieldValueAuthority	AS ufva	ON	ufx.UserFieldID = ufva.UserFieldID -- This gives the available values

WHERE ufx.UserFieldGroupID = 13

ORDER BY ufx.ID, ufgx.DisplayOrder




