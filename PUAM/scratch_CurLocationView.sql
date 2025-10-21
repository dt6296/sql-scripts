
/*

select 
 o.ObjectID as ID
,o.ObjectNumber
,o.SortNumber
,d.Mnemonic
,c.[Classification]
,can.DisplayName
,can.Alphasort
,ot.Title
,o.Dated
,o.DateBegin
,substring(o.[Medium],1,255) as [Medium]
,substring(o.Dimensions,1,255) as Dimensions
,substring(o.CreditLine,1,255) as CreditLine
,CurLocation =  
	(
		select --case oclv.CurLocationID when - 1 then '; no current location recorded' else '; ' + ca.ShortName + ', ' end
		string_agg
		(
			case when oclv.CurLocationID = -1 
			then 'no current location recorded' + ' (' + ComponentNumber + ')' else ca.ShortName + ', ' + 
			cast(
					concat_ws(', '
					,nullif(CurSite,'')
					,nullif(CurRoom,'')
					,nullif(CurUnitType,'')
					,nullif(CurUnitNumber,'')
					,nullif(CurUnitPosition,'')
					,nullif(CurSublevel,'')
					,nullif(CurContainer,'')) + ' (' + ComponentNumber + ')'
					as nvarchar(max)
				)
			end,'; '
		) 
		from ObjCurLocView_PUAM as oclv 
		left outer join ConAddress as ca on ca.ConAddressID = oclv.CurAddressID
		where o.ObjectID = oclv.ObjectID 
		and oclv.CurLocationID <> 3678
	 )

from			[Objects]					as o
inner join		Departments					as d	on	o.DepartmentID = d.DepartmentID 
inner join		vListViewClassifications	as c	on	o.ClassificationID = c.ClassificationID 
left outer join	ObjTitles					as ot	on	o.ObjectID = ot.ObjectID 
													and	ot.DisplayOrder = 1 
													and	ot.Displayed = 1 
left outer join	ConXrefs					as cx	on	o.ObjectID = cx.ID
inner join		Roles						as r	on	cx.RoleID = r.RoleID 
inner join		ConXrefDetails				as cxd	on	cx.ConXrefID = cxd.ConXrefID 
													and	cxd.UnMasked = 1 
inner join		ConAltNames					as can	on	cxd.NameID = can.AltNameId 
													and	cx.RoleTypeID = 1 
													and	cx.TableID = 108 
													and	cx.DisplayOrder = 1 
													and	cx.Displayed = 1

where o.ObjectNumber = '2016-1280' 
or o.ObjectNumber = '2016-1299'
or o.ObjectNumber = 'L.2023.12.087'


GO

--select ObjectNumber from Objects where ObjectID = 27355

/*
select
oc.ObjectID, o.ObjectNumber, count(*) as ComponentCount
from ObjComponents as oc
inner join Objects as o on oc.ObjectID = o.ObjectID
group by oc.ObjectID, o.ObjectNumber
having count(*) > 10
order by count(*) desc
*/




select
 ID
,ObjectNumber
,count(*) as Instances
from vlvObjects_CurLocation
group by 
 ID
,ObjectNumber
having count(*) > 1


select * from vlvObjects_CurLocation as o
where 

o.ObjectNumber = '2016-1280' 
or o.ObjectNumber = '2016-1299'
or o.ObjectNumber = 'L.2023.12.087'

ID in (31563,2219,141546)

*/

--select count(*) from Objects					--	135,854
--select count(*) from vlvObjects_CurLocation	--	135,854 records



select ID, count(*) from ConXrefs as cx
where cx.TableID = 108 and RoleTypeID = 1 and ID in

(

select sq.ID,count(*) --, o.ObjectNumber
--from [Objects] as o
--left outer join

from
(

-- 104,122 records

select 
 o.ObjectID as ID
,o.ObjectNumber
,o.SortNumber
,d.Mnemonic
,c.[Classification]
,can.DisplayName
,can.Alphasort
,ot.Title
,o.Dated
,o.DateBegin
,left(o.[Medium],255) as [Medium]
,left(o.Dimensions,255) as Dimensions
,left(o.CreditLine,255) as CreditLine
,cl.CurLocation 

from			[Objects]					as o
inner join		Departments					as d	on	o.DepartmentID = d.DepartmentID 
inner join		vListViewClassifications	as c	on	o.ClassificationID = c.ClassificationID 
left outer join	ObjTitles					as ot	on	o.ObjectID = ot.ObjectID 
													and	ot.DisplayOrder = 1 
													and	ot.Displayed = 1 
left outer join	ConXrefs					as cx	on	o.ObjectID = cx.ID		--136,004 (152 more than expected)
													and	cx.RoleTypeID = 1 
													and	cx.TableID = 108 
													and	cx.DisplayOrder = 1 
													and	cx.Displayed = 1
inner join		Roles						as r	on	cx.RoleID = r.RoleID 
inner join		ConXrefDetails				as cxd	on	cx.ConXrefID = cxd.ConXrefID 
													and	cxd.UnMasked = 1 
inner join		ConAltNames					as can	on	cxd.NameID = can.AltNameId 

left outer join
-- This works.
(
-- 135,843 records

select
 oclv.ObjectID
,string_agg(case oclv.CurLocationID when - 1 then 'No current location recorded.' 
			else ca.ShortName + ', ' +
			cast(
			concat_ws(
						 ', '
						,nullif(oclv.CurSite,'')
						,nullif(oclv.CurRoom,'')
						,nullif(oclv.CurUnitType,'')
						,nullif(oclv.CurUnitNumber,'')
						,nullif(oclv.CurUnitPosition,'')
						,nullif(oclv.CurSublevel,'')
						,nullif(oclv.CurContainer,'')
						,' (' + oclv.ComponentNumber 
						,nullif(oclv.ComponentName,'')
					  ) as nvarchar(max))
			+ ')'
			end,', ')
as CurLocation

from ObjCurLocView_PUAM as oclv -- 140,229 records
left outer join ConAddress as ca on oclv.CurAddressID = ca.ConAddressID

group by oclv.ObjectID
) as cl on o.ObjectID = cl.ObjectID




) as sq --on o.ObjectID = sq.ID
group by sq.ID
having count(*) > 1

--where sq.ID is null
--order by o.SortNumber
-- 31,732 records

) 
group by cx.ID
order by cx.ID

--	141319	L.2023.12.086 is in the above 31732 records. 
--	Maybe it's the problem with the PUAM L2-G-20 FSV-09 location?
--	It has no object-related constituents.




