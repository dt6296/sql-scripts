USE [TMS]
GO

/****** Object:  View [dbo].[MFAHv_OBJ]    Script Date: 3/22/2016 12:14:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
GO








--ALTER VIEW [dbo].[MFAHv_OBJ] AS

/*

MFAHv_OBJ
Custom MFAH View

Author:					Dave Thompson
Originally Created:		1/22/2014
Renamed:				5/10/2014

Description:	
--This query provides "basic" Object data for reports and the new website.
--Location is still an issue, needs to account for objects not on view, but available in Print Study Room.
--Most statements commented-out are for populating an Objects table for the website.
--This view was used to supply the web developer (Michael Villegas) with Object data and a table structre.

Updated:	4/10/2014

Updated:	4/22/2014
Added AltNums table and "Display Accession Number" if it exists so that I can display the properly formatted
object number for those with components (.A, .B, etc.)
Added Component Count as nested subquery, will write a separate view for component detail to pull into object data reports.

Updated:	4/30/2014		***** Object Location *****
Added l.LocationString.
Subsequently replaced ObjCurLocView (modified Gallery Systems view) with MFAHv_ObjectLocation (my version of ObjCurLocView).
I wanted to see the current location for all objects, thinking I could just add l.LocationString.
However, since I linked Objects to ObjComponents via ObjectID AND ObjectNumber, a null value was returned
for components that didn't have the same ObjectNumber as the Object.ObjectNumber.  This became more apparent with
single items with separable components I updated to have separate component records.  (ex. B.2013.18.A,.B)

I think this reveals a fundamental problem with the way single items with separable components are catalogued and the way
object locations are pulled.  Instead of reporting the object location at the object level, it really needs to be
reported at the object-component level.  This would mean that I have to remove object location information from this view,
and report on it through a separate view, MFAHv_ObjectLocation_Current, using subreports.

I think this will have implications for Dimension recording and reporting, too.

I need to discuss with Julie and Kim before proceeding.

Updated:	5/2/2014	Added o.Description

Updated:	5/10/2014	Copied from, and to replace MFAHv_OCM_Object in order to not be limited 
						to just the Online Collections Module, and to conform with more standard
						naming conventions.

Updated:	5/14/2014	Updated IsVirtualDisplay 
						from	CASE WHEN o.IsVirtual = 1 THEN 'Virtual Object'
						ELSE '' END AS IsVirtualDisplay
						to		CASE WHEN o.IsVirtual = 1 THEN 'Virtual Object'
						ELSE 'Physical Object' END AS IsVirtualDisplay

Updated:	5/30/2014	Updated references to views
						MFAHv_OBJ_Title_FirstDisplayed
						MFAHv_OBJ_Maker_FirstDisplayed

Updated		6/3/2014	Added ObjRightsTypes table and rt.ObjRightsType field
						Added CreditLineDisplay

Updated		6/10/2014	Renamed from MFAHv_Object
						Reorganized and removed old comments
						Added information from ObjAccession with date functions

Updated		6/21/2014	Added TitleDateDisplay

Updated		7/11/2014	Added CM_Name to be able to parameterize accession month.

Updated		7/13/2014	Edited CreditLineDisplay formula

Updated		7/15/2014	Added o.Exhibitions

Updated		7/16/2014	Added o.Chat (Label Text) for OCM Presentation, object 74.139

Updated		7/29/2014	Duplicated CreditLineDisplay to CopyrightStatement
						I'll need to update other views and reports, so I duplicated the
						field instead of renaming it.
						Aliased o.Chat AS LabelText

Updated		7/30/2014	Added oa.ApprovalISODate1 (Subcommittee Approval Date)

Updated		8/16/2014	Added fields
						dbo.MFAHfx_FiscalYear(oa.AccessionISODate)		AS Accessioned_FY,
						dbo.MFAHfx_FiscalQuarter(oa.AccessionISODate)	AS Accessioned_FQ,
						dbo.MFAHfx_FiscalMonth(oa.AccessionISODate)		AS Accessioned_FM
						because the aliases FY, FQ, FM are confusing in 
						accession and valuation queries and I need to make them clearer.
						But I don't want to break existing reports, so I left the
						original fields so that I can update them more easily in the
						reports.
						
Updated		8/19/2014	Added AccessionMethodDisplay, ObjectStatusDisplay

Updated		8/24/2014	Added SumCompCount

Updated		10/20/2014	Added 	oa.ApprovalISODate2,	--Collections Committee Approval

Updated		12/02/2014	Edited Provenance to (per 11/19 website meeting):
						CASE WHEN o.Provenance IS NULL THEN 'Research ongoing' ELSE
						CASE WHEN o.Provenance LIKE '' THEN 'Research ongoing' ELSE
						CASE WHEN o.Provenance LIKE ' ' THEN 'Research ongoing' ELSE
						o.Provenance END END END AS Provenance
						
Updated		1/12/2015	Added fields PaperSupport and Inscribed.

Updated		2/10/2015	Added to WHERE clause:
						AND mm.MediaMasterID IS NOT NULL
						due to orphaned MediaXref records causing multiple Object records.
						
Updated		2/13/2015	Added OCMCopyrightStatement for use on the OCM specifically.

Updated		2/17/2015	Replaced hard-coded DisplayAccessionNumber with MFAHfx_AccessionNumber

Updated		3/2/2015	Replaced expressions to create copyright statements with functions.

Updated		3/13/2015	Added to WHERE clause:
						AND mr.RenditionID IS NOT NULL
						due to orphaned MediaXref records causing multiple Object records.

Updated		3/23/2015	Changed CuratorApproved fields to  WebsiteApproved

Updated		3/24/2015	Changed otd to otfd, was using displayed titles, not first displayed titles,
						removed ot (ObjTitles) from FROM clause.
						
						
Updated		3/31/2015	Undid 3/23/15 change to CuratorApprove fields
						Made PublicAccess field the WebsiteApproved field.		
						
Updated		6/10/2015	Undid 3/2/15 changes that replaced copyright statements with functions
						because using the functions caused the OBJ_Data report not to run in TMS.										

Updated		7/15/2015	Added fields o.Notes, o.CuratorialRemarks

Updated		8/19/2015	Changed refernce to table Departments to MFAHv_Department and
						added d.Department_Public to SELECT list.

Updated		8/24/2015	Changed refrence to view MFAHv_Department to table MFAHt_DepartmentPublic
						and added d.DepartmentPublicID and d.DepartmentPublic

Updated		9/18/2015	Added fields
						oa.DeedOfGiftSendISO,
						oa.DeedOfGiftReceivedISO	
						ApprovalDate1,
						ApprovalDate2,
						AccessionDate,
						DeedOfGiftSent,
						DeedOfGiftReceived,		
						
Updated		11/2/2015	Added fields:
						o.Portfolio,
						o.State,
						o.Edition,
						o.CatRais

Updated		11/25/2015	CAST all NVARCHAR(MAX) fields to NVARCHAR(4000) because NVARCHR(MAX)
						fields appear in Crystal Reports XI as STRING(255) fields and either 
						truncate or don't display  at all.

Updated		12/08/2015	Added RelatedWorks

Updated		3/22/2016	Added Object Maker info (first displayed object maker) -- THEN REVERSED

*/


