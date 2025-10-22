---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
-- make backup table of data to be changed
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

select
 o.ObjectID
,o.ObjectNumber
,o.SortNumber
,o.DateBegin
,o.DateEnd
,o.BeginISODate
,o.EndISODate

into PUAMt_Objects_Dates_BackUp_251022

from [Objects] as o


-- (135909 rows affected)   Completion time: 2025-10-22T11:18:45.3358024-04:00



---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
-- backup database!
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
-- get AuditTrail information
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

select 
a.ObjectID
,a.ColumnName
,a.OldValue
,a.NewValue
,a.Explanation
,a.EnteredDate
,a.LoginID

from AuditTrail as a
where a.ModuleID = 1
and a.TableName = 'Objects'
and a.ColumnName in ('DateBegin','DateEnd') -- 155898
and a.EnteredDate > '2024-09-18' -- 0



select distinct
ObjectID
from AuditTrail
where TableName = 'Objects'
and ColumnName = 'DateBegin'
and EnteredDate > '2024-09-18'
--  1179 rows


select distinct
ObjectID
from AuditTrail
where TableName = 'Objects'
and ColumnName = 'DateEnd'
and EnteredDate > '2024-09-18'
-- 1179 rows









select ObjectID, ObjectNumber, Dated, DateBegin, BeginISODate, DateEnd, EndISODate from Objects where ObjectID = 19869
--select *  from Objects where ObjectID = 19869
select * from AuditTrail where ObjectID = 19869


Begin/EndISODates >> nvarchar(19),null

DateBegin/End >> int, not null

select top 1 * from Objects order by ObjectID desc


-- create object record
select ObjectID, ObjectNumber, Dated, DateBegin, BeginISODate, DateEnd, EndISODate from Objects where ObjectID = 142671
select * from AuditTrail where ObjectID = 142671


-- update dates in application (putting -500 and -200 into Begin and EndDate fields in application update ISODate fields as well.)
select ObjectID, ObjectNumber, Dated, DateBegin, BeginISODate, DateEnd, EndISODate from Objects where ObjectID = 142671
select * from AuditTrail where ObjectID = 142671
/*

AuditTrailID	ObjectID		ColumnName	OldValue	Explanation	Approvals	LoginID	EnteredDate				NewValue	TableName	ModuleID	GSRowVersion		ModuleRecordID
3298678	142671	DateBegin		0			NULL		NULL					dt6296	2025-09-09 11:19:45.190	-500		Objects		1			0x000000008F28BFEA	142671
3298679	142671	DateEnd			0			NULL		NULL					dt6296	2025-09-09 11:19:45.333	-200		Objects		1			0x000000008F28BFEC	142671
3298680	142671	BeginISODate	0			NULL		NULL					dt6296	2025-09-09 11:19:45.470	09999999500	Objects		1			0x000000008F28BFEE	142671
3298681	142671	EndISODate		0			NULL		NULL					dt6296	2025-09-09 11:19:45.610	09999999800	Objects		1			0x000000008F28BFF2	142671

*/

-- update dates in backend
--update Objects set DateBegin = 1971, DateEnd = 1971
--select ObjectID, ObjectNumber, Dated, DateBegin, BeginISODate, DateEnd, EndISODate from Objects
where ObjectID = 142671

select ObjectID, ObjectNumber, Dated, DateBegin, BeginISODate, DateEnd, EndISODate from Objects where ObjectID = 142671
select * from AuditTrail where ObjectID = 142671

-- This did NOT update BeginISODate or EndISODate


--select * from ObjDates where ObjectID = 142671 -- 0


--update in application
ObjectID	ObjectNumber	Dated		DateBegin	BeginISODate	DateEnd	EndISODate
142671		TEST.DAVE.01	500–200 B.C.	-500	09999999500		-200	09999999800
													09999999500				09999999800
--update in application
ObjectID	ObjectNumber	Dated	DateBegin	BeginISODate	DateEnd	EndISODate
142671		TEST.DAVE.01	1971	1971		10000001971		1971	10000001971


select 10000000000 - 500

select '0' + cast(10000000000 - 500 as char(11))

select '0' + cast(10000000000 - 2500 as char(11))


