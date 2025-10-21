

-- Executed 1/21/2016 1:40 PM



SELECT * FROM ObjRightsTypes AS ort
--	1 = Copyright Protected
--	2 = Public Domain

SELECT
obr.ObjectID
FROM ObjRights AS obr
--WHERE obr.ObjRightsTypeID = 1		-- 17055
--WHERE obr.ObjRightsTypeID = 2		-- 35186





SELECT * FROM FlagLabels
--	1 = See Rights / Repro. Restrictions
--	24 = Public Domain


SELECT
sf.ObjectID
FROM StatusFlags AS sf
--WHERE sf.FlagID = 1					-- 21066
--WHERE sf.FlagID = 24					-- 35052

---------------------------------------------------------------------------------------------------

-- copyright protected, but no "see rights/repro" flag


SELECT
obr.ObjectID
FROM ObjRights AS obr
WHERE obr.ObjRightsTypeID = 1		-- 17055
AND obr.ObjectID NOT IN
(
	SELECT
	sf.ObjectID
	FROM StatusFlags AS sf
	WHERE sf.FlagID = 1				-- 21066
)
-- 1535



-- Public Domain, but no Public Domain flag


SELECT
obr.ObjectID
FROM ObjRights AS obr
WHERE obr.ObjRightsTypeID = 2		-- 35186
AND obr.ObjectID NOT IN
(
	SELECT
	sf.ObjectID
	FROM StatusFlags AS sf
	WHERE sf.FlagID = 24			-- 35052
)
-- 237


---------------------------------------------------------------------------------------------------


--INSERT INTO StatusFlags (ObjectID, FlagID, OnOff, LoginID, EnteredDate)
SELECT DISTINCT o.ObjectID, 1, 1, 'dthompson', GETDATE()
FROM			Objects			AS o
WHERE	o.ObjectID IN 
(
SELECT
obr.ObjectID
FROM ObjRights AS obr
WHERE obr.ObjRightsTypeID = 1		-- 17055
AND obr.ObjectID NOT IN
(
	SELECT
	sf.ObjectID
	FROM StatusFlags AS sf
	WHERE sf.FlagID = 1				-- 21066
))	
-- 1535

56



--INSERT INTO StatusFlags (ObjectID, FlagID, OnOff, LoginID, EnteredDate)
SELECT DISTINCT o.ObjectID, 24, 1, 'dthompson', GETDATE()
FROM			Objects			AS o
WHERE	o.ObjectID IN 
(
SELECT
obr.ObjectID
FROM ObjRights AS obr
WHERE obr.ObjRightsTypeID = 2		-- 35186
AND obr.ObjectID NOT IN
(
	SELECT
	sf.ObjectID
	FROM StatusFlags AS sf
	WHERE sf.FlagID = 24			-- 35052
))
-- 237

1281

