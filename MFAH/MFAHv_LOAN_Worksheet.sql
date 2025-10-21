


USE [TMS]
GO

/****** Object:  View [dbo].[MFAHv_LOAN_Worksheet]    Script Date: 7/21/2016 10:01:55 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[MFAHv_LOAN_Worksheet] 

AS

/*

MFAHv_LOAN_Worksheet
Custom MFAH View

Created		7/21/2016	Dave Thompson
						
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
lc.CourierRequired,
lc.TravelType,
lc.TravelExpense,
lc.PerDiem,
lc.NumberOfDays,
lc.TravelInsurance,
lc.Hotel,
lc.OtherRequirements,
lf.Loan AS LoanFees,
lf.Crating AS CratingFees,
lf.MattingFraming AS MatFrameFees,
lf.Conservation AS ConservationFees,
lf.Reproduction AS ReproductionFees,
lf.CompCatalogues,
li.LenderToSelfInsure,
li.EstimatedPremium,
li.AcceptsMFAHInsurance,
li.AbsoluteLiabilityRequired,
li.TerrorismOnPremisesRequired,
li.AcceptsUSGI

FROM MFAHv_LOAN AS l
LEFT OUTER JOIN [dbo].[MFAHv_LOAN_FF_Courier] AS lc ON l.LoanID = lc.LoanID
LEFT OUTER JOIN [dbo].[MFAHv_LOAN_FF_Fees] AS lf ON l.LoanID = lf.LoanID
LEFT OUTER JOIN [dbo].[MFAHv_LOAN_FF_Insurance] AS li ON l.LoanID = li.LoanID

--WHERE l.LoanID = 9704

GO



EXEC('GRANT SELECT ON MFAHv_LOAN_FF_Fees TO TMSUsers')
GO













