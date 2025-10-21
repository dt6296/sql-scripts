


SELECT

o.ObjectID,
o.ObjectNumber,
tt.TitleType,
ot.Title,
ot.Remarks,
CASE WHEN ot.Active = 1 THEN 'Y' ELSE 'N' END AS Active,
CASE WHEN ot.Displayed = 1 THEN 'Y' ELSE 'N' END AS Displayed,
ot.DisplayOrder,
l.Language

FROM		ObjTitles		AS ot
INNER JOIN	Objects			AS o	ON ot.ObjectID = o.ObjectID
INNER JOIN	TitleTypes		AS tt	ON ot.TitleTypeID = tt.TitleTypeID
LEFT OUTER JOIN Languages	AS l	ON ot.LanguageID = l.LanguageID

WHERE	o.ObjectStatusID IN (2,27)
AND		ot.Title LIKE '%(%'

ORDER BY o.SortNumber

--6155 title records