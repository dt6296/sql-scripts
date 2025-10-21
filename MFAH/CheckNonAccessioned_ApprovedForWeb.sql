
--Check for non-accessioned objects that are marked "approved for web"


SELECT
COUNT(*) AS Occurrences,
o.ObjectStatusID,
os.ObjectStatus

FROM Objects AS o
INNER JOIN ObjectStatuses AS os ON o.ObjectStatusID = os.ObjectStatusID

WHERE o.PublicAccess = 1

GROUP BY
o.ObjectStatusID,
os.ObjectStatus