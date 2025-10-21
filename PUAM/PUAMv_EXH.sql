USE [TMS]
GO

/****** Object:  View [dbo].[PUAMv_EXH]    Script Date: 10/8/2025 2:52:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--alter view [dbo].[PUAMv_EXH] as

/*

Created			10/8/2025	Dave Thompson
							
*/

select
 e.ExhibitionID											as ID
,e.ExhibitionID
,e.ExhType
,isnull(e.ExhTitle,'Title not entered.')				as ExhTitle
,isnull(e.SubTitle,'')									as SubTitle
,case when (SubTitle IS NULL OR SubTitle = '') then ExhTitle else SubTitle end as ExhTitleDisplay

,case when e.ExhTitle is not null then 
  case when e.SubTitle is not null then e.ExhTitle + ', ' + e.SubTitle
  else case when e.SubTitle is null then e.ExhTitle
 else isnull(e.ExhTitle,'') end end end as ExhFullTitleDisplay


,e.ExhMnemonic
,e.ExhDepartment
,d.Department
,e.ExhibitionStatusID
,es.ExhibitionStatus
,e.ExhTravelling
,case when e.ExhTravelling = 1 then 'Travelling'
	else 'Not Travelling' end							as ExhTravellingDisplay
,e.BeginYear
,e.EndYear
,isnull(e.DisplayDate,'Display date not entered')		as DisplayDate
,e.DisplayObjID
,isnull(e.BeginISODate,0) as BeginISODate
,dbo.PUAMfx_ISOtoDATE(e.BeginISODate)					as BeginDate
,isnull(e.endISODate,0) as EndISODate	
,dbo.PUAMfx_ISOtoDATE(e.endISODate)						as EndDate
,e.IsInHouse
,case when e.IsInHouse = 1 then 'In House' else '' end	as IsInHouseDisplay
,e.IsVirtual
,case when e.IsVirtual = 1 then 'Is Virtual' else '' end as IsVirtualDisplay
,e.NextDexID
,mr.ThumbBlob											as ExhImage
,e.EnteredDate

FROM			Exhibitions			as e
left outer join	Departments			as d	on	e.ExhDepartment = d.DepartmentID
left outer join MediaXrefs			as mx	on	e.ExhibitionID = mx.ID and mx.TableID = 47 and PrimaryDisplay = 1
left outer join MediaRenditions		as mr	on	mx.MediaMasterID = mr.MediaMasterID
left outer join ExhibitionStatuses	as es	on	e.ExhibitionStatusID = es.ExhibitionStatusID

--order by e.ExhibitionID

--WHERE e.ExhibitionID = 836





GO


