USE [TMS]
GO

/****** Object:  View [dbo].[MFAHv_OBJ_Maker_FirstDisplayed]    Script Date: 02/09/2015 17:12:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




--CREATE VIEW [dbo].[MFAHv_OBJ_Maker_FirstDisplayed] AS

/*

MFAHv_OBJ_Maker_FirstDisplayed
Custom MFAH View


Created		4/9/2014		Dave Thompson
This view returns the first ACTIVE DISPLAYED Object-Related Constituent per object, regardless of the actual value stored in DisplayOrder.
The reason is that a ConXref with DisplayOrder = 1 may have Displayed = 0.
There are only a few instances of this, but I thought it better to account for it instead of pulling bad or null records.
This is really a data standards issue, but that doesn't seem to be making much progress.
This is based on the same logic as MFAHv_OBJ-Title_FirstDisplayed.

Updated		5/30/2014	Renamed from MFAHv_Object-ObjRelCon_FirstDisplayed

Updated		1/13/2015	Added can and cxd fields/condition so that artist names will appear.

*/

	SELECT
	oc.cx_ID	AS ObjectID,
	oc.c_ConstituentID,
	oc.DisplayName,
	crank.RankByDisplayOrder,
	--crank.RoleTypeID
	oc.cx_RoleTypeID
	
	FROM
	(
		SELECT ID AS ObjectID, ConXrefID, RoleTypeID,
		RANK() OVER(PARTITION BY ID ORDER BY DisplayOrder) AS RankByDisplayOrder
		FROM ConXrefs
		WHERE Active = 1		-- Active ConXref
		AND Displayed = 1		-- Displayed ConXref
		AND TableID = 108	
		AND RoleTypeID = 1		-- Object Related ConXref
	) AS crank
	
	LEFT OUTER JOIN MFAHv_OBJ_Constituent	AS oc	ON crank.ObjectID = oc.cx_ID
													AND oc.cx_TableID = 108
													AND crank.ConXrefID = oc.cx_ConXrefID
	
	WHERE RankByDisplayOrder IN (1,2,3)
	AND oc.cxd_UnMasked = 1
	AND oc.cx_RoleTypeID = 1
	AND ObjectID IN (882,30630,11253,34592,48235,98805,108448,106774,120735,42316,110005,110421)



GO

		SELECT ID AS ObjectID, ConXrefID, RoleTypeID,
		RANK() OVER(PARTITION BY ID ORDER BY DisplayOrder) AS RankByDisplayOrder
		FROM ConXrefs
		WHERE Active = 1		-- Active ConXref
		AND Displayed = 1		-- Displayed ConXref
		AND TableID = 108
		AND RoleTypeID = 1	
		AND ID = 110421


SELECT * FROM MFAHv_OBJ_Constituent WHERE cx_ID = 110421








