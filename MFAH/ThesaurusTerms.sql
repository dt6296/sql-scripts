







SELECT * FROM DDTables
-- 23 = Constituents


SELECT * FROM ThesXrefTypes


SELECT TOP 25 * FROM Terms ORDER BY EnteredDate DESC


SELECT TOP 25 * FROM ThesXrefs

SELECT * FROM Terms WHERE Term = 'Gender'  -- 4 = Gender


SELECT * FROM Terms 
WHERE Term IN ('male','female')
ORDER BY TermID



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




SELECT * FROM Terms WHERE TermID IN (105,106,101460,101469,201187,201188,201452,1191120,1237270,1293269)


--------------------------------------------------------------------------	Counts by Term

SELECT
COUNT(tx.ThesXrefID) AS	 Instances,
t.TermID,
tx.ThesXrefTypeID,
txt.ThesXrefType,
t.Term
FROM ThesXrefs AS tx
INNER JOIN Terms AS t ON tx.TermID = t.TermID
INNER JOIN ThesXrefTypes AS txt ON tx.ThesXrefTypeID = txt.ThesXrefTypeID
WHERE tx.TableID = 23
AND tx.TermID IN (105,106,101460,101469,201187,201188,201452,1191120,1237270,1293269) --(105,106,201187,201188,201452)
GROUP BY 
tx.ThesXrefTypeID,
txt.ThesXrefType,
t.Term,
t.TermID





SELECT * FROM TermMasterThes
WHERE TermMasterID IN
(
	SELECT TermMasterID FROM Terms 
	WHERE Term IN ('male','female')
	--ORDER BY TermID
)


SELECT * 
FROM ThesaurusBases AS tb
LEFT OUTER JOIN ClassificationNotations AS cn ON tb.ThesaurusBaseID = cn.ThesaurusBaseID
LEFT OUTER JOIN TermMasterThes AS tmt ON cn.TermMasterID = tmt.TermMasterID
LEFT OUTER JOIN TermClasses AS tc ON tmt.TermClassID = tc.TermClassID
LEFT OUTER JOIN Terms AS t ON tmt.TermMasterID = t.TermMasterID
WHERE tb.ThesaurusBaseID = 2 --AND t.Approved = 0
ORDER BY t.Term


SELECT * FROM Terms WHERE Approved = 0


SELECT * FROM Terms WHERE LocalTerm = 1






SELECT *

FROM	ThesaurusBases	AS tb
INNER JOIN	ClassificationNotations	AS cn	ON tb.ThesaurusBaseID = cn.ThesaurusBaseID
INNER JOIN	TermMasterThes	AS tmt	ON cn.TermMasterID = tmt.TermMasterID
INNER JOIN	Terms	AS t	ON tmt.TermMasterID = t.TermMasterID

WHERE tb.ThesaurusBaseID = 2
AND (t.Term LIKE 'female%' OR t.Term LIKE 'male%')



SELECT *

FROM	ThesaurusBases	AS tb
INNER JOIN	ClassificationNotations	AS cn	ON tb.ThesaurusBaseID = cn.ThesaurusBaseID
INNER JOIN	TermMasterThes	AS tmt	ON cn.TermMasterID = tmt.TermMasterID
INNER JOIN	Terms	AS t	ON tmt.TermMasterID = t.TermMasterID

WHERE tb.ThesaurusBaseID = 2
AND t.Approved = 0



SELECT * FROM DDColumns WHERE ColumnName LIKE '%label%' ORDER BY ColumnName





SELECT * FROM TextEntries WHERE TableID = 287 AND LoginID = 'dthompson'



SELECT * FROM TextEntries WHERE TableID = 287 AND TextEntry LIKE 'Referring to the sex that normally produces eggs or female germ cells.  RHDEL2.'
-- ID 105 = female from AAT



SELECT * FROM TextEntries WHERE TableID = 287 AND TextEntry LIKE 'Referring to the sex that in reproduction normally produces sperm cells or male gametes.  RHDEL2.'
-- ID 106 - male from AAT

SELECT * FROM TextEntries WHERE TableID = 287 AND TextEntry LIKE '170215'







