
--create view PUAMv_OBJ_Location_Current_byComponent as

/*

	Created		Dave Thompson	10/9/2025

*/

select 
oclv.ObjectID

,isnull(
			 case when oclv.CurLocationID = -1 
			 then 'no current location recorded' + ' (' + ComponentNumber + ')' 
			 else ca.ShortName + ', ' + 
				cast
				(
					 concat_ws(', '
					,nullif(CurSite,'')
					,nullif(CurRoom,'')
					,nullif(CurUnitType,'')
					,nullif(CurUnitNumber,'')
					,nullif(CurUnitPosition,'')
					,nullif(CurSublevel,'')
					,nullif(CurContainer,'')) + (' (' + ComponentNumber + ')') 
					as nvarchar(max)
				)
			 end
			,''
	      ) as LocationCurrent


,isnull(oclv.ComponentName,'') as ComponentName
,	isnull(
			 case when oclv.CurLocationID = -1 
			 then 'no current location recorded' + ' (' + ComponentNumber + ')' 
			 else ca.ShortName + ', ' + 
				cast
				(
					 concat_ws(', '
					,nullif(CurSite,'')
					,nullif(CurRoom,'')
					,nullif(CurUnitType,'')
					,nullif(CurUnitNumber,'')
					,nullif(CurUnitPosition,'')
					,nullif(CurSublevel,'')
					,nullif(CurContainer,'')) + (' (' + ComponentNumber + '') 
					as nvarchar(max)
				)
			 end
			,''
	      ) + 
		  case when oclv.ComponentName is null then ')' else '; ' + oclv.ComponentName + ')' end as ComponentLocationCurrent
		  


from ObjCurLocView_PUAM as oclv 
left outer join ConAddress as ca on ca.ConAddressID = oclv.CurAddressID
where oclv.CurLocationID <> 3678	-- PUAM, inventory, See Component Records	PUAM (old)
--and oclv.ObjectID = 42505







/*


select * from ObjComponents


select
ObjectID, count(*) as ComponentCount
from ObjComponents
group by ObjectID
having count(*) > 4



*/