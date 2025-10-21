










SELECT 
o.ObjectNumber		AS id,
o.ObjectID			AS [alt id],
''					AS [alt id2],
''					AS [alt id3],
''					AS lender,
''					AS artist,
''					AS title,
o.Dated				AS [date of creation],
o.Medium			AS media,
od.Width			AS width,
od.Height			AS height,
od.Depth			AS depth,
'cm'				AS units

FROM MFAHv_OBJ AS o
INNER JOIN MFAHv_OBJ_Dimensions_cm AS od ON o.ObjectID = od.ID AND od.TableID = 108

WHERE o.ObjectID = 110421




