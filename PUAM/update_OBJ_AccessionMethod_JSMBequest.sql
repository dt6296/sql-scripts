


select * from PackageList

select * from Packages where [Name] = 'JSM-Bequest-To-Tidy-AccMethod' -- 275476

select * from AccessionMethods

AccessionMethodID	AccessionMethod
0					(not assigned)
1					Gift
2					Purchase
3					Bequest
4					Promised Gift
5					Promised and Partial Gift
6					Exchanged
7					Donative Sale
8					Commission



--update ObjAccession
set AccessionMethodID = 3
where ObjectID in
(
	select 
	 oa.ObjectID
	,o.ObjectNumber
	,o.CreditLine
	,oa.AccessionMethodID
	,am.AccessionMethod

	from ObjAccession as oa
	inner join PackageList as pl on oa.ObjectID = pl.ID and PackageID = 275476 
	inner join Objects as o on oa.ObjectID = o.ObjectID
	inner join AccessionMethods as am on oa.AccessionMethodID = am.AccessionMethodID

	order by o.SortNumber
)
and AccessionMethodID = 1


-- Production system:
--(3364 rows affected)	Completion time: 2025-09-16T10:24:01.3548044-04:00

