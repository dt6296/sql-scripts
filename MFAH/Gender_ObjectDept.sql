


/*

SELECT * FROM DDLocalColumnNames WHERE ColumnLabel LIKE 'Data%'
AND LanguageID = 1



SELECT * FROM DDColumns WHERE ColumnID = 1266	-- Objects

SELECT * FROM DDColumns WHERE ColumnID = 4458	-- Constituents

*/



SELECT DISTINCT ConstituentType, DisplayName, TermID, Term, Role, ObjectID
FROM
(

	SELECT DISTINCT
	o.ObjectID,
	o.ObjectNumber,
	o.DateBegin,
	o.DateEnd,
	o.Dated,
	cx.ConXrefID,
	ct.ConstituentType,
	cxd.ConstituentID,
	c.DisplayName,
	c.Approved AS DataStandardsApproved,
	r.Role,
	t.ThesXrefType,
	t.TermID,
	t.Term,
	t.IsMale,
	t.IsFemale,
	t.LocalTerm,
	t.GenderTerm

	FROM Objects AS o
	LEFT OUTER JOIN ConXrefs AS cx ON o.ObjectID = cx.ID AND cx.TableID = 108
	LEFT OUTER JOIN ConXrefDetails AS cxd ON cx.ConXrefID = cxd.ConXrefID
	LEFT OUTER JOIN Constituents AS c ON cxd.ConstituentID = c.ConstituentID
	LEFT OUTER JOIN ConTypes AS ct ON c.ConstituentTypeID = ct.ConstituentTypeID
	LEFT OUTER JOIN Roles AS r ON cx.RoleID = r.RoleID
	LEFT OUTER JOIN ObjAccession AS oa ON o.ObjectID = oa.ObjectID
	LEFT OUTER JOIN
	(
		SELECT
		tx.ThesXrefID,
		tx.ThesXrefTypeID,
		txt.ThesXrefType,
		tx.ID,
		tx.TableID,
		tx.TermID,
		tx.ThesXrefTableID,
		t.Term,
		CASE WHEN t.Term LIKE 'male' THEN 1 ELSE 0 END AS IsMale,
		CASE WHEN t.Term LIKE 'female' THEN 1 ELSE 0 END AS IsFemale,
		t.LocalTerm,
		CASE WHEN t.TermID IN (105,106,1336160) THEN 'New' ELSE
		CASE WHEN t.TermID IS NULL THEN 'Not Entered' ELSE 'Old' END END AS GenderTerm,
		c.ConstituentID,
		c.ConstituentTypeID,
		c.DisplayName,
		c.Approved AS DataStandardsApproved

		FROM ThesXrefs AS tx
		INNER JOIN Terms AS t ON tx.TermID = t.TermID
		INNER JOIN ThesXrefTypes AS txt ON tx.ThesXrefTypeID = txt.ThesXrefTypeID
		INNER JOIN Constituents AS c ON tx.ID = c.ConstituentID

		WHERE tx.TableID = 23		-- Constituents
		AND tx.Active = 1			-- Active attributes (not deleted)
		--AND tx.TermID IN (105,106,101460,101469,201187,201188,201452,1191120,1237270,1293269,1336160) -- male, female, unknown
		AND tx.TermID IN (105,106,1336160)

	) AS t ON cxd.ConstituentID = t.ID

	WHERE	o.ObjectStatusID	=	2	--	Accessioned objects
	AND		cx.RoleTypeID		=	1		--	Object-related
	AND		cxd.UnMasked		=	1
	--AND		o.DepartmentID		=	11		--	Photography
	--AND		o.DateEnd			<	1965
	AND		oa.AccessionISODate >= '2011%'
	AND		c.ConstituentTypeID =	1

) AS x












--AND t.ThesXrefID IS NOT NULL

--ORDER BY o.SortNumber


--	105		female
--	106		male
--	1336160	unknown


/*


SELECT * FROM ConXrefDetails


SELECT
tx.ThesXrefID,
tx.ThesXrefTypeID,
txt.ThesXrefType,
tx.ID,
tx.TableID,
tx.TermID,
tx.ThesXrefTableID,
t.Term,
c.DisplayName
FROM ThesXrefs AS tx
INNER JOIN Terms AS t ON tx.TermID = t.TermID
INNER JOIN ThesXrefTypes AS txt ON tx.ThesXrefTypeID = txt.ThesXrefTypeID
INNER JOIN Constituents AS c ON tx.ID = c.ConstituentID
WHERE tx.TableID = 23
AND tx.TermID IN (105,106,101460,101469,201187,201188,201452,1191120,1237270,1293269)
ORDER BY c.AlphaSort

*/



TermID IN (105,106,101460,101469,201187,201188,201452,1191120,1237270,1293269,1336160)


SELECT * FROM Terms WHERE Term LIKE '%unknown%'




SELECT
t.TermID,
t.TermMasterID,
t.TermTypeID,
t.Term,
tmt.*

FROM Terms AS t
LEFT OUTER JOIN TermMasterThes AS tmt ON t.TermMasterID = tmt.TermMasterID
WHERE TermID IN (105,106,101460,101469,201187,201188,201452,1191120,1237270,1293269,1336160)

SELECT * FROM TermMasterThes WHERE SourceTermID IN (189557,189559)


SELECT * FROM TermMasterThes WHERE TermMasterID IN (105,106,101460,101469,201187,201188,201452,1191120,1237270,1293269,1336160)

SELECT * FROM TermTypes





SELECT
tx.*,
t.*,
txt.*
FROM ThesXrefs AS tx
LEFT OUTER JOIN Terms AS t ON tx.TermID = t.TermID
LEFT OUTER JOIN ThesXrefTypes AS txt ON tx.ThesXrefTypeID = txt.ThesXrefTypeID
WHERE tx.ID = 29872 
AND tx.TableID = 23 
AND tx.ThesXrefTableID = 343
AND tx.Active = 1




SELECT * FROM DDTables WHERE TableID = 343	--ThesXrefs Attributes

SELECT * FROM ThesXrefTypes ORDER BY ThesXrefType


-----------------------------------------------------------------------------------	This gives me each obj - 9681


SELECT
o.ObjectID,
o.ObjectNumber

FROM Objects AS o					-- = 9681 = TMS count when running in Advanced Query

WHERE o.ObjectStatusID IN (2,27)	-- accessioned
AND o.DepartmentID = 9				-- Prints & Drawings



-----------------------------------------------------------------------------------	This gives me each obj-con xref - 15758


SELECT
o.ObjectID,
o.ObjectNumber,
c.c_DisplayName

FROM Objects AS o					-- = 9681 = TMS count when running in Advanced Query
LEFT OUTER JOIN MFAHv_OBJ_Constituent AS c ON o.ObjectID = c.o_ObjectID AND c.cx_RoleTypeID = 1		-- = 15756 = ConXrefs

WHERE o.ObjectStatusID IN (2,27)	-- accessioned
AND o.DepartmentID = 9				-- Prints & Drawings






SELECT
o.ObjectID,
o.ObjectNumber,
c.c_DisplayName

FROM Objects AS o					-- = 9681 = TMS count when running in Advanced Query
LEFT OUTER JOIN MFAHv_OBJ_Constituent AS c ON o.ObjectID = c.o_ObjectID AND c.cx_RoleTypeID = 1		-- = 15756 = ConXrefs

WHERE o.ObjectStatusID IN (2,27)	-- accessioned
AND o.DepartmentID = 9				-- Prints & Drawings


--------------------------------------------------------------------------------------------------  10/16/2019




/*

SELECT
o.ObjectID,
o.ObjectNumber,
c.c_DisplayName
FROM Objects AS o
LEFT OUTER JOIN ObjAccession AS oa ON o.ObjectID = oa.ObjectID
LEFT OUTER JOIN MFAHv_OBJ_Constituent AS c ON o.ObjectID = c.o_ObjectID AND c.cx_RoleTypeID = 1		-- = 15756 = ConXrefs
WHERE o.ObjectStatusID = 2
AND oa.AccessionISODate >= '2011-01-01'

*/



SELECT DISTINCT ConstituentType, DisplayName, Role, TermID, Term, x.IsFemale
FROM
(

	SELECT DISTINCT
	o.ObjectID,
	o.ObjectNumber,
	o.DateBegin,
	o.DateEnd,
	o.Dated,
	oa.AccessionISODate,
	cx.ConXrefID,
	ct.ConstituentType,
	cxd.ConstituentID,
	c.DisplayName,
	r.Role,
	t.ThesXrefType,
	t.TermID,
	t.Term,
	t.IsMale,
	t.IsFemale,
	t.LocalTerm,
	t.GenderTerm

	FROM Objects AS o
	LEFT OUTER JOIN ConXrefs AS cx ON o.ObjectID = cx.ID AND cx.TableID = 108
	LEFT OUTER JOIN ConXrefDetails AS cxd ON cx.ConXrefID = cxd.ConXrefID
	LEFT OUTER JOIN Constituents AS c ON cxd.ConstituentID = c.ConstituentID
	LEFT OUTER JOIN ConTypes AS ct ON c.ConstituentTypeID = ct.ConstituentTypeID
	LEFT OUTER JOIN Roles AS r ON cx.RoleID = r.RoleID
	LEFT OUTER JOIN ObjAccession AS oa ON o.ObjectID = oa.ObjectID
	LEFT OUTER JOIN
	(
		SELECT
		tx.ThesXrefID,
		tx.ThesXrefTypeID,
		txt.ThesXrefType,
		tx.ID,
		tx.TableID,
		tx.TermID,
		tx.ThesXrefTableID,
		t.Term,
		CASE WHEN t.Term LIKE 'male' THEN 1 ELSE 0 END AS IsMale,
		CASE WHEN t.Term LIKE 'female' THEN 1 ELSE 0 END AS IsFemale,
		t.LocalTerm,
		CASE WHEN t.TermID IN (105,106,1336160) THEN 'New' ELSE
		CASE WHEN t.TermID IS NULL THEN 'Not Entered' ELSE 'Old' END END AS GenderTerm,
		c.ConstituentID,
		c.DisplayName

		FROM ThesXrefs AS tx
		INNER JOIN Terms AS t ON tx.TermID = t.TermID
		INNER JOIN ThesXrefTypes AS txt ON tx.ThesXrefTypeID = txt.ThesXrefTypeID
		INNER JOIN Constituents AS c ON tx.ID = c.ConstituentID

		WHERE tx.TableID = 23		-- Constituents
		AND tx.Active = 1			-- Active attributes (not deleted)
		--AND tx.TermID IN (105,106,101460,101469,201187,201188,201452,1191120,1237270,1293269,1336160) -- male, female, unknown
		AND tx.TermID IN (105,106,1336160)
		AND c.ConstituentTypeID = 1	-- Person

	) AS t ON cxd.ConstituentID = t.ID 

	WHERE	o.ObjectStatusID	=	2			--	Accessioned objects
	AND		cx.RoleTypeID		=	1			--	Object-related
	AND		cxd.UnMasked		=	1
	AND		oa.AccessionISODate >= '2011-01-01'
	AND		c.ConstituentTypeID	=	1			--	Person
	AND		t.IsFemale			=	1

) AS x



SELECT ID
FROM ConXrefs
WHERE TableID = 108
AND RoleTypeID = 1

SELECT * FROM ConXrefDetails








SELECT cx.ID AS ObjectID, o.ObjectNumber, cxd.ConstituentID, cxd.NameID, sq.IsFemale, sq.IsMale, sq.DisplayName, sq.Term AS Gender
FROM ConXrefs AS cx
LEFT OUTER JOIN ConXrefDetails AS cxd ON cx.ConXrefID = cxd.ConXrefID
LEFT OUTER JOIN Constituents AS c ON cxd.ConstituentID = c.ConstituentID
LEFT OUTER JOIN Objects AS o ON cx.ID = o.ObjectID AND cx.TableID = 108
LEFT OUTER JOIN ObjAccession AS oa ON o.ObjectID = oa.ObjectID
LEFT OUTER JOIN
(
		SELECT
		tx.ThesXrefID,
		tx.ThesXrefTypeID,
		txt.ThesXrefType,
		tx.ID,
		tx.TableID,
		tx.TermID,
		tx.ThesXrefTableID,
		t.Term,
		CASE WHEN t.Term LIKE 'male' THEN 1 ELSE 0 END AS IsMale,
		CASE WHEN t.Term LIKE 'female' THEN 1 ELSE 0 END AS IsFemale,
		t.LocalTerm,
		CASE WHEN t.TermID IN (105,106,1336160) THEN 'New' ELSE
		CASE WHEN t.TermID IS NULL THEN 'Not Entered' ELSE 'Old' END END AS GenderTerm,
		c.ConstituentID,
		c.ConstituentTypeID,
		c.DisplayName

		FROM ThesXrefs AS tx
		INNER JOIN Terms AS t ON tx.TermID = t.TermID
		INNER JOIN ThesXrefTypes AS txt ON tx.ThesXrefTypeID = txt.ThesXrefTypeID
		INNER JOIN Constituents AS c ON tx.ID = c.ConstituentID

		WHERE tx.TableID = 23		-- Constituents
		AND tx.Active = 1			-- Active attributes (not deleted)
		AND tx.TermID IN (105,106,1336160)
		AND c.ConstituentTypeID = 1	-- Person
)	AS sq ON cxd.ConstituentID = sq.ConstituentID
WHERE cx.TableID = 108
AND cx.RoleTypeID = 1
AND cxd.UnMasked = 1
AND o.ObjectStatusID = 2
AND oa.AccessionISODate >= '2011%'
AND c.ConstituentTypeID = 1
ORDER BY o.SortNumber





