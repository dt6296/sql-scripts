





SELECT
o.ObjectID,
o.ObjectNumber,
oc.LongText10 AS KeywordField

FROM Objects AS o
LEFT OUTER JOIN ObjContext AS oc ON o.ObjectID = oc.ObjectID

WHERE o.ObjectID IN

(
	SELECT ID FROM PackageList WHERE PackageID = 255937
)
ORDER BY o.SortNumber




--SELECT * FROM Packages WHERE Name LIKE '%Accessions%'

/*
PackageID	Name
257051		Photo Accessions 2010
257050		Photo Accessions 2011
257049		Photo Accessions 2012
257048		Photo Accessions 2013
257046		Photo Accessions 2014
257045		Photo Accessions 2015
257044		Photo Accessions 2016
257037		Photo Accessions 2017
255938		Photo Accessions 2018
255937		Photo Accessions 2019
*/



SELECT
tx.ID AS ObjectID,
tx.TermID,
t.Term,
dbo.MFAHfx_ConcatObjThesTerms(tx.ID) AS Attributes

FROM ThesaurusBases AS tb
LEFT OUTER JOIN ClassificationNotations AS cn ON tb.ThesaurusBaseID = cn.ThesaurusBaseID
LEFT OUTER JOIN Terms AS t ON cn.TermMasterID = t.TermMasterID
LEFT OUTER JOIN ThesXrefs AS tx ON t.TermID = tx.TermID

WHERE tb.ThesaurusBaseID = 8
AND cn.CN LIKE 'TGO.AAE.AAA.%'
AND tx.TableID = 108
AND tx.Active = 1
AND tx.ID IN (SELECT ID FROM PackageList WHERE PackageID = 255937)

---------------------------------------------------------------------------------------------------
THIS IS IT !!!


SELECT 
o.ObjectID,
o.ObjectNumber,
oc.LongText10 AS KeywordNotes,
dbo.MFAHfx_ConcatObjThesTerms(o.ObjectID) AS Attributes

FROM Objects AS o
INNER JOIN ObjContext AS oc ON o.ObjectID = oc.ObjectID

WHERE o.DepartmentID = 11
AND o.ObjectNumber LIKE '2019.%' 






















