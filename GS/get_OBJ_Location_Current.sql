
-- Version used for OBJ_List_ExportToExcel
select
 oc.ObjectID
,string_agg(c.DisplayName,'; ') as Constituent
,string_agg(ca.StreetLine1,'; ') as StreetLine1
,string_agg(ca.StreetLine2,'; ') as StreetLine2
,string_agg(ca.StreetLine3,'; ') as StreetLine3
,string_agg(ca.City,'; ') as City
,string_agg(ca.[State],'; ') as [State]
,string_agg(ca.ZipCode,'; ') as ZipCode
,string_agg(ct.Country,'; ') as Country
,string_agg(l.[Site],'; ') as [Site]
,string_agg(l.Room,'; ') as Room
,string_agg(l.UnitType,'; ') as UnitType
,string_agg(l.UnitPosition,'; ') as UnitPosition
,string_agg(l.UnitNumber,'; ') as UnitNumber
,string_agg(isnull(case when ol.LocationID = -1 then 'No current location recorded!' else l.LocationString end,''),'; ' + char(10)+char(13)) as CurLocationString

from			ObjComponents						as oc
inner join		ObjLocations						as ol	on	oc.CurrentObjLocID	= ol.ObjLocationID 
left outer join Locations							as l	on	ol.LocationID		= l.LocationID
left outer join ConAddress							as ca	on l.AddressID			= ca.ConAddressID
left outer join Countries							as ct	on ca.CountryID			= ct.CountryID
left outer join Constituents						as c	on ca.ConstituentID		= c.ConstituentID
where ol.TransCodeID < 4
--and oc.ObjectID = @ObjectID

group by
 oc.ObjectID


-- Version used for zsub_OBJ_Location_Current
SELECT
oc.ObjectID,
oc.ComponentID,
oc.ComponentNumber,
oc.HomeLocationID,

oc.ComponentName,
oc.ComponentType,
oct.ObjCompType,
oc.CompCount,
oc.SortNumber,

ol.LocationID					AS CurLocationID,
ISNULL(CASE WHEN ol.LocationID = -1 THEN 'No current location recorded!' 
ELSE l.LocationString END,'')	AS CurLocationString

FROM			ObjComponents						AS oc
LEFT OUTER JOIN	ObjCompTypes						AS oct	ON	oc.ComponentType	= oct.ObjCompTypeID
INNER JOIN		ObjLocations						AS ol	ON	oc.CurrentObjLocID	= ol.ObjLocationID 
LEFT OUTER JOIN Locations							AS l	ON	ol.LocationID		= l.LocationID
LEFT OUTER JOIN	LocPurposes							AS lp	ON	ol.LocPurposeID		= lp.LocPurposeID

WHERE ol.TransCodeID < 4
AND oc.ObjectID = @ObjectID