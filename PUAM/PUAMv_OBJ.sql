

--alter view dbo.PUAMv_OBJ as

/*

	Created		10/8/2025	Dave Thompson

*/

select

/*
--Package Info
rp.ID
,rp.ReportGUID
,rp.PackageID 
,rp.OrderPOS
,cast(o.ObjectID as nchar(10)) as ObjectID
,'a' as GroupByNone
*/

--Tombstone Data
 o.ObjectID	as ID
,o.ObjectID
,o.ObjectNumber
,ocfd.DisplayName as ArtistMaker
,ocfd.DisplayName +
 case when ocfd.DisplayBio IS NULL then '' else ', ' + ocfd.DisplayBio end as ArtistMakerDisplayBio
,o.ObjectName
,isnull(otf.Title,o.ObjectName) as Title
,o.Dated
,case when o.Dated is null then isnull(otf.Title,o.ObjectName)
 else isnull(isnull(otf.Title,o.ObjectName),'') + ', ' + isnull(o.Dated,'') end as TitleDate
,case when o.Dated is null then '<i>' + isnull(otf.Title,o.ObjectName) + '</i>'
 else '<i>' + isnull(isnull(otf.Title,o.ObjectName),'') + '<i>' + ', ' + isnull(o.Dated,'') end as TitleDate_Formatted
,o.DateBegin
,o.DateEnd
,cast(o.[Medium] as nvarchar(4000))		as [Medium]
,cast(o.Dimensions as nvarchar(4000))	as Dimensions
,cast(o.CreditLine as nvarchar(4000))	as CreditLine

--Context
,ocx.Culture
,ocx.Nationality
,ocx.Style
,ocx.School
,ocx.Dynasty
,ocx.Reign
,ocx.Movement
,ocx.[Period]

--Documentation
,cast(o.Portfolio as nvarchar(4000))			as Portfolio
,cast(o.[State] as nvarchar(4000))				as [State]
,cast(o.Edition as nvarchar(4000))				as Edition
,cast(o.Signed as nvarchar(4000))				as Signed
,cast(o.Markings as nvarchar(4000))				as Markings
,cast(o.Inscribed as nvarchar(4000))			as Inscribed
,cast(o.Inscribed as nvarchar(4000))			as Inscriptions
,o.PaperSupport
,o.Provenance
,cast(o.CatRais as nvarchar(4000))				as CatRais
,cast(o.PubReferences as nvarchar(4000))		as PublishedReferences
,cast(o.Bibliography as nvarchar(4000))			as Bibliography
,cast(o.RelatedWorks as nvarchar(4000))			as RelatedWorks
,cast(o.Exhibitions as nvarchar(4000))			as Exhibitions
,o.PaperFileRef									as DescriptiveKeyword
,cast(o.Notes as nvarchar(4000))				as Notes
,cast(o.CuratorialRemarks as nvarchar(4000))	as CuratorialRemarks
,cast(o.[Description] as nvarchar(4000))		as [Description]
--,cnd.OverallCondition							as OverallCondition
--,cnd.ConditionDate							as ConditionDate

--Administrative
,ot.ObjectType
,ol.ObjectLevel
,cast(o.ObjectCount as nchar(5))				as ObjectCount
,cast(occ.ComponentCount as nchar(5))			as ComponentCount
,case when o.IsVirtual = 1 then 'Virtual Object' else 'Physical Object' end as IsVirtualDisplay
,case when o.CuratorApproved = 1 then 'Curator Approved' else 'NOT Curator Approved' end as IsCuratorApprovedDisplay
,case when o.PublicAccess = 1 then 'Public Access Approved' else 'NOT Public Access Approved' end as IsPublicAccessApprovedDisplay
,d.Department
,c.[Classification]
,case when o.OnView = 1 then 'on view' else 'not on view' end as IsOnviewDisplay
,o.SortNumber

--Registration
,os.ObjectStatus
,am.AccessionMethod

--Object Rights
,rt.ObjRightsType
,cast(ocr.Copyright as nvarchar(4000))			as Copyright
,cast(ocr.Restrictions as nvarchar(4000)) 		as Restrictions
,cast(ocr.CreditLineRepro as nvarchar(4000))	as CreditLineRepro

--Thumbnail
,mr.ThumbBlob

--Cached Image
--,ci.MediaCachePathFileHTTP

from [Objects]								as o
left outer join ObjectLevels				as ol	ON	o.ObjectLevelID = ol.ObjectLevelID
left outer join ObjectTypes					as ot	ON	o.ObjectTypeID = ot.ObjectTypeID
left outer join Departments					as d	ON	o.DepartmentID = d.DepartmentID
left outer join Classifications				as c	ON	o.ClassificationID = c.ClassificationID
left outer join ObjContext					as ocx	ON	o.ObjectID = ocx.ObjectID
left outer join ObjectStatuses				as os	ON	o.ObjectStatusID = os.ObjectStatusID
left outer join MediaXrefs					as mx	ON	o.ObjectID = mx.ID 
													and mx.TableID = 108 
													and mx.PrimaryDisplay = 1
left outer join MediaMaster					as mm	ON	mx.MediaMasterID = mm.MediaMasterID
left outer join MediaRenditions				as mr	ON	mm.DisplayRendID = mr.RenditionID
left outer join ObjRights					as ocr	ON	o.ObjectID = ocr.ObjectID
left outer join ObjRightsTypes				as rt	ON	ocr.ObjRightsTypeID = rt.ObjRightsTypeID
left outer join ObjAccession				as oa	ON	o.ObjectID = oa.ObjectID
left outer join AccessionMethods			as am	ON	oa.AccessionMethodID = am.AccessionMethodID

-- Component count
left outer join		
(
	select
	ocmp.ObjectID, count(ocmp.ComponentID) as Componentcount, sum(ocmp.Compcount) as SumCompcount
	from ObjComponents ocmp
	GROUP BY ocmp.ObjectID
) as occ	on occ.ObjectID = o.ObjectID

-- First Displayed Title
left outer join		
(
	select
	ot.ObjectID,
	ot.TitleID,
	ot.Title,
	rank() over(partition by ot.ObjectID order by ot.DisplayOrder) as RankByDisplayOrder
	from ObjTitles as ot
	where ot.Displayed = 1
) as otf	on o.ObjectID = otf.ObjectID and otf.RankByDisplayOrder = 1

-- First Active Displayed Object-related ConXref
left outer join		
(
	select
	crank.ID,
	crank.ConXrefID,
	crank.RankByDisplayOrder,
	crank.RoleID,
	r.[Role],
	r.Prepositional,
	can.AltNameId,
	can.ConstituentID,
	can.DisplayName,
	can.AlphaSort,
	cdb.DisplayBio,
	cxd.Prefix,
	cxd.Suffix
	from
	(
		select ID, ConXrefID, RoleID,
		rank() over(partition by ID order by DisplayOrder) as RankByDisplayOrder
		from ConXrefs
		where Active = 1		-- Active ConXref
		and Displayed = 1		-- Displayed ConXref
		and TableID = 108	
		and RoleTypeID = 1		-- Object Related ConXref
	) as crank
	left outer join ConXrefDetails	as cxd	ON	crank.ConXrefID = cxd.ConXrefID and cxd.UnMasked = 1
	left outer join ConAltNames		as can	ON	cxd.NameID = can.AltNameId
	left outer join ConDisplayBios	as cdb	ON	cxd.DisplayBioID = cdb.ConDisplayBioID
	left outer join ConXrefs		as cx	ON	cxd.ConXrefID = cx.ConXrefID
	left outer join Roles			as r	ON	cx.RoleID = r.RoleID
	where crank.RankByDisplayOrder = 1
) as ocfd	on o.ObjectID = ocfd.ID 	

/*
-- Master Display Conservation Report Condition
left outer join
(
	select
	crx.ID as ObjectID
	,oc.OverallCondition
	,cr.DateCompleted as ConditionDate
	from ConservationReportXrefs as crx
	inner join ConservationReports as cr on crx.ConservationReportID = cr.ConservationReportID and crx.TableID = 108
	inner join OverallConditions as oc on cr.OverallConditionID = oc.OverallConditionID
	where cr.MasterReport = 1
	and cr.DisplayReport = 1
) as cnd on o.ObjectID = cnd.ObjectID

Cached Image
left outer join zDT_MediaMasterID_UNCWebappCachePNG as ci on mx.MediaMasterID = ci.mediamasterid and ci.sizeorder = @ImageSize
--left outer join vgsdvHTTPWebappCache as ci on mx.MediaMasterID = ci.mediamasterid and ci.sizeorder = @ImageSize


-- Package info
inner join	
(
	select
	 q.ReportGUID
	,q.ID
	,sq.PackageID
	,sq.[Name]
	,pl.OrderPos
	from
	(
		select ReportGUID, ID
		from ReportIDs as rid
		UNION
		select ReportGUID, ID
		from WebReportIDs as rid
	) as q

	inner join -- get list of packages for @PackageID
	(
		select ReportGUID, rht.HashTotal, pht.PackageID, pht.[Name]
		from
		(
			select ReportGUID, sum(cast(ID as BIGINT)) as HashTotal  
			from ReportIDs as rid
			GROUP BY ReportGUID
			UNION
			select ReportGUID, sum(cast(ID as BIGINT)) as HashTotal  
			from WebReportIDs as rid
			GROUP BY ReportGUID
		) as rht 
		inner join	-- Package Hash Totals
		(
			select
			p.PackageID,p.[Name],p.Itemcount,p.PackageType,sum(cast(pl.ID as BIGINT)) as HashTotal
			from Packages as p
			inner join PackageList as pl on p.PackageID = pl.PackageID
			where pl.TableID = 108	-- Objects
			AND p.PackageType = 1	-- "user-created packages"
			--	Package Type ID
			--	1 = "user-created packages"
			--	2 = *-MRU- packages
			--	13 = WEB-MEDIACART- packages
			GROUP BY
			p.PackageID,p.[Name],p.Itemcount,p.PackageType
		) as pht on rht.HashTotal = pht.HashTotal
		where ReportGUID = @TMSReportID
		UNION
		select
		@TMSReportID as ReportID
		,0
		,0
		,'No'
	) as sq on q.ReportGUID = sq.ReportGUID
	left outer join PackageList as pl on sq.PackageID =  pl.PackageID
	AND q.ID = pl.ID
) as rp on o.ObjectID = rp.ID

where rp.PackageID = @PackageID

order by 
case when rp.PackageID = 0 then o.SortNumber else
case when LEN(rp.OrderPOS) = 1 then (cast('0000' as nchar(4)) + cast(rp.OrderPOS as nchar(80))) else 
case when LEN(rp.OrderPOS) = 2 then (cast('000' as nchar(3)) + cast(rp.OrderPOS as nchar(80))) else 
case when LEN(rp.OrderPOS) = 3 then (cast('00' as nchar(2)) + cast(rp.OrderPOS as nchar(80))) else 
case when LEN(rp.OrderPOS) = 4 then (cast('0' as nchar(1)) + cast(rp.OrderPOS as nchar(80))) else 
'99999' end end end end end;

*/