select ObjectID, ObjectNumber, DateBegin, DateEnd, BeginISODate, EndISODate from Objects where ObjectID = 142671

ObjectID	ObjectNumber	DateBegin	DateEnd	BeginISODate	EndISODate
142671		TEST.DAVE.01	1971		1971	10000001971		10000001971


-- update dates in backend
--update Objects set DateBegin = -500, DateEnd = -200
--select ObjectID, ObjectNumber, Dated, DateBegin, BeginISODate, DateEnd, EndISODate from Objects
where ObjectID = 142671

select ObjectID, ObjectNumber, DateBegin, DateEnd, BeginISODate, EndISODate from Objects where ObjectID = 142671

ObjectID	ObjectNumber	DateBegin	DateEnd	BeginISODate	EndISODate
142671		TEST.DAVE.01	-500		-200	10000001971		10000001971
                                                10000001971     10000001971
--update Objects
set BeginISODate = '0' + cast(10000000000 + DateBegin as char(11)),
	EndISODate = '0' + cast(10000000000 + DateEnd as char(11))
where ObjectID = 142671

--(1 row affected)	Completion time: 2025-09-09T12:09:20.5015583-04:00

select ObjectID, ObjectNumber, DateBegin, DateEnd, BeginISODate, EndISODate from Objects where ObjectID = 142671

ObjectID	ObjectNumber	DateBegin	DateEnd	BeginISODate	EndISODate
142671		TEST.DAVE.01	-500		-200	09999999500 	09999999800 
                                                09999990500     09999990200





---- "reset", update dates to 0 in application

select ObjectID, ObjectNumber, DateBegin, DateEnd, BeginISODate, EndISODate from Objects where ObjectID = 142671

ObjectID	ObjectNumber	DateBegin	DateEnd	BeginISODate	EndISODate
142671		TEST.DAVE.01	0			0		


-- update dates in backend
--update Objects set DateBegin = 1971, DateEnd = 1971
--select ObjectID, ObjectNumber, Dated, DateBegin, BeginISODate, DateEnd, EndISODate from Objects
where ObjectID = 142671

select ObjectID, ObjectNumber, DateBegin, DateEnd, BeginISODate, EndISODate from Objects where ObjectID = 142671

ObjectID	ObjectNumber	DateBegin	DateEnd	BeginISODate	EndISODate
142671		TEST.DAVE.01	1971		1971		


-- update ISO Dates in backend

--UPDATE Objects
SET BeginISODate = 
        CASE 
            WHEN DateBegin >= 0 THEN '1000000' + RIGHT('0000' + CAST(DateBegin AS VARCHAR), 4)
            ELSE '0999999' + RIGHT('0000' + CAST(ABS(DateBegin) AS VARCHAR), 4)
        END,
    EndISODate = 
        CASE 
            WHEN DateEnd >= 0 THEN '1000000' + RIGHT('0000' + CAST(DateEnd AS VARCHAR), 4)
            ELSE '0999999' + RIGHT('0000' + CAST(ABS(DateEnd) AS VARCHAR), 4)
        END
WHERE ObjectID = 142671;

select ObjectID, ObjectNumber, DateBegin, DateEnd, BeginISODate, EndISODate from Objects where ObjectID = 142671

ObjectID	ObjectNumber	DateBegin	DateEnd	BeginISODate	EndISODate
142671	    TEST.DAVE.01	1971	    1971	10000001971	    10000001971

-- Good.
-- update Dates in backend

--update Objects set DateBegin = -500, DateEnd = -200
--select ObjectID, ObjectNumber, Dated, DateBegin, BeginISODate, DateEnd, EndISODate from Objects
where ObjectID = 142671

select ObjectID, ObjectNumber, DateBegin, DateEnd, BeginISODate, EndISODate from Objects where ObjectID = 142671

ObjectID	ObjectNumber	DateBegin	DateEnd	BeginISODate	EndISODate
142671	    TEST.DAVE.01	-500	    -200	10000001971	    10000001971     -- ISO dates did not update, okay.


