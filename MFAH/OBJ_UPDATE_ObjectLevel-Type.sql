





SELECT
o.ObjectID,
o.ObjectNumber,
o.ObjectLevelID,
o.ObjectTypeID,
o.ObjectCount


SELECT
COUNT(o.ObjectID) AS CountID,
o.ObjectLevelID,
ol.ObjectLevel,
o.ObjectTypeID,
ot.ObjectType,
o.ObjectCount

FROM Objects AS o

LEFT OUTER JOIN ObjectLevels	AS ol	ON o.ObjectLevelID = ol.ObjectLevelID
LEFT OUTER JOIN	ObjectTypes		AS ot	ON o.ObjectTypeID = ot.ObjectTypeID

WHERE o.ObjectID IN
(
	SELECT ObjectID 
	FROM MFAHv_ObjectAccessions
	WHERE FY = 2014
	AND FQ = 2
)	--745

GROUP BY
o.ObjectLevelID,
ol.ObjectLevel,
o.ObjectTypeID,
ot.ObjectType,
o.ObjectCount


--745

UPDATE Objects
SET ObjectLevelID = 6
WHERE ObjectID IN
(
	SELECT ObjectID 
	FROM MFAHv_ObjectAccessions
	WHERE FY = 2014
	AND FQ = 2
)	--745
AND ObjectLevelID IN (0,1,3)	--728



UPDATE Objects
SET ObjectTypeID = 5
WHERE ObjectID IN
(
	SELECT ObjectID 
	FROM MFAHv_ObjectAccessions
	WHERE FY = 2014
	AND FQ = 2
)	--745
AND ObjectTypeID IN (0,1,2)	--728