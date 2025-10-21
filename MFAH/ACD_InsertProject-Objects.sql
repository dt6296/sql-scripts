


select * from ConsProject -- 30 = Textiles

select * from Survey -- Survey_ID = 75, Proj_ID = 30


select * from ProjObj_Relation



select * from  ConsObject where Obj_Type = 'TEXTILE'


declare @projectID int
set @projectID = 30

insert into ProjObj_Relation (Proj_ID, Obj_ID)

select @projectID, Obj_ID
from  ConsObject where Obj_Type = 'TEXTILE'







