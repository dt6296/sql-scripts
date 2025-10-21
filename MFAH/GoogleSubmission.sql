
--Worchester
--Gorham
--Knoll



-- * Required


SELECT 
'Object'															AS [Record Type],					--* object, collection, series, group, volume, fonds. default = object
o.DisplayAccessionNumber											AS [Object ID],						--*
dbo.MFAHfx_ConcatTitles(o.ObjectID,'')								AS [Object Title],					--* 
o.Classification													AS [Object Work Type],				--*
o.ObjectID															AS [Alternate Object ID],
''																	AS [Object Room],
-----	Artists	--*
CASE WHEN c.ConstituentTypeID = 3 
	THEN 'Unknown' ELSE oc.LastFirst END							AS [Artist Name],
CASE WHEN CAST(c.BeginDate AS NVARCHAR(6)) = '0' 
	THEN '' ELSE CAST(c.BeginDate AS NVARCHAR(6)) END				AS [Artist Birth Date],
CASE WHEN CAST(c.EndDate AS NVARCHAR(6)) = '0' 
	THEN '' ELSE CAST(c.EndDate AS NVARCHAR(6)) END					AS [Artist Death Date],

CASE WHEN RIGHT(dbo.MFAHfx_ConcatMakers_PrepPrefix_ActiveDisplayed(o.ObjectID,''),1) = ';'
	THEN LEFT(dbo.MFAHfx_ConcatMakers_PrepPrefix_ActiveDisplayed(o.ObjectID,''),
	LEN(dbo.MFAHfx_ConcatMakers_PrepPrefix_ActiveDisplayed(o.ObjectID,''))-1)
	ELSE dbo.MFAHfx_ConcatMakers_PrepPrefix_ActiveDisplayed(o.ObjectID,'') END	
																	AS [Artist Name Display],			--want first artist, name only, but string together any others so Matt can identify
c.DisplayName														AS [IsThisArtistNameDisplay],






--oc.c_DisplayDateRange	
CASE WHEN CAST(c.BeginDate AS NVARCHAR(6)) = '0' 
	THEN '' ELSE CAST(c.BeginDate AS NVARCHAR(6)) END				AS [Artist Birth Date Display],		-- unless company include display date
CASE WHEN CAST(c.EndDate AS NVARCHAR(6)) = '0' 
	THEN '' ELSE CAST(c.EndDate AS NVARCHAR(6)) END					AS [Artist Death Date Display],		-- these two are funky :(, why not same as indexed?
ISNULL(c.Nationality,'')											AS [Artist Nationality],
''																	AS [Artist Gender],					-- We do not record gender
oc.cx_Role															AS [Role Type],
''																	AS [Artist Birth Place],			-- not consistently recorded
''																	AS [Artist Death Place],			-- not consistently recorded
				
o.DateBegin															AS [Object Earliest Date],			--*  !!!
o.DateEnd															AS [Object Latest Date],			--*  !!!
o.Dated																AS [Object Earliest Date Display],	--   !!!
CASE WHEN CAST(o.DateEnd AS NVARCHAR(6))
= CAST(o.DateBegin AS NVARCHAR(6)) THEN '' 
ELSE CAST(o.DateEnd AS NVARCHAR(6))	END								AS [Object Latest Date Display],

''																	AS [Object Rights],					-- see Facet 2
''																	AS [Object Notes],

'Medium'															AS [Object Facet Label1],			-- Medium
REPLACE(REPLACE(REPLACE(o.Medium,CHAR(10),''),CHAR(09),''),CHAR(13),'')	AS [Object Facet Value1],
'en'																AS [Object Facet Language1],
'entire'															AS [Object Facet Extent1],
'MFAH'																AS [Object Facet Label Source1],

'Credit Line'														AS [Object Facet Label2],			-- Credit Line
CAST(CASE WHEN o.ObjectStatusID = 2 THEN
	CAST('The Museum of Fine Arts, Houston, ' AS NVARCHAR(MAX)) +
	REPLACE(REPLACE(REPLACE(CAST(o.CreditLine AS NVARCHAR(MAX))
	,'Gift of','gift of')
	,'Museum purchase','museum purchase')
	,'Bequest of','bequest of')
	ELSE ISNULL(o.CreditLine,'^')END AS NVARCHAR(MAX))				AS [Object Facet Value2],
'en'																AS [Object Facet Language2],
'entire'															AS [Object Facet Extent2],
'MFAH'																AS [Object Facet Label Source2],



''																	AS [Object Facet Label3],			-- 
''																	AS [Object Facet Value3],			-- 
''																	AS [Object Facet Language3],
''																	AS [Object Facet Extent3],
''																	AS [Object Facet Label Source3],

''																	AS [Object Facet Label4],			-- Not used?
''																	AS [Object Facet Value4],
''																	AS [Object Facet Language4],
''																	AS [Object Facet Extent4],
''																	AS [Object Facet Label Source4],

''																	AS [Place Name],					-- Not used?
''																	AS [Place Relationship Type],
''																	AS [Place Classification],
''																	AS [Place Part Of],
''																	AS [Place Earliest Date Display],
''																	AS [Place Latest Date Display],

'https://collections.mfah.org/art/detail/'+
	CAST(o.ObjectID	AS NVARCHAR(10))								AS [Object Link],					-- OCM Link
'MFAH'																AS [Object Link Source],
''																	AS [Object Link Rights],

----Dimensions
d.Height															AS [Measurement Height],	
CASE WHEN d.Width = 0 THEN d.Diameter ELSE d.Width END				AS [Measurement Width],				--or Diameter
d.Depth																AS [Measurement Depth],	
'cm'																AS [Measurement Units],
d.Element															AS [Measurement Extent],			--entire, framed, etc. *****

''																	AS [Related Object ID],				-- Not used?
''																	AS [Related Object Relationship Type],
''																	AS [Related Object Note]

FROM MFAHv_OBJ									AS o
LEFT OUTER JOIN MFAHv_OBJ_Dimensions_cm			AS d	ON o.ObjectID = d.ID	AND TableID = 108
LEFT OUTER JOIN MFAHv_OBJ_Maker_FirstDisplayed	AS om	ON o.ObjectID = om.ObjectID
LEFT OUTER JOIN Constituents					AS c	ON om.ConstituentID = c.ConstituentID
LEFT OUTER JOIN MFAHv_OBJ_Constituent			AS oc	ON om.ConXrefID = oc.cx_ConXrefID
LEFT OUTER JOIN MFAHv_OBJ_Rights				AS obr	ON o.ObjectID = obr.ObjectID



WHERE o.ObjectID IN (
3765,
90926,
0,
63862,
75448,
75451,
109783,
109783,
59380,
111648,
70692,
40889,
118949,
118949,
24591,
24591,
24591,
24591,
24591,
45169,
45169
)

--WHERE o.ObjectID IN (117874,106103,95002,45831,60091,76946,17311,116879,6104)