SELECT * FROM ThesXrefTypes WHERE ThesXrefType LIKE 'Constituents%'

SELECT * FROM ThesXrefs WHERE ThesXrefTypeID = 3

SELECT * FROM Terms WHERE TermID IN
(
201188,
201185,
201186,
201198,
201184,
201187,201452
)

201187	Male	2001-04-09 17:32:30.030	dja
201188	Female	2001-04-09 17:32:38.543	dja
201452	female	2013-11-27 09:26:35.797	jlevy


SELECT * FROM ThesXrefTypes WHERE ThesXrefType LIKE 'Male%'

SELECT DISTINCT TermID FROM ThesXrefs WHERE ThesXrefTypeID = 3

SELECT * FROM Terms WHERE TermID IN (201187,201188,201452)

SELECT COUNT(*), TermID FROM ThesXrefs WHERE TermID IN (201187,201188,201452) GROUP BY TermID




SELECT top 10000 * FROM TERMMASTER WHERE CN NOT LIKE ('AAT.%') AND CN NOT LIKE ('TGO.%') AND CN NOT LIKE ('TGN.%')


SELECT * FROM ThesXrefs WHERE TermID IN (105,106)
SELECT * FROM ThesXrefs WHERE TermID IN (201187,201188,201452)


SELECT COUNT(*), TermID, Active FROM ThesXrefs WHERE TermID IN (201187,201188,201452) GROUP BY TermID, Active



SELECT COUNT(*), TermID, Active FROM ThesXrefs WHERE TermID IN (105,106,101460,101469,201187,201188,201452,1191120,1237270,1293269) GROUP BY TermID, Active



SELECT * FROM TermSourceXrefs






SELECT * FROM ThesXrefs WHERE TableID = 23 AND ID = 29872
SELECT * FROM Terms WHERE TermID = 659005

SELECT * FROM Terms 
WHERE 

TermID IN 
(
201187,
201188,
201452
)

SELECT * FROM DDTables WHERE TableID IN (343,346) -- Attributes, Geography

-- Old terms from bad thesaurus setup
SELECT * FROM ThesXrefs WHERE TermID = 201187	--	Male
SELECT * FROM ThesXrefs WHERE TermID = 201188	--	Female
SELECT * FROM ThesXrefs WHERE TermID = 201452	--	female
-- I MANUALLY DELETEED ALL REFERENCES TO THESE TERMS 2/15/17, but the Thesaurus "check term usage" says there are still more?!



SELECT * FROM TermSourceXrefs WHERE TermID IN (201187,201188,201452)	-- 0
SELECT * FROM ThesXrefs WHERE TermID IN (201187,201188,201452)	-- 0
SELECT * FROM ColThesXrefs WHERE TermID IN (201187,201188,201452)	-- 0


Select * from ThesXrefs 


SELECT * FROM vDataViewThesTerms WHERE TermID IN (201187,201188,201452)

SELECT * FROM ClassificationNotations WHERE TermMasterID IN (201187,201188,201452)

SELECT * FROM ThesXrefs WHERE termID IN (201187,201188,201452)

SELECT * FROM TermMasterThes WHERE PrimaryCNID IN (201187,201188,201452)


select * from TermMasterThes where TermMasterID in (36428,36429,36677)
SELECT * FROM vDataViewThesTerms WHERE TermID IN (201187,201188,201452)

select * from TermMasterThes where SourceTermID in (201187,201188,201452) --201452


select * from vDataViewThesTerms where TermMasterID = 28330

select * from Terms where  TermID IN (201187,201188,201452)

select * from TermMasterThes where TermMasterID in (36428,36429,36677)
select * from TermMasterThes where SourceTermID in (201187,201188,201452) 


select * from ThesXrefs where TermID in (28330,43296,121264)


select * from  Terms  where Term like '3rd%'






SELECT
tm.*

FROM ThesaurusBases AS tb
LEFT OUTER JOIN	TERMMASTER AS tm ON tb.ThesaurusBaseID = tm.ThesaurusBaseID
LEFT OUTER JOIN Terms AS t ON tm.


