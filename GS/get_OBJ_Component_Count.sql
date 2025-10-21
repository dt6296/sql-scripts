select
 cast(o.ObjectID as nchar(10)) as ObjectID
,cast(occ.ComponentCount as nchar(5)) as ComponentCount

from [Objects]	as o
left outer join		-- Component Count
(
	select
	ocmp.ObjectID, count(ocmp.ComponentID) as ComponentCount, sum(ocmp.CompCount) as SumCompCount
	from ObjComponents ocmp
	group by ocmp.ObjectID
) as occ	on occ.ObjectID = o.ObjectID