--UPDATE Objects
SET BeginISODate = 
        CASE 
            WHEN DateBegin >= 0 THEN '1000000' + RIGHT('0000' + CAST(DateBegin AS VARCHAR), 4)
            ELSE '0999999' + RIGHT('0000' + CAST(ABS(DateBegin) AS VARCHAR), 4)
        END,
    EndISODate = 
        CASE 
            WHEN DateEnd >= 0 THEN '1000000' + RIGHT('0000' + CAST(DateEnd AS VARCHAR), 4)
            ELSE '0999999' + RIGHT('0000' + CAST(ABS(DateEnd) AS VARCHAR), 4)
        END
WHERE ObjectID = 142671;




select ObjectID, ObjectNumber, DateBegin, DateEnd, BeginISODate, EndISODate from Objects where ObjectID = 142671

ObjectID	ObjectNumber	DateBegin	DateEnd	BeginISODate	EndISODate
142671	    TEST.DAVE.01	-500	    -200	09999990500	    09999990200 -- not quite, 0 appears where negative sign would appear
                                                9999999500      9999999800

-- try again.


--UPDATE Objects
SET BeginISODate = 
        CASE 
            WHEN DateBegin >= 0 THEN CAST(10000000000 + DateBegin + 1 AS VARCHAR)
            ELSE CAST(9999999999 + DateBegin + 1 AS VARCHAR)
        END,
    EndISODate = 
        CASE 
            WHEN DateEnd >= 0 THEN CAST(10000000000 + DateEnd + 1 AS VARCHAR)
            ELSE CAST(9999999999 + DateEnd + 1 AS VARCHAR)
        END
WHERE ObjectID = 142671;


select ObjectID, ObjectNumber, DateBegin, DateEnd, BeginISODate, EndISODate from Objects where ObjectID = 142671

ObjectID	ObjectNumber	DateBegin	DateEnd	BeginISODate	EndISODate
142671	       TEST.DAVE.01	-500	    -200	9999999500	    9999999800 -- almost, needs to be 11 characters

---------------------------------------------------------------------------------------------------------------
--  This is the query to update Begin/End ISODates
---------------------------------------------------------------------------------------------------------------

--UPDATE Objects
SET BeginISODate = 
        RIGHT('00000000000' + 
            CAST(
                CASE 
                    WHEN DateBegin >= 0 THEN 10000000000 + DateBegin
                    ELSE 9999999999 + (DateBegin + 1)
                END 
            AS VARCHAR), 11),
    EndISODate = 
        RIGHT('00000000000' + 
            CAST(
                CASE 
                    WHEN DateEnd >= 0 THEN 10000000000 + DateEnd
                    ELSE 9999999999 + (DateEnd + 1)
                END 
            AS VARCHAR), 11)
--WHERE ObjectID = 142671;


---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------


select ObjectID, ObjectNumber, DateBegin, DateEnd, BeginISODate, EndISODate from Objects where ObjectID = 142671

ObjectID	ObjectNumber	DateBegin	DateEnd	BeginISODate	EndISODate
142671	    TEST.DAVE.01	-500	    -200	09999999500	    09999999800
                                                09999990500     09999990200

-- YES

-- now update Dates to 1971

--update Objects set DateBegin = 1971, DateEnd = 1971
--select ObjectID, ObjectNumber, Dated, DateBegin, BeginISODate, DateEnd, EndISODate from Objects
where ObjectID = 142671

select ObjectID, ObjectNumber, DateBegin, DateEnd, BeginISODate, EndISODate from Objects where ObjectID = 142671

ObjectID	ObjectNumber	DateBegin	DateEnd	BeginISODate	EndISODate
142671	    TEST.DAVE.01	1971	    1971	09999999500	    09999999800

-- run script

select ObjectID, ObjectNumber, DateBegin, DateEnd, BeginISODate, EndISODate from Objects where ObjectID = 142671
ObjectID	ObjectNumber	DateBegin	DateEnd	BeginISODate	EndISODate
142671	    TEST.DAVE.01	1971    	1971	10000001971 	10000001971
                                                10000001971     10000001971

-- YES







select * from tPUAM_Objects_Dates_ZeroUpdate
--tPUAM_OBJ_Dates_ZeroUpdate










select
 o.ObjectID
,o.ObjectNumber
,o.Dated
,o.DateBegin	as DateBegin_OLD
,o.DateEnd		as DateEnd_OLD
,o.BeginISODate	as BeginISODate_OLD
,o.EndISODate	as EndISODate_OLD

