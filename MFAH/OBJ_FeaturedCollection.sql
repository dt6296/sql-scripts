








SELECT * FROM Associations AS a
WHERE a.RelationshipID = 42





SELECT r.* FROM Relationships AS r
WHERE r.RelationshipID = 42


SELECT * FROM MFAHv_OBJ_Related WHERE --ObjectID = 60082
RelationshipID = 42



SELECT o.ObjectID
FROM MFAHv_OBJ AS o
WHERE o.AccessionISODate >= GETDATE() - 180
or o.ObjectID = 60082
ORDER BY o.ObjectID



------7/25/2014



SELECT ap.* FROM AssocParents AS ap WHERE ap.ID = 92423 AND ap.TableID = 108


SELECT r.* FROM Relationships AS r WHERE r.RelationshipID = 42


SELECT a.* FROM Associations AS a WHERE a.RelationshipID = 42


SELECT
o.ObjectID AS CollectionID,
a.ID2 AS WorkID,
o.ObjectNumber,
o.Title

FROM MFAHv_OBJ AS o
LEFT OUTER JOIN Associations AS a ON o.ObjectID = a.ID1 AND a.TableID = 108 
WHERE a.RelationshipID = 42



----------- this was it.  But I tried looking for Garth Clark, no object record for the collection.
--I think I'll have to pull from acq-related constituent role = Collection.

SELECT
orr.RelationshipType,
orr.RelationshipID,
Relationship,
ObjectID,
RelatedObjectID,
RelationFocus,
RelationTarget,
ObjectNumber,
ObjectType,
ObjectLevel,
IsVirtualDisplay,
Title


FROM MFAHv_OBJ_RelatedAndRecent AS orr
WHERE orr.RelationshipID IN (42,999)





SELECT * FROM MFAHv_OBJ_Constituent WHERE cx_RoleTypeID = 2 AND cx_RoleID = 36  -- this returned 11,645 records.


SELECT * FROM Roles

--This is it.-----------------------------------------------------------------------------------

SELECT
oc.o_ObjectID AS ObjectID,
oc.cx_ConXrefID AS ConXrefID,
DisplayName

FROM MFAHv_OBJ_Constituent AS oc

WHERE oc.cx_RoleTypeID = 2 AND oc.cx_RoleID = 36

UNION

SELECT 
o.ObjectID,
0 AS ConXrefID,
'Recent Accessions'

FROM MFAHv_OBJ AS o
WHERE o.AccessionISODate >= GETDATE() - 180




