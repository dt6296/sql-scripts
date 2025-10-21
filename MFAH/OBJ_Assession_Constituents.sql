USE [TMS]
GO

/****** Object:  View [dbo].[MFAHv_Object-Accessions]    Script Date: 04/15/2014 13:03:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







--CREATE VIEW [dbo].[MFAHv_Object-Accessions] AS


/*

MFAHv_Object-Accessions
Custom MFAH View

Author:			Dave Thompson
Created:		4/9/2014
Last Updated:	4/14/2014

Description:	
This returns the PURCHASE and most recent INSURANCE values for Objects with ObjInsurance records,
written for the quarterly accessions reports for Development and Accounting.

*/

		SELECT
		o.ObjectID,
		o.IsVirtual,
		o.SortNumber,
		o.ObjectNumber,
		o.ObjectStatusID,
		o.ObjectStatus,
		oa.AccessionMethodID,
		am.AccessionMethod,
		oa.AccessionISODate,
		o.DepartmentID,
		o.Department,
		o.Title,
		o.Dated,
		o.Culture,
		o.CreditLine,

		opp.ValuationPurposeID	AS PurchaseValueationPurposeID,
		opp.ValuationPurpose	AS PurchaseValuationPurpose,
		opp.ValueISODate		AS PurchaseValueISODate,
		opp.Value				AS PurchaseValue,
		opp.Currency			AS PurchaseCurrency,
		opp.ValueNotes			AS PurchaseNotes,

		oiv.ValuationPurposeID	AS InsuranceValueationPurposeID,
		oiv.ValuationPurpose	AS InsuranceValuationPurpose,
		oiv.ValueISODate		AS InsuranceValueISODate,
		oiv.Value				AS InsuranceValue,
		oiv.Currency			AS InsuranceCurrency,
		oiv.ValueNotes			AS InsuranceNotes,

		--Calendar Dates
		dbo.MFAHfx_CalendarYear(oa.AccessionISODate)	AS CY,
		dbo.MFAHfx_CalendarQuarter(oa.AccessionISODate)	AS CQ,
		dbo.MFAHfx_CalendarMonth(oa.AccessionISODate)	AS CM,

		--Fiscal Dates
		dbo.MFAHfx_FiscalYear(oa.AccessionISODate)		AS FY,
		dbo.MFAHfx_FiscalQuarter(oa.AccessionISODate)	AS FQ,
		dbo.MFAHfx_FiscalMonth(oa.AccessionISODate)		AS FM,
		
		o.ThumbBlob,
		oc.can_DisplayArtistMaker	-- 4/10/2014
		 
		FROM			MFAHv_OCM_Object						AS o
		LEFT OUTER JOIN ObjAccession							AS oa	ON o.ObjectID = oa.ObjectID
		LEFT OUTER JOIN AccessionMethods						AS am	ON oa.AccessionMethodID = am.AccessionMethodID

		LEFT OUTER JOIN [MFAHv_Object-ValueInsurance_Original]	AS oiv	ON o.ObjectID = oiv.ObjectID
		LEFT OUTER JOIN [MFAHv_Object-ValuePurchase]			AS opp	ON o.ObjectID = opp.ObjectID
		
		LEFT OUTER JOIN [MFAHv_Object-ObjRelCon_FirstDisplayed]	AS cfd	ON o.ObjectID = cfd.ObjectID		-- 4/10/2014
		LEFT OUTER JOIN [MFAHv_ObjectConstituent]				AS oc	ON cfd.ConXrefID = oc.cx_ConXrefID	-- 4/10/2014

		--WHERE	o.ObjectStatusID IN (2,27,5)			-- 2 = Accessioned Objects, 
														--27 = Blaffer Accessions (so we can run the report for both) 4/10/2014
		
		WHERE o.ObjectID = 110421 AND oc.cx_RoleTypeID = 2
		--AND	CASE WHEN MONTH(oa.AccessionISODate) < 6 THEN YEAR(oa.AccessionISODate) ELSE YEAR(oa.AccessionISODate) + 1 END = 2013
		--AND CASE WHEN DATEPART(QUARTER,oa.AccessionISODate) < 3 THEN DATEPART(QUARTER,oa.AccessionISODate) + 2 ELSE DATEPART(QUARTER,oa.AccessionISODate) - 2 END = 4
		
		--AND		oa.AccessionMethodID IN (1,2)		-- 1 = Purchase, 2 = Gift, others excluded (SELECT * FROM AccessionMethods)
		--AND		oa.AccessionISODate > '2011-01-01'	--BETWEEN '2012-07-01' AND '2012-09-30'  --

'This doesn''t quite work because I pull the first displayed object-constituent before pulling in the constituents to select RoleTypeID.'
'Anyway, I want ALL the acquisition-related constituents, not just first, so it needs to be in a separate view.'



GO


