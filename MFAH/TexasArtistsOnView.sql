

SELECT * FROM Terms 
WHERE Term IN ('Texan')
ORDER BY TermID


SELECT
tx.ID AS ConstituentID
FROM ThesXrefs AS tx
INNER JOIN Terms AS t ON tx.TermID = t.TermID
INNER JOIN ThesXrefTypes AS txt ON tx.ThesXrefTypeID = txt.ThesXrefTypeID
INNER JOIN Constituents AS c ON tx.ID = c.ConstituentID
WHERE tx.TableID = 23
AND tx.TermID IN (201185)
ORDER BY c.AlphaSort


-- This is it.

SELECT DISTINCT oc.c_ConstituentID, oc.c_DisplayName, oc.can_AlphaSort
FROM MFAHv_OBJ_Location AS ol
INNER JOIN Objects AS o ON ol.ObjectID = o.ObjectID
INNER JOIN MFAHv_OBJ_Constituent AS oc ON o.ObjectID = oc.o_ObjectID 
									AND oc.RoleTypeID = 1
									AND oc.cxd_Unmasked = 1
WHERE ol.CurSite = 'KINDER BUILDING'
AND ol.CurUnitPosition =  'on view'
AND o.ObjectStatusID IN (2,27)
AND oc.c_ConstituentID IN
(
	SELECT
	tx.ID AS ConstituentID
	FROM ThesXrefs AS tx
	INNER JOIN Terms AS t ON tx.TermID = t.TermID
	INNER JOIN ThesXrefTypes AS txt ON tx.ThesXrefTypeID = txt.ThesXrefTypeID
	INNER JOIN Constituents AS c ON tx.ID = c.ConstituentID
	WHERE tx.TableID = 23
	AND tx.TermID IN (201185)
	--ORDER BY c.AlphaSort
)
ORDER BY oc.can_AlphaSort



