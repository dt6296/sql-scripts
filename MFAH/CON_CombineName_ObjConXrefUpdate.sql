
--CombineConstituentNames
--4/24/14




SELECT * FROM ConAltNames WHERE ConstituentID = 4497
22697 - 38432




SELECT ConXrefDetails.*
FROM ConXrefDetails
INNER JOIN ConXrefs ON  ConXrefDetails.ConXrefID = ConXrefs.ConXrefID
WHERE NameID = 22697
AND ConXrefs.TableID = 108 
AND ConXrefs.ID BETWEEN 122566 AND 122584


UPDATE ConXrefDetails
SET NameID = 38432
FROM ConXrefDetails
LEFT OUTER JOIN ConXrefs ON  ConXrefDetails.ConXrefID = ConXrefs.ConXrefID
WHERE NameID = 22697
AND ConXrefs.TableID = 108 
AND ConXrefs.ID BETWEEN 122566 AND 122584





SELECT * FROM ConAltNames WHERE ConstituentID = 4498
22698 > 38433

SELECT ConXrefDetails.*
FROM ConXrefDetails
INNER JOIN ConXrefs ON  ConXrefDetails.ConXrefID = ConXrefs.ConXrefID
WHERE NameID = 22698
AND ConXrefs.TableID = 108 
AND ConXrefs.ID BETWEEN 122566 AND 122584



UPDATE ConXrefDetails
SET NameID = 38433
FROM ConXrefDetails
LEFT OUTER JOIN ConXrefs ON  ConXrefDetails.ConXrefID = ConXrefs.ConXrefID
WHERE NameID = 22698
AND ConXrefs.TableID = 108 
AND ConXrefs.ID BETWEEN 122566 AND 122584


SELECT * FROM ConXrefs
WHERE TableID = 108
AND ID BETWEEN 122566 AND 122584
AND RoleID = 2


UPDATE ConXrefs
SET Displayed = 0
WHERE TableID = 108
AND ID BETWEEN 122566 AND 122584
AND RoleID = 2
AND DisplayOrder = 2