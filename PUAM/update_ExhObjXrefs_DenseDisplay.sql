
select count(*) from PUAMt_UPDATE_DenseDisplay_251014 -- 279


select count(*) from ExhObjXrefs

select
*
into PUAMt_ExhObjXrefs_251014_1610_backup
from ExhObjXrefs

--(35926 rows affected)
--Completion time: 2025-10-03T13:02:42.0583431-04:00

--(36290 rows affected)
--Completion time: 2025-10-14T13:46:30.9707998-04:00

select count(*) from PUAMt_ExhObjXrefs_251014_backup

-- BACKUP DATABASE!!! ---



select
u.*

from PUAMt_UPDATE_DenseDisplay_251014 as u
left outer join ExhObjXrefs as eox on u.ExhibitionID = eox.ExhibitionID and eox.ObjectID = u.ObjectID
where eox.ObjectID is null

ObjectID	ObjectNumber	DenseDisplayCase	Section	Segment	CaseNumber	SequenceNumber	ExhibitionID
1259		2016-1326		World in Miniature	4		NULL	4			2				3834
2226		2016-1355		World in Miniature	4		NULL	4			1				3834
2281		2016-1358		World in Miniature	9		NULL	9			9				3834
2283		2016-1360		World in Miniature	6		NULL	6			6				3834

ObjectID	Object_Number	DemseDisplayCase						Section	Segment	CaseNumber	SequenceNumber	ExhibitionID
16266		x1986-206		EW Artwalk Case B - Materials Surfaces	1		NULL	1			1				3934
44186		2005-17			EW Artwalk Case B - Materials Surfaces	2		NULL	2			2				3934

select
u.*
from PUAMt_UPDATE_DenseDisplay_251014 as u
inner join ExhObjXrefs as eox on u.ExhibitionID = eox.ExhibitionID and eox.ObjectID = u.ObjectID



select distinct ExhibitionID from PUAMt_UPDATE_DenseDisplay_251014



select 
 eox.ExhibitionID
,eox.ObjectID
,eox.Section
,eox.Segment
,eox.CaseNumber
,eox.SequenceNumber
,u.Section
,u.Segment
,u.CaseNumber
,u.SequenceNumber


from ExhObjXrefs as eox
inner join PUAMt_UPDATE_DenseDisplay_251014 as u on u.ExhibitionID = eox.ExhibitionID and eox.ObjectID = u.ObjectID

where eox.ExhibitionID in 
(
 3931
,3932
,3933
,3934
)

order by 
 eox.ExhibitionID
,eox.ObjectID




--update ExhObjXrefs
set 
 Section = u.Section
,Segment = u.Segment
,CaseNumber = u.CaseNumber
,SequenceNumber = u.SequenceNumber
--select *
from ExhObjXrefs as eox
inner join PUAMt_UPDATE_DenseDisplay_251014 as u on eox.ExhibitionID = u.ExhibitionID and eox.ObjectID = u.ObjectID
where eox.ExhibitionID = u.ExhibitionID
and eox.ObjectID = u.ObjectID


--(94 rows affected)
--Completion time: 2025-10-03T13:09:37.5625962-04:00



--(277 rows affected)
--Completion time: 2025-10-14T14:41:58.4417759-04:00