

SELECT
oc.ObjContextID,
oc.ObjectID,
i.ObjectID,
i.KeywordNotes,
i.KeywordReviewNotes

FROM ObjContext AS oc
INNER JOIN MFAHt_IMPORT_Keywords AS i ON oc.ObjectID = i.ObjectID



SELECT * FROM ObjContext AS oc
INNER JOIN MFAHt_IMPORT_Keywords AS i  ON oc.ObjectID = i.ObjectID

SELECT * FROM ObjContext AS oc
WHERE oc.ObjectID IN (SELECT ObjectID FROM MFAHt_IMPORT_Keywords)


SELECT i.* 
FROM MFAHt_IMPORT_Keywords AS i
LEFT OUTER JOIN ObjContext AS oc ON i.ObjectID = oc.ObjectID
WHERE oc.ObjectID IS NULL



--INSERT INTO ObjContext (LongText10,ShortText1)
SELECT
i.KeywordNotes,
i.KeywordReviewNotes
FROM MFAHt_IMPORT_Keywords AS i 
INNER JOIN ObjContext AS oc ON oc.ObjectID = i.ObjectID


