select * from ConTypes


select * from GeoCodes
select * from ObjGeography


select * from ConGeoCodes
select * from ConGeography


select * from Roles where RoleTypeID = 1

select ID from ConXrefs 
where TableID = 108
and RoleID = 422
and Active = 1
and Displayed = 1
group by ID
having count(ID) > 1

select * from ConXrefs where TableID = 108 and ID = 140412

select ObjectNumber from Objects where ObjectID = 140412
