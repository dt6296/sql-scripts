
SELECT * FROM FlagLabels AS f
WHERE FlagID IN (20,21)




SELECT 
sf.*,
fl.*

FROM StatusFlags AS sf
LEFT OUTER JOIN FlagLabels AS fl ON sf.FlagID = fl.FlagID
WHERE sf.FlagID IN (20,21)				--13032 Objects with the "See Rights / Repro. Restrictions" status flag.
ORDER BY sf.EnteredDate DESC




SELECT
SUM(sf.OnOff) AS OnOff
FROM StatusFlags AS sf
WHERE sf.FlagID IN (20,21)				-- 13032 Objects with the "See Rights / Repro. Restrictions" status flag.
GROUP BY sf.OnOff


--UPDATE StatusFlags
SET OnOff = 0
WHERE FlagID IN (20,21)		--(13032 row(s) affected)


--DELETE FROM StatusFlags
WHERE FlagID IN (20,21)		--(13032 row(s) affected)

