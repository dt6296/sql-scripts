SELECT

--Package Info
rp.ID
,rp.ReportGUID
,rp.PackageID 
,rp.OrderPOS
,CAST(o.ObjectID AS NCHAR(10)) AS ObjectID
,'a' AS GroupByNone

--Tombstone Data
,o.ObjectNumber
,CASE WHEN ocfd.DisplayName LIKE '%Unknown%' OR ocfd.DisplayName IS NULL THEN ocx.Culture ELSE ocfd.DisplayName END AS ArtistMaker
,CASE WHEN ocfd.DisplayName LIKE '%Unknown%' OR ocfd.DisplayName IS NULL THEN ocx.Culture ELSE ocfd.DisplayName END +
 CASE WHEN ocfd.DisplayBio IS NULL THEN '' ELSE ', ' + ocfd.DisplayBio END AS ArtistMakerDisplayBio
,ISNULL(ISNULL(otf.Title,o.ObjectName),'') AS Title
,o.Dated
,o.DateBegin
,o.DateEnd
,CAST(o.Medium AS NVARCHAR(4000))		AS [Medium]
,CAST(o.Dimensions AS NVARCHAR(4000))	AS Dimensions
,CAST(o.CreditLine AS NVARCHAR(4000))	AS CreditLine

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
,CAST(o.Portfolio AS NVARCHAR(4000))			AS Portfolio
,CAST(o.[State] AS NVARCHAR(4000))				AS [State]
,CAST(o.Edition AS NVARCHAR(4000))				AS Edition
,CAST(o.Signed AS NVARCHAR(4000))				AS Signed
,CAST(o.Markings AS NVARCHAR(4000))				AS Markings
,CAST(o.Inscribed AS NVARCHAR(4000))			AS Inscribed
,CAST(o.Inscribed AS NVARCHAR(4000))			AS Inscriptions
,o.PaperSupport
,o.Provenance
,CAST(o.CatRais AS NVARCHAR(4000))				AS CatRais
,CAST(o.PubReferences AS NVARCHAR(4000))		AS PublishedReferences
,CAST(o.Bibliography AS NVARCHAR(4000))			AS Bibliography
,CAST(o.RelatedWorks AS NVARCHAR(4000))			AS RelatedWorks
,CAST(o.Exhibitions AS NVARCHAR(4000))			AS Exhibitions
,o.PaperFileRef									AS DescriptiveKeyword
,CAST(o.Notes AS NVARCHAR(4000))				AS Notes
,CAST(o.CuratorialRemarks AS NVARCHAR(4000))	AS CuratorialRemarks
,CAST(o.[Description] AS NVARCHAR(4000))		AS [Description]
,cnd.OverallCondition							AS OverallCondition
,cnd.ConditionDate								AS ConditionDate

--Administrative
,ot.ObjectType
,ol.ObjectLevel
,CAST(o.ObjectCount AS NCHAR(5))				AS ObjectCount
,CAST(occ.ComponentCount AS NCHAR(5))			AS ComponentCount
,CASE WHEN o.IsVirtual = 1 THEN 'Virtual Object' ELSE 'Physical Object' END AS IsVirtualDisplay
,CASE WHEN o.CuratorApproved = 1 THEN 'Curator Approved' ELSE 'NOT Curator Approved' END AS IsCuratorApprovedDisplay
,CASE WHEN o.PublicAccess = 1 THEN 'Public Access Approved' ELSE 'NOT Public Access Approved' END AS IsPublicAccessApprovedDisplay
,d.Department
,c.[Classification]
,CASE WHEN o.OnView = 1 THEN 'on view' ELSE 'not on view' END AS IsOnviewDisplay
,o.SortNumber

--Registration
,os.ObjectStatus
,am.AccessionMethod

--Object Rights
,rt.ObjRightsType
,CAST(ocr.Copyright AS NVARCHAR(4000))			AS Copyright
,CAST(ocr.Restrictions AS NVARCHAR(4000)) 		AS Restrictions
,CAST(ocr.CreditLineRepro AS NVARCHAR(4000))	AS CreditLineRepro

--Thumbnail
,mr.ThumbBlob

--Cached Image
,ci.MediaCachePathFileHTTP

FROM [Objects]								AS o
LEFT OUTER JOIN ObjectLevels				AS ol	ON	o.ObjectLevelID = ol.ObjectLevelID
LEFT OUTER JOIN ObjectTypes					AS ot	ON	o.ObjectTypeID = ot.ObjectTypeID
LEFT OUTER JOIN Departments					AS d	ON	o.DepartmentID = d.DepartmentID
LEFT OUTER JOIN Classifications				AS c	ON	o.ClassificationID = c.ClassificationID
LEFT OUTER JOIN ObjContext					AS ocx	ON	o.ObjectID = ocx.ObjectID
LEFT OUTER JOIN ObjectStatuses				AS os	ON	o.ObjectStatusID = os.ObjectStatusID
LEFT OUTER JOIN MediaXrefs					AS mx	ON	o.ObjectID = mx.ID 
													AND mx.TableID = 108 
													AND mx.PrimaryDisplay = 1
LEFT OUTER JOIN MediaMaster					AS mm	ON	mx.MediaMasterID = mm.MediaMasterID
LEFT OUTER JOIN MediaRenditions				AS mr	ON	mm.DisplayRendID = mr.RenditionID
LEFT OUTER JOIN ObjRights					AS ocr	ON	o.ObjectID = ocr.ObjectID
LEFT OUTER JOIN ObjRightsTypes				AS rt	ON	ocr.ObjRightsTypeID = rt.ObjRightsTypeID
LEFT OUTER JOIN ObjAccession				AS oa	ON	o.ObjectID = oa.ObjectID
LEFT OUTER JOIN AccessionMethods			AS am	ON	oa.AccessionMethodID = am.AccessionMethodID

-- Component Count
LEFT OUTER JOIN		
(
	SELECT
	ocmp.ObjectID, COUNT(ocmp.ComponentID) AS ComponentCount, SUM(ocmp.CompCount) AS SumCompCount
	FROM ObjComponents ocmp
	GROUP BY ocmp.ObjectID
) AS occ	ON occ.ObjectID = o.ObjectID

-- First Displayed Title
LEFT OUTER JOIN		
(
	SELECT
	ot.ObjectID,
	ot.TitleID,
	ot.Title,
	RANK() OVER(PARTITION BY ot.ObjectID ORDER BY ot.DisplayOrder) AS RankByDisplayOrder
	FROM ObjTitles AS ot
	WHERE ot.Displayed = 1
) AS otf	ON o.ObjectID = otf.ObjectID AND otf.RankByDisplayOrder = 1

-- First Active Displayed Object-related ConXref
LEFT OUTER JOIN		
(
	SELECT
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
	FROM
	(
		SELECT ID, ConXrefID, RoleID,
		RANK() OVER(PARTITION BY ID ORDER BY DisplayOrder) AS RankByDisplayOrder
		FROM ConXrefs
		WHERE Active = 1		-- Active ConXref
		AND Displayed = 1		-- Displayed ConXref
		AND TableID = 108	
		AND RoleTypeID = 1		-- Object Related ConXref
	) AS crank
	LEFT OUTER JOIN ConXrefDetails	AS cxd	ON	crank.ConXrefID = cxd.ConXrefID AND cxd.UnMasked = 1
	LEFT OUTER JOIN ConAltNames		AS can	ON	cxd.NameID = can.AltNameId
	LEFT OUTER JOIN ConDisplayBios	AS cdb	ON	cxd.DisplayBioID = cdb.ConDisplayBioID
	LEFT OUTER JOIN ConXrefs		AS cx	ON	cxd.ConXrefID = cx.ConXrefID
	LEFT OUTER JOIN Roles			AS r	ON	cx.RoleID = r.RoleID
	WHERE crank.RankByDisplayOrder = 1
) AS ocfd	ON o.ObjectID = ocfd.ID 	

-- Master Display Conservation Report Condition
LEFT OUTER JOIN
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

-- Cached Image
LEFT OUTER JOIN zDT_MediaMasterID_UNCWebappCachePNG AS ci ON mx.MediaMasterID = ci.mediamasterid AND ci.sizeorder = @ImageSize
--LEFT OUTER JOIN vgsdvHTTPWebappCache as ci on mx.MediaMasterID = ci.mediamasterid AND ci.sizeorder = @ImageSize

-- Package info
INNER JOIN	
(
	SELECT
	 q.ReportGUID
	,q.ID
	,sq.PackageID
	,sq.[Name]
	,pl.OrderPos
	FROM
	(
		SELECT ReportGUID, ID
		FROM ReportIDs AS rid
		UNION
		SELECT ReportGUID, ID
		FROM WebReportIDs AS rid
	) AS q

	INNER JOIN -- get list of packages for @PackageID
	(
		SELECT ReportGUID, rht.HashTotal, pht.PackageID, pht.[Name]
		FROM
		(
			SELECT ReportGUID, SUM(CAST(ID AS BIGINT)) AS HashTotal  
			FROM ReportIDs AS rid
			GROUP BY ReportGUID
			UNION
			SELECT ReportGUID, SUM(CAST(ID AS BIGINT)) AS HashTotal  
			FROM WebReportIDs AS rid
			GROUP BY ReportGUID
		) AS rht 
		INNER JOIN	-- Package Hash Totals
		(
			SELECT
			p.PackageID,p.[Name],p.ItemCount,p.PackageType,SUM(CAST(pl.ID AS BIGINT)) AS HashTotal
			FROM Packages AS p
			INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
			WHERE pl.TableID = 108	-- Objects
			AND p.PackageType = 1		-- "user-created packages"
			--	Package Type ID
			--	1 = "user-created packages"
			--	2 = *-MRU- packages
			--	13 = WEB-MEDIACART- packages
			GROUP BY
			p.PackageID,p.[Name],p.ItemCount,p.PackageType
		) AS pht ON rht.HashTotal = pht.HashTotal
		WHERE ReportGUID = @TMSReportID
		UNION 
		SELECT
		@TMSReportID AS ReportID
		,0
		,0
		,'No'
	) AS sq ON q.ReportGUID = sq.ReportGUID
	LEFT OUTER JOIN PackageList AS pl ON sq.PackageID =  pl.PackageID
	AND q.ID = pl.ID
) AS rp ON o.ObjectID = rp.ID

WHERE rp.PackageID = @PackageID

ORDER BY 
CASE WHEN rp.PackageID = 0 THEN o.SortNumber ELSE
CASE WHEN LEN(rp.OrderPOS) = 1 THEN (CAST('0000' AS NCHAR(4)) + CAST(rp.OrderPOS AS NCHAR(80))) ELSE 
CASE WHEN LEN(rp.OrderPOS) = 2 THEN (CAST('000' AS NCHAR(3)) + CAST(rp.OrderPOS AS NCHAR(80))) ELSE 
CASE WHEN LEN(rp.OrderPOS) = 3 THEN (CAST('00' AS NCHAR(2)) + CAST(rp.OrderPOS AS NCHAR(80))) ELSE 
CASE WHEN LEN(rp.OrderPOS) = 4 THEN (CAST('0' AS NCHAR(1)) + CAST(rp.OrderPOS AS NCHAR(80))) ELSE 
'99999' END END END END END;