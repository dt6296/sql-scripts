/*





SELECT
ap.*
FROM AssocParents AS ap
WHERE ID IN
(
120862,	-- 602652 Crate
87520,	-- 2014.24.1
87521,	-- 2014.24.2

121764,	-- 2013.519
122068	-- 602692 Crate
)




SELECT * FROM MFAHv_OBJ_Related
WHERE ObjectID IN
(
120862,	-- 602652 Crate
87520,	-- 2014.24.1
87521,	-- 2014.24.2

121764,	-- 2013.519
122068	-- 602692 Crate
)



SELECT ova.* FROM MFAHvr_OBJ_Value_Acquisitions AS ova
WHERE ova.ObjectID IN
(
120862,	-- 602652 Crate
87520,	-- 2014.24.1
87521,	-- 2014.24.2

121764,	-- 2013.519
122068	-- 602692 Crate
)






SELECT * FROM MFAHv_OBJ_RelatedAndRecent

WHERE ObjectID IN
(
120606,	-- 2014.10
120607,	-- 2014.11
87374,	-- 2014.17
89126,	-- 2014.44.1
89165,	-- 2014.44.2
120862	-- 602652
)

ORDER BY ObjectID, RelatedObjectID




SELECT * FROM MFAHv_OBJ_Related

WHERE ObjectID IN
(
120606,	-- 2014.10
120607,	-- 2014.11
87374,	-- 2014.17
89126,	-- 2014.44.1
89165,	-- 2014.44.2
120862,	-- 602652
123843,
109318
)

ORDER BY ObjectID, RelatedObjectID


select * from ObjectLevels


SELECT * FROM Associations WHERE ID1 IN
 (
--120606,	-- 2014.10
--120607,	-- 2014.11
--87374,	-- 2014.17
--89126,	-- 2014.44.1
--89165,	-- 2014.44.2
120862,	-- 602652 Crate
87520,	-- 2014.24.1
87521,	-- 2014.24.2
121764,	-- 2013.519
122068	-- 602692 Crate
)

OR ID2 IN
(
--120606,	-- 2014.10
--120607,	-- 2014.11
--87374,	-- 2014.17
--89126,	-- 2014.44.1
--89165,	-- 2014.44.2
120862,	-- 602652 Crate
87520,	-- 2014.24.1
87521,	-- 2014.24.2
121764,	-- 2013.519
122068	-- 602692 Crate
)
ORDER BY ID1, ID2



--Here I was testing Parent-Child vs. See also associations.

SELECT 
r.*,
a.*
FROM Associations AS a
LEFT OUTER JOIN Relationships AS r ON a.RelationshipID = r.RelationshipID
WHERE a.ID1 IN
(
120862,	-- 602652
87520,	-- 2014.24.1
87521	-- 2014.24.2
)
OR a.ID2 IN
(
120862,	-- 602652
87520,	-- 2014.24.1
87521	-- 2014.24.2
)


--------------------------------------------------------------------------



SELECT
ap.*
FROM AssocParents AS ap
WHERE ID IN
(
120606, -- 2014.10			Pitcher			in crate		should apper

122901,	-- 2014.24 (.1-.13)	Set				NOT in Crate	should appear			The only AssocParent record
87524,	-- 2014.24.5		Object in Set	in Crate		should NOT appear

89126,	-- 2014.44.1		Related Object	in Crate		should appear
89165,	-- 2014.44.2		Related Object	in Crate		should appear

120862	-- 602652			Crate

--Olitsky, to compare in Q2
--121764,	-- 2013.519
---122068	-- 602692 Crate
)
 



SELECT * FROM Associations 
WHERE ID1 IN
(
120606, -- 2014.10			Pitcher			in crate		should apper

122901,	-- 2014.24 (.1-.13)	Set				NOT in Crate	should appear			The only AssocParent record
87524,	-- 2014.24.5		Object in Set	in Crate		should NOT appear

89126,	-- 2014.44.1		Related Object	in Crate		should appear
89165,	-- 2014.44.2		Related Object	in Crate		should appear

120862	-- 602652			Crate

--Olitsky, to compare in Q2
--121764,	-- 2013.519
---122068	-- 602692 Crate
)
OR ID2 IN
(
120606, -- 2014.10			Pitcher			in crate		should apper

122901,	-- 2014.24 (.1-.13)	Set				NOT in Crate	should appear			The only AssocParent record
87524,	-- 2014.24.5		Object in Set	in Crate		should NOT appear

89126,	-- 2014.44.1		Related Object	in Crate		should appear
89165,	-- 2014.44.2		Related Object	in Crate		should appear

120862	-- 602652			Crate

--Olitsky, to compare in Q2
--121764,	-- 2013.519
---122068	-- 602692 Crate
)

ORDER BY ID1, ID2



SELECT * FROM MFAHv_OBJ_Related
WHERE ObjectID IN
(
120606, -- 2014.10			Pitcher			in crate		should apper

122901,	-- 2014.24 (.1-.13)	Set				NOT in Crate	should appear			The only AssocParent record
87524,	-- 2014.24.5		Object in Set	in Crate		should NOT appear

89126,	-- 2014.44.1		Related Object	in Crate		should appear
89165,	-- 2014.44.2		Related Object	in Crate		should appear

120862,	-- 602652			Crate

--Olitsky, to compare in Q2
--121764,	-- 2013.519
---122068	-- 602692 Crate

123843,
123929,
123930,
123931,
109318
)
ORDER BY ObjectID



SELECT * FROM MFAHv_OBJ_Value
WHERE ObjectID IN
(
120606, -- 2014.10			Pitcher			in crate		should apper

122901,	-- 2014.24 (.1-.13)	Set				NOT in Crate	should appear			The only AssocParent record
87524,	-- 2014.24.5		Object in Set	in Crate		should NOT appear

89126,	-- 2014.44.1		Related Object	in Crate		should appear
89165,	-- 2014.44.2		Related Object	in Crate		should appear

120862	-- 602652			Crate

--Olitsky, to compare in Q2
--121764,	-- 2013.519
---122068	-- 602692 Crate
)

AND ObjectTypeID NOT IN (6,8)
AND ObjectStatusID IN (2,27,5,0,3,30)

ORDER BY ObjectID


------------------------------------
*/


