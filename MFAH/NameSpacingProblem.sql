

/*

MFAHv_OCM_Object-ConstituentMaker
Custom MFAH View

Author:			Dave Thompson
Created:		3/17/2014
Last Updated:	4/10/2014

Description:	
--This query provides the Constituent.DisplayName, which I think is fine for the website,
--AND the Object-ConXref-specific name (ConAltNames.DisplayName) in case we would ever want to use it.
--The Gallery Systems view vgsrpObjTombstoneD_RO assumes that we would use the Xref-specific name, so if a different name were chosen
--for different Xrefs, different names would appear in the Object record returned.

*/

--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

			SELECT
/*
			--Objects----------------------------------------

			'        |||||  o  |||||'	AS marker1,
			o.ObjectID					AS o_ObjectID,
			o.ObjectNumber				AS o_ObjectNumber,
			


			--ConXrefs---------------------------------------Source for Object-Constiuent roles, display and active status, and Prefix in ConXrefDetails.Prefix
			
			'        |||||  cx  |||||'	AS marker2,
			cx.ID						AS cx_ID,					-- ObjectID
			cx.TableID					AS cx_TableID,				-- Objects table (108)
			cx.ConXrefID				AS cx_ConXrefID,			-- Readded 4/10/2014
--			cx.RoleTypeID				AS cx_RoleTypeID,
			rt.RoleType					AS cx_RoleType,				-- Object Related, Acquisition Related, Ex-Collections Related
--			cx.RoleID					AS cx_RoleID,
			r.Role						AS cx_Role,
			r.Prepositional				AS cx_Prepositional,		-- TMS automatically populates this into the ConXrefDetails.Prefix
			cx.Active					AS cx_Active,				-- Check Box on the Constituent Assistant screen
			CASE WHEN cx.Active = 1 THEN 'Active' ELSE 'Not Active'				END	AS cx_ActiveLabel,
			cx.Displayed				AS cx_Displayed,			-- Check Box on the Constituent Assistant screen
			CASE WHEN cx.Displayed = 1 THEN 'Displayed' ELSE 'Not Displayed'	END	AS cx_DisplayedLabel,
			cx.DisplayOrder				AS cx_DisplayOrder,			-- Display order on the Constituent Assistant screen

			--ConXrefSets------------------------------------Source for Attribution information (Constituent Assistant > Attribution Label tab)

			'        |||||  cxs  |||||'	AS marker3,
--			cxs.ConXrefSetID			AS cxs_ConXrefSetID,
--			cxs.DisplayOrder			AS cxs_DisplayOrder,
			cxs.ForwardDisplay			AS cxs_ForwardDisplay,			-- Used in some TMS UI data views, maybe some reports?
--			cxs.InvertedDisplay			AS cxs_InvertedDisplay,
--			cxs.Displayed				AS cxs_Displayed,			--  ***   I'm not sure what this is, or if it's copied from ConXrefs?   ***
--			CASE WHEN cxs.Displayed = 1 THEN 'Displayed' ELSE 'Not Displayed'	END	AS cxs_DisplayedLabel,
--			cxs.Active					AS cxs_Active,				--  ***   I'm not sure what this is, or if it's copied from ConXrefs?   ***
--			CASE WHEN cxs.Active = 1 THEN 'Active' ELSE 'Not Active'				END	AS cxs_ActiveLabel,
--			cxs.DateEffectiveISODate	AS cxs_DateEffectiveISODate,
			
			--ConXrefDetails---------------------------------Source for Object-Constituent xref characteristics (prefix, suffix, dates...) 
--																(Constituent Assistant > Cross-Reference Information tab)
			'        |||||  cxd  |||||'	AS marker4,
--			cxd.ConXrefDetailID			AS cxd_ConXrefDetailID,
			cxd.ConstituentID			AS cxd_ConstituentID,
			cxd.NameID					AS cxd_NameID,				-- This is the ID of the name selected for this particular Xref
--			cxd.RoleTypeID				AS cxd_RoleTypeID,			-- I think this is exactly the same as cx.RoleTypeID		
			rt2.RoleType				AS cxd_RoleType,			-- From second instance of RoleTypes, just to double-check
			cxd.Prefix					AS cxd_Prefix,				-- If Role has a prefix, it will automatically populate this field, user can delete or change.
			cxd.Suffix					AS cxd_Suffix,				-- To indicate uncertainty ("probably", "possibly")
			cxd.DateBegin				AS cxd_DateBegin,			-- Begin Date for this object-constituent xref
			cxd.DateEnd					AS cxd_DateEnd,				-- End Date for this object-constituent xref
			cxd.DisplayDate				AS cxd_DisplayDate,			--TMS-calculaed Display Date based on Begin and End Dates
--			cxd.UnMasked				AS cxd_Unmasked,
--			cxd.Remarks					AS cxd_Remarks,				--From Constituent-Assistant > Cross-Reference Characteristics tab)

			--ConAltNames------------------------------------

			'        |||||  can  |||||'	AS marker5,
			can.AltNameId				AS can_AltNameID,
			can.NameType				AS can_NameType,
			can.salutation				AS can_Salutation,
			can.NameTitle				AS can_NameTitle,
			can.FirstName				AS can_FirstName,
			can.MiddleName				AS can_MiddleName,
			can.LastName				AS can_LastName,
			can.Suffix					AS can_Suffix,
			can.Institution				AS can_Institution,
			can.CultureGroup			AS can_CultureGroup,
			can.DisplayName				AS can_DisplayName,
			can.AlphaSort				AS can_AlphaSort,
			can.Position				AS can_Position,
			can.ConstituentID			AS can_ConstituentID,
			
			--Constituents--------------------------
			'        |||||  c  |||||'	AS marker6,
			c.ConstituentID				AS c_ConstituentID,
			c.ConstituentTypeID			AS c_ConstituentTypeID,
			c.DisplayName				AS c_DisplayName,
			c.DisplayDate				AS c_DisplayDate,
			c.Active					AS c_Active,
			CASE WHEN c.Active = 1 THEN 'Active' ELSE 'Inactive' END AS ActiveDisplay,				--Added 3/26/14
			c.Approved					AS c_Approved,	
			CASE WHEN c.Approved = 1 THEN 'Approved' ELSE 'NOT Approved' END AS ApprovedDisplay,	--Added 3/26/14	
			ct.ConstituentType,																		--Added 3/26/14
*/				
			--ObjectCulture-------------------------
			
			'        |||||  oc  |||||'	AS marker7,
			oc.Culture,
						
			--MFAH----------------------------------
			
			'      |||||  MFAH  |||||'	AS marker8,
			
			--Based on CONSTITUENT record, NOT ConAltName used in the Obj-Con Xref record
			CASE WHEN (cxd.Prefix IS NULL OR LEN(cxd.Prefix) = 0) THEN '' ELSE cxd.Prefix + ' ' END +				--Prefix
			(CASE WHEN c.ConstituentTypeID = 3 THEN oc.Culture ELSE c.DisplayName END) +	--If culture, then culture, else DisplayName
			CASE WHEN (cxd.Suffix IS NULL OR LEN(cxd.Suffix) = 0) THEN '' ELSE ' ' + cxd.Suffix END +				--Suffix
			(CASE WHEN c.DisplayDate IS NULL THEN '' ELSE ', ' + c.DisplayDate END)			--Date
			AS c_DisplayArtistMaker,
			
			CASE WHEN cxd.Prefix IS NULL THEN 'Null' ELSE 'Not Null' END AS PrefixNULLTest,
			LEN(cxd.Prefix) AS LENPrefix,
			CASE WHEN cxd.Suffix IS NULL THEN 'Null' ELSE 'Not Null' END AS SuffixNULLTest,
			LEN(cxd.Suffix) AS LENSuffix,
			LEN(cxd.DisplayDate) AS LENDisplayDate,
			LEN(can.DisplayName) AS LENDisplayName,
			
			dbo.MFAHsvf_Format_RemoveAccents (UPPER(LEFT(c.AlphaSort,1))) AS c_AlphaGroup,
			
			--Based on CONALTNAME record referenced in the Obj-Con Xref record, NOT Constituent record
			CASE WHEN cxd.Prefix IS NULL OR LEN(cxd.Prefix) = 0 THEN '' ELSE cxd.Prefix + ' '	END +				--Prefix
			CASE WHEN c.ConstituentTypeID = 3 THEN oc.Culture ELSE can.DisplayName				END +	--If culture, then culture, else DisplayName
			CASE WHEN cxd.Suffix IS NULL OR LEN(cxd.Suffix) = 0 THEN '' ELSE ' ' + cxd.Suffix	END +				--Suffix
			CASE WHEN c.DisplayDate IS NULL THEN 'x' ELSE ', ' + c.DisplayDate					END		--Date
			AS can_DisplayArtistMaker,
			
			LEN(CASE WHEN c.DisplayDate IS NULL THEN 'x' ELSE ', ' + c.DisplayDate END) AS LENtest,
			LEN(CASE WHEN c.DisplayDate IS NULL THEN '' ELSE ', ' + c.DisplayDate END) AS LENtest2,
			
			
			LTRIM(CASE WHEN c.DisplayDate IS NULL THEN 'x' ELSE ', ' + c.DisplayDate END) AS test,			--Suffix
			
			c.DisplayDate,
			ISNULL(c.DisplayDate, '') AS ISNULLtest,
			
			can.DisplayName,
			can.DisplayName + cxd.DisplayDate AS DAMTest,
			
			dbo.MFAHsvf_Format_RemoveAccents (UPPER(LEFT(can.AlphaSort,1))) AS can_AlphaGroup,
			
			'        |||||  END  |||||'	AS markerEND
			
			--FROM--------------------------------------------
			
			FROM			Objects			AS o
			LEFT OUTER JOIN	ConXrefs		AS cx	ON	o.ObjectID = cx.ID	
													AND	cx.TableID = 108
			LEFT OUTER JOIN Roles			AS r	ON	cx.RoleID = r.RoleID
			LEFT OUTER JOIN RoleTypes		AS rt	ON	r.RoleTypeID = rt.RoleTypeID
			LEFT OUTER JOIN ConXrefSets		AS cxs	ON	o.ObjectID = cxs.ID
													AND	cxs.TableID = 108
													AND cxs.DisplayOrder = -1
			LEFT OUTER JOIN ConXrefDetails	AS cxd	ON	cx.ConXrefID = cxd.ConXrefID
			LEFT OUTER JOIN RoleTypes		AS rt2	ON	cxd.RoleTypeID = rt2.RoleTypeID
			LEFT OUTER JOIN ConAltNames		AS can	ON	cxd.NameID = can.AltNameId				--returns just the Xref-specific name for each constituent
--													OR	cxd.ConstituentID = can.ConstituentID	--returns all names for each constituent
			LEFT OUTER JOIN Constituents	AS c	ON	cxd.ConstituentID = c.ConstituentID
			LEFT OUTER JOIN ObjContext		AS oc	ON	o.ObjectID = oc.ObjectID
			LEFT OUTER JOIN ConTypes		AS ct	ON	c.ConstituentTypeID = ct.ConstituentTypeID

			--WHERE-------------------------------------------

			WHERE	rt.RoleTypeID = 1
			AND		cxd.UnMasked = 1
			--AND		c.ConstituentID = 6
			--AND		o.ObjectID IN (110421,95002) 
			AND o.ObjectID = 46469

			--ORDER--------------------------------------------
			
--			ORDER BY o_ObjectID, cx_DisplayOrder




GO


