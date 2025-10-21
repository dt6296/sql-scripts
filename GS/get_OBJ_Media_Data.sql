select
 o.ObjectID

,o.ObjectNumber
,o.SortNumber as OBJ_SortNumber
,mx.MediaXrefID
,mx.PrimaryDisplay
,case when mx.PrimaryDisplay = 1 then 'Yes' else 'No' end as IsPrimary_Display
,mx.[Rank]
,mx.Remarks	as mx_Remarks
,mx.DisplayOrder

,mm.MediaMasterID
,mm.ApprovedForWeb
,case when mm.ApprovedForWeb = 1 then 'Yes' else 'No' end as ApprovedForWeb_Display
,mm.DisplayRendID
,mm.PrimaryRendID
,mm.PublicCaption
,mm.Copyright
,mm.Restrictions
,mf.IsConfidential
,case when mf.IsConfidential = 1 then 'Yes' else 'No' end as IsConfidential_Display
,mm.[Description]
,mm.Remarks as mm_Remarks
,mm.LoginID as mm_LoginID
,mm.DepartmentID
,d.Department
,mm.MediaView as Media_View
,mvt.MediaViewType

,mr.RenditionID
,mr.RenditionNumber
,mr.SortNumber
,mr.ParentRendID
,mt.IsDigital
,case when mt.IsDigital = 1 then 'Digital Media' else 'Physical Media' end as MediaGroup
,mt.MediaType
,ms.MediaStatus as Media_Status
,mr.MediaStatusDate
,mp.[Path]
,mr.ThumbFileName
,me.Extension as ThumbExtension
,mr.Remarks as mr_Remarks
,mr.QualityConID
,cq.DisplayName as QualityConstituent
,mr.PhotographerConxrefID
,p.Photographer
,mr.Technique

,mf.FileID
,mf.[FileName]
,mf.PathID
,mp.PhysicalPath
,mf.FileSize as FileSize_B
,case when mf.FileSize > 1000000000 then convert(nvarchar(25),convert(decimal(10,1),mf.FileSize/1024/1000/1000,1)) + ' GB' else
 case when mf.FileSize > 1000000 then convert(nvarchar(25),convert(decimal(10,1),mf.FileSize/1024/1000,1)) + ' MB' else
 case when mf.FileSize > 1000 then convert(nvarchar(25),convert(decimal(10,1),mf.FileSize/1024,1)) + ' KB' else '' end end end as FileSize
,mf.FormatID
,mft.[Format]
,mf.PixelH
,mf.PixelW
,convert(nvarchar(10),mf.PixelW) + ' x ' + convert(nvarchar(10),mf.PixelH) as PixelDimensions
,mf.Duration
,mf.FileDate
,mf.ArchVolName
,mf.RequireTiling
,(mp.PhysicalPath + '\' + mf.FileName) as FilePathName

,mfm.Make as CameraMake
,mfm.Model as CameraModel
,mfm.XResolution	--	cast(mfm.XResolution as int) as XResolution,
,mfm.YResolution	--	cast(mfm.YResolution as int) as YResolution,
,mfm.ResolutionUnit

from			[Objects]					as o
left outer join MediaXrefs					as mx	on	o.ObjectID = mx.ID
													and	mx.TableID = 108
left outer join	MediaMaster					as mm	on	mx.MediaMasterID = mm.MediaMasterID
left outer join	MediaRenditions				as mr	on	mm.MediaMasterID = mr.MediaMasterID
left outer join	MediaTypes					as mt	on	mr.MediaTypeID = mt.MediaTypeID
left outer join MediaViewTypes				as mvt	on	mm.MediaViewTypeID = mvt.MediaViewTypeID
left outer join	MediaStatuses				as ms	on	mr.MediaStatusID = ms.MediaStatusID
left outer join MediaFiles					as mf	on	mr.RenditionID = mf.RenditionID
left outer join MediaPaths					as mp	on	mf.PathID = mp.PathID
left outer join Departments					as d	on	mm.DepartmentID = d.DepartmentID
left outer join MediaFormats				as mft	on	mf.FormatID = mft.FormatID
left outer join MediaExtensions				as me	on	mr.ThumbExtensionID = me.ExtensionID
left outer join Constituents				as cq	on	mr.QualityConID = cq.ConstituentID


left outer join  -- Media File Metadata
(select * from 
	(
		select distinct
		mm.MediaMasterID,
		mr.RenditionID,
		mr.RenditionNumber,
		fp.FileID,
		fp.PropertyName, --fp.PropertyType,
		fp.PropertyValue

		from		MediaMaster		as mm
		inner join	MediaRenditions as mr	ON mm.PrimaryRendID = mr.RenditionID
		inner join	FileProperties	as fp	ON mr.PrimaryFileID = fp.FileID

		WHERE	((PropertyType in ('IFD0','ExifIFD','Photoshop') and PropertyName IN ('Model','Make'))
		OR		(PropertyType in ('ExifIFD','Photoshop','JFIF') and PropertyName IN ('XResolution','YResolution','ResolutionUnit'))
		OR		(PropertyType in ('ICC_Profile') and PropertyName in ('ProfileDescription')))
	)	as SourceTable
	pivot
	(
		max(PropertyValue) for PropertyName in (Make, Model, XResolution, YResolution, ResolutionUnit, ProfileDescription)
	) as PivotTable
) as mfm on mm.MediaMasterID = mfm.MediaMasterID

left outer join	-- Photographer(s)
(
	select
	 mm.MediaMasterID
	,mr.RenditionID
	,string_agg(cp.DisplayName,'; ') as Photographer

	from			MediaMaster					as mm	
	left outer join	MediaRenditions				as mr	on	mm.MediaMasterID = mr.MediaMasterID
	left outer join ConXrefs					as cx	on	mr.RenditionID = cx.ID 
														and cx.TableID = 322 -- Media Renditions
														--and cx.RoleID = 373  -- Photographer		-- This is hardcoded, see below.
	left outer join Roles						as r	on cx.RoleID = r.RoleID and r.[Role] = 'Photographer'
	left outer join ConXrefDetails				as cxd	on	cx.ConXrefID = cxd.ConXrefID 
														and cxd.Unmasked = 1
	left outer join Constituents				as cp	on	cxd.ConstituentID = cp.ConstituentID

	group by
	 mm.MediaMasterID
	,mr.RenditionID
) as p on mm.MediaMasterID = p.MediaMasterID


/*
WHERE mm.MediaMasterID = @MediaMasterID
AND o.ObjectID = @ObjectID
AND case when mt.IsDigital = 1 then 'Digital Media' else 'Physical Media' end IN (@MediaGroup)
*/
