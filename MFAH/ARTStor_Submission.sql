






SELECT


CASE WHEN RIGHT(dbo.MFAHfx_ConcatMakers_PrepPrefix_ActiveDisplayed(o.ObjectID,''),1) = ';'
	THEN LEFT(dbo.MFAHfx_ConcatMakers_PrepPrefix_ActiveDisplayed(o.ObjectID,''),
	LEN(dbo.MFAHfx_ConcatMakers_PrepPrefix_ActiveDisplayed(o.ObjectID,''))-1)
	ELSE dbo.MFAHfx_ConcatMakers_PrepPrefix_ActiveDisplayed(o.ObjectID,'') END		AS Creator,
o.Culture								AS Culture,
o.Title									AS Title,
''	AS ImageViewDescription,
o.Dated									AS Date,
o.DateBegin								AS EarliestDate,
o.DateEnd								AS LatestDate,
ISNULL(o.Style,'') + ' ' + ISNULL(o.Period,'')	AS StylePeriod,
o.Medium								AS MaterialsTechniques,
o.Dimensions							AS Measurements,
o.Classification						AS WorkType,
'Houston, Texas USA'					AS Location,
'The Museum of Fine Arts, Houston'		AS Repository,
o.DisplayAccessionNumber				AS RepositoryAccessionNumber,
''										AS Description,
''										AS Subject,
''										AS Relationships,
'The Museum of Fine Arts, Houston'		AS Source,
''										AS Photographer,
''										AS ImageDate,
o.ObjectID								AS IDNumber,
ISNULL(obr.OCMCopyrightStatement,'')	AS Rights

FROM			MFAHv_OBJ						AS o
LEFT OUTER JOIN MFAHv_OBJ_Rights				AS obr	ON o.ObjectID = obr.ObjectID

WHERE o.ObjectID IN (117874,106103,95002,45831,60091,76946,17311,116879,6104)