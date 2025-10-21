

select
 o.ObjectID
,mr.ThumbBLOB

from [Objects] as o
left outer join MediaXrefs as mx on o.ObjectID = mx.ID and mx.TableID = 108
left outer join MediaRenditions as mr on mx.MediaMasterID = mr.MediaMasterID

where mx.PrimaryDisplay = 1
