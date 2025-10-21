

select * from 	ConXrefs					as cx	where--136,004 (152 more than expected)
														cx.RoleTypeID = 1 
													and	cx.TableID = 108 
													and	cx.DisplayOrder = 1 
													and	cx.Displayed = 1


select cx.ID, o.ObjectNumber, count(*)
from ConXrefs as cx
inner join Objects as o on cx.ID = o.ObjectID and cx.TableID = 108
where--136,004 (152 more than expected)
														cx.RoleTypeID = 1 
													and	cx.TableID = 108 
													and	cx.DisplayOrder = 1 
													and	cx.Displayed = 1
group by cx.ID, o.ObjectNumber
having count(*) > 1


101235	L.2014.39.73


select * from ConXrefs where TableID = 108 and ID = 101235


select cx.*, cxd.*
from ConXrefs as cx
inner join ConXrefDetails as cxd on cx.ConXrefID = cxd.ConXrefID
where cx.TableID = 108
and cxd.UnMasked = 1
and cx.ID = 101235



select cx.*, cxd.*
from ConXrefs as cx
left outer join ConXrefDetails as cxd on cx.ConXrefID = cxd.ConXrefID
where cx.ConXrefID = 345015


select
o.ObjectID, o.ObjectNumber, cx.*
from ConXrefs as cx
left outer join Objects as o on cx.ID = o.ObjectID and cx.TableID = 108
left outer join ConXrefDetails as cxd on cx.ConXrefID = cxd.ConXrefID
where cxd.ConXrefID is null
order by o.ObjectID


