select
 cast(o.ObjectID as nchar(10)) as ObjectID
,case WHEN ocfd.DisplayName like '%Unknown%' or ocfd.DisplayName is null then ocx.Culture else ocfd.DisplayName end as ArtistMaker
,case WHEN ocfd.DisplayName like '%Unknown%' or ocfd.DisplayName is null then ocx.Culture else ocfd.DisplayName end +
 case WHEN ocfd.DisplayBio is null then '' else ', ' + ocfd.DisplayBio end as ArtistMakerDisplayBio
,ocx.Culture

from [Objects]	as o
left outer join ObjContext					as ocx	on	o.ObjectID = ocx.ObjectID
left outer join		-- First Active Displayed Object-related ConXref
(
	select
	crank.ID,
	crank.ConXrefID,
	crank.rankByDisplayorder,
	crank.RoleID,
	r.[Role],
	r.Prepositional,
	can.AltNameId,
	can.ConstituentID,
	can.DisplayName,
	can.Alphasort,
	cdb.DisplayBio,
	cxd.Prefix,
	cxd.Suffix
	from
	(
		select ID, ConXrefID, RoleID,
		rank() over(partition by ID order by Displayorder) as rankByDisplayorder
		from ConXrefs
		where Active = 1		-- Active ConXref
		and Displayed = 1		-- Displayed ConXref
		and TableID = 108	
		and RoleTypeID = 1		-- Object Related ConXref
	) as crank
	left outer join ConXrefDetails	as cxd	on	crank.ConXrefID = cxd.ConXrefID and cxd.UnMasked = 1
	left outer join ConAltNames		as can	on	cxd.NameID = can.AltNameId
	left outer join ConDisplayBios	as cdb	on	cxd.DisplayBioID = cdb.ConDisplayBioID
	left outer join ConXrefs		as cx	on	cxd.ConXrefID = cx.ConXrefID
	left outer join Roles			as r	on	cx.RoleID = r.RoleID
	where crank.rankByDisplayorder = 1
) as ocfd	on o.ObjectID = ocfd.ID 