SELECT

--Administrative Data

	o.ObjectID,
	o.ObjectNumber,

	CASE WHEN an.AltNum IS NULL THEN o.ObjectNumber ELSE an.AltNum END AS DisplayAccessionNumber,	-- uncommented 3/22/2016
	--dbo.MFAHfx_AccessionNumber(o.ObjectID) AS DisplayAccessionNumber,								-- commented out 3/22/2016
		
	o.SortNumber,
	o.ObjectCount,
	occ.ComponentCount,
	occ.SumCompCount,
	o.DepartmentID,
	d.Department,
	d.DepartmentPublicID,
	d.DepartmentPublic,
	o.ObjectStatusID,
	os.ObjectStatus,
	
	CASE	WHEN o.ObjectStatusID = 2 THEN 'Accessioned'
	ELSE os.ObjectStatus 
	END AS ObjectStatusDisplay,
	
	o.ClassificationID,
	c.Classification,
	o.ObjectLevelID,
	ol.ObjectLevel,
	o.ObjectTypeID,
	ot.ObjectType,
	o.IsVirtual,
	CASE WHEN o.IsVirtual = 1 THEN 'Virtual Object' ELSE 'Physical Object' END AS IsVirtualDisplay,
	
	
	o.CuratorApproved,
	CASE WHEN o.CuratorApproved = 1 THEN 'Curator Approved' ELSE 'NOT Curator Approved' END AS IsCuratorApprovedDisplay,
	
	o.PublicAccess	AS WebsiteApproved,
	CASE WHEN o.PublicAccess = 1 THEN 'Website Approved' ELSE 'NOT Website Approved' END AS IsWebsiteApprovedDisplay,
	
	o.Accountability AS DataStandardsApproved,
	CASE WHEN o.Accountability = 1 THEN 'Data Standards Approved' ELSE 'NOT Data Standards Approved' END AS IsDataStdsApprovedDisplay,	-- Added 3/23/14

	o.Cataloguer,
	o.Curator,
	o.CatalogueISODAte,
	o.CuratorRevISODate,
	o.DateEffectiveISODate,

