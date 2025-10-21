


SELECT * FROM FlagLabels AS f



SELECT 
sf.*,
fl.*

FROM StatusFlags AS sf
LEFT OUTER JOIN FlagLabels AS fl ON sf.FlagID = fl.FlagID
WHERE sf.FlagID = 1					--Objects with the "See Rights / Repro. Restrictions" status flag.

AND sf.ObjectID IN 
(
	SELECT 
	obr.ObjectID--, *
	FROM ObjRights AS obr
	WHERE obr.ObjRightsTypeID = 2	--Objects marked "Public Domain" in the R&R Panel.   25181 records
)
--642 records
ORDER BY sf.EnteredDate DESC

--SELECT * FROM ObjRightsTypes


SELECT ObjectNumber FROM Objects WHERE ObjectID = 19287



UPDATE StatusFlags --AS sf

SET FlagID = 24

WHERE FlagID = 1					--Objects with the "See Rights / Repro. Restrictions" status flag.

AND ObjectID IN 
(
	SELECT 
	obr.ObjectID--, *
	FROM ObjRights AS obr
	WHERE obr.ObjRightsTypeID = 2	--Objects marked "Public Domain" in the R&R Panel.   25183 records
)









