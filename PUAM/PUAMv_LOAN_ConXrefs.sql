USE [TMS]
GO

/****** Object:  View [dbo].[PUAMv_LOAN_ConXrefs]    Script Date: 10/8/2025 1:44:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--alter view [dbo].[PUAMv_LOAN_ConXrefs] as

/*
    
    created     10/8/2025   Dave Thompson

*/

-- Primary Loan Constituent (Borrower/Lender)
select
 l.PrimaryConXrefID
,cx.ConXrefID
,'Primary' as ConXrefType
,l.LoanID
,l.LoanNumber
,cxd.ConstituentID
,r.RoleID
,r.[Role]
,cxd.Prefix
,c.DisplayName
,cxd.Suffix
,cdb.DisplayBio
,cxd.AddressID
,ca.DisplayAddress
,isnull(ca.DisplayAddress,c.DisplayName) as DisplayAddressOrName
,cx.DisplayOrder
,cxd.DateBegin
,cxd.BeginISODate
,cxd.DateEnd
,cxd.EndISODate
,cxd.Remarks
,cxd.ConStatement
,cxd.Amount
,cxd.DisplayDate

from Loans as l
left outer join ConXrefs as cx on l.LoanID = cx.ID and cx.TableID = 81 and l.PrimaryConXrefID = cx.ConXrefID
inner join ConXrefDetails as cxd on cx.ConXrefID = cxd.ConXrefID and cxd.UnMasked = 1
inner join Roles as r on cx.RoleID = r.RoleID
inner join Constituents as c on cxd.ConstituentID = c.ConstituentID
left outer join ConDisplayBios as cdb on cxd.DisplayBioID = cdb.ConDisplayBioID 
left outer join ConAddress as ca on cxd.AddressID = ca.ConAddressID

where cx.Displayed = 1
and cx.Active = 1

UNION

-- Loan Registrars
select
 l.PrimaryConXrefID
,cx.ConXrefID
,'Registrar' as ConXrefType
,l.LoanID
,l.LoanNumber
,cxd.ConstituentID
,r.RoleID
,r.[Role]
,cxd.Prefix
,c.DisplayName
,cxd.Suffix
,cdb.DisplayBio
,cxd.AddressID
,ca.DisplayAddress
,isnull(ca.DisplayAddress,c.DisplayName) as DisplayAddressOrName
,cx.DisplayOrder
,cxd.DateBegin
,cxd.BeginISODate
,cxd.DateEnd
,cxd.EndISODate
,cxd.Remarks
,cxd.ConStatement
,cxd.Amount
,cxd.DisplayDate

from Loans as l
left outer join ConXrefs as cx on l.LoanID = cx.ID and cx.TableID = 81 --and l.PrimaryConXrefID = cx.ConXrefID
inner join ConXrefDetails as cxd on cx.ConXrefID = cxd.ConXrefID and cxd.UnMasked = 1
inner join Roles as r on cx.RoleID = r.RoleID
inner join Constituents as c on cxd.ConstituentID = c.ConstituentID
left outer join ConDisplayBios as cdb on cxd.DisplayBioID = cdb.ConDisplayBioID 
left outer join ConAddress as ca on cxd.AddressID = ca.ConAddressID

where cx.Displayed = 1
and cx.Active = 1
and cx.RoleID in (470,471) -- Registrars


UNION

-- All other Loan Constituents
select
 l.PrimaryConXrefID
,cx.ConXrefID
,'Other' as ConXrefType
,l.LoanID
,l.LoanNumber
,cxd.ConstituentID
,r.RoleID
,r.[Role]
,cxd.Prefix
,c.DisplayName
,cxd.Suffix
,cdb.DisplayBio
,cxd.AddressID
,ca.DisplayAddress
,isnull(ca.DisplayAddress,c.DisplayName) as DisplayAddressOrName
,cx.DisplayOrder
,cxd.DateBegin
,cxd.BeginISODate
,cxd.DateEnd
,cxd.EndISODate
,cxd.Remarks
,cxd.ConStatement
,cxd.Amount
,cxd.DisplayDate

from Loans as l
left outer join ConXrefs as cx on l.LoanID = cx.ID and cx.TableID = 81 and l.PrimaryConXrefID <> cx.ConXrefID
inner join ConXrefDetails as cxd on cx.ConXrefID = cxd.ConXrefID and cxd.UnMasked = 1
inner join Roles as r on cx.RoleID = r.RoleID
inner join Constituents as c on cxd.ConstituentID = c.ConstituentID
left outer join ConDisplayBios as cdb on cxd.DisplayBioID = cdb.ConDisplayBioID 
left outer join ConAddress as ca on cxd.AddressID = ca.ConAddressID

where cx.Displayed = 1
and cx.Active = 1
and cx.RoleID not in (470,471)






GO


--select * from Roles order by RoleTypeID, Role

--select count(*) from Loans

--select count(*) from ConXrefs where TableID = 81