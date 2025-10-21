



select * from Constituents where DisplayName = 'Stephanie Polos' -- 23799



select o.ObjectID, o.ObjectNumber, te.TextEntryID, te.TextEntry, te.TextEntryHTML, te.TextDate, te.EnteredDate
from TextEntries as te
inner join Objects as o on te.ID = o.ObjectID and te.TableID = 108
where 
(te.AuthorConID = 23799 or te.LoginID = 'sp3131')
/*
and 
(
(te.TextEntry is null or te.TextEntry = '')
or (te.TextEntryHTML is null or te.TextEntryHTML = '')
)
*/


