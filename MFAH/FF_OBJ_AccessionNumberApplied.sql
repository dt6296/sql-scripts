



SELECT * FROM UserFieldGroups 
WHERE ContextID = 1

SELECT * FROM UserFields
ORDER BY UserFieldName

--UserFieldID	UserFieldName
--262	Accession Number Applied


SELECT ufx.UserFieldXrefID, o.ObjectID, o.ObjectNumber, o.SortNumber, ufx.FieldValue, ufx.ValueDate, ufx.ValueRemarks
FROM UserFieldXrefs AS ufx
INNER JOIN Objects AS o ON ufx.ID = o.ObjectID AND ContextID = 1
WHERE UserFieldID = 262
AND o.ObjectStatusID = 2
AND o.DepartmentID = 11
ORDER BY o.SortNumber

