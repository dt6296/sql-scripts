


--alter view [dbo].[PUAMv_PKG_HashTotal_Loans] as

	select
	pht.PackageID,
	pht.[Name],
	pht.HashTotal

	from 
	(
	
	-- Package Hash Totals
		select
		p.PackageID,p.[Name],p.ItemCount,p.PackageType,sum(cast(pl.ID as bigint)) as HashTotal
		--,sum(cast(pl.ID as bigint))+p.PackageID as HashTotalP

		from Packages as p
		inner join PackageList as pl on p.PackageID = pl.PackageID

		where p.PackageType = 1		-- "user-created packages"
		and pl.TableID = 108		-- Loans

		/*
		Package Type ID
		1 = "user-created packages"
		2 = *-MRU- packages
		13 = WEB-MEDIACART- packages
		*/

		group by
		p.PackageID,p.[Name],p.ItemCount,p.PackageType

	) as pht
	inner join
	(
		select
		ReportGUID, sum(ID) as HashTotal
		from WebReportIDs
		--where ReportGUID = @TMSReportID
		group by ReportGUID
	
		union

		select 
		ReportGUID, sum(ID) as HashTotal
		from ReportIDs
		--where ReportGUID = @TMSReportID
		group by ReportGUID
	) as r on pht.HashTotal = r.HashTotal

	union

	select
	0,
	'No',
	0