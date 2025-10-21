



SELECT 

ocr.ObjectID,
ocr.ObjRightsID,
ocr.ObjRightsTypeID,
rt.ObjRightsType,
ocr.CreditLineRepro,

CASE WHEN ocr.ObjRightsTypeID = 2 THEN rt.ObjRightsType								ELSE
CASE WHEN ocr.ObjRightsTypeID = 0 THEN 'Copyright NOT CLEARED for website publication.' ELSE
ISNULL(ocr.CreditLineRepro,'Need copyright statement.')	END END AS CreditLineReproDisplay,

CASE WHEN ocr.ObjRightsTypeID = 0 OR ocr.CreditLineRepro IS NULL THEN 0 ELSE 1 END AS CreditLineCleared

FROM			ObjRights		AS ocr
LEFT OUTER JOIN	ObjRightsTypes	AS rt	ON ocr.ObjRightsTypeID = rt.ObjRightsTypeID

WHERE	ocr.ObjectID	IN

--	from Object Package record
(
	SELECT
	pl.ID
	FROM		PackageList	AS pl
	INNER JOIN	Packages	AS p	ON pl.PackageID = p.PackageID
	WHERE p.PackageID = 14311
)