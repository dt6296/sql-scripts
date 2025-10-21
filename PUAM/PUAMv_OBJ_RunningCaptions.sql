USE [TMS]
GO

/****** Object:  View [dbo].[puamRunningCaptions]    Script Date: 8/28/2025 1:59:28 PM ******/
SET ANSI_NULLS on
GO

SET QUOTED_IDENTIFIER on
GO


--create view [dbo].[PUAMv_OBJ_RunningCaptions] as

--	formerly								dbo.puamRunningCaptions
--	updated		8/28/2025	Dave Thompson	reformatted, renamed

SELECT        
 o.ObjectID
,o.ObjectNumber
,o.SortNumber
,concat(c.[Classification], '-' + c.SubClassification) as [Classification]
,d.Department
,dbo.puamConcatCons(o.ObjectID, N', ') as Makers
,ot.Title
,dbo.puamFormatTitleCaptionItalicHTML(o.ObjectID) as TitleItalicHTML
,dbo.puamFormatTitleCaptionBoldHTML(o.ObjectID) as TitleBoldHTML
,dbo.puamFormatGeoCaption(o.ObjectID) as [Geography]
,o.Dated
,o.BeginISODate
,o.[Medium]
,dbo.puamConcatDims(o.ObjectID, N', ') as Dimensions
,o.CreditLine
,dbo.puamFormatObjNumCaption(o.ObjectID)			as ObjNum
,dbo.puamCreate1AttribCaption(o.ObjectID)			as AttributionCaption
,dbo.puamCreate1AttribCaptionItalicHTML(o.ObjectID)	as AttributionCaptionItalicHTML
,dbo.puamCreate1AttribCaptionBoldHTML(o.ObjectID)	as AttributionCaptionBoldHTML
,dbo.puamCreate2PhysicalCaption(o.ObjectID)			as PhysicalCaption
,dbo.puamCreate3AccessionCaption(o.ObjectID)		as AccessionCaption
,dbo.puamCreateRunCaption(o.ObjectID)				as RunningCaption
,dbo.puamCreateRunCaptionItalicHTML(o.ObjectID)		as RunningCaptionItalicHTML
,dbo.puamCreateRunCaptionBoldHTML(o.ObjectID)		as RunningCaptionBoldHTML
,dbo.puamCreateRunCaptionDigital(o.ObjectID)		as RunningCaptionDigital
,checksum(dbo.puamCreateRunCaptionItalicHTML(o.ObjectID)) as RunningCaptionChecksum

from [Objects] as o 
left outer join ObjTitles		as ot	on	o.ObjectID = ot.ObjectID 
											and ot.DisplayOrder = 1 
left outer join Departments		as d	on	d.DepartmentID = o.DepartmentID
left outer join Classifications as c	on	c.ClassificationID = o.ClassificationID


GO