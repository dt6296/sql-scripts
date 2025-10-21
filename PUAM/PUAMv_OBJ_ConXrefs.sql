

--alter view dbo.PUAMv_OBJ_ConXrefs as

/*

	Created		10/10/2025	Dave Thompson

*/


select
 cx.ConXrefID
,cx.ID as ObjectID
,cx.Active
,cx.Displayed
,cx.DisplayOrder
,cx.RoleTypeID
,rt.RoleType
,cx.RoleID
,r.[Role]
,cxd.ConXrefDetailID
,r.Prepositional
,can.AltNameId
,can.Alphasort
,can.ConstituentID
,cxd.Prefix
,can.DisplayName 
,case when cxd.Prefix is null then can.DisplayName else ' ' + can.DisplayName end as DisplayName_Display
,case when cxd.Suffix is null then '' else	
	case when left(cxd.Suffix,1) = ',' then cxd.Suffix else ' ' + cxd.Suffix
	end
 end as Suffix_Display
,cdb.DisplayBio
,cxd.DisplayDate
,case when cxd.DisplayDate is null then ' ' else ', ' + cxd.DisplayDate end as DisplayDate_Display

from			ConXrefs		as cx
left outer join ConXrefDetails	as cxd	on	cx.ConXrefID = cxd.ConXrefID and cxd.UnMasked = 1
left outer join ConAltNames		as can	on	cxd.NameID = can.AltNameId
left outer join ConDisplayBios	as cdb	on	cxd.DisplayBioID = cdb.ConDisplayBioID
left outer join RoleTypes		as rt	on	cx.RoleTypeID = rt.RoleTypeID
left outer join Roles			as r	on	cx.RoleID = r.RoleID

where cx.TableID = 108
and cxd.DisplayDate is not null
go