--Object Data

	o.ObjectName,
	o.Dated,
	o.DateBegin,
	o.DateEnd,
	CAST(o.Medium AS NVARCHAR(4000))		AS Medium,
	CAST(o.Dimensions AS NVARCHAR(4000))	AS Dimensions,
	CAST(o.Bibliography AS NVARCHAR(4000))	AS Bibliography,
	CAST(CASE WHEN o.Provenance IS NULL THEN 'Research ongoing' ELSE
	CASE WHEN o.Provenance LIKE '' THEN 'Research ongoing' ELSE
	CASE WHEN o.Provenance LIKE ' ' THEN 'Research ongoing' ELSE
	o.Provenance END END END AS NVARCHAR(4000)) AS Provenance,
	CAST(o.Exhibitions AS NVARCHAR(4000))		AS Exhibitions,
	CAST(o.Description AS NVARCHAR(4000))		AS Description,
	CAST(o.Chat AS NVARCHAR(4000))				AS LabelText,
	CAST(o.RelatedWorks AS NVARCHAR(4000))		AS RelatedWorks,
	CAST(o.Signed AS NVARCHAR(4000))			AS Signed,
	CAST(o.Markings AS NVARCHAR(4000))			AS Markings,
	o.PaperSupport,
	CAST(o.Inscribed AS NVARCHAR(4000))			AS Inscribed,
	otfd.Title,	--Replaced o.Title because not all object records have Title field populated.  
				--This pulls the first DISPLAYED title in ObjTitles for each Object.
	CASE WHEN otfd.Title IS NULL THEN '' ELSE otfd.Title
	+
	CASE WHEN o.Dated IS NULL THEN '' ELSE ', ' + o.Dated
	END END AS TitleDateDisplay,
	'The Museum of Fine Arts, Houston. '		 AS MFAHCredit,
	CAST(o.CreditLine AS NVARCHAR(4000))		AS CreditLine,
	CAST(o.Notes AS NVARCHAR(4000))				AS Notes,
	CAST(o.CuratorialRemarks AS NVARCHAR(4000))	AS CuratorialRemarks,

	CAST(o.Portfolio AS NVARCHAR(4000))			AS Portfolio,	--	Added 11/2/2015
	CAST(o.State AS NVARCHAR(4000))				AS State,		--	Added 11/2/2015
	CAST(o.Edition AS NVARCHAR(4000))			AS Edition,		--	Added 11/2/2015
	o.CatRais,		--	Added 11/2/2015

--Object Maker													--	Added 3/22/2016
	ocn.c_DisplayName,
	ocn.c_DisplayDate,
	ocn.Prefix_CultureSchoolName_Date_Suffix,
	ocn.can_AlphaSort,

--Object Context

	oc.Culture,
	oc.Style,
	oc.Movement,
	oc.Nationality,
	oc.Period,
	oc.School,
	oc.Reign,
	oc.Dynasty,

