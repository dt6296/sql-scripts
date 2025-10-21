

select distinct c.componentnumber
,convert(varchar(10),ol.transdate,121) as PendingDate,

case when l.[External]=0 then
substring(l.LocationString,charindex(', ',l.locationstring,1)+2,LEN(l.locationstring))
else l.LocationString end

as MoveToLocation 
, ol.requestedby

from objlocations as ol
inner join locations as l on ol.locationid = l.locationid
left outer join objcomponents as c on c.componentid = ol.componentid
inner join objects as o on c.objectid = o.objectid
where ol.transstatusid = 0  
and datediff(week,getdate(),convert(datetime,ol.transdate,121)) between 0 and 2
and (ol.transcodeid > 7 and ol.transcodeid < 10)
/*
and ol.loginid = (

      select top 5 substring(system_user,
                       charindex('\',system_user)+1 ,
                       len(system_user)) as [login])
*/
order by pendingdate, movetolocation, c.componentnumber



SELECT
ocr.ObjectID,
ocr.ObjRightsType

FROM MFAHv_OBJ_Rights AS ocr
INNER JOIN MFAHv_OBJ AS o ON ocr.ObjectID = o.ObjectID
WHERE o.ObjectStatusID IN (2,27)


SELECT DISTINCT
oc.can_DisplayName
FROM MFAHv_OBJ_Constituent AS oc
INNER JOIN Objects AS o ON oc.o_ObjectID = o.ObjectID
WHERE cx_RoleTypeID = 1
AND o.ObjectStatusID IN (2,27)





SELECT DISTINCT
oc.can_DisplayName, ObjRightsType
FROM MFAHv_OBJ_Constituent AS oc
INNER JOIN Objects AS o ON oc.o_ObjectID = o.ObjectID
INNER JOIN MFAHv_OBJ_Rights AS ocr ON o.ObjectID = ocr.ObjectID
WHERE cx_RoleTypeID = 1
AND o.ObjectStatusID IN (2,27)



