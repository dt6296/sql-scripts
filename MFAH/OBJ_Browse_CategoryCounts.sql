

--Object Browse Category Counts


--Geography
SELECT
og.NationCountry,
COUNT(og.ObjectID)


FROM [MFAHv_OCM_Object-Geography] AS og
LEFT OUTER JOIN Objects AS o ON og.ObjectID = o.ObjectID
LEFT OUTER JOIN ObjectStatuses AS os ON og.ObjectID = o.ObjectID

WHERE os.ObjectStatusID IN (2,27)

GROUP BY og.NationCountry
ORDER BY og.NationCountry



SELECT * FROM ObjectStatuses
SELECT * FROM GeoCodes


--Current Location

SELECT
o.DisplayLocation AS Location,
COUNT(o.ObjectID) AS ObjectID


FROM MFAHv_OCM_Object AS o
WHERE o.ObjectStatusID IN (2,27)

GROUP BY o.DisplayLocation
ORDER BY o.DisplayLocation



SELECT
o.DisplayRoom		AS Room,
COUNT(o.ObjectID)	AS ObjectID

FROM MFAHv_OCM_Object AS o
WHERE o.ObjectStatusID IN (2,27)

GROUP BY o.DisplayLocation, o.DisplayRoom
ORDER BY o.DisplayLocation, o.DisplayRoom


--Classification

SELECT
o.Classification,
COUNT(o.ObjectID)	AS ObjectID

FROM MFAHv_OCM_Object AS o
WHERE o.ObjectStatusID IN (2,27)

GROUP BY o.Classification
ORDER BY o.Classification


--Accession Number


SELECT
o.ObjectID,
o.ObjectNumber,
o.Department

FROM MFAHv_OCM_Object AS o
WHERE o.ObjectStatusID IN (2,27)


--Object Culture

SELECT
COUNT(o.ObjectID) AS ObjectCount,
oc.Culture

FROM Objects AS o
LEFT OUTER JOIN ObjContext AS oc ON o.ObjectID = oc.ObjectID

GROUP BY oc.Culture
ORDER BY oc.Culture