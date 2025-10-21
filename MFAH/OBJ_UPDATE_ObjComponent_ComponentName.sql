







SELECT 
o.ObjectID,
o.ObjectNumber,
o.ObjectName,
o.Title,
o.ClassificationID,
dbo.MFAH_Proper(c.Classification),
o.ObjectCount,
CASE WHEN o.ClassificationID IN (6,9,18,1096) THEN dbo.MFAH_Proper(LEFT(c.Classification,LEN(c.Classification)-1)) ELSE dbo.MFAH_Proper(c.Classification) END AS Class2,
oc.ComponentID,
oc.CompCount,
oc.ComponentNumber,
oc.ComponentName

FROM			Objects			AS o
LEFT OUTER JOIN	ObjComponents	AS oc	ON o.ObjectID = oc.ObjectID
LEFT OUTER JOIN	Classifications	AS c	ON o.ClassificationID = c.ClassificationID


WHERE o.ObjectID IN
(
	SELECT ObjectID 
	FROM MFAHv_ObjectAccessions
	WHERE FY = 2014
	AND FQ = 3
)	--
AND oc.ComponentName IS NULL


/*

SELECT
c.ClassificationID,
c.Classification,
RIGHT(c.Classification,1),
CASE WHEN RIGHT(c.Classification,1) = 'S' THEN 1 ELSE 0 END AS Test,
CASE WHEN RIGHT(c.Classification,1) = 'S' THEN LEFT(c.Classification,LEN(c.Classification)-1) ELSE c.Classification END AS Test2
FROM Classifications	AS c

*/

SELECT
ComponentName,
CASE WHEN Objects.ClassificationID IN (6,9,18,1096) THEN dbo.MFAH_Proper(LEFT(Classification,LEN(Classification)-1)) ELSE dbo.MFAH_Proper(Classification) END AS NewComponentName

FROM ObjComponents
INNER JOIN Objects ON ObjComponents.ObjectID = Objects.ObjectID
INNER JOIN Classifications ON Objects.ClassificationID = Classifications.ClassificationID
WHERE Objects.ObjectID IN
(
	SELECT ObjectID 
	FROM MFAHv_ObjectAccessions
	WHERE FY = 2014
	AND FQ = 3
)	--
AND ComponentName IS NULL





UPDATE ObjComponents
SET ComponentName = CASE WHEN Objects.ClassificationID IN (6,9,18,1096) THEN dbo.MFAH_Proper(LEFT(Classification,LEN(Classification)-1)) ELSE dbo.MFAH_Proper(Classification) END

FROM ObjComponents
INNER JOIN Objects ON ObjComponents.ObjectID = Objects.ObjectID
INNER JOIN Classifications ON Objects.ClassificationID = Classifications.ClassificationID
WHERE Objects.ObjectID IN
(
	SELECT ObjectID 
	FROM MFAHv_ObjectAccessions
	WHERE FY = 2014
	AND FQ = 3
)	--
AND ComponentName IS NULL
