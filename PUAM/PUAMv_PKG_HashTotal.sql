USE [TMS]
GO
/****** Object:  View [dbo].[PUAMv_PKG_HashTotal]    Script Date: 3/25/2021 12:37:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




--alter view [dbo].[PUAMv_PKG_HashTotal] as

/*
Created		9/29/2025	Dave Thompson	This returns the sum of the ObjectIDs (HashTotal) in each OBJECT Package.
*/

-- Package Hash Totals

select
 p.PackageID
,p.TableID
,p.[Name]
,p.ItemCount
,p.PackageType
,sum(cast(pl.ID as bigint)) as HashTotal

from Packages as p
inner join PackageList as pl on p.PackageID = pl.PackageID

where p.PackageType = 1	-- "user-created packages"
--and pl.TableID = 108	-- Objects

/*
		PackageType
		1	=	"user-created packages"
		2	=	*-MRU- packages
		13	=	WEB-MEDIACART- packages
*/

group by
 p.PackageID
,p.TableID
,p.[Name]
,p.ItemCount
,p.PackageType

GO
