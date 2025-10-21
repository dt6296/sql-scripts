


  
SELECT 
COUNT(*),
fl.FlagID,
fl.FlagLabel

FROM StatusFlags			AS sf
LEFT OUTER JOIN FlagLabels	AS fl	ON	sf.FlagID = fl.FlagID
  
WHERE sf.FlagID IN (21,20)

GROUP BY fl.FlagID, fl.FlagLabel






SELECT 
sf.ObjectID

FROM StatusFlags			AS sf
LEFT OUTER JOIN FlagLabels	AS fl	ON	sf.FlagID = fl.FlagID
  
WHERE sf.FlagID IN (20) --Website I
WHERE sf.FlagID IN (21) --Website II
