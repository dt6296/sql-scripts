
USE [TMS]
GO

/****** Object:  View [dbo].[MFAHv_OBJ_AccessioningDates]    Script Date: 3/22/2016 12:14:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




--ALTER VIEW [dbo].[MFAHv_OBJ_Accessioning] AS


/*

MFAHv_OBJ_Accessioning
Custom MFAH View

Created		3/22/2016	Dave Thompson
						This is intended to pull date and date parts from the ObjectAccessions
						table, to be linked into other views as neeeded, MFAHv_OBJ, for example.

*/


SELECT
ObjectID,

oa.AccessionMethodID,
am.AccessionMethod,
	
CASE	WHEN oa.AccessionMethodID = 1 THEN 'Purchases'
WHEN oa.AccessionMethodID = 2 THEN 'Gifts'
ELSE am.AccessionMethod 
END AS AccessionMethodDisplay,

oa.AccessionISODate,
	CAST(  CASE WHEN LEN(oa.AccessionISODate) = 4 THEN oa.AccessionISODate + '-06-30' ELSE 
		   CASE WHEN LEN(oa.AccessionISODate) = 7 THEN oa.AccessionISODate + '-01' ELSE
		   oa.AccessionISODate END END AS DATETIME)														AS AccessionDate,
	ISNULL(YEAR(oa.AccessionISODate),0)																	AS CY,
	ISNULL(DATEPART(QUARTER,oa.AccessionISODate),0)														AS CQ,
	ISNULL(MONTH(oa.AccessionISODate),0)																AS CM,
	ISNULL(DATENAME(MONTH,oa.AccessionISODate),'')														AS CM_Name,
	ISNULL(CASE WHEN MONTH(oa.AccessionISODate) < 7 THEN 
		YEAR(oa.AccessionISODate) ELSE 
		YEAR(oa.AccessionISODate) + 1 END,0)															AS FY,
	ISNULL(CASE WHEN DATEPART(QUARTER,oa.AccessionISODate) < 3 
		THEN DATEPART(QUARTER,oa.AccessionISODate) + 2 
		ELSE DATEPART(QUARTER,oa.AccessionISODate) - 2 END,0)											AS FQ,
	ISNULL(CASE WHEN MONTH(oa.AccessionISODate) < 7
		THEN MONTH(oa.AccessionISODate) + 6 
		ELSE MONTH(oa.AccessionISODate) - 6 END,0)														AS FM,


oa.ApprovalISODate1,		--Subcommittee Approval Date
	--ISNULL(dbo.MFAHfx_ISOtoDATETIME(oa.ApprovalISODate1),'1900-01-01 00:00.000')						AS ApprovalDate1,
	CAST(	CASE WHEN LEN(oa.ApprovalISODate1) = 4 THEN oa.ApprovalISODate1 + '-06-30' ELSE 
			CASE WHEN LEN(oa.ApprovalISODate1) = 7 THEN oa.ApprovalISODate1 + '-01' ELSE
			oa.ApprovalISODate1 END END AS DATETIME)													AS ApprovalDate1,


oa.ApprovalISODate2,		--Collections Committee Approval	
	--ISNULL(dbo.MFAHfx_ISOtoDATETIME(oa.ApprovalISODate2),'1900-01-01 00:00.000')						AS ApprovalDate2,
	CAST(	CASE WHEN LEN(oa.ApprovalISODate2) = 4 THEN oa.ApprovalISODate2 + '-06-30' ELSE 
			CASE WHEN LEN(oa.ApprovalISODate2) = 7 THEN oa.ApprovalISODate2 + '-01' ELSE
			oa.ApprovalISODate2 END END AS DATETIME)													AS ApprovalDate2,

oa.DeedOfGiftSentISO,
	--ISNULL(dbo.MFAHfx_ISOtoDATETIME(oa.DeedOfGiftSentISO),'1900-01-01 00:00.000')						AS DeedOfGiftSent,
	CAST(	CASE WHEN LEN(oa.DeedOfGiftSentISO) = 4 THEN oa.DeedOfGiftSentISO + '-06-30' ELSE 
			CASE WHEN LEN(oa.DeedOfGiftSentISO) = 7 THEN oa.DeedOfGiftSentISO + '-01' ELSE
			oa.DeedOfGiftSentISO END END AS DATETIME)													AS DeedOfGiftSent,

oa.DeedOfGiftReceivedISO,
	--ISNULL(dbo.MFAHfx_ISOtoDATETIME(oa.DeedOfGiftReceivedISO),'1900-01-01 00:00.000')					AS DeedOfGiftReceived,
	CAST(	CASE WHEN LEN(oa.DeedOfGiftReceivedISO) = 4 THEN oa.DeedOfGiftReceivedISO + '-06-30' ELSE 
			CASE WHEN LEN(oa.DeedOfGiftReceivedISO) = 7 THEN oa.DeedOfGiftReceivedISO + '-01' ELSE
			oa.DeedOfGiftReceivedISO END END AS DATETIME)												AS DeedOfGiftReceived

FROM ObjAccession					AS oa
LEFT OUTER JOIN AccessionMethods	AS am	ON	oa.AccessionMethodID = am.AccessionMethodID
GO
