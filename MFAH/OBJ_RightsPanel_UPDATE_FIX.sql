



SELECT * FROM ConXrefs WHERE EnteredDate > '2018-03-09 00:00:00' AND LoginID = 'dthompson' AND TableID = 126

--SELECT * FROM DDTables WHERE TableID IN (81,51,345)





SELECT * FROM ConXrefDetails WHERE EnteredDate > '2018-03-09 00:00:00' AND LoginID = 'dthompson' AND ConstituentID = 2533

SELECT * FROM ConXrefDetails WHERE EnteredDate > '2018-03-09 00:00:00' AND LoginID = 'dthompson' AND ConstituentID = 6573



SELECT
o.ObjectID,
o.ObjectNumber,
ort.*,
cx.*,
cxd.*

FROM Objects AS o
LEFT OUTER JOIN ObjRights AS ort ON o.ObjectID = ort.ObjectID
INNER JOIN ConXrefs AS cx ON cx.ID = ort.ObjRightsID AND TableID = 126
INNER JOIN ConXrefDetails AS cxd ON cx.ConXrefID = cxd.ConXrefID

WHERE o.ObjectID = 6379



SELECT
pl.PackageID,

o.ObjectID,
o.ObjectNumber,
ort.ObjRightsID,

cx.ConXrefID,
cx.RoleTypeID,
cx.RoleID,
cx.Displayed,
cx.DisplayOrder,
cx.EnteredDate,
cx.LoginID,

cxd.ConXrefDetailID,
cxd.ConstituentID,
cxd.RoleTypeID,
cxd.UnMasked,
cxd.EnteredDate,
cxd.LoginID,

c.DisplayName

FROM Objects AS o
INNER JOIN ObjRights AS ort ON o.ObjectID = ort.ObjectID
INNER JOIN ConXrefs AS cx ON cx.ID = ort.ObjRightsID AND TableID = 126
INNER JOIN ConXrefDetails AS cxd ON cx.ConXrefID = cxd.ConXrefID
INNER JOIN Constituents AS c ON cxd.ConstituentID = c.ConstituentID
INNER JOIN PackageList AS pl ON pl.ID = o.ObjectID AND pl.TableID = 108

WHERE pl.PackageID = 172870
AND cxd.EnteredDate > '2018-03-09 00:00'
AND cxd.LoginID = 'dthompson'



--DELETE FROM ConXrefDetails WHERE ConXrefDetailID IN
(
	SELECT ConXrefDetailID
	FROM Objects AS o
	INNER JOIN ObjRights AS ort ON o.ObjectID = ort.ObjectID
	INNER JOIN ConXrefs AS cx ON cx.ID = ort.ObjRightsID AND TableID = 126
	INNER JOIN ConXrefDetails AS cxd ON cx.ConXrefID = cxd.ConXrefID
	INNER JOIN Constituents AS c ON cxd.ConstituentID = c.ConstituentID
	INNER JOIN PackageList AS pl ON pl.ID = o.ObjectID AND pl.TableID = 108
	WHERE pl.PackageID = 172870
	AND cxd.EnteredDate > '2018-03-09 00:00'
	AND cxd.LoginID = 'dthompson'
)


--DELETE FROM ConXrefs WHERE ConXrefID IN
(
	SELECT DISTINCT cx.ConXrefID
	FROM Objects AS o
	INNER JOIN ObjRights AS ort ON o.ObjectID = ort.ObjectID
	INNER JOIN ConXrefs AS cx ON cx.ID = ort.ObjRightsID AND TableID = 126
	--INNER JOIN ConXrefDetails AS cxd ON cx.ConXrefID = cxd.ConXrefID
	--INNER JOIN Constituents AS c ON cxd.ConstituentID = c.ConstituentID
	INNER JOIN PackageList AS pl ON pl.ID = o.ObjectID AND pl.TableID = 108
	WHERE pl.PackageID = 172870
	AND cx.EnteredDate > '2018-03-09 00:00'
	AND cx.LoginID = 'dthompson'
)


-----------------------------------------------------------------------------------------

SELECT
cx.ConXrefID, cx.TableID, cx.EnteredDate, cx.LoginID, cx.*
FROM ConXrefs AS cx
LEFT OUTER JOIN ConXrefDetails AS cxd ON cx.ConXrefID = cxd.ConXrefID
WHERE cxd.ConXrefID IS NULL




SELECT
o.ObjectID,
o.ObjectNumber,
ort.ObjRightsID,
cx.*,
cxd.*
FROM Objects AS o
LEFT OUTER JOIN ObjRights AS ort ON o.ObjectID = ort.ObjectID
LEFT OUTER JOIN ConXrefs AS cx ON ort.ObjRightsID = cx.ID AND cx.TableID = 126
LEFT OUTER JOIN ConXrefDetails AS cxd ON cx.ConXrefID = cxd.ConXrefID

WHERE o.ObjectNumber = '2010.2198'




	SELECT
	o.ObjectID,o.ObjectNumber,ort.ObjRightsID,COUNT(*)
	--ort.ObjRightsID
	FROM Objects AS o
	LEFT OUTER JOIN ObjRights AS ort ON o.ObjectID = ort.ObjectID
	LEFT OUTER JOIN ConXrefs AS cx ON ort.ObjRightsID = cx.ID AND cx.TableID = 126
	WHERE cx.DisplayOrder = 1
	GROUP BY 
	o.ObjectID,
	o.ObjectNumber,
	ort.ObjRightsID
	HAVING COUNT(*) > 1






--UPDATE ConXrefs SET DisplayOrder = 2
WHERE ConXrefID IN
(
	SELECT sub.ConXrefID
	FROM
	(
		SELECT cx.ConXrefID,cx.DisplayOrder,cx.EnteredDate,ort.ObjRightsID,RANK() OVER (PARTITION BY cx.ID ORDER BY cx.EnteredDate ASC) AS RNK
		FROM ConXrefs AS cx
		INNER JOIN ObjRights AS ort ON cx.ID = ort.ObjRightsID AND cx.TableID = 126
		WHERE ort.ObjRightsID IN
		(
			SELECT
			--o.ObjectID,o.ObjectNumber,ort.ObjRightsID,COUNT(*)
			ort.ObjRightsID
			FROM Objects AS o
			LEFT OUTER JOIN ObjRights AS ort ON o.ObjectID = ort.ObjectID
			LEFT OUTER JOIN ConXrefs AS cx ON ort.ObjRightsID = cx.ID AND cx.TableID = 126
			WHERE cx.DisplayOrder = 1
			GROUP BY 
			o.ObjectID,
			o.ObjectNumber,
			ort.ObjRightsID
			HAVING COUNT(*) > 1
		)
	)	AS sub
	WHERE sub.RNK = 2
)