--Object Rights

	rt.ObjRightsType,
	CAST(ocr.Copyright AS NVARCHAR(4000))	AS Copyright,
	CAST(ocr.Restrictions AS NVARCHAR(4000)) AS Restrictions,
	CAST(ocr.CreditLineRepro AS NVARCHAR(4000)) AS CreditLineRepro,
	
--Replaced with f(x) 3/2/2015, removed f(x) 6/10/2015 because OBJ_Data report would not run in TMS.
	CAST(CASE WHEN ocr.ObjRightsTypeID = 2 THEN rt.ObjRightsType	ELSE
	CASE WHEN ocr.ObjRightsTypeID IN (0,3,4,5) THEN 'Copyright NOT CLEARED for website publication.'	ELSE
	ISNULL(ocr.CreditLineRepro,'Need copyright statement.')	END END AS NVARCHAR(4000))	AS CopyrightStatement,
--dbo.MFAHfx_OBJ_CopyrightStmt(o.ObjectID) AS CopyrightStatement,	

--Replaced with f(x) 3/2/2015, removed f(x) 6/10/2015 because OBJ_Data report would not run in TMS.
	CAST(CASE WHEN ocr.ObjRightsTypeID IN (0,1) THEN ISNULL(ocr.CreditLineRepro,'')	ELSE 
	CASE WHEN ocr.ObjRightsTypeID = 2 THEN rt.ObjRightsType ELSE '' END END AS NVARCHAR(4000)) AS OCMCopyrightStatement,
--dbo.MFAHfx_OBJ_CopyrightStmt_OCM(o.ObjectID) AS OCMCopyrightStatement,

--Object Thumbnail

	mx.MediaMasterID,
	mx.MediaXrefID,
	mx.PrimaryDisplay,
	mr.RenditionID,
	mr.ThumbBLOB,


--Object Acquisition

	oa.AccessionMethodID,
	oa.AccessionMethod,
	oa.AccessionMethodDisplay,

	oa.ApprovalISODate1,		--Subcommittee Approval Date
	oa.ApprovalISODate2,		--Collections Committee Approval	
	oa.AccessionISODate,
	oa.DeedOfGiftSentISO,
	oa.DeedOfGiftReceivedISO,

	oa.ApprovalDate1,
	oa.ApprovalDate2,
	oa.AccessionDate,
	oa.DeedOfGiftSent,
	oa.DeedOfGiftReceived,

	oa.CY,
	oa.CQ,
	oa.CM,
	oa.CM_Name,

	oa.FY,
	oa.FQ,
	oa.FM


/*

	CASE	WHEN oa.AccessionMethodID = 1 THEN 'Purchases'
	WHEN oa.AccessionMethodID = 2 THEN 'Gifts'
	ELSE am.AccessionMethod 
	END AS AccessionMethodDisplay,

	ISNULL(dbo.MFAHfx_ISOtoDATETIME(oa.ApprovalISODate1),'1900-01-01 00:00.000')		AS ApprovalDate1,
	ISNULL(dbo.MFAHfx_ISOtoDATETIME(oa.ApprovalISODate2),'1900-01-01 00:00.000')		AS ApprovalDate2,
	ISNULL(dbo.MFAHfx_ISOtoDATETIME(oa.AccessionISODate),'1900-01-01 00:00.000')		AS AccessionDate,
	ISNULL(dbo.MFAHfx_ISOtoDATETIME(oa.DeedOfGiftSentISO),'1900-01-01 00:00.000')		AS DeedOfGiftSent,
	ISNULL(dbo.MFAHfx_ISOtoDATETIME(oa.DeedOfGiftReceivedISO),'1900-01-01 00:00.000')	AS DeedOfGiftReceived,

	--Calendar Dates
	dbo.MFAHfx_CalendarYear(oa.AccessionISODate)		AS CY,
	dbo.MFAHfx_CalendarQuarter(oa.AccessionISODate)		AS CQ,
	dbo.MFAHfx_CalendarMonth(oa.AccessionISODate)		AS CM,
	dbo.MFAHfx_CalendarMonthName(oa.AccessionISODate)	AS CM_Name,

	--Fiscal Dates
	dbo.MFAHfx_FiscalYear(oa.AccessionISODate)			AS FY,
	dbo.MFAHfx_FiscalQuarter(oa.AccessionISODate)		AS FQ,
	dbo.MFAHfx_FiscalMonth(oa.AccessionISODate)			AS FM,
	
	dbo.MFAHfx_FiscalYear(oa.AccessionISODate)			AS Acquired_FY,
	dbo.MFAHfx_FiscalQuarter(oa.AccessionISODate)		AS Acquired_FQ,
	dbo.MFAHfx_FiscalMonth(oa.AccessionISODate)			AS Acquired_FM
	*/





