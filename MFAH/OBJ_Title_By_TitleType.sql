
--	SELECT * FROM TitleTypes





SELECT
ot.ObjectID,
o.Original

FROM ObjTitles AS ot

LEFT OUTER JOIN
(
	SELECT
	ot.ObjectID,
	ot.TitleTypeID,
	ot.Title AS Original
	FROM ObjTitles AS ot
	WHERE ot.TitleTypeID = 30	-- Original
)	AS o ON ot.ObjectID = o.ObjectID AND ot.TitleTypeID = o.TitleTypeID

WHERE ot.ObjectID = 110421

