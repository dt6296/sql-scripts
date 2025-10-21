

--	ObjLocations view from GS



select 
 ObjLocationHistoryID as ObjLocationID
,ComponentID
,SearchContainer
,RequestedBy
,h.LoginID
,h.EnteredDate
,DateOut
,PrevObjLocID
,NextObjLocID
,SchedObjLocID
,ShipmentID
,CrateID
,LocationID
,LocLevel
,TransCodeID
,TransDate
,TransStatusID
,Handler
,LocPurposeID
,TempFlag
,TempText
,TempTicklerDate
,Approver
,AnticipEndDate
,Inactive
,Sublevel
,h.GSRowVersion

from		ObjLocationHistory	as h
inner join	MoveTransactions	as t on h.MoveTransactionID = t.MoveTransactionID

GO