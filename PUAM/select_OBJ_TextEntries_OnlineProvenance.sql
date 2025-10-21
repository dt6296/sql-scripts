

/*

	Created		10/2/2025	Dave Thompson
							For troubleshooting why some provenance text entries are not appearing in the collections website.
							Returns all Text Entries entered after 5/1/2025 where Type = Online, Purpose = Provenance, and Object is marked as Public Access


*/

select
 o.ObjectID
,te.TextTypeID
,tt.TextType
,te.Purpose
,te.TextEntry
,te.TextDate
,te.EnteredDate
,case when te.TextDate > te.EnteredDate then 'Updated' else '' end as IsUpdated

from TextEntries as te
inner join TextTypes as tt on te.TextTypeID = tt.TextTypeID
inner join Objects as o on te.ID = o.ObjectID and te.TableID = 108
 
where te.EnteredDate >= '2025-05-01 00:00'
and o.PublicAccess = 1
and te.Purpose = 'Provenance'
and te.TextTypeID in (29)





