select
og.ObjectID
,string_agg(
	 nullif(
		 concat_ws(', '
		 	-- Physical Geography
			,nullif(og.Building,'')
			,nullif(og.Excavation,'')
			,nullif(og.locus,'')
			,nullif(og.Locale,'')
			,nullif(og.CulturalRegion,'')
			,nullif(og.River,'')
			,nullif(og.SubRegion,'')
			,nullif(og.Region,'')
			,nullif(og.SubContinent,'')
			,nullif(og.Continent,'')

			-- Political Geography
			,nullif(og.MapReferenceNumber,'')
			,nullif(og.VillageCorporation,'')
			,nullif(og.RegionalCorp,'')
			,nullif(og.Township,'')
			,nullif(og.City,'')
			,nullif(og.County,'')
			,nullif(og.[State],'')
			,nullif(og.PoliticalRegion,'')
			,nullif(og.Country,'')
			,nullif(og.Nation,'')
		)
	,'')
,'; ') as Place
from ObjGeography as og
inner join GeoCodes as gc on og.GeoCodeID = gc.GeoCodeID
where og.GeoCodeID = 1
group by og.ObjectID