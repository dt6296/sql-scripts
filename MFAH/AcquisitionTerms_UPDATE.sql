




SELECT oa.* 
FROM ObjAccession AS oa
INNER JOIN Objects AS o ON oa.ObjectID = o.ObjectID
WHERE o.ObjectNumber LIKE '2014.660.%'






SELECT AcquisitionTerms FROM ObjAccession WHERE ObjectID = 123413



--UPDATE ObjAccession
SET AcquisitionTerms = (SELECT AcquisitionTerms FROM ObjAccession WHERE ObjectID = 123413)
FROM ObjAccession AS oa
INNER JOIN Objects AS o ON oa.ObjectID = o.ObjectID
WHERE o.ObjectNumber LIKE '2014.660.%'
AND o.ObjectID <> 123413



