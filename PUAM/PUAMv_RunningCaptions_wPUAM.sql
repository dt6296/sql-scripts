USE [TMS]
GO

/****** Object:  View [dbo].[PUAMv_RunningCaptions_wPUAM]    Script Date: 9/23/2025 4:39:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create view [dbo].[PUAMv_RunningCaptions_wPUAM] as

select
 o.ObjectID
,o.ObjectNumber
,o.SortNumber
,concat(c.[Classification]
,'-' + c.SubClassification) as [Classification]
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
,dbo.puamFormatObjNumCaption(o.ObjectID) as ObjNum
,dbo.puamCreate1AttribCaption(o.ObjectID) as AttributionCaption
,dbo.puamCreate1AttribCaptionItalicHTML(o.ObjectID) as AttributionCaptionItalicHTML
,dbo.puamCreate1AttribCaptionBoldHTML(o.ObjectID) as AttributionCaptionBoldHTML
,dbo.puamCreate2PhysicalCaption(o.ObjectID) as PhysicalCaption
,dbo.puamCreate3AccessionCaption(o.ObjectID) as AccessionCaption
,dbo.puamCreateRunCaption(o.ObjectID) as RunningCaption
,dbo.puamCreateRunCaptionItalicHTML(o.ObjectID) as RunningCaptionItalicHTML
,dbo.puamCreateRunCaptionBoldHTML(o.ObjectID) as RunningCaptionBoldHTML
,dbo.puamCreateRunCaptionDigital(o.ObjectID) as RunningCaptionDigital
,checksum(dbo.puamCreateRunCaptionItalicHTML(o.ObjectID)) as RunningCaptionChecksum

from dbo.[Objects] as o 
left outer join dbo.ObjTitles       as ot   on o.ObjectID = ot.ObjectID
                                            and ot.DisplayOrder = 1 
left outer join dbo.Departments     as d    on d.DepartmentID = o.DepartmentID 
left outer join dbo.Classifications as c    on c.ClassificationID = o.ClassificationID

GO





