

select distinct Role from (

select * from Constituents where Nationality like '%america%' and constituentID not in (



select distinct				-- 31,631
 cgq.ConstituentID 
,c.DisplayName
,cx.ConXrefID
,r.Role
,cx.ID as ObjectID
,o.ObjectNumber
,os.ObjectStatus

from 
(
	select
	 cg.ConstituentID
	,cg.GeoCodeID
	,cgc.ConGeoCode
	,cg.Continent
	,cg.Country
	,cg.State
	,cg.City

	from ConGeography as cg
	inner join ConGeoCodes as cgc on cg.GeoCodeID = cgc.ConGeoCodeID

	where cg.Continent = 'North America'
	or cg.Country in ('United States','Canada','Mexico'--)
	,'Canada and United States','Mexico, Guatemala, and Belize','United States Virgin Islands')
) as cgq -- all North American constituents
inner join Constituents		as c	on cgq.ConstituentID = c.ConstituentID
inner join ConXrefDetails	as cxd	on cgq.ConstituentID = cxd.ConstituentID and cxd.UnMasked = 1
inner join ConXrefs			as cx	on cxd.ConxrefID = cx.ConXrefID and cx.RoleTypeID = 1 and cx.TableID = 108 -- object-related ConXrefs
inner join Roles			as r	on cx.RoleID = r.RoleID
inner join Objects			as o	on cx.ID = o.ObjectID and cx.TableID = 108
inner join ObjectStatuses	as os	on o.ObjectStatusID = os.ObjectStatusID

where o.ObjectStatusID in (1,6,7,10,19,20,21,22,24) -- Accessioned Objects; Princeton Collection; Acquisition Approval; Campus Collection; Firestone Collection; Promised Gift; Archives; Study Collection; Distinguished Furniture Collection
and cx.RoleID not in (434,25,420,427) -- Depicted; Former Attribution; Period; Restorer
and c.ConstituentTypeID <> 11

union

select distinct				-- 1,506
 cgq.ConstituentID 
,c.DisplayName
,cx.ConXrefID
,r.Role
,cx.ID as ObjectID
,o.ObjectNumber
,os.ObjectStatus

from 
(
	select
	 cg.ConstituentID
	,cg.GeoCodeID
	,cgc.ConGeoCode
	,cg.Continent
	,cg.Country
	,cg.State
	,cg.City

	from ConGeography as cg
	inner join ConGeoCodes as cgc on cg.GeoCodeID = cgc.ConGeoCodeID

	where cg.Continent = 'North America'
	or cg.Country in ('United States','Canada','Mexico'--)
	,'Canada and United States','Mexico, Guatemala, and Belize','United States Virgin Islands')
) as cgq -- all North American constituents
inner join Constituents		as c	on cgq.ConstituentID = c.ConstituentID
inner join ConXrefDetails	as cxd	on cgq.ConstituentID = cxd.ConstituentID and cxd.UnMasked = 1
inner join ConXrefs			as cx	on cxd.ConxrefID = cx.ConXrefID and cx.RoleTypeID = 1 and cx.TableID = 108 -- object-related ConXrefs
inner join Roles			as r	on cx.RoleID = r.RoleID
inner join Objects			as o	on cx.ID = o.ObjectID and cx.TableID = 108
inner join ObjectStatuses	as os	on o.ObjectStatusID = os.ObjectStatusID

where o.ObjectStatusID in (1,6,7,10,19,20,21,22,24) -- Accessioned Objects; Princeton Collection; Acquisition Approval; Campus Collection; Firestone Collection; Promised Gift; Archives; Study Collection; Distinguished Furniture Collection
and cx.RoleID not in (434,25,420,427) -- Depicted; Former Attribution; Period; Restorer
and c.ConstituentTypeID = 11
and c.ConstituentID in 
(
 13972	--American
,14158	--Alaskan Native
,15976	--Arctic
,15556	--Diné
,13979	--Hopitu Shi-nu-mu (Hopi)
,14660	--Inuit
,14454	--Ipiutak
,14459	--Iñupiaq
,13962	--Lingít
,15947	--Northwest Coast
,21180	--Northern Northwest Coast
,18122	--Pueblo
)

order by cgq.ConstituentID		-- 33,137

) as q



--select * from ObjectStatuses

--select * from Roles where RoleTypeID = 1 order by Role

--select distinct Country from ConGeography order by Country


select * from ConTypes 


select * from Constituents where ConstituentTypeID in (0,11)
and ConstituentID in
(
 13972	--American
,14158	--Alaskan Native
,15976	--Arctic
,15556	--Diné
,13979	--Hopitu Shi-nu-mu (Hopi)
,14660	--Inuit
,14454	--Ipiutak
,14459	--Iñupiaq
,13962	--Lingít
,15947	--Northwest Coast
,21180	--Northern Northwest Coast
,18122	--Pueblo
)
order by DisplayName



select distinct Nationality, count(*) as ConstituentCount from Constituents group by Nationality order by Nationality