

select count(*) from PUAMt_Insert_Provenance_251016_AAA -- 517
select * from Packages where Name = 'Day 1-AAA-no online provenance' -- 263608

select count(*) from PUAMt_Insert_Provenance_251016_AsianArt -- 300
select * from Packages where Name = 'Asian Art - New Building Needs Provenance' -- 261087




select * from PUAMt_Insert_Provenance_251016_AAA as p
inner join PackageList as pl on p.ObjectID = pl.ID and pl.TableID = 108 and pl.PackageID = 263608 -- 517



select * from PUAMt_Insert_Provenance_251016_AsianArt as p
inner join Objects as o on p.ObjectNumber = o.ObjectNumber -- 298

select * from PUAMt_Insert_Provenance_251016_AsianArt as p
left outer join Objects as o on p.ObjectNumber = o.ObjectNumber
where o.ObjectNumber is null

inner join PackageList as pl on p.ObjectID = pl.ID and pl.TableID = 108 and pl.PackageID = 263608 -- 517



select * from AltNums as an where TableID = 108 and AltNum = 'NBGP-003'
select * from Objects where ObjectID = 140564

--update PUAMt_Insert_Provenance_251016_AsianArt
set ObjectNumber = 'L.2025.25.1'
where ObjectNumber = 'NBGP-003'




select * from PUAMt_Insert_Provenance_251016_AAA as p
inner join PackageList as pl on p.ObjectID = pl.ID and pl.TableID = 108 and pl.PackageID = 263608 -- 517


select * from PUAMt_Insert_Provenance_251016_AsianArt as p
inner join Objects as o on p.ObjectNumber = o.ObjectNumber -- 300





select ObjectID from PUAMt_Insert_Provenance_251016_AAA as p
inner join PackageList as pl on p.ObjectID = pl.ID and pl.TableID = 108 and pl.PackageID = 263608 -- 517


select ObjectID from PUAMt_Insert_Provenance_251016_AsianArt as p
inner join Objects as o on p.ObjectNumber = o.ObjectNumber -- 300


select * from textTypes where TableID = 108 -- 21 Curatorial Notes

select * from TextStatuses -- 7	OnLine

select distinct Purpose from TextEntries where TableID = 108 order by Purpose --Provenance




select te.* from TextEntries as te
where te.TableID = 108
and te.TextTypeID = 21 -- Curatorial Notes
and te.TextStatusID = 7  -- Online
and te.Purpose = 'Provenance'
and te.ID in
(
	select ObjectID from PUAMt_Insert_Provenance_251016_AAA as p
	inner join PackageList as pl on p.ObjectID = pl.ID and pl.TableID = 108 and pl.PackageID = 263608 -- 517
) -- 0


select te.* from TextEntries as te
where te.TableID = 108
and te.TextTypeID = 21 -- Curatorial Notes
and te.TextStatusID = 7  -- Online
and te.Purpose = 'Provenance'
and te.ID in
(
	select ObjectID from PUAMt_Insert_Provenance_251016_AsianArt as p
	inner join Objects as o on p.ObjectNumber = o.ObjectNumber -- 300
) -- 0



select ConstituentID from Constituents where DisplayName = 'Shing-Kwan Chan'  -- 23451

select ConstituentID from Constituents where DisplayName = 'MaryKate Cleary'  -- 23431



select 
 p.ObjectID
,108 as TableID
,21 as TextTypeID
,7 as TextStatusID
,'Provenance' as Purpose
,trim(p.Provenance) as Provenance
,'2025-10-13' as TextDate
,23431 as AuthorID -- MaryKate Cleary
from PUAMt_Insert_Provenance_251016_AAA as p

select 
 o.ObjectID
,108 as TableID
,21 as TextTypeID
,7 as TextStatusID
,'Provenance' as Purpose
,trim(p.Provenance) as Provenance
,'2025-10-13' as TextDate
,23451 as AuthorID -- Shing-Kwan Chan
from PUAMt_Insert_Provenance_251016_AsianArt as p
inner join Objects as o on p.ObjectNumber = o.ObjectNumber -- 300


-------------------------------------------   DEV SYSTEM   -------------------------------------------------------


Test System TEST.DAVE.01 -- 142671
David Thompson -- 23130

select * from Constituents where DisplayName = 'David Thompson' -- 23130
select * from Objects where ObjectNumber = 'TEST.DAVE.01'



select * from PUAMt_Insert_Provenance_251016_AAA
where Provenance like '%[[2]]%'


1753	G33	
[Rassiga Gallery, owned and operated by Everett Rassiga (1921-2003)]; purchased on April 18 1973 [1], by Gillett G. Griffin (1928-2016), Princeton, NJ [2]; bequest to the Princeton University Art Museum, 2016.  
[1] According to stylistic inference, dated invoice and gallery sticker on object. 
[2] According to multiple reference in dated slides from 1973 - 1977 in the Griffin archive.



select * from PUAMt_Insert_Provenance_251016_AAA
where  ObjectID = 1753

select * from Objects
where  ObjectID = 1753

--update PUAMt_Insert_Provenance_251016_AAA
set ObjectID = 142671 where ObjectID = 1753



--insert into TextEntries(ID,TableID,TextTypeID,TextStatusID,Purpose,TextEntry,TextEntryHTML,TextDate,AuthorConID)

select 
 p.ObjectID as ID
,108 as TableID
,21 as TextTypeID
,7 as TextStatusID
,'Provenance' as Purpose
,trim(p.Provenance) as TextEntry
,trim(p.Provenance) as TextEntryHTML
,'2025-10-13' as TextDate
,23130 as AuthorConID -- David Thompson
from PUAMt_Insert_Provenance_251016_AAA as p
where p.ObjectID = 142671

select * from TextEntries where TableID = 108 and ID = 142671



-------------------------------------------   PROD SYSTEM   -------------------------------------------------------




--insert into TextEntries(ID,TableID,TextTypeID,TextStatusID,Purpose,TextEntry,TextEntryHTML,TextDate,AuthorConID)

select 
 p.ObjectID as ID
,108 as TableID
,21 as TextTypeID
,7 as TextStatusID
,'Provenance' as Purpose
,trim(p.Provenance) as TextEntry
,trim(p.Provenance) as TextEntryHTML
,'2025-10-13' as TextDate
,23431 as AuthorConID -- MaryKate Cleary
from PUAMt_Insert_Provenance_251016_AAA as p



--insert into TextEntries(ID,TableID,TextTypeID,TextStatusID,Purpose,TextEntry,TextEntryHTML,TextDate,AuthorConID)

select 
 p.ObjectID as ID
,108 as TableID
,21 as TextTypeID
,7 as TextStatusID
,'Provenance' as Purpose
,trim(p.Provenance) as TextEntry
,trim(p.Provenance) as TextEntryHTML
,'2025-10-13' as TextDate
,23451 as AuthorConID -- Shing-Kwan Chan
from PUAMt_Insert_Provenance_251016_AsianArt as p