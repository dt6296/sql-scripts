



SELECT os.ObjectStatus, COUNT(o.ObjectID) AS ObjectCount
FROM ObjectStatuses AS os 
LEFT OUTER JOIN Objects AS o ON os.ObjectStatusID = o.ObjectStatusID 
GROUP BY os.ObjectStatus




SELECT fl.FlagLabel, COUNT(sf.ObjectID) AS ObjectCount 
FROM StatusFlags AS sf
INNER JOIN FlagLabels AS fl ON sf.FlagID = fl.FlagID
GROUP BY fl.FlagLabel
ORDER BY FlagLabel