SELECT DISTINCT
ov.ObjectID,
ISNULL(aol.AVG_ObjectLevelID,0) AS AVG_ObjectLevelID,
ov.DisplayAccessionNumber,
ov.ObjectLevelID,
ov.ObjectLevel,
ov.ObjectTypeID,
ov.ObjectType,

obr.AssociationID,
obr.ObjectID		AS obr_ObjectID,
obr.ObjectNumber	AS obr_ObjectNumber,
obr.RelationshipType,
obr.AssocField,
obr.RelPosition,
obr.ObjectLevelID	AS obr_ObjectLevelID,
obr.ObjectLevel		AS obr_ObjectLevel,
obr.ObjectTypeID	AS obr_ObjectTypeID,
obr.ObjectType		AS obr_ObjectType,
obr.RelationFocus,
obr.RelationTarget

FROM MFAHv_OBJ_Value				AS ov
LEFT OUTER JOIN	MFAHv_OBJ_Related	AS obr	ON ov.ObjectID = obr.ObjectID
LEFT OUTER JOIN
(SELECT ObjectID, AVG(ObjectLevelID) AS AVG_ObjectLevelID FROM MFAHv_OBJ_Related GROUP BY ObjectID) AS aol ON ov.ObjectID = aol.ObjectID

WHERE ov.ObjectID IN
(

122901,	-- 2014.24 (.1-.13)	Ice cream Set	NOT in Crate	should appear			The only AssocParent record

87524,	-- 2014.24.5		Spoon in Set	in Crate		should NOT appear

120606, -- 2014.10			Pitcher			in crate		should appear

89126,	-- 2014.44.1		Related Object	in Crate		should appear
89165,	-- 2014.44.2		Related Object	in Crate		should appear

120862,	-- 602652			Crate

111514,  -- 2014.16			Object with NO relations		should appear

--Olitsky, to compare in Q2
--121764,	-- 2013.519
---122068	-- 602692 Crate

123843,
123929,
123930,
123931

)

AND ov.ObjectLevelID NOT IN (13)
AND ov.ObjectTypeID NOT IN (6,8)
AND ov.ObjectStatusID IN (2,27,5,0,3,30)
AND	ISNULL(obr.RelPosition,0) < 2

AND obr.ObjectTypeID != 8
/*
AND
(
	(ISNULL(aol.AVG_ObjectLevelID,0) = ISNULL(obr.ObjectLevelID,0))
	OR (aol.AVG_ObjectLevelID != obr.ObjectLevelID AND obr.ObjectLevelID != 13)
)
*/

ORDER BY ov.ObjectID


--SELECT ObjectID, ISNULL(AVG(ObjectLevelID),0) AS AVG_ObjectLevelID FROM MFAHv_OBJ_Related WHERE ObjectID = 87524 GROUP BY ObjectID


--SELECT * FROM ObjectLevels
--SELECT * FROM ObjectTypes


/*

SELECT
ObjectID,
ISNULL(AVG(ObjectLevelID),0) AS AVG_ObjectLevelID
FROM MFAHv_OBJ_Related
WHERE ObjectID = 87524
GROUP BY ObjectID

*/