/*

No bother at all Dave! 

Sure. i would go this way about it

select Term, T.TermID, ThesaurusBase from 
Terms T inner join TermMaster TM on T.TermMasterID = TM.TermMasterID 
inner join ThesaurusBases TB on TM.ThesaurusBaseID = TB.ThesaurusBaseID 

This will bring you Terms and give you an idea of Thes basis. now if you have isolated 3 terms you want to delete you can query on them and find TermID s and then do simple 

Select * from ThesXrefs where TermID in (1,2,3) 
it will give you an idea where they are are linked. 

it could also maybe terms are linked between themselves like levels? 
Dimitry


*/

SELECT
t.TermID,
t.Term,
tb.ThesaurusBase

FROM Terms AS t
INNER JOIN TermMaster AS tm ON t.TermMasterID = tm.TermMasterID
INNER JOIN ThesaurusBases AS tb ON tm.ThesaurusBaseID = tb.ThesaurusBaseID

WHERE t.TermID IN (201187,201188,201452)

/*

TermID	Term	ThesaurusBase
201187	Male	Authorities
201188	Female	Authorities
201452	female	Authorities

*/

SELECT * FROM ThesXrefs WHERE TermID IN (201187,201188,201452)
SELECT * FROM ThesXrefs WHERE TermID IN (105,106)

SELECT * FROM TermMasterLevel
WHERE TermMasterID IN (201187,201188,201452)
OR LevelTermMasterID IN (201187,201188,201452)


SELECT * FROM Terms WHERE Term LIKE 'unknown'
SELECT * FROM Terms WHERE TermID = 1336160
SELECT * FROM ThesXrefs WHERE TermID = 1336160	--48 records

SELECT * FROM Packages WHERE Name LIKE 'Gender_%'
/*
PackageID	Name
116053	Gender_Female
116052	Gender_Male
116051	Gender_Unknown
*/

SELECT * FROM Terms WHERE TermID IN (201187,201188,201452)
SELECT * FROM Terms WHERE TermID IN (105,106)
/*
TermID	TermMasterID	TermTypeID	Term
105	105	1	female
106	106	1	male
*/

SELECT COUNT(*) FROM Constituents -- 33470

--INSERT INTO TMS.dbo.PackageList												--(294 row(s) affected)
(PackageID, ID, MainData, OrderPos, LoginID, EnteredDate, Notes, TableID)

SELECT DISTINCT
116052,
tx.ID,
c.DisplayName,
ROW_NUMBER() OVER (ORDER BY c.AlphaSort) + ISNULL((SELECT MAX(OrderPOS) FROM PackageList WHERE PackageID = 116052),0),
'dthompson',
GETDATE(),
'',
23
FROM ThesXrefs AS tx
INNER JOIN Constituents AS c ON tx.ID = c.ConstituentID AND tx.TableID = 23
WHERE tx.TermID = 106


SELECT * FROM Terms WHERE TermID IN (201187,201188,201452)
SELECT * FROM Terms WHERE TermID IN (105,106)


SELECT COUNT(*) FROM PackageList WHERE PackageID = 116051	--	48		Gender_Unknown
SELECT COUNT(*) FROM PackageList WHERE PackageID = 116052	--	7593	Gender_Male
SELECT COUNT(*) FROM PackageList WHERE PackageID = 116053	--	1964	Gender_Female



SELECT COUNT(*) FROM ThesXrefs WHERE TermID = 105		-- 1964	female
SELECT COUNT(*) FROM ThesXrefs WHERE TermID = 106		-- 7593	male
SELECT COUNT(*) FROM ThesXrefs WHERE TermID = 201187	-- 0	Male
SELECT COUNT(*) FROM ThesXrefs WHERE TermID = 201188	-- 0	Female
SELECT COUNT(*) FROM ThesXrefs WHERE TermID = 201452	-- 0	female


--female	1964
SELECT ID FROM ThesXrefs WHERE TermID = 105		--	1964 female
UNION
SELECT ID FROM ThesXrefs WHERE TermID = 201188	--	   0 Female
UNION
SELECT ID FROM ThesXrefs WHERE TermID = 201452	--	   0 female
	
--male		7593
SELECT ID FROM ThesXrefs WHERE TermID = 106		--	7593 male
UNION
SELECT ID FROM ThesXrefs WHERE TermID = 201187	--	   0 Male




