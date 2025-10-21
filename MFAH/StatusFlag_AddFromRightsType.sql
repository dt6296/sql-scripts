


-- Add StatusFlag to objects that have RightsType entered, but not a corresponding StatusFlag.
-- 7/27/2016

--------------------------------------------------------------------------Copyright Protected - See Rights / Repro. Restrictions

SELECT * FROM ObjRightsTypes
0	(not entered)
1	Copyright Protected
2	Public Domain
3	Orphan
4	Needs Research
5	Unknown




SELECT * FROM FlagLabels
1	See Rights / Repro. Restrictions
24	Public Domain





SELECT
o.ObjectID,
o.ObjectNumber,
ort.ObjRightsType

FROM Objects AS o
LEFT OUTER JOIN ObjRights AS ors ON o.ObjectID = ors.ObjectID
LEFT OUTER JOIN ObjRightsTypes AS ort ON ors.ObjRightsTypeID = ort.ObjRightsTypeID

WHERE ort.ObjRightsTypeID = 1 --Copyright Protected
AND o.ObjectID NOT IN
(
	SELECT 
	--sf.*,
	sf.ObjectID 
	FROM StatusFlags AS sf
	WHERE sf.FlagID = 1 --See Rights / Repro. Restrictions
	--AND OnOff = 0		-- 0
)


--INSERT INTO StatusFlags (ObjectID, FlagID, OnOff, LoginID, EnteredDate)

SELECT
o.ObjectID,1,1,'dthompson',GETDATE()
FROM Objects AS o

LEFT OUTER JOIN ObjRights AS ors ON o.ObjectID = ors.ObjectID
LEFT OUTER JOIN ObjRightsTypes AS ort ON ors.ObjRightsTypeID = ort.ObjRightsTypeID

WHERE ort.ObjRightsTypeID = 1 --Copyright Protected
AND o.ObjectID NOT IN
(
	SELECT 
	--sf.*,
	sf.ObjectID 
	FROM StatusFlags AS sf
	WHERE sf.FlagID = 1 --See Rights / Repro. Restrictions
	--AND OnOff = 0		-- 0
)





--------------------------------------------------------------------------Public Domain - Public Domain




SELECT * FROM ObjRightsTypes
0	(not entered)
1	Copyright Protected
2	Public Domain
3	Orphan
4	Needs Research
5	Unknown




SELECT * FROM FlagLabels
1	See Rights / Repro. Restrictions
24	Public Domain





SELECT
o.ObjectID,
o.ObjectNumber,
ort.ObjRightsType

FROM Objects AS o
LEFT OUTER JOIN ObjRights AS ors ON o.ObjectID = ors.ObjectID
LEFT OUTER JOIN ObjRightsTypes AS ort ON ors.ObjRightsTypeID = ort.ObjRightsTypeID

WHERE ort.ObjRightsTypeID = 2 --Public Domain
AND o.ObjectID NOT IN
(
	SELECT 
	--sf.*,
	sf.ObjectID 
	FROM StatusFlags AS sf
	WHERE sf.FlagID = 24 --Public Domain
	--AND OnOff = 0		-- 0
)


--INSERT INTO StatusFlags (ObjectID, FlagID, OnOff, LoginID, EnteredDate)

SELECT
o.ObjectID,24,1,'dthompson',GETDATE()
FROM Objects AS o

LEFT OUTER JOIN ObjRights AS ors ON o.ObjectID = ors.ObjectID
LEFT OUTER JOIN ObjRightsTypes AS ort ON ors.ObjRightsTypeID = ort.ObjRightsTypeID

WHERE ort.ObjRightsTypeID = 2 --Public Domain
AND o.ObjectID NOT IN
(
	SELECT 
	--sf.*,
	sf.ObjectID 
	FROM StatusFlags AS sf
	WHERE sf.FlagID = 24 -- Public Domain
	--AND OnOff = 0		-- 0
)