,z.Dated
,z.DateBegin	as DateBegin_NEW
,z.DateEnd		as DateEnd_NEW

,RIGHT('00000000000' + 
            CAST(
                CASE 
                    WHEN z.DateBegin >= 0 THEN 10000000000 + z.DateBegin
                    ELSE 9999999999 + (z.DateBegin + 1)
                END 
            AS VARCHAR), 11)    AS BeginISODate_NEW

,RIGHT('00000000000' + 
    CAST(
        CASE 
            WHEN z.DateEnd >= 0 THEN 10000000000 + z.DateEnd
            ELSE 9999999999 + (z.DateEnd + 1)
        END 
    AS VARCHAR), 11)    AS EndISODate_NEW

from [Objects] as o
inner join tPUAM_Objects_Dates_ZeroUpdate as z on o.ObjectID = z.ObjectID

where o.ObjectID not in
(
    select distinct
    ObjectID
    from AuditTrail
    where TableName = 'Objects'
    and ColumnName = 'DateBegin'
    and EnteredDate > '2024-09-18'

    union

    select distinct
    ObjectID
    from AuditTrail
    where TableName = 'Objects'
    and ColumnName = 'DateEnd'
    and EnteredDate > '2024-09-18'
)

and o.DateEnd < 0 or o.DateBegin < 0





select
 a.ObjectID
,max(a.EnteredDate) as LastUpdated_DateBegin

from AuditTrail as a

where a.TableName = 'Objects'
and a.ColumnName = 'DateBegin'
and EnteredDate > '2024-09-18'

group by a.ObjectID



select
 a.ObjectID
,max(a.EnteredDate) as LastUpdated_DateEnd

from AuditTrail as a

where a.TableName = 'Objects'
and a.ColumnName = 'DateEnd'
and EnteredDate > '2024-09-18'

group by a.ObjectID



---------------------------------------------------------------------------------------------------------------
--- This update presumes that if either date has been updated then omit from UPDATE -- do not use, see below.




--update [Objects]

set 
 DateBegin = z.DateBegin
,DateEnd = z.DateEnd
,BeginISODate = RIGHT('00000000000' + 
    CAST(
        CASE 
            WHEN z.DateBegin >= 0 THEN 10000000000 + z.DateBegin
            ELSE 9999999999 + (z.DateBegin + 1)
        END 
    AS VARCHAR), 11)
,EndISODate = RIGHT('00000000000' + 
    CAST(
        CASE 
            WHEN z.DateEnd >= 0 THEN 10000000000 + z.DateEnd
            ELSE 9999999999 + (z.DateEnd + 1)
        END 
    AS VARCHAR), 11)

from [Objects] as o
inner join tPUAM_Objects_Dates_ZeroUpdate as z on o.ObjectID = z.ObjectID

where o.ObjectID not in
(
    select distinct
    ObjectID
    from AuditTrail
    where TableName = 'Objects'
    and ColumnName = 'DateBegin'
    and EnteredDate > '2024-09-18'

    union

    select distinct
    ObjectID
    from AuditTrail
    where TableName = 'Objects'
    and ColumnName = 'DateEnd'
    and EnteredDate > '2024-09-18'
)
---------------------------------------------------------------------------------------------------------------
-- These are the UPDATEs to use. There's one for Begin dates and one for End dates.
---------------------------------------------------------------------------------------------------------------

-- UPDATE DateBegin, BeginISODate

/*
select count(*) from PUAMt_Objects_Dates_ZeroUpdate -- 6229

select o.ObjectID, o.DateBegin, o.BeginISODate 
from Objects as o
inner join PUAMt_Objects_Dates_ZeroUpdate as z on o.ObjectID = z.ObjectID

select * from PUAMt_Objects_Dates_BackUp_251022
*/

--update [Objects]

set --select
 DateBegin = isnull(z.DateBegin,0) 
,BeginISODate = RIGHT('00000000000' + 
    CAST(
        CASE 
            WHEN z.DateBegin >= 0 THEN 10000000000 + z.DateBegin
            ELSE 9999999999 + (z.DateBegin + 1)
        END 
    AS VARCHAR), 11)

