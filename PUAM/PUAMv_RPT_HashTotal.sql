USE [TMS]
GO
/****** Object:  View [dbo].[PUAMv_RPT_HashTotal]    Script Date: 3/25/2021 12:37:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--alter view [dbo].[PUAMv_RPT_HashTotal] as

/*

Created		9/29/2025	Dave Thompson	This returns the sum of the IDs (HashTotal) in each Report.

*/

select
 r.ReportGUID
,r.ReportTable
,r.HashTotal

from 
(
	select sum(cast(ID as bigint)) as HashTotal,'TMS Reports' as ReportTable,ReportGUID 
	from ReportIDs as rid 
	group by ReportGUID
	union
	select sum(cast(ID as bigint)) as HashTotal,'Web Reports' as ReportTable,ReportGUID 
	from WebReportIDs as rid 
	group by ReportGUID
) as r

go
