




SELECT * FROM MFAHv_OBJ_Related WHERE ObjectID IN (121826,121827)


SELECT * FROM Relationships

RelationshipID = 12 = Frame-Artwork
RelationshipID = 40 - Object-Frame

RelationshipID = 20 = Crate-Object
RelationshipID = 39	= Object-Crate

RelationshipID = 50 = Object with crate - Crate for object (See Also)

SELECT * FROM Associations AS a WHERE a.ID1 IN (121764) OR a.ID2 IN (121764)

SELECT * FROM Associations AS a WHERE RelationshipID = 20	--3378


SELECT * FROM Associations  WHERE ID1 = 122068
CrateID = 122068

SELECT * FROM Associations  WHERE AssociationID BETWEEN 28346 AND 28346

/*
UPDATE Associations
SET ID1 = ID2, ID2 = ID1
WHERE RelationshipID = 20
AND AssociationID BETWEEN 28346 AND 28346


UPDATE Associations
SET RelationshipID = 39
WHERE RelationshipID = 20
AND AssociationID BETWEEN 28346 AND 28346
*/


SELECT * FROM Associations WHERE ID2 = 124838 - child crate

UPDATE Associations
SET RelationshipID = 50
WHERE RelationshipID = 39
AND AssociationID BETWEEN 29635 AND 29637