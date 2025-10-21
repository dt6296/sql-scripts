USE [TMS]
GO
/****** Object:  View [dbo].[PUAMv_LOAN_Objects]    Script Date: 3/25/2021 12:37:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

alter view [dbo].[PUAMv_LOAN_Objects] as

/*

Created		10/8/2025	Dave Thompson

*/

select
 lox.LoanID
,l.LoanNumber
,lox.LoanObjXrefID
,lox.ObjectID
,lox.Conditions
,lox.CourierRequirements
,lox.IsCourierRequired
,case when lox.IsCourierRequired = 1 then 'Required' 
	else 'Not Required' end								as IsCourierRequiredDisplay
,lox.LoanObjectStatusID
,los.LoanObjectStatus
,case when los.LoanObjectStatus is null or los.LoanObjectStatus = '' 
 then '(loan object status not recorded)'
 else los.LoanObjectStatus
 end as LoanObjStatus_Display
,lox.LoanObjStatus_OLD
,case when lox.LoanObjStatus_OLD is null or lox.LoanObjStatus_OLD = '' 
 then '(loan object status not recorded)'
 else lox.LoanObjStatus_OLD
 end as LoanObjStatus_OLD_Display
,lox.[Description]										as Notes
,lox.Remarks
,lox.InsuranceValueID
,oi.CurrencyValue
,oi.CurrencyID
,c.CurrencyCode
,c.Currency
,isnull(oi.[Value],0)									as [Value]
,isnull(lox.IndemnityReceivedValue,0)					as IndemnityReceivedValue


,isnull(lox.LoanFee,0)									as LoanFee
,lox.ISOLoanPaidDate
,dbo.PUAMfx_ISOtoDATE(lox.ISOLoanPaidDate)				as LoanPaidDate


,isnull(lox.ConservationFee,0)							as MattingAndFramingFee	
,lox.ISOConservationPaidDate								as ISOMattingAndFramingPaidDate
,dbo.PUAMfx_ISOtoDATE(lox.ISOConservationPaidDate)		as MattingAndFramingPaidDate


,isnull(lox.CrateFee,0)									as CrateFee
,lox.ISOCratePaidDate
,dbo.PUAMfx_ISOtoDATE(lox.ISOCratePaidDate)				as CratePaidDate


,isnull(lox.InsuranceFee,0)								as ConservationFee
,lox.InsuranceFeePaidDateISO
,dbo.PUAMfx_ISOtoDATE(lox.InsuranceFeePaidDateISO)		as ConservationFeePaidDate


,isnull(lox.OtherFees,0)									as OtherFees
,lox.OtherFeesPaidDateISO
,dbo.PUAMfx_ISOtoDATE(lox.OtherFeesPaidDateISO)			as OtherFeesPaidDate


,isnull(lox.LoanFee,0) + isnull(lox.ConservationFee,0) + 
 isnull(lox.CrateFee,0) + isnull(lox.InsuranceFee,0) + 
 isnull(lox.OtherFees,0)								as TotalFees

/*
l.PrimaryLender,
l.PrimaryLenderAlphaSort,
l.DisplayAddress,
l.Remarks
*/

from			Loans			as l
left outer join	LoanObjXrefs	as lox	on l.LoanID = lox.LoanID
left outer join ObjInsurance	as oi	on lox.InsuranceValueID = oi.ObjInsuranceID
left outer join Currencies		as c	on oi.CurrencyID = c.CurrencyID
left outer join LoanObjStatuses as los	on lox.LoanObjectStatusID = los.LoanObjectStatusID

--WHERE l.LoanID = 12672

GO
