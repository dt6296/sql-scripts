



---vMFAH_MFAH_Employee


SELECT
c.ConstituentID,
c.AlphaSort,
c.LastName,
c.FirstName,
c.Institution,
c.DisplayName,
c.Position,
ce.EMailAddress,
cp.PhoneNumber,
cp.Description,
a.AssociationID,
a.ID1,
r.Relation1,
a.ID2,
r.Relation2,
a.TableID,
a.RelationshipID,
a.EnteredDate,
r.Description,
r.RelationshipTypeID


FROM			Constituents	AS c
LEFT OUTER JOIN	ConEMail		AS ce	ON c.ConstituentID = ce.ConstituentID
LEFT OUTER JOIN ConPhones		AS cp	ON c.ConstituentID = cp.ConstituentID
LEFT OUTER JOIN Associations	AS a	ON c.ConstituentID = a.ID2	AND a.ID1 = 0
LEFT OUTER JOIN Relationships	AS r	ON a.RelationshipID = r.RelationshipID

WHERE	a.TableID = 23


--c.ConstituentID = 18901	


--SELECT * FROM Relationships WHERE RelationshipID = 29



-- USE THIS ONE

SELECT
c.ConstituentID,
c.DisplayName,
c.AlphaSort,
c.LastName,
c.MiddleName,
c.FirstName,
c.Institution,
c.Position,
a.AssociationID,
a.ID1,
r.Relation1,
a.ID2,
r.Relation2,
a.TableID,
a.RelationshipID,
a.EnteredDate,
r.Description,
r.RelationshipTypeID


FROM			Constituents	AS c
LEFT OUTER JOIN Associations	AS a	ON c.ConstituentID = a.ID2	AND a.ID1 = 0
LEFT OUTER JOIN Relationships	AS r	ON a.RelationshipID = r.RelationshipID

WHERE	a.TableID = 23
AND		a.ID1 = 0
AND		a.RelationshipID = 29

ORDER BY c.Institution, c.AlphaSort
