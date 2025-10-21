










SELECT
c.ConstituentID,
c.DisplayName,
c.BeginDate,
c.EndDate,
o.ObjectID,
o.ObjectNumber

FROM Constituents AS c
INNER JOIN ConXrefDetails AS cxd ON cxd.ConstituentID = c.ConstituentID
INNER JOIN ConXrefs AS cx ON cxd.ConXrefID = cx.ConXrefID
INNER JOIN Objects AS o ON cx.ID = o.ObjectID AND cx.TableID = 108

WHERE c.EndDate = 1946
AND o.ObjectStatusID IN (2,27)
AND cxd.UnMasked = 1
















