



--select * from ExhObjXrefs where ExhibitionID in 


select
eox.Section
,'Section ' + eox.Section from ExhObjXrefs as eox where eox.ExhibitionID in 

(
	select distinct ExhibitionID from PUAMt_UPDATE_DenseDisplay_251001
	union
	select distinct ExhibitionID from PUAMt_UPDATE_DenseDisplay_251003
	union
	select distinct ExhibitionID from PUAMt_UPDATE_DenseDisplay_251014
)

--update ExhObjXrefs
set Section = 'Section ' + Section
where ExhibitionID in
--select * from ExhObjXrefs where ExhibitionID in
(
	select distinct ExhibitionID from PUAMt_UPDATE_DenseDisplay_251001
	union
	select distinct ExhibitionID from PUAMt_UPDATE_DenseDisplay_251003
	union
	select distinct ExhibitionID from PUAMt_UPDATE_DenseDisplay_251014
)

--(1115 rows affected)
--Completion time: 2025-10-14T16:18:21.7849119-04:00




--------------------------

select
eox.Section
,'Section ' + eox.Section from ExhObjXrefs as eox where eox.ExhibitionID in 

(
	3943,3954
)
-- 112 rows


select
*
into PUAMt_ExhObjXrefs_251015_backup
from ExhObjXrefs

--(36290 rows affected)
--Completion time: 2025-10-15T15:15:50.8356657-04:00


--update ExhObjXrefs
set Section = 'Section ' + Section
where ExhibitionID in
--select * from ExhObjXrefs where ExhibitionID in
(
	3943,3954
)

--(112 rows affected)
--Completion time: 2025-10-15T15:16:34.6526860-04:00