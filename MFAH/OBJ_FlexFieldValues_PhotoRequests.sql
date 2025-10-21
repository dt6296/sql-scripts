

-----  Photography Request Status - ALL Objects with this group attached.

SELECT
o.ObjectID,
o.ObjectNumber,
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
ufx.ValueRemarks


--ufva.UserFieldValue

FROM Objects							AS o
INNER JOIN UserFieldXrefs				AS ufx	ON	o.ObjectID = ufx.ID	AND ufx.ContextID = 1
INNER JOIN UserFieldGroupXrefs			AS ufgx	ON	ufx.UserFieldGroupID = ufgx.UserFieldGroupID
												AND	ufx.UserFieldID = ufgx.UserFieldID
INNER JOIN UserFieldGroups				AS ufg	ON	ufgx.UserFieldGroupID = ufg.UserFieldGroupID
INNER JOIN UserFields					AS uf	ON	ufgx.UserFieldID = uf.UserFieldID

--LEFT OUTER JOIN UserFieldValueAuthority	AS ufva	ON	ufx.UserFieldID = ufva.UserFieldID

WHERE ufx.UserFieldGroupID = 7

ORDER BY o.ObjectID, ufgx.DisplayOrder



(
	SELECT
	hox.ObjectID

	FROM Associations				AS a
	LEFT OUTER JOIN HistEvents		AS he	ON a.ID2 = he.HistEventID
	LEFT OUTER JOIN HistObjXrefs	AS hox	ON he.HistEventID = hox.HistEventID

	WHERE 
	a.TableID = 108	--HistEvents
	--AND a.ID1 = 10	--Data Standardization FY 2014
	--AND he.HistEventID IN (11,19)	--Data Cleanup Events (Stage I)
	--AND he.HistEventID IN (17)		--Test Records
	AND he.HistEventID = 18		--Works on Paper Photography Project
)


select * from HistEvents  

SELECT * FROM DDTables WHERE TableID = 187 --HistEvents

SELECT * FROM Associations WHERE TableID = 108


SELECT * FROM  HistObjXrefs
WHERE HistEventID = 18



-------------------------


SELECT
he.EventName,
he.HistEventID,
o.ObjectID,
o.ObjectNumber,
	s.UserFieldGroupID,
	CASE WHEN s.UserFieldGroupID IS NULL THEN 'Photography Request Status' ELSE s.GroupName END AS GroupName,
	CASE WHEN s.UserFieldGroupID IS NULL THEN 0 ELSE s.DisplayOrder END AS DisplayOrder,
	s.UserFieldID,
	CASE WHEN s.UserFieldID IS NULL THEN 'Not Started' ELSE s.UserFieldName END AS UserFieldName,
	s.UserFieldType,
	CASE WHEN s.UserFieldID IS NULL THEN 1 ELSE s.FieldValue END AS FieldValue,
	s.FieldValue,
	s.ValueDate,
	DATEPART(YYYY,s.ValueDate)	AS ValueYear,
	DATEPART(mm,s.ValueDate)		AS ValueMonth,
	s.ValueRemarks

FROM Objects						AS o
LEFT OUTER JOIN	HistObjXrefs		AS hox	ON	o.ObjectID = hox.ObjectID
LEFT OUTER JOIN HistEvents			AS he	ON	hox.HistEventID = he.HistEventID

LEFT OUTER JOIN
(
	SELECT
	--o.ObjectID,
	ufg.UserFieldGroupID,
	ufg.GroupName,
	ufgx.DisplayOrder,
	uf.UserFieldID,
	uf.UserFieldName,
	uf.UserFieldType,
	ufx.ID,
	o.ObjectID,
	ufx.FieldValue,
	ufx.ValueDate,
	DATEPART(YYYY,ufx.ValueDate)	AS ValueYear,
	DATEPART(mm,ufx.ValueDate)		AS ValueMonth,
	ufx.ValueRemarks

	FROM			UserFieldGroups		AS ufg
	LEFT OUTER JOIN	UserFieldGroupXrefs	AS ufgx	ON	ufg.UserFieldGroupID = ufgx.UserFieldGroupID
	LEFT OUTER JOIN	UserFields			AS uf	ON	ufgx.UserFieldID = uf.UserFieldID
	LEFT OUTER JOIN	UserFieldXrefs		AS ufx	ON	ufgx.UserFieldID = ufx.UserFieldID
												AND	ufx.ContextID = 1
	LEFT OUTER JOIN	Objects				AS o	ON	o.ObjectID = ufx.ID
	
	WHERE ufg.UserFieldGroupID = 7
	
) AS s	ON o.ObjectID = s.ObjectID

WHERE 	he.HistEventID = 18

ORDER BY o.ObjectID

