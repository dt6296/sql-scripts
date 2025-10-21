








SELECT o.ObjectID, o.ObjectNumber,
--COUNT(*) AS Frequency,
o.ObjectTypeID,
ot.ObjectType

FROM Objects AS o 
LEFT OUTER JOIN ObjectTypes AS ot ON o.ObjectTypeID = ot.ObjectTypeID

WHERE o.ObjectStatusID IN (2,27)
AND o.ObjectTypeID IN (2,3,0)

ORDER BY o.ObjectTypeID, o.SortNumber

GROUP BY
o.ObjectTypeID,
ot.ObjectType




SELECT o.ObjectID, o.ObjectNumber,
--COUNT(*) AS Frequency,
o.ObjectLevelID,
ol.ObjectLevel

FROM Objects AS o 
LEFT OUTER JOIN ObjectLevels AS ol ON o.ObjectLevelID = ol.ObjectLevelID

WHERE o.ObjectStatusID IN (2,27)
AND o.ObjectLevelID IN (0,1,2)

ORDER BY o.ObjectLevelID, o.SortNumber

GROUP BY
o.ObjectLevelID,
ol.ObjectLevel



SELECT
COUNT(*) AS Frequency,
o.ObjectTypeID,
ot.ObjectType,
o.ObjectLevelID,
ol.ObjectLevel,
o.ObjectStatusID,
os.ObjectStatus

FROM Objects AS o 
LEFT OUTER JOIN ObjectTypes AS ot ON o.ObjectTypeID = ot.ObjectTypeID
LEFT OUTER JOIN ObjectLevels AS ol ON o.ObjectLevelID = ol.ObjectLevelID
LEFT OUTER JOIN ObjectStatuses AS os ON o.ObjectStatusID = os.ObjectStatusID

GROUP BY
o.ObjectTypeID,
ot.ObjectType,
o.ObjectLevelID,
ol.ObjectLevel,
o.ObjectStatusID,
os.ObjectStatus





SELECT *
FROM Objects AS o
WHERE ObjectStatusID = 27
AND ObjectTypeID = 5
AND ObjectLevelID = 1



