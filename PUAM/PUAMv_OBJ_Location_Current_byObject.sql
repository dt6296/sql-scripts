
create view PUAMv_OBJ_Location_Current_byObject as

/*

	Created		Dave Thompson	10/9/2025

*/

select 
 o.ObjectID
,LocationCurrent =  
	(
		select --case oclv.CurLocationID when - 1 then '; no current location recorded' else '; ' + ca.ShortName + ', ' end
		string_agg
		(
			case when oclv.CurLocationID = -1 
			then 'no current location recorded' + ' (' + ComponentNumber + ')' else ca.ShortName + ', ' + 
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
			end,'; '
		) 
		from ObjCurLocView_PUAM as oclv 
		left outer join ConAddress as ca on ca.ConAddressID = oclv.CurAddressID
		where o.ObjectID = oclv.ObjectID 
		and oclv.CurLocationID <> 3678	-- PUAM, inventory, See Component Records	PUAM (old)
	 )

from [Objects]	as o

go