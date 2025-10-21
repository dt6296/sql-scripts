USE [TMS]
GO

/****** Object:  View [dbo].[MFAHv_LOAN_Worksheet]    Script Date: 8/12/2016 1:47:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







--CREATE VIEW [dbo].[MFAHv_LOAN_FF_Expenses] AS

/*

MFAHv_LOAN_FF_Expenses
Custom MFAH View

Created		8/12/2016	Dave Thompson
						
*/

SELECT
l.LoanID,
l.LoanNumber,
l.SortNumber,
l.Mnemonic,
l.Department,
l.LoanPurpose,
l.LoanStatus,
l.LoanIn,
l.RequestedBy,
l.RequestDate,
l.ApprovedBy,
l.ApprovedDate,
l.Remarks,
l.Contact,
l.Description,
l.BeginISODate,
l.EndISODate,
l.DispBegISODate,
l.DispEndISODate,
l.HasSpecialRequirements,
l.AgreementSentISODate,
l.AgreementReceivedISODate,
l.LoanRenewalISODate,
l.IsForeignLender,
l.PrimaryLender,
l.PrimaryLenderAlphaSort,
l.DisplayAddress,
l.EnteredDate,


lce.PerDiem,
lce.NumberOfNights,
lce.Hotel,
lce.OtherRequirements,
lce.OtherExpenses,

lf.Loan AS LoanFees,
lf.Crating AS CratingFees,
lf.MattingFraming AS MatFrameFees,
lf.Conservation AS ConservationFees,
lf.Reproduction AS ReproductionFees,
lf.CompCatalogues,
li.LenderToSelfInsure,
li.LenderToSelfInsure_Display,
li.EstimatedPremium,
li.AcceptsMFAHInsurance,
li.AcceptsMFAHInsurance_Display,
li.AbsoluteLiabilityRequired,
li.AbsoluteLiabilityRequired_Display,
li.TerrorismOnPremisesRequired,
li.TerrorismOnPremisesRequired_Display,
li.AcceptsUSGI,
li.AcceptsUSGI_Display

FROM MFAHv_LOAN AS l
LEFT OUTER JOIN [dbo].[MFAHv_LOAN_FF_Fees]				AS lf	ON l.LoanID = lf.LoanID
LEFT OUTER JOIN [dbo].[MFAHv_LOAN_FF_Insurance]			AS li	ON l.LoanID = li.LoanID
LEFT OUTER JOIN [dbo].[MFAHv_LOAN_FF_CourierExpenses]	AS lce	ON l.LoanID = lce.LoanID

WHERE l.LoanID = 9704



GO


EXEC('GRANT SELECT ON MFAHv_LOAN_FF_Expenses TO TMSUsers')
GO