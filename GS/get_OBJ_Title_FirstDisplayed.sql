select
 cast(o.ObjectID as nchar(10)) as ObjectID
,isnull(isnull(otf.Title,o.ObjectName),'') as Title

from [Objects]	as o
left outer join		-- First Displayed Title
(
	select
	ot.ObjectID,
	ot.TitleID,
	ot.Title,
	rank() over(partition by ot.ObjectID order by ot.DisplayOrder) as RankByDisplayOrder
	from ObjTitles as ot
	where ot.Displayed = 1
) as otf	on o.ObjectID = otf.ObjectID and otf.RankByDisplayOrder = 1