from [Objects] as o
inner join PUAMt_Objects_Dates_ZeroUpdate as z on o.ObjectID = z.ObjectID

where o.ObjectID not in
(
    select distinct
    ObjectID
    from AuditTrail
    where TableName = 'Objects'
    and ColumnName = 'DateBegin'
    and EnteredDate > '2024-09-18'
)

--  (6140 rows affected)    Completion time: 2025-10-22T11:41:24.0578473-04:00

---------------------------------------------------------------------------------------------------------------
-- UPDATE DateEnd, EndISODate



--update [Objects]

set --select
 DateEnd = isnull(z.DateEnd,0)
,EndISODate = RIGHT('00000000000' + 
    CAST(
        CASE 
            WHEN z.DateEnd >= 0 THEN 10000000000 + z.DateEnd
            ELSE 9999999999 + (z.DateEnd + 1)
        END 
    AS VARCHAR), 11)

from [Objects] as o
inner join PUAMt_Objects_Dates_ZeroUpdate as z on o.ObjectID = z.ObjectID

where o.ObjectID not in
(
    select distinct
    ObjectID
    from AuditTrail
    where TableName = 'Objects'
    and ColumnName = 'DateEnd'
    and EnteredDate > '2024-09-18'
)

--  (6140 rows affected)    Completion time: 2025-10-22T11:42:22.7405238-04:00




---------------------------------------------------------------------------------------------------------------
-- create QC list

select count(*) from PUAMt_Objects_Dates_ZeroUpdate


select
 o.ObjectID
,o.ObjectNumber

,o.Dated        as Dated_OLD
,z.Dated        as Dated_NEW

,o.DateBegin	as DateBegin_OLD
,z.DateBegin	as DateBegin_NEW
,DateBeginLastUpdated = (select max(EnteredDate) from AuditTrail where TableName = 'Objects' and ColumnName = 'DateBegin' and EnteredDate > '2024-09-18' and ObjectID = o.ObjectID)
,case when o.ObjectID in 
    (
        select distinct
        ObjectID
        from AuditTrail
        where TableName = 'Objects'
        and ColumnName = 'DateBegin'
        and EnteredDate > '2024-09-18'
    ) then 0 else 1 end as UpdateDateBegin

,o.DateEnd		as DateEnd_OLD
,z.DateEnd		as DateEnd_NEW
,DateEndLastUpdated = (select max(EnteredDate) from AuditTrail where TableName = 'Objects' and ColumnName = 'DateEnd' and EnteredDate > '2024-09-18' and ObjectID = o.ObjectID)
,case when o.ObjectID in 
    (
        select distinct
        ObjectID
        from AuditTrail
        where TableName = 'Objects'
        and ColumnName = 'DateEnd'
        and EnteredDate > '2024-09-18'
    ) then 0 else 1 end as UpdateDateEnd
,o.BeginISODate	as BeginISODate_OLD
,RIGHT('00000000000' + 
            CAST(
                CASE 
                    WHEN z.DateBegin >= 0 THEN 10000000000 + z.DateBegin
                    ELSE 9999999999 + (z.DateBegin + 1)
                END 
            AS VARCHAR), 11)    AS BeginISODate_NEW
,o.EndISODate	as EndISODate_OLD
,RIGHT('00000000000' + 
    CAST(
        CASE 
            WHEN z.DateEnd >= 0 THEN 10000000000 + z.DateEnd
            ELSE 9999999999 + (z.DateEnd + 1)
        END 
    AS VARCHAR), 11)    AS EndISODate_NEW

from [Objects] as o
inner join [dbo].[PUAMt_Objects_Dates_ZeroUpdate] as z on o.ObjectID = z.ObjectID

---------------------------------------------------------------------------------------------------------------
where
case when o.ObjectID in 
    (
        select distinct
        ObjectID
        from AuditTrail
        where TableName = 'Objects'
        and ColumnName = 'DateBegin'
        and EnteredDate > '2024-09-18'
    ) then 0 else 1 end = 0
or case when o.ObjectID in 
    (
        select distinct
        ObjectID
        from AuditTrail
        where TableName = 'Objects'
        and ColumnName = 'DateEnd'
        and EnteredDate > '2024-09-18'
    ) then 0 else 1 end = 0