/*		Queried on MFAH-TMS-UP

SELECT * FROM Terms WHERE TermID IN (201187,201188,201452)
SELECT * FROM Terms WHERE TermID IN (105,106)



SELECT COUNT(*) FROM ThesXrefs WHERE TermID = 105		-- 753	female
SELECT COUNT(*) FROM ThesXrefs WHERE TermID = 106		-- 3471	male
SELECT COUNT(*) FROM ThesXrefs WHERE TermID = 201187	-- 3899	Male
SELECT COUNT(*) FROM ThesXrefs WHERE TermID = 201188	-- 1072	Female
SELECT COUNT(*) FROM ThesXrefs WHERE TermID = 201452	-- 80	female


--female	1903
SELECT ID FROM ThesXrefs WHERE TermID = 105		--	753 female
UNION
SELECT ID FROM ThesXrefs WHERE TermID = 201188	-- 1072 Female
UNION
SELECT ID FROM ThesXrefs WHERE TermID = 201452	--	 80 female
	
--male		7362
SELECT ID FROM ThesXrefs WHERE TermID = 106		--	3471 male
UNION
SELECT ID FROM ThesXrefs WHERE TermID = 201187	--	3899 Male

*/



SELECT * FROM ThesaurusBases WHERE ThesaurusBaseID = 8




SELECT TOP 100 * FROM ThesXrefs WHERE TableID = 108

SELECT TOP 100 * FROM ThesXrefTypes WHERE TableID = 108



-- Here are the terms from the Top Level Category Keywords list

SELECT
tb.ThesaurusBaseID,
tb.ThesaurusBase,
cn.CN,
cn.TermMasterID,
t.TermID,
t.Term,
t.TermTypeID

FROM ThesaurusBases AS tb
LEFT OUTER JOIN ClassificationNotations AS cn ON tb.ThesaurusBaseID = cn.ThesaurusBaseID
LEFT OUTER JOIN Terms AS t ON cn.TermMasterID = t.TermMasterID

WHERE tb.ThesaurusBaseID = 8
AND cn.CN LIKE 'TGO.AAE.AAA.%'




SELECT
tx.ID AS ObjectID,
tx.TermID,
t.Term

FROM ThesaurusBases AS tb
LEFT OUTER JOIN ClassificationNotations AS cn ON tb.ThesaurusBaseID = cn.ThesaurusBaseID
LEFT OUTER JOIN Terms AS t ON cn.TermMasterID = t.TermMasterID
LEFT OUTER JOIN ThesXrefs AS tx ON t.TermID = tx.TermID

WHERE tb.ThesaurusBaseID = 8
AND cn.CN LIKE 'TGO.AAE.AAA.%'
AND tx.TableID = 108
AND tx.ID IN (SELECT ID FROM PackageList WHERE PackageID = 255937)




SELECT DISTINCT
tx.ID AS ObjectID,
dbo.MFAHfx_ConcatObjThesTerms(255937,tx.ID)

FROM ThesaurusBases AS tb
LEFT OUTER JOIN ClassificationNotations AS cn ON tb.ThesaurusBaseID = cn.ThesaurusBaseID
LEFT OUTER JOIN Terms AS t ON cn.TermMasterID = t.TermMasterID
LEFT OUTER JOIN ThesXrefs AS tx ON t.TermID = tx.TermID

WHERE tb.ThesaurusBaseID = 8
AND cn.CN LIKE 'TGO.AAE.AAA.%'
AND tx.TableID = 108
AND tx.Active = 1
AND tx.ID IN (SELECT ID FROM PackageList WHERE PackageID = 255937)




SELECT dbo.MFAHfx_ConcatObjThesTerms (255937,140695)





SELECT COUNT(*) FROM ObjContext WHERE ShortText1 IS NOT NULL OR ShortText1 <> ''

SELECT 
o.ObjectID,
o.ObjectNumber,
oc.ShortText1
FROM Objects AS o
INNER JOIN ObjContext AS oc ON o.ObjectID = oc.ObjectID
WHERE ShortText1 IS NOT NULL