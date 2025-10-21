USE [TMS]
GO

/****** Object:  View [dbo].[MFAHv_OBJ]    Script Date: 02/10/2015 14:07:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--CREATE VIEW [dbo].[MFAHv_OBJ] AS

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

*/


SELECT 

--Administrative Data
	o.ObjectID,
	o.ObjectNumber,

--Object Thumbnail
	mr.ThumbBLOB,
	mx.MediaMasterID

FROM			Objects									AS o
LEFT OUTER JOIN MediaXrefs								AS mx	ON	o.ObjectID = mx.ID AND mx.TableID = 108
LEFT OUTER JOIN MediaMaster								AS mm	ON	mx.MediaMasterID = mm.MediaMasterID
LEFT OUTER JOIN MediaRenditions							AS mr	ON	mm.DisplayRendID = mr.RenditionID

WHERE	(mx.PrimaryDisplay = 1 
OR		mx.PrimaryDisplay IS NULL)		--Added 4/8/2014 because not all object records have MediaXref records.

AND mm.MediaMasterID IS NOT NULL	--!!!!!!!!!!!!!

AND o.ObjectID IN
(
6338,
37897,
17187,
90827,
90821,
79502,
106203,
84866,
43671,
90824,
77107,
24324,
86777,
16909,
87386,
12930,
90823,
53525,
90826,
17185,
83205,
90822,
78914,
90825,
4903,
90004,
6310,
86566
)


SELECT * FROM MediaXrefs WHERE MediaMasterID = 98369--91703--87037
SELECT * FROM MediaMaster WHERE MediaMasterID = 98369--91703--87037

