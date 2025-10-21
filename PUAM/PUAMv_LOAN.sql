



--  PUAMv_LOAN

--alter view dbo.PUAMv_LOAN as


/*
    
    created     10/6/2025   Dave Thompson

*/



select distinct
 l.LoanID as ID
,l.LoanID
,l.LoanNumber
,l.SortNumber as LoanSortNumber
,l.LoanPurposeID
,l.LoanStatusID

,l.LoanIn
,LoanLit.Literal as InOut

,l.BeginISODate
,l.DispBegISODate
,dbo.PUAMfx_ISOtoDATE (l.BeginISODate) as BeginDate

,l.EndISODate
,l.DispEndISODate
,dbo.PUAMfx_ISOtoDATE (l.EndISODate) as EndDate

,dbo.PUAMfx_ISOtoDATE_Range(l.BeginISODate,l.EndISODate) as LoanDates

,l.OrigLoanEndDate as OrigLoanEndISODate
,dbo.PUAMfx_ISOtoDATE (l.OrigLoanEndDate) as OrigLoanEndDate
,case when l.OrigLoanEndDate is null then null else 'Original End Date: ' + dbo.PUAMfx_ISOtoDATE (l.OrigLoanEndDate) end as OrigLoanEndDate_withLabel

,l.LoanRenewalISODate
,dbo.PUAMfx_ISOtoDATE (l.LoanRenewalISODate) as LoanRenewalDate
,case when l.LoanRenewalISODate is null then null else 'Loan Renewal Date: ' + dbo.PUAMfx_ISOtoDATE (l.LoanRenewalISODate) end as LoanRenewalDate_withLabel

,l.DisplayDateQualifier as LoanRenewalPeriod
,case when l.DisplayDateQualifier is null then null else 'Loan Renewal Period: ' + l.DisplayDateQualifier end as LoanRenewalPeriod_withLabel

,l.LoanConditions
,case when l.LoanConditions is null or l.LoanConditions = '' then '' else 'Loan Conditions: ' + l.LoanConditions end as LoanConditions_withLabel

,case when l.LoanIn = 1 then 'Lender' else 'Borrower' end as LenderBorrower
,l.Contact

,l.PrimaryConXrefID
,lpc.DisplayName as LoanConstituent
,lpc.AlphaSort as ConstituentAlphaSort

,lp.LoanPurpose


--,case when l.LoanPurposeID = 1 then 'Exhibition: ' else 'For the purpose of: ' + lp.LoanPurpose end as LoanPurpose_withLabel
--,case when (l.LoanPurposeID = 1 and l.LoanStatusID in (2,4) and l.LoanIn = 0) then isnull(e.ExhTitle,lp.LoanPurpose) else lp.LoanPurpose end as LoanPurpose_fx
,case when (l.LoanPurposeID = 1 and l.LoanStatusID in (2,4) and l.LoanIn = 0) 
 then '<i>' + isnull(e.ExhTitle,'') + '</i>'-- + lp.LoanPurpose
 else '' + lp.LoanPurpose
 end as LoanPurpose_Exhibition

,case when (l.LoanPurposeID = 1 and l.LoanStatusID in (2,4) and l.LoanIn = 0) 
 then '<i>' + isnull(e.ExhTitle + '</i>','For the purpose of: ' + lp.LoanPurpose) 
 else 'For the purpose of: ' + lp.LoanPurpose
 end as LoanPurpose_Exhibition_Label

,ls.LoanStatus

,l.Remarks
,case when l.Remarks is null or l.Remarks = '' then '' else 'Loan Remarks: ' + l.Remarks end as LoanRemarks_withLabel

,l.[Description] as Notes

from Loans as l
inner join
(select Literal, case when LiteralNumber = 463 then 1 else 0 end as LoanIn
 from          dbo.DDLiterals
 where      (LiteralNumber in (463, 465)) and (LanguageID =
	(select     ConfigValue
     from          dbo.Configuration
     where      (ConfigLabel = 'System.Language.Default')))) as LoanLit on l.LoanIn = LoanLit.LoanIn
left outer join	dbo.vgslvLoanPrimaryConstituentS as lpc	on l.LoanID = lpc.LoanID
left outer join LoanStatuses as ls on l.LoanStatusID = ls.LoanStatusID
left outer join LoanPurposes as lp on l.LoanPurposeID = lp.LoanPurposeID
left outer join ExhLoanXrefs as elx on l.LoanID = elx.LoanID
left outer join Exhibitions as e on elx.ExhibitionID = e.ExhibitionID


/*
where l.LoanNumber = 'LTR.2017-47'

where (l.LoanPurposeID = 1 -- 1 = Exhibition
and l.LoanStatusID in (2,4) -- 2 = Pending, 4 = Declined
and l.LoanIn = 0) -- Outgoing
or l.LoanID in (select ID from PackageList where PackageID = 277940)

--select * from LoanPurposes
--select * from LoanStatuses
--select * from LoanObjStatuses

select * from PUAMv_LOAN_Objects where LoanID in (10418,10420)
*/
/*

SELECT 
    case 
        when isodate_column is null then 'no date recorded'
        when len(isodate_column) = 4 then 'Year only: ' + isodate_column
        when len(isodate_column) = 7 then 
            'Year and month: ' + format(convert(date, isodate_column + '-01'), 'MMM, yyyy')
        when len(isodate_column) = 10 then 
            'Full date: ' + format(convert(date, isodate_column), 'MMM, dd, yyyy')
        else 'Unknown format'
    end AS formatted_date
FROM your_table;





--select LoanID, BeginISODate, EndISODate from Loans where LoanID in (96,97)

if (not isnull({Loans.BeginISODate}) and len(totext({Loans.BeginISODate}))<>4.00) then (
    if not isnull({Loans.EndISODate}) then totext(datevalue({Loans.BeginISODate}), "MMMM d, yyyy") + " — " + totext(datevalue({Loans.EndISODate}), "MMMM d, yyyy")
    else if isnull({Loans.EndISODate}) then totext(datevalue({Loans.BeginISODate}), "MMMM d, yyyy") + " — no recorded end date"
    )
else if (not isnull({Loans.BeginISODate}) and len(totext({Loans.BeginISODate}))=4.00) then (
    if not isnull({Loans.EndISODate}) then totext({Loans.BeginISODate}) + " — " + totext(datevalue({Loans.EndISODate}), "MMMM d, yyyy")
    else if isnull({Loans.EndISODate}) then totext({Loans.BeginISODate}) + " — no recorded end date"
    )
else if isnull({Loans.BeginISODate}) then (
    if not isnull({Loans.EndISODate}) then "no recorded begin date — " + totext(datevalue({Loans.EndISODate}), "MMMM d, yyyy")
    else if isnull({Loans.EndISODate}) then "no recorded begin — no recorded end date"
    )


*/
