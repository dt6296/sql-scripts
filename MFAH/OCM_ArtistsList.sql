

-- I used this to give Gwen and Anthony a list of artists for browsing.  3/6/2014


SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;


DECLARE @Str nvarchar(15)

SELECT DISTINCT


--cx.ConXrefID,
--cx.TableID AS cxTableID,
--cx.ID AS cxID,
--cxd.ConXrefDetailID,
--cxd.ConstituentID,
--c.Approved,
--ct.ConstituentType,
--cx.RoleID,
--r.[Role],

--r.Prepositional,

dbo.MFAHsvf_Format_RemoveAccents (UPPER(LEFT(c.AlphaSort,1))) AS AlphaGroup,
c.ConstituentID,
c.AlphaSort + CASE WHEN (c.DisplayDate IS NULL OR c.DisplayDate = '') THEN '' ELSE ' (' + c.DisplayDate + ')' END AS DisplayNameLastFirst,
c.DisplayName + CASE WHEN (c.DisplayDate IS NULL OR c.DisplayDate = '') THEN '' ELSE ' (' + c.DisplayDate + ')' END AS DisplayNameFirstLast,
c.AlphaSort,
c.salutation,
c.FirstName,
c.MiddleName,
c.LastName,
c.Suffix,
c.DisplayName,
c.DisplayDate,
c.CultureGroup,
c.Nationality

--cxd.Prefix,
--cxd.Suffix,

--CASE WHEN cxd.Prefix IS NULL THEN '' ELSE cxd.Prefix + ' ' END +				--Prefix
--(CASE WHEN c.ConstituentTypeID = 3 THEN oc.Culture ELSE c.DisplayName END) +	--If culture, then culture, else DisplayName
--CASE WHEN cxd.Suffix IS NULL THEN '' ELSE ' ' + cxd.Suffix END +				--Suffix
--(CASE WHEN c.DisplayDate IS NULL THEN '' ELSE ', ' + c.DisplayDate END)			--Date
--AS DisplayArtistMaker,	

--cx.DisplayOrder AS cxDisplayOrder,
--cx.Displayed AS cxDisplayed,
--cx.Active AS cxActive,
--cxd.DateBegin,
--cxd.DateEnd,
--cxd.Remarks

FROM			ConXrefs		AS cx
LEFT OUTER JOIN ConXrefDetails	AS cxd	ON	cx.ConXrefID		= cxd.ConXrefID
LEFT OUTER JOIN Roles			AS r	ON	cx.RoleID			= r.RoleID
LEFT OUTER JOIN Constituents	AS c	ON	cxd.ConstituentID	= c.ConstituentID
LEFT OUTER JOIN ConTypes		AS ct	ON c.ConstituentTypeID	= ct.ConstituentTypeID
LEFT OUTER JOIN [Objects]		AS o	ON cx.ID				= o.ObjectID
LEFT OUTER JOIN ObjContext		AS oc	ON o.ObjectID = oc.ObjectID

WHERE cx.RoleTypeID = 1				-- Object-Related
AND cxd.UnMasked = 1				-----------THIS IS FUNKY, WHY?  I don't understand this.  --Has to do with Constituent Anonymity, see ER diagram.
AND cx.TableID = 108				-- Objects Table
AND o.ObjectStatusID IN (2,27)		-- MFAH and Blaffer accessions
--AND cx.ID = @cxID

ORDER BY c.AlphaSort


/*

--SELECT * FROM ObjectStatuses






SELECT cxs.*, o.ObjectNumber

FROM ConXrefSets cxs
LEFT OUTER JOIN Objects AS o ON cxs.ID = o.ObjectID

WHERE cxs.TableID = 108
AND cxs.ID IN (110421,95002)
--AND cxs.DisplayOrder = - 1 

--AND cxs.ForwardDisplay LIKE ''

*/