SELECT o.ObjectID, o.ObjectNumber, cxd.ConstituentID, cxd.NameID, can.DisplayName
FROM Objects AS o
LEFT OUTER JOIN ObjAccession AS oa ON o.ObjectID = oa.ObjectID
LEFT OUTER JOIN ConXrefs AS cx ON o.ObjectID = cx.ID AND cx.TableID = 108
LEFT OUTER JOIN ConXrefDetails AS cxd ON cx.ConXrefID = cxd.ConXrefID
LEFT OUTER JOIN ConAltNames AS can ON cxd.NameID = can.AltNameId
LEFT OUTER JOIN Constituents AS c ON cxd.ConstituentID = c.ConstituentID
WHERE oa.AccessionISODate >= '2011%'
AND ObjectStatusID = 2
AND cx.RoleTypeID = 1
AND cxd.UnMasked = 1
AND c.ConstituentTypeID = 1




SELECT o.ObjectID, o.ObjectNumber
FROM MFAHv_OBJ AS o
LEFT OUTER JOIN MFAHv_OBJ_Constituent AS oc ON o.ObjectID = oc.o_ObjectID
WHERE o.CY >= 2011
--o.AccessionISODate >= '2011%'
AND o.ObjectStatusID = 2
AND oc.RoleTypeID = 1
AND oc.cxd_Unmasked = 1
and oc.c_ConstituentTypeID = 1


------------------------------------------------------
-- Constituent Gender

SELECT DISTINCT
cxd.ConstituentID,
c.DisplayName,
sq.Term AS Gender

FROM ConXrefDetails AS cxd
INNER JOIN ConXrefs AS cx ON cxd.ConXrefID = cx.ConXrefID
INNER JOIN Constituents AS c ON cxd.ConstituentID = c.ConstituentID
LEFT OUTER JOIN
(
		SELECT
		t.Term,
		CASE WHEN t.Term LIKE 'male' THEN 1 ELSE 0 END AS IsMale,
		CASE WHEN t.Term LIKE 'female' THEN 1 ELSE 0 END AS IsFemale,
		c.ConstituentID,
		c.ConstituentTypeID,
		c.DisplayName

		FROM ThesXrefs AS tx
		INNER JOIN Terms AS t ON tx.TermID = t.TermID
		INNER JOIN ThesXrefTypes AS txt ON tx.ThesXrefTypeID = txt.ThesXrefTypeID
		INNER JOIN Constituents AS c ON tx.ID = c.ConstituentID

		WHERE tx.TableID = 23		-- Constituents
		AND tx.Active = 1			-- Active attributes (not deleted)
		AND tx.TermID IN (105,106,1336160)
		AND c.ConstituentTypeID = 1	-- Person
)	AS sq ON cxd.ConstituentID = sq.ConstituentID

WHERE	cxd.UnMasked = 1
AND		cx.TableID = 108
AND		cxd.RoleTypeID = 1
AND		c.ConstituentTypeID = 1

------------------------------------------------------------------------------------

SELECT
o.ObjectID, o.ObjectNumber
FROM MFAHv_OBJ AS o
WHERE o.ObjectStatusID = 2
AND o.CY >= 2011





SELECT DISTINCT
cx.Gender,
cx.DisplayName,
COUNT(cx.ObjectID) AS ObjectCount,
cx.c_ConstituentTypeID,
cx.ConstituentType,
cx.cx_RoleTypeID,
cx.cx_Role

FROM
(
	SELECT
	o.ObjectID,
	o.ObjectNumber,
	o.SortNumber,
	c.DisplayName,
	g.Gender,
	g.IsMale,
	g.IsFemale,
	c.c_ConstituentTypeID,
	c.ConstituentType,
	c.cx_RoleTypeID,
	c.cx_Role,
	c.cx_Active,
	c.cx_Displayed

	FROM MFAHv_OBJ AS o
	LEFT OUTER JOIN MFAHv_OBJ_Constituent AS c ON o.ObjectID = c.o_ObjectID AND c.cx_TableID = 108
	LEFT OUTER JOIN MFAHv_CON_Gender AS g ON c.c_ConstituentID = g.ConstituentID

	WHERE o.ObjectStatusID = 2
	AND o.CY < 2011
	AND c.cx_RoleTypeID = 1
	AND c.cx_Active = 1
	AND c.cx_Displayed = 1
	--AND ObjectNumber = '2018.39'
	--ORDER BY o.SortNumber
)AS cx

--WHERE cx.Gender NOT IN ('male','female') OR cx.Gender IS NULL

GROUP BY
cx.DisplayName,
cx.Gender,
cx.c_ConstituentTypeID,
cx.ConstituentType,
cx.cx_RoleTypeID,
cx.cx_Role

ORDER BY
cx.DisplayName,
cx.Gender,
cx.c_ConstituentTypeID,
cx.ConstituentType,
cx.cx_RoleTypeID,
cx.cx_Role