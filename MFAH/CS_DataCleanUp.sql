
SELECT * FROM MFAHt_CS_Import_TT	--	18309
UNION
SELECT * FROM MFAHt_CS_Import_MG	--	 1877

--	20186

---------------------------------------------------------------------------------------------------
--	This isn't returning the results I expect
SELECT * FROM MFAHt_CS_Import_TT	--	18309
UNION
SELECT * FROM MFAHt_CS_Import_MG	--	 1877
WHERE ConditionID IN
(
	-- Tina and Mel touched these records
	SELECT ConditionID--, COUNT(*) AS Occurances 
	FROM
	(
		SELECT * FROM MFAHt_CS_Import_TT	--	18309
		UNION
		SELECT * FROM MFAHt_CS_Import_MG	--	 1877
	) AS u
	GROUP BY ConditionID
	HAVING COUNT(*) > 1					--	 1769		Tina AND Mel BOTH touched these records
)

---------------------------------------------------------------------------------------------------
--	WOP
--	SurveyType


SELECT * FROM MFAHt_CS_Import_TT	--	18309
WHERE	NEW_SurveyType NOT IN ('[Not wop]','1','2','3','4','5','6','7','8','9','10','11','12','13') --11503
AND NEW_SurveyType NOT LIKE '%Delete%' -- 11493 --  reviewed

SELECT * FROM MFAHt_CS_Import_TT	--	18309
WHERE	NEW_SurveyType IN ('[Not wop]','1','2','3','4','5','6','7','8','9','10','11','12','13') --6806
OR NEW_SurveyType LIKE '%Delete%' -- 6816 -- NO change


SELECT
t.ConditionID,
st1.SurveyTypeID,
t.SurveyType,
st2.SurveyTypeID,
t.NEW_SurveyType
FROM MFAHt_CS_Import_TT AS t
INNER JOIN SurveyTypes AS st1 ON t.SurveyType = st1.SurveyType
INNER JOIN SurveyTypes AS st2 ON t.SurveyType = st2.SurveyType
WHERE t.ConditionID IN
(
	SELECT ConditionID FROM MFAHt_CS_Import_TT	--	18309
	WHERE	NEW_SurveyType NOT IN ('[Not wop]','1','2','3','4','5','6','7','8','9','10','11','12','13') --11503
	AND NEW_SurveyType NOT LIKE '%Delete%' -- 11493 --  Reviewed
)
--	11493	Reviewed

SELECT t.ConditionID, *
FROM MFAHt_CS_Import_TT t
LEFT OUTER JOIN Conditions AS c ON t.ConditionID = c.ConditionID
WHERE c.ConditionID IS NULL
-- 250 Records in Tina's spreadsheet unmatched in Conditions table.


SELECT t.ConditionID, *
FROM MFAHt_CS_Import_TT t
LEFT OUTER JOIN Conditions AS c ON t.ConditionID = c.ConditionID
WHERE c.ConditionID IS NULL
-- 250 Records in Tina's spreadsheet unmatched in Conditions table.
AND t.ConditionID IN
(
	SELECT ConditionID FROM MFAHt_CS_Import_TT	--	18309
	WHERE	NEW_SurveyType NOT IN ('[Not wop]','1','2','3','4','5','6','7','8','9','10','11','12','13') --11503
	AND NEW_SurveyType NOT LIKE '%Delete%' -- 11493 --  Reviewed
)	-- OF the 250, these are the Reviewed records
	-- 110


 SELECT
c.ConditionID,
t.ConditionID,
st1.SurveyTypeID,
t.SurveyType,
st2.SurveyTypeID,
t.NEW_SurveyType,
c.ShortText01,
c.ShortText02,
c.ShortText03
FROM Conditions AS c
INNER JOIN MFAHt_CS_Import_TT AS t ON c.ConditionID = t.ConditionID
INNER JOIN SurveyTypes AS st1 ON t.SurveyType = st1.SurveyType
INNER JOIN SurveyTypes AS st2 ON t.SurveyType = st2.SurveyType
WHERE t.ConditionID IN
(
	SELECT t.ConditionID FROM MFAHt_CS_Import_TT AS t			--	18309
	INNER JOIN Conditions AS c ON t.ConditionID = c.ConditionID	--	18059
	WHERE t.NEW_SurveyType NOT IN ('[Not wop]','1','2','3','4','5','6','7','8','9','10','11','12','13') --11385
	AND t.NEW_SurveyType NOT LIKE '%Delete%' -- 11383 
)

--		11493 Records in Tina's spreadsheet reviewed
--	-	  110 Records to change from Tina's spreadsheet, unmatched in Conditions
--	=	11383 SurveyTypes to change




---------------------------------------------------------------------------------------------------
--	WOP
--	Project

SELECT COUNT(*) FROM MFAHt_CS_Import_TT	--	18309
SELECT COUNT(*) FROM Conditions			--	20269

SELECT COUNT(*) FROM MFAHt_CS_Import_TT AS t
INNER JOIN Conditions AS c ON t.ConditionID = c.ConditionID	--	18059

SELECT * FROM MFAHt_CS_Import_TT	--	18309
WHERE NEW_Project <> '1'			--	 
AND NEW_Project IS NOT NULL			--	12771 *

SELECT * FROM MFAHt_CS_Import_TT	--	18309 total records
WHERE NEW_Project <> '1'			--	 
AND NEW_Project IS NOT NULL			--	12771 changes

SELECT t.ConditionID
FROM MFAHt_CS_Import_TT AS t
LEFT OUTER JOIN Conditions AS c ON t.ConditionID = c.ConditionID
WHERE c.ConditionID IS NULL			--	 250 Unmatched in Conditions

									--	12521 changes that are matched


SELECT t.ConditionID
FROM MFAHt_CS_Import_TT AS t
INNER JOIN Conditions AS c ON t.ConditionID = c.ConditionID	--	18059
WHERE t.NEW_Project <> '1'			--	 
AND t.NEW_Project IS NOT NULL			--	12666 matched changes



-- This is my first attempt at the select query, looking at all records changed.
SELECT
c.ConditionID,
t.ConditionID,
t.Project,
t.NEW_Project,
c.ShortText01,
c.ShortText02,
c.ShortText03
FROM Conditions AS c
INNER JOIN MFAHt_CS_Import_TT AS t ON c.ConditionID = t.ConditionID		-- 18059 = 18309 - 250 unmatched
WHERE t.ConditionID IN
(
	SELECT t.ConditionID FROM MFAHt_CS_Import_TT AS t			--	18309 = 18059 + 250 unmatched
	INNER JOIN Conditions AS c ON t.ConditionID = c.ConditionID	--	18059
	WHERE NEW_Project <> '1'									--	12666 
	AND NEW_Project IS NOT NULL									--	12666
)--																--	12666 = 12771 - 250 unmatched
AND t.ConditionID NOT IN
(
	SELECT t.ConditionID FROM MFAHt_CS_Import_TT AS t			--	18309	*
	INNER JOIN Conditions AS c ON t.ConditionID = c.ConditionID	--	18059
	WHERE NEW_Project LIKE '%Delete%'							--	 9769	*
	AND t.Project IS NULL										--	 3601	=  9769 - 6171 (subtract these from 12666)
)--																--	 9065	The correct number of records to update


--	1)	Remove value from Project field

--		SET c.Project = ''			WHERE	t.NEW_Project LIKE '%Delete%'	
--									AND		t.Project IS NOT NULL
--		6168 records

SELECT t.ConditionID
FROM MFAHt_CS_Import_TT AS t								--	18309
INNER JOIN Conditions AS c ON t.ConditionID = c.ConditionID	--	18059
WHERE t.NEW_Project LIKE '%Delete%'							--	 9769	( 9856 with unmatched)
--AND t.Project IS  NULL									--	 3601	( 3685 with unmatched)
AND t.Project IS NOT NULL									--	 6168	( 6171 with unmatched)
AND t.NEW_Project <> '1'									--	 6168	( 6171 with unmatched)

-- verified in spreadsheet


--	2)	Update Project field

--		SET c.Project = NEW_Project	WHERE	t.NEW_Project <> '1'				
--									AND		t.NEW_Project NOT LIKE '%Delete%'
--		2915 records

SELECT t.ConditionID
FROM MFAHt_CS_Import_TT AS t								--	18309
INNER JOIN Conditions AS c ON t.ConditionID = c.ConditionID	--	18059
WHERE t.NEW_Project <> '1'									--	12666	( 12771 with unmatched)
AND t.NEW_Project NOT LIKE '%Delete%'						--	 2897	(  2915 with unmatched)

-- verified in spreadsheet







---------------------------------------------------------------------------------------------------
--	PAINITNGS
--	Project


SELECT * FROM MFAHt_CS_Import_MG	--	1877
WHERE NEW_Project <> '1'			--	1274  *
 
									

SELECT t.ConditionID, *
FROM MFAHt_CS_Import_MG t
LEFT OUTER JOIN Conditions AS c ON t.ConditionID = c.ConditionID
WHERE c.ConditionID IS NULL
-- 1 Record in Mel's spreadsheet unmatched in Conditions table.



SELECT t.ConditionID, *
FROM MFAHt_CS_Import_MG t
INNER JOIN Conditions AS c ON t.ConditionID = c.ConditionID 
WHERE t.NEW_Project <> '1'			--	1274


-- This is the select query for removing Project value where Project = 0
SELECT
c.ConditionID,
t.ConditionID,
t.Project,
t.NEW_Project,
c.ShortText01,
c.ShortText02,
c.ShortText03
FROM Conditions AS c
INNER JOIN MFAHt_CS_Import_MG AS t ON c.ConditionID = t.ConditionID		-- 1876 = 1877 - 1 unmatched
WHERE t.ConditionID IN
(
	SELECT t.ConditionID FROM MFAHt_CS_Import_MG AS t			--	1877
	INNER JOIN Conditions AS c ON t.ConditionID = c.ConditionID	--	1876
	WHERE NEW_Project = '0'										--	615 
	AND NEW_Project IS NOT NULL									--	615
)--																--	615 set Project = ''



-- This is the select query for updating Project value where Project NOT IN (0,1)
SELECT
c.ConditionID,
t.ConditionID,
t.Project,
t.NEW_Project,
c.ShortText01,
c.ShortText02,
c.ShortText03
FROM Conditions AS c
INNER JOIN MFAHt_CS_Import_MG AS t ON c.ConditionID = t.ConditionID		-- 1876 = 1877 - 1 unmatched
WHERE t.ConditionID IN
(
	SELECT t.ConditionID FROM MFAHt_CS_Import_MG AS t			--	1877
	INNER JOIN Conditions AS c ON t.ConditionID = c.ConditionID	--	1876
	WHERE NEW_Project NOT IN ('0','1')							--	659 
	AND NEW_Project IS NOT NULL									--	659
)--																--	659 set Project = NEW_Project

























---------------------------------------------------------------------------------------------------


SELECT DISTINCT 
ShortText01		AS Reviewed,
ShortText02		AS Updated,
ShortText03		AS SurveyType_OLD,
ShortText04		AS Project_OLD,
ShortText05		AS SurveyType_NEW_Tina,
ShortText06		AS SurveyType_NEW_Mel,
ShortText07		AS Project_NEW_Tina,
ShortText08		AS Project_NEW_Mel
FROM Conditions


--UPDATE Conditions SET ShortText01 = '2020-06'
--SELECT ConditionID, ShortText01 FROM Conditions
WHERE ConditionID IN
(
	SELECT ConditionID
	FROM MFAHt_CS_Import_TT
	UNION
	SELECT ConditionID
	FROM MFAHt_CS_Import_MG
)
--(18167 rows affected)



--UPDATE Conditions SET ShortText03 = st.SurveyType
--SELECT c.ConditionID, st.SurveyType, c.ShortText03
FROM Conditions AS c
INNER JOIN SurveyTypes AS st ON c.SurveyTypeID = st.SurveyTypeID
WHERE c.ConditionID IN
(
	SELECT ConditionID
	FROM MFAHt_CS_Import_TT
	UNION
	SELECT ConditionID
	FROM MFAHt_CS_Import_MG
)
--(18167 rows affected)



--UPDATE Conditions SET ShortText04 = Project
--SELECT ConditionID, Project, ShortText04
FROM Conditions
WHERE ConditionID IN
(
	SELECT ConditionID
	FROM MFAHt_CS_Import_TT
	UNION
	SELECT ConditionID
	FROM MFAHt_CS_Import_MG
)
AND Project IS NOT NULL		--	9563
--(9563 rows affected)



--UPDATE Conditions SET ShortText05 -- NEVER RAN, Don't think it's worth it.
SELECT c.ConditionID, 
t.Classification,
c.SurveyTypeID AS SurveyTypeID,
st.SurveyType	AS CURRENT_SurveyType, 
t.SurveyType	AS OLD_SurveyType, 
t.NEW_SurveyType AS NEW_SurveyType, 
c.Project
FROM Conditions AS c
INNER JOIN SurveyTypes AS st ON c.SurveyTypeID = st.SurveyTypeID
INNER JOIN MFAHt_CS_Import_TT AS t ON c.ConditionID = t.ConditionID
WHERE t.NEW_SurveyType NOT IN ('[Not wop]','1','2','3','4','5','6','7','8','9','10','11','12','13') --11385











































--	I don't understand the below.
---------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------
-----	Exclude these records from the update.

SELECT
t.ConditionID,
t.Project,
t.NEW_Project	AS TT_NEW_Project,
m.NEW_Project	AS MG_NEW_Project

FROM		MFAHt_CS_Import_TT	AS	t
INNER JOIN	MFAHt_CS_Import_MG	AS	m	ON t.ConditionID = m.ConditionID

WHERE	t.NEW_SurveyType NOT LIKE '%wop%'
AND		t.NEW_Project <>	m.NEW_Project		--	951		-- Exclude these from the update.
AND		t.NEW_Project =		m.NEW_Project		--	28


SELECT t.ConditionID
FROM		MFAHt_CS_Import_TT	AS	t
INNER JOIN	MFAHt_CS_Import_MG	AS	m	ON t.ConditionID = m.ConditionID
WHERE	t.NEW_SurveyType NOT LIKE '%wop%'
AND		t.NEW_Project <>	m.NEW_Project		--	951		-- Exclude these from the update.


--------------------------------------------------------------------------
-----	Update Condition records to indicate that they have been reviewed 
-----	and if they have a conflict.
-----	Tag all reveiwed records			ShortText01 = 'Reviewed 2020 06'	-- #####
-----	Tag all the records Tina reviewed	ShortText02 = 'TINA'				-- #####
-----	Tag all the records Tina reviewed	ShortText03 = 'MEL'					-- #####

SELECT ShortText01 FROM Conditions WHERE ShortText01 IS NOT NULL	--	0		Tag with 'Reviewed June 2020'
SELECT ShortText02 FROM Conditions WHERE ShortText01 IS NOT NULL	--	0		Tag with 'TINA'
SELECT ShortText03 FROM Conditions WHERE ShortText01 IS NOT NULL	--	0		Tag with 'MEL'
SELECT COUNT(*) FROM Conditions										--	19121


-----	All Reviewed Records
-----	14891 / 19140 REVIEWED		Production 8/4/2020 PM

SELECT	ConditionID
FROM	MFAHt_CS_Import_TT		-- NOT all of these were reviewed!
WHERE	NEW_SurveyType NOT IN ('[Not wop]','1','2','3','4','5','6','7','8','9','10','11','12','13')
--	11503 (Survey Types reviewed)

UNION

SELECT	ConditionID
FROM	MFAHt_CS_Import_TT		-- NOT all of these were reviewed!
WHERE	NEW_Project NOT IN ('1','')
--	12771 (Projects reviewed)

UNION
SELECT	ConditionID
FROM	MFAHt_CS_Import_MG	











--------------------------------------------------------------------------



-----	Works on Paper (Tina)
-----	Update SurveyTypeID
-----	11493	Production 7/31/2020 AM
-----	10580	Production 7/31/2020 PM excluding conflicts

SELECT
c.ConditionID,
c.SurveyType,
c.NEW_SurveyType,
st.SurveyTypeID

--UPDATE	Conditions SET		SurveyTypeID = st.SurveyTypeID

FROM			MFAHt_CS_Import_TT	AS c
LEFT OUTER JOIN	SurveyTypes			AS st	ON c.NEW_SurveyType = st.SurveyType

WHERE	c.NEW_SurveyType NOT IN ('[Not wop]','1','2','3','4','5','6','7','8','9','10','11','12','13')
AND		c.NEW_SurveyType NOT LIKE '%Delete%'
AND		c.ConditionID NOT IN
(
	SELECT t.ConditionID
	FROM		MFAHt_CS_Import_TT	AS	t
	INNER JOIN	MFAHt_CS_Import_MG	AS	m	ON t.ConditionID = m.ConditionID
	WHERE	t.NEW_SurveyType NOT LIKE '%wop%'
	AND		t.NEW_Project <>	m.NEW_Project		--	951		-- Exclude these from the update.
)




-----	Works on Paper (Tina)
-----	Delete Record?
-----	10	Production 7/31/2020 AM
-----	10	Production 7/31/2020 PM excluding conflicts

SELECT
c.ConditionID,
c.SurveyType,
c.NEW_SurveyType,
st.SurveyTypeID

-----	DELETE FROM Conditions WHERE... ???

FROM			MFAHt_CS_Import_TT	AS c
LEFT OUTER JOIN	SurveyTypes			AS st	ON c.NEW_SurveyType = st.SurveyType

WHERE	c.NEW_SurveyType LIKE '%Delete%'
AND		c.ConditionID NOT IN
(
	SELECT t.ConditionID
	FROM		MFAHt_CS_Import_TT	AS	t
	INNER JOIN	MFAHt_CS_Import_MG	AS	m	ON t.ConditionID = m.ConditionID
	WHERE	t.NEW_SurveyType NOT LIKE '%wop%'
	AND		t.NEW_Project <>	m.NEW_Project		--	951		-- Exclude these from the update.
)






-----	Works on Paper (Tina)
-----	Update Project
-----	2915	Production 7/31/2020 AM
-----	2843	Production 7/31/2020 PM excluding conflicts

SELECT
c.ConditionID,
c.Project,
c.NEW_Project

--UPDATE	Conditions SET		Project = c.NEW_Project

FROM			MFAHt_CS_Import_TT	AS c

WHERE			c.NEW_Project	IS NOT NULL
AND				c.NEW_Project	<> '1'
AND				c.NEW_Project	NOT LIKE '%Delete%'
AND		c.ConditionID NOT IN
(
	SELECT t.ConditionID
	FROM		MFAHt_CS_Import_TT	AS	t
	INNER JOIN	MFAHt_CS_Import_MG	AS	m	ON t.ConditionID = m.ConditionID
	WHERE	t.NEW_SurveyType NOT LIKE '%wop%'
	AND		t.NEW_Project <>	m.NEW_Project		--	951		-- Exclude these from the update.
)



-----	Works on Paper (Tina)
-----	Delete Project
-----	9856	Production 7/31/2020 AM
-----	8986	Production 7/31/2020 PM excluding conflicts

--UPDATE	Conditions SET		Project = NULL

SELECT
c.ConditionID,
c.Project,
c.NEW_Project

FROM			MFAHt_CS_Import_TT	AS c

WHERE			c.NEW_Project	LIKE '%Delete%'
AND		c.ConditionID NOT IN
(
	SELECT t.ConditionID
	FROM		MFAHt_CS_Import_TT	AS	t
	INNER JOIN	MFAHt_CS_Import_MG	AS	m	ON t.ConditionID = m.ConditionID
	WHERE	t.NEW_SurveyType NOT LIKE '%wop%'
	AND		t.NEW_Project <>	m.NEW_Project		--	951		-- Exclude these from the update.
)

------------------------------------------------------------------------------




-----	Paintings (Mel)
-----	Update Project
-----	659	Production 7/31/2020 AM
-----	308	Production 7/31/2020 PM excluding conflicts

SELECT
c.ConditionID,
c.Project,
c.NEW_Project

--UPDATE	Conditions SET		Project = c.NEW_Project

FROM			MFAHt_CS_Import_MG	AS c

WHERE			c.NEW_Project	IS NOT NULL
AND				c.NEW_Project	NOT IN ('0','1')
AND		c.ConditionID NOT IN
(
	SELECT t.ConditionID
	FROM		MFAHt_CS_Import_TT	AS	t
	INNER JOIN	MFAHt_CS_Import_MG	AS	m	ON t.ConditionID = m.ConditionID
	WHERE	t.NEW_SurveyType NOT LIKE '%wop%'
	AND		t.NEW_Project <>	m.NEW_Project		--	951		-- Exclude these from the update.
)



-----	Paintings (Mel)
-----	Delete Project
-----	659	Production 7/31/2020 AM
-----	344	Production 7/31/2020 PM excluding conflicts

SELECT
c.ConditionID,
c.Project,
c.NEW_Project

--UPDATE	Conditions SET		Project = NULL

FROM			MFAHt_CS_Import_MG	AS c

WHERE			c.NEW_Project	IS NOT NULL
AND				c.NEW_Project	= ('0')
AND		c.ConditionID NOT IN
(
	SELECT t.ConditionID
	FROM		MFAHt_CS_Import_TT	AS	t
	INNER JOIN	MFAHt_CS_Import_MG	AS	m	ON t.ConditionID = m.ConditionID
	WHERE	t.NEW_SurveyType NOT LIKE '%wop%'
	AND		t.NEW_Project <>	m.NEW_Project		--	951		-- Exclude these from the update.
)
