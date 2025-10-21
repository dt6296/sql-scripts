--alter view dbo.PUAMv_OBJ_Value_Latest as

/*

	Created		10/9/2025	Dave Thompson

*/

select
v.ObjectID
,v.StatedValue
,v.ValuationDate
,v.ValuationPurpose
,v.StatedValueDate_Display

from 
(
	select
	ov.ObjectID
	,ov.StatedValue
	,ov.ValuationDate
	,ov.ValuationPurpose
	,ov.StatedValueDate_Display
	,rank() over(partition by ObjectID order by ov.ValueISODate desc) as RankByValueISODate
	from PUAMv_OBJ_Value as ov
)
as v

where v.RankByValueISODate = 1

GO