SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

/*

--This query, originally used for the OCM_ObjectData, only provides the Constituent.DisplayName, which I think is fine for the website,
--but it does not provide the Object-ConXref-specific name (ConAltNames.DisplayName) in case we would ever want to use it.
--The Gallery Systems view vgsrpObjTombstoneD_RO assumes that we would use the Xref-specific name, so if a different name were chosen
--for different Xrefs, different names would appear in the Object record returned.


SELECT

cx.ConXrefID,
cx.TableID AS cxTableID,
cx.ID AS cxID,
cxd.ConXrefDetailID,
cxd.ConstituentID,
c.Approved,
ct.ConstituentType,
cx.RoleID,
r.[Role],
r.Prepositional,
cxd.Prefix,
c.DisplayName,
c.DisplayDate,
cxd.Suffix,

CASE WHEN cxd.Prefix IS NULL THEN '' ELSE cxd.Prefix + ' ' END +				--Prefix
(CASE WHEN c.ConstituentTypeID = 3 THEN oc.Culture ELSE c.DisplayName END) +	--If culture, then culture, else DisplayName
CASE WHEN cxd.Suffix IS NULL THEN '' ELSE ' ' + cxd.Suffix END +				--Suffix
(CASE WHEN c.DisplayDate IS NULL THEN '' ELSE ', ' + c.DisplayDate END)			--Date
AS DisplayArtistMaker,	

cx.DisplayOrder AS cxDisplayOrder,
cx.Displayed AS cxDisplayed,
cx.Active AS cxActive,
cxd.DateBegin,
cxd.DateEnd,
cxd.Remarks

FROM			ConXrefs		AS cx
LEFT OUTER JOIN ConXrefDetails	AS cxd	ON	cx.ConXrefID		= cxd.ConXrefID
LEFT OUTER JOIN Roles			AS r	ON	cx.RoleID			= r.RoleID
LEFT OUTER JOIN Constituents	AS c	ON	cxd.ConstituentID	= c.ConstituentID
LEFT OUTER JOIN ConTypes		AS ct	ON c.ConstituentTypeID	= ct.ConstituentTypeID
LEFT OUTER JOIN [Objects]		AS o	ON cx.ID				= o.ObjectID
LEFT OUTER JOIN ObjContext		AS oc	ON o.ObjectID = oc.ObjectID

WHERE cx.RoleTypeID = 1		--Object-Related
AND cxd.UnMasked = 1		---------------------this has to do with anonymous constituents, there are always 2 xref detail records.
AND cx.TableID = 108		--Objects Table
--AND cx.ID = @cxID
--AND cx.ID IN (48123,110421,119208,78829,33653,19195,22428,2324,32835,1388,29874,84131,5410,109944,95424,71013,12379,3370,4858,1093,1442,1614,1723,6115,59856,34748,12479,10894,65393,90429,77456,114330,115845)	--test records
AND cx.ID = 110421


ORDER BY cx.ID

*/

--This query returns BOTH the Xref-specific DisplayName AND the Constituents.DisplayName.

SELECT

--Objects----------------------------------------

o.ObjectID					AS o_ObjectID,
o.ObjectNumber				AS o_ObjectNumber,
'          ||||||||||',

--ConXrefs---------------------------------------Source for Object-Constiuent roles, display and active status, and Prefix in ConXrefDetails.Prefix

cx.ID						AS cx_ID,
cx.TableID					AS cx_TableID,
cx.ConXrefID				AS cx_ConXrefID,
cx.RoleTypeID				AS cx_RoleTypeID,
rt.RoleType					AS cx_RoleType,
cx.RoleID					AS cx_RoleID,
r.Role						AS cx_Role,
r.Prepositional				AS cx_Prepositional,
cx.Active					AS cx_Active,
cx.Displayed				AS cx_Displayed,
cx.DisplayOrder				AS cx_DisplayOrder,
'          ||||||||||',

--ConXrefSets------------------------------------Source for Attribution information (Constituent Assistant > Attribution Label tab)

cxs.ConXrefSetID			AS cxs_ConXrefSetID,
cxs.DisplayOrder			AS cxs_DisplayOrder,
cxs.ForwardDisplay			AS cxs_Attribution,			-- Used in some TMS UI data views, maybe some reports?
cxs.InvertedDisplay			AS cxs_InvertedDisplay,
cxs.Displayed				AS cxs_Displayed,
cxs.Active					AS cxs_Active,
cxs.DateEffectiveISODate	AS cxs_DateEffectiveISODate,
'          ||||||||||',

--ConXrefDetails---------------------------------

cxd.ConXrefDetailID			AS cxd_ConXrefDetailID,
cxd.ConstituentID			AS cxd_ConstituentID,
cxd.NameID					AS cxd_NameID,
cxd.RoleTypeID				AS cxd_RoleTypeID,
cxd.Prefix					AS cxd_Prefix,
cxd.Suffix					AS cxd_Suffix,
cxd.DateBegin				AS cxd_DateBegin,
cxd.DateEnd					AS cxd_DateEnd,
cxd.DisplayDate				AS cxd_DisplayDate,
cxd.UnMasked				AS cxd_Unmasked,
cxd.Remarks					AS cxd_Remarks,
'          ||||||||||',

--ConAltNames------------------------------------

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
dbo.MFAHsvf_Format_RemoveAccents (UPPER(LEFT(can.AlphaSort,1))) AS c_AlphaGroup,
'          ||||||||||',

--Constituents-----------------------------------

c.ConstituentID				AS c_ConstituentID,
c.Approved					AS c_Approved,
c.IsPrivate					AS c_IsPrivate,
c.PublicAccess				AS c_PublicAccess,
c.DefaultNameID				AS c_DefaultNameID,
c.salutation				AS c_Salutation,
c.NameTitle					AS c_NameTitle,
c.FirstName					AS c_FirstName,
c.MiddleName				AS c_MiddleName,
c.LastName					AS c_LastName,
c.Suffix					AS c_Suffix,
c.Institution				AS c_Institution,
c.DisplayName				AS c_DisplayName,
c.DisplayDate				AS c_DisplayDate,
c.Nationality				AS c_Nationality,
c.School					AS c_School,
c.CultureGroup				AS c_CultureGroup,
c.N_DisplayDate				AS c_N_DisplayDate,
c.N_DisplayName				AS c_N_DisplayName,
c.AlphaSort		+ CASE WHEN (c.DisplayDate IS NULL OR c.DisplayDate = '') THEN '' ELSE ' (' + c.DisplayDate + ')' END AS c_LastFirstNameDate,
c.DisplayName	+ CASE WHEN (c.DisplayDate IS NULL OR c.DisplayDate = '') THEN '' ELSE ' (' + c.DisplayDate + ')' END AS c_FirstLastNameDate,


CASE WHEN cxd.Prefix IS NULL THEN '' ELSE cxd.Prefix + ' ' END +					--cxd_Prefix
(CASE WHEN c.ConstituentTypeID = 3 THEN oc.Culture ELSE c.DisplayName END) +		--IF ConstituentType IS Culture THEN oc_Culture ELSE c_DisplayName
CASE WHEN cxd.Suffix IS NULL THEN '' ELSE ' ' + cxd.Suffix END +					--cxd_Suffix
(CASE WHEN c.DisplayDate IS NULL THEN '' ELSE ', ' + c.DisplayDate END)				--c_DisplayDate
AS DisplayArtistMaker

--FROM-------------------------------------------

FROM			Objects			AS o
LEFT OUTER JOIN ObjContext		AS oc	ON	o.ObjectID = oc.ObjectID
LEFT OUTER JOIN	ConXrefs		AS cx	ON	o.ObjectID = cx.ID	
										AND	cx.TableID = 108
LEFT OUTER JOIN ConXrefSets		AS cxs	ON	o.ObjectID = cxs.ID						--NEW
										AND	cxs.TableID = 108						--NEW
										AND cxs.DisplayOrder = -1					--NEW
LEFT OUTER JOIN Roles			AS r	ON	cx.RoleID = r.RoleID
LEFT OUTER JOIN RoleTypes		AS rt	ON	r.RoleTypeID = rt.RoleTypeID
LEFT OUTER JOIN ConXrefDetails	AS cxd	ON	cx.ConXrefID = cxd.ConXrefID
LEFT OUTER JOIN ConAltNames		AS can	ON	cxd.ConstituentID = can.ConstituentID	--returns all names for each constituent
										OR	cxd.NameID = can.AltNameId				--returns just the Xref-specific name for each constituent
LEFT OUTER JOIN Constituents	AS c	ON can.ConstituentID = c.ConstituentID

--WHERE------------------------------------------

WHERE	rt.RoleTypeID = 1
AND		cxd.UnMasked = 1
--AND		c.ConstituentID = 6
AND		o.ObjectID IN (110421,95002) 

--ORDER------------------------------------------

ORDER BY cx.DisplayOrder, cx.ConXrefID


/*
SELECT * FROM ConXrefs WHERE TableID = 108 and ID IN (110421,95002)
SELECT * FROM ConXrefSets WHERE TableID = 108 and ID IN (110421,95002)



SELECT * FROM DDTables WHERE TableID IN (49,327,628)

SELECT * FROM DDColumns WHERE ColumnName LIKE 'ConXrefSetID'
*/

-----------------------------------------------------------------------------------------------------------------------------------------------------

--  How to pull this to illustrate different places object-constituent data is located?



/*
--This query provides the Constituent.DisplayName, which I think is fine for the website,
--AND the Object-ConXref-specific name (ConAltNames.DisplayName) in case we would ever want to use it.
--The Gallery Systems view vgsrpObjTombstoneD_RO assumes that we would use the Xref-specific name, so if a different name were chosen
--for different Xrefs, different names would appear in the Object record returned.
*/


SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

			SELECT

			--Objects----------------------------------------

			'        |||||  o  |||||',
			o.ObjectID					AS o_ObjectID,
			o.ObjectNumber				AS o_ObjectNumber,
			


			--ConXrefs---------------------------------------Source for Object-Constiuent roles, display and active status, and Prefix in ConXrefDetails.Prefix
			
			'        |||||  cx  |||||',
			cx.ID						AS cx_ID,					-- ObjectID
			cx.TableID					AS cx_TableID,				-- Objects table (108)
--			cx.ConXrefID				AS cx_ConXrefID,
--			cx.RoleTypeID				AS cx_RoleTypeID,
			rt.RoleType					AS cx_RoleType,				-- Object Related, Acquisition Related, Ex-Collections Related
--			cx.RoleID					AS cx_RoleID,
			r.Role						AS cx_Role,
			r.Prepositional				AS cx_Prepositional,		-- TMS automatically populates this into the ConXrefDetails.Prefix
			cx.Active					AS cx_Active,				-- Check Box on the Constituent Assistant screen.
			cx.Displayed				AS cx_Displayed,			-- Check Box on the Constituent Assistant screen.
			cx.DisplayOrder				AS cx_DisplayOrder,			-- Display order on the Constituent Assistant screen.

			--ConXrefSets------------------------------------Source for Attribution information (Constituent Assistant > Attribution Label tab)

			'        |||||  cxs  |||||',
--			cxs.ConXrefSetID			AS cxs_ConXrefSetID,
--			cxs.DisplayOrder			AS cxs_DisplayOrder,
			cxs.ForwardDisplay			AS cxs_Attribution,			-- Used in some TMS UI data views, maybe some reports?
--			cxs.InvertedDisplay			AS cxs_InvertedDisplay,
			cxs.Displayed				AS cxs_Displayed,			--  ***   I'm not sure what this is, or if it's copied from ConXrefs?   ***
			cxs.Active					AS cxs_Active,				--  ***   I'm not sure what this is, or if it's copied from ConXrefs?   ***
--			cxs.DateEffectiveISODate	AS cxs_DateEffectiveISODate,
			
			--ConXrefDetails---------------------------------Source for Object-Constituent xref characteristics (prefix, suffix, dates...) 
--																(Constituent Assistant > Cross-Reference Information tab)
			'        |||||  cxd  |||||',
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

			'          |||||  can  |||||',
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
			dbo.MFAHsvf_Format_RemoveAccents (UPPER(LEFT(can.AlphaSort,1))) AS c_AlphaGroup,
			
			--MFAH Display Name------------------------------
			
			'        |||||  MFAH  |||||',			
			
			--Based on CONSTITUENT record, NOT ConAltName used in the Obj-Con Xref record
			CASE WHEN cxd.Prefix IS NULL THEN '' ELSE cxd.Prefix + ' ' END +				--Prefix
			(CASE WHEN c.ConstituentTypeID = 3 THEN oc.Culture ELSE c.DisplayName END) +	--If culture, then culture, else DisplayName
			CASE WHEN cxd.Suffix IS NULL THEN '' ELSE ' ' + cxd.Suffix END +				--Suffix
			(CASE WHEN c.DisplayDate IS NULL THEN '' ELSE ', ' + c.DisplayDate END)			--Date
			AS c_DisplayArtistMaker,	
			
			
			--Based on CONALTNAME record referenced in the Obj-Con Xref record, NOT Constituent record
			CASE WHEN cxd.Prefix IS NULL THEN '' ELSE cxd.Prefix + ' ' END +				--Prefix
			(CASE WHEN c.ConstituentTypeID = 3 THEN oc.Culture ELSE can.DisplayName END) +	--If culture, then culture, else DisplayName
			CASE WHEN cxd.Suffix IS NULL THEN '' ELSE ' ' + cxd.Suffix END +				--Suffix
			(CASE WHEN c.DisplayDate IS NULL THEN '' ELSE ', ' + c.DisplayDate END)			--Date
			AS can_DisplayArtistMaker,
			
			'        |||||  END  |||||'
			
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

			--WHERE-------------------------------------------

			WHERE	rt.RoleTypeID = 1
			AND		cxd.UnMasked = 1
			--AND		c.ConstituentID = 6
			AND		o.ObjectID IN (110421,95002) 

			--ORDER--------------------------------------------
			
			ORDER BY o_ObjectID, cx_DisplayOrder