FROM			Objects									AS o
LEFT OUTER JOIN AltNums									AS an	ON	o.ObjectID = an.ID AND TableID = 108 AND an.Description = 'Display Accession Number'
LEFT OUTER JOIN MFAHt_DepartmentPublic					AS d	ON	o.DepartmentID = d.DepartmentID
LEFT OUTER JOIN ObjectStatuses							AS os	ON	o.ObjectStatusID = os.ObjectStatusID
LEFT OUTER JOIN Classifications							AS c	ON	o.ClassificationID = c.ClassificationID
LEFT OUTER JOIN ObjectLevels							AS ol	ON	o.ObjectLevelID = ol.ObjectLevelID
LEFT OUTER JOIN ObjectTypes								AS ot	ON	o.ObjectTypeID = ot.ObjectTypeID
LEFT OUTER JOIN ObjContext								AS oc	ON	o.ObjectID = oc.ObjectID
LEFT OUTER JOIN ObjRights								AS ocr	ON	o.ObjectID = ocr.ObjectID
LEFT OUTER JOIN ObjRightsTypes							AS rt	ON	ocr.ObjRightsTypeID = rt.ObjRightsTypeID
LEFT OUTER JOIN MFAHv_OBJ_Title_FirstDisplayed			AS otfd ON	o.ObjectID = otfd.ObjectID				-- Added 4/8/2014 (see otd.Title above)
--LEFT OUTER JOIN ObjTitles								AS otd	ON	otfd.TitleID = otd.TitleID				--commented out 3/24/2015

LEFT OUTER JOIN MFAHv_OBJ_Accessioning					AS oa	ON	o.ObjectID = oa.ObjectID					--added 3/22/2016
--LEFT OUTER JOIN	ObjAccession							AS oa	ON	o.ObjectID	= oa.ObjectID				--commented out 3/22/2016
--LEFT OUTER JOIN AccessionMethods						AS am	ON	oa.AccessionMethodID = am.AccessionMethodID	--commented out 3/22/2016

LEFT OUTER JOIN MediaXrefs								AS mx	ON	o.ObjectID = mx.ID 
																AND mx.TableID = 108 
																AND mx.PrimaryDisplay = 1
LEFT OUTER JOIN MediaMaster								AS mm	ON	mx.MediaMasterID = mm.MediaMasterID
LEFT OUTER JOIN MediaRenditions							AS mr	ON	mm.DisplayRendID = mr.RenditionID

LEFT OUTER JOIN MFAHv_OBJ_Maker_FirstDisplayed			AS omfd	ON	o.ObjectID = omfd.ObjectID					--	Added 3/22/2016
LEFT OUTER JOIN MFAHv_OBJ_Constituent					AS ocn	ON	omfd.ObjectID = ocn.o_ObjectID				--	Added 3/22/2016
																AND omfd.ConstituentID = ocn.c_ConstituentID
																AND ocn.cx_DisplayOrder = 1						--	the first displayed record
																AND	ocn.cx_RoleTypeID = 1						--	within the role type

LEFT OUTER JOIN		-- Component Count
(
	SELECT
	ObjectID, COUNT(ComponentID) AS ComponentCount, SUM(CompCount) AS SumCompCount
	FROM ObjComponents
	GROUP BY ObjectID
) AS occ ON occ.ObjectID = o.ObjectID
			
WHERE	(mx.PrimaryDisplay = 1 
OR		mx.PrimaryDisplay IS NULL)	














GO


