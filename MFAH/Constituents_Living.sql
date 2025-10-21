


SELECT DISTINCT oc.c_ConstituentID, c.BeginDate, c.EndDate,
CASE WHEN c.BeginDate = 0 AND c.EndDate = 0 THEN 'Undetermined' ELSE
CASE WHEN c.BeginDate <> 0 AND c.EndDate = 0 THEN 'Living' ELSE
CASE WHEN c.EndDate <> 0 THEN 'Deceased' END END END AS IsLiving,
c.DisplayName, ct.ConstituentType, c.ConstituentTypeID



FROM MFAHv_OBJ_Constituent AS oc
INNER JOIN MFAHv_OBJ AS O ON oc.o_ObjectID = o.ObjectID
INNER JOIN Constituents AS c ON oc.c_ConstituentID = c.ConstituentID
INNER JOIN ConTypes AS ct ON c.ConstituentTypeID = ct.ConstituentTypeID
WHERE o.ObjectStatusID IN (2,27)
AND oc.cx_RoleTypeID = 1
AND c.ConstituentTypeID = 1


SELECT DISTINCT
c.ConstituentID, c.BeginDate, c.EndDate,
CASE WHEN c.BeginDate = 0 AND c.EndDate = 0 THEN 'Undetermined' ELSE
CASE WHEN c.BeginDate <> 0 AND c.EndDate = 0 THEN 'Living' ELSE
CASE WHEN c.EndDate <> 0 THEN 'Deceased' END END END AS IsLiving,
c.DisplayName
FROM Constituents AS c WHERE ConstituentID IN
(
	SELECT DISTINCT cxd.ConstituentID
	FROM ConXrefs AS cx
	INNER JOIN ConXrefDetails AS cxd ON cx.ConXrefID = cxd.ConXrefID
	INNER JOIN Objects AS o ON cx.ID = o.ObjectID AND cx.TableID = 108
	WHERE cx.RoleTypeID = 1
	AND o.ObjectStatusID IN (2,27)
)
AND c.ConstituentTypeID = 1






SELECT DISTINCT
c.ConstituentID, c.BeginDate, c.EndDate,
CASE WHEN c.BeginDate = 0 AND c.EndDate = 0 THEN 'Undetermined' ELSE
CASE WHEN c.BeginDate <> 0 AND c.EndDate = 0 THEN 'Living' ELSE
CASE WHEN c.EndDate <> 0 THEN 'Deceased' END END END AS IsLiving,
c.DisplayName
FROM Constituents AS c WHERE ConstituentID IN
(
	SELECT DISTINCT cxd.ConstituentID
	FROM ConXrefs AS cx
	INNER JOIN ConXrefDetails AS cxd ON cx.ConXrefID = cxd.ConXrefID
	INNER JOIN Objects AS o ON cx.ID = o.ObjectID AND cx.TableID = 108
	WHERE cx.RoleTypeID = 1
	AND o.ObjectStatusID IN (2,27)
)
AND c.ConstituentTypeID = 1
AND CASE WHEN c.BeginDate = 0 AND c.EndDate = 0 THEN 'Undetermined' ELSE
CASE WHEN c.BeginDate <> 0 AND c.EndDate = 0 THEN 'Living' ELSE
CASE WHEN c.EndDate <> 0 THEN 'Deceased' END END END = 'Living'




-- Living Artists in Permanent Collection w/ Addresses

SELECT DISTINCT
c.ConstituentID, c.BeginDate, c.EndDate,
CASE WHEN c.BeginDate = 0 AND c.EndDate = 0 THEN 'Undetermined' ELSE
CASE WHEN c.BeginDate <> 0 AND c.EndDate = 0 THEN 'Living' ELSE
CASE WHEN c.EndDate <> 0 THEN 'Deceased' END END END AS IsLiving,
c.AlphaSort,
c.DisplayName,

ISNULL(ca.StreetLine1,'')	AS StreetLine1,
ISNULL(ca.StreetLine2,'')	AS StreetLine2,
ISNULL(ca.StreetLine3,'')	AS StreetLine3,
ISNULL(ca.City,'')			AS City,
ISNULL(ca.State,'')			AS State,
ISNULL(ca.ZipCode,'')		AS ZipCode,
ISNULL(cnt.Country,'')		AS Country

FROM Constituents AS c 
LEFT OUTER JOIN ConAddress AS ca ON c.ConstituentID = ca.ConstituentID
LEFT OUTER JOIN Countries AS cnt ON ca.CountryID = cnt.CountryID


WHERE c.ConstituentID IN
(
	SELECT DISTINCT cxd.ConstituentID
	FROM ConXrefs AS cx
	INNER JOIN ConXrefDetails AS cxd ON cx.ConXrefID = cxd.ConXrefID
	INNER JOIN Objects AS o ON cx.ID = o.ObjectID AND cx.TableID = 108
	WHERE cx.RoleTypeID = 1
	AND o.ObjectStatusID IN (2,27)
)
AND c.ConstituentTypeID = 1
AND CASE WHEN c.BeginDate = 0 AND c.EndDate = 0 THEN 'Undetermined' ELSE
CASE WHEN c.BeginDate <> 0 AND c.EndDate = 0 THEN 'Living' ELSE
CASE WHEN c.EndDate <> 0 THEN 'Deceased' END END END = 'Living'

ORDER BY c.AlphaSort




