

-----------		Scroll down for stage 1 and 2 queries	--------------------------------------




SELECT
p.PackageID,
p.Name,
p.[Owner],
COUNT(pl.ID) AS ObjectCount

FROM [Packages] AS p
INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID

WHERE p.PackageID = 14543


GROUP BY
p.PackageID,
p.Name,
p.[Owner]

ORDER BY
p.Name
  
--LTA/MS Nov 2013							PackageID = 15012
--Conservation request						PackageID = 15811
--Blaffer Phase I
--Blaffer Hightlights Book:					PackageID = 12200
--Blaffer War & Peace - No books/folios:	PackageID = 14594

--Costume Deaccession Recommendations 2014	PackageID = 15916, 276 Objects


/****** Script for SelectTopNRows command from SSMS  ******/
SELECT
p.PackageID,
p.Name,
p.[Owner],
pl.ID	AS ObjectID

FROM [Packages] AS p
INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID

WHERE pl.PackageID = 15916


----------------------------------------------------------------------Packages and what's been approved.

SELECT
'Stage 1' AS Stage,
p.PackageID,
p.Name,
p.[Owner],
o.CuratorApproved,
o.Accountability AS DataStandardsApproved,
COUNT(pl.ID) AS ObjectCount


FROM [Packages] AS p
INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
INNER JOIN Objects AS o ON pl.ID = o.ObjectID

WHERE p.PackageID IN
(
14402,	--TMS Cleanup - BB - 98 Catalogue
12200,	--Blaffer Hightlights Book
14594,	--Blaffer War and Peace - No books/folios
14616,	--TMS Cleanup_Leirner
14617,	--TMS Cleanup_CAF
14618,	--TMS Cleanup_LA Recent Acq (No CAF)
14543,	--PHOTOGRAPHY - PHOTOGRAPH (WEBSITE PROJECT 2013)
14614,	--RienziBook.Highlights
14613	--TMS Cleanup-Antiquities
)

GROUP BY
p.PackageID,
p.Name,
p.[Owner],
o.CuratorApproved,
o.Accountability

UNION

SELECT
'Stage 2' AS Stage,
p.PackageID,
p.Name,
p.[Owner],
o.CuratorApproved,
o.Accountability AS DataStandardsApproved,
COUNT(pl.ID) AS ObjectCount

FROM [Packages] AS p
INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
INNER JOIN Objects AS o ON pl.ID = o.ObjectID

WHERE p.PackageID IN
(
	15674,	--ModCon Texas Final
	15064,	--Dec Arts 120913
	15065,	--American Art Data Clean 122013
	15071,	--CD-TMS Cleanup, AOA
	14793,	--Euro Art Paintings 120913
	14795,	--Euro Art Sculpture 120913
	14559,	--P&D: Website Project
	16986	--Euro Art Web Approved  (added 2/18/2015)	
)

GROUP BY
p.PackageID,
p.Name,
p.[Owner],
o.CuratorApproved,
o.Accountability

UNION

SELECT
'Stage 1' AS Stage,
p.PackageID,
p.Name,
p.[Owner],
o.CuratorApproved,
o.Accountability AS DataStandardsApproved,
COUNT(pl.ID) AS ObjectCount


FROM [Packages] AS p
INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
INNER JOIN Objects AS o ON pl.ID = o.ObjectID

WHERE p.PackageID IN
(
16615,	--BC_Standards Thompson
16249,	--BC_Standards 2013
16533,	--BC_Standards 2012-2010
16580,	--BC_Standards 2009-2008
15484	--TMS Cleanup - Asian Art
)

GROUP BY
p.PackageID,
p.Name,
p.[Owner],
o.CuratorApproved,
o.Accountability


ORDER BY
Stage,
p.Name






















--------------------------------------------------------------------------

SELECT * FROM Packages WHERE PackageID = 15323

SELECT * FROM Packages ORDER BY Name

SELECT * FROM Packages WHERE Name LIKE 'BC_%' ORDER BY Name

16615	BC_Standards Thompson
16249	BC_Standards 2013
16533	BC_Standards 2012-2010
16580	BC_Standards 2009-2008
--------------------------------------------------------------------------

SELECT
o.ObjectID,
o.ObjectNumber,
o.IsVirtual,
d.Department,
os.ObjectStatus

FROM Objects AS o
LEFT OUTER JOIN Departments AS d	ON o.DepartmentID = d.DepartmentID
LEFT OUTER JOIN	ObjectStatuses	AS os	ON o.ObjectStatusID = os.ObjectStatusID

WHERE o.ObjectID IN

(
	SELECT
	pl.ID AS ObjectCount

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID

	WHERE p.PackageID IN
	(

		12200,
		14594,
		14543,
		14614,
		15323,
		14402,
		14613,
		14617,
		14618,
		14616,	
		15674,
		15064,
		14559,
		14793,
		14795,
		15071,
		15065
	)
)



---------------------------------------------------------------------------------------------



------------------------------------------------------------------------------------------

SELECT
d.Department,
COUNT(o.ObjectID) AS ObjectCount,
o.IsVirtual,
	--Calendar Dates
	dbo.MFAHfx_CalendarYear(oa.AccessionISODate)	AS CY,
	dbo.MFAHfx_CalendarQuarter(oa.AccessionISODate)	AS CQ,
	dbo.MFAHfx_CalendarMonth(oa.AccessionISODate)	AS CM,
	dbo.MFAHfx_CalendarMonthName(oa.AccessionISODate)	AS CM_Name


FROM Objects AS o
LEFT OUTER JOIN Departments AS d	ON o.DepartmentID = d.DepartmentID
LEFT OUTER JOIN ObjAccession	AS oa	ON o.ObjectID = oa.ObjectID

WHERE ObjectStatusID = 2

GROUP BY d.Department, o.IsVirtual,
dbo.MFAHfx_CalendarYear(oa.AccessionISODate),
dbo.MFAHfx_CalendarQuarter(oa.AccessionISODate),
dbo.MFAHfx_CalendarMonth(oa.AccessionISODate),
dbo.MFAHfx_CalendarMonthName(oa.AccessionISODate)


------------------------------------------------------------------------------------------







SELECT
'Stage 2' AS Stage,
p.PackageID,
p.Name,
p.[Owner],
COUNT(pl.ID) AS ObjectCount

FROM [Packages] AS p
INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID

WHERE p.PackageID IN
(
	15012
)

GROUP BY
p.PackageID,
p.Name,
p.[Owner]

ORDER BY
Stage,
p.Name

-------------------------------------------------------------------------------


SELECT o.ObjectID, o.ObjectNumber, o.Title
FROM Objects AS o
WHERE o.ObjectID IN
(
	SELECT pl.ID
	FROM PackageList AS pl
	WHERE PackageID = 15323
)




---------------------------------------------------------------------------------------------------


SELECT
p.PackageID,
p.Name,
p.[Owner],
pl.ID	AS ObjectID,
o.ObjectNumber,
cx.RoleID,
r.Role,
r.RoleTypeID

FROM [Packages] AS p
INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
INNER JOIN Objects AS o ON pl.ID = o.ObjectID AND pl.TableID = 108
INNER JOIN ConXrefs AS cx ON o.ObjectID = cx.ID AND cx.TableID = 108
INNER JOIN Roles AS r ON cx.RoleID = r.RoleID


WHERE pl.PackageID = 15916
AND cx.RoleID = 1


ORDER BY pl.ID





--UPDATE ConXrefs
SET RoleID = 25
--SELECT * FROM ConXrefs
WHERE TableID = 108
AND RoleID = 1
AND ID IN

(
	SELECT pl.ID 
	FROM PackageList AS pl
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID AND pl.TableID = 108
	LEFT OUTER JOIN ConXrefs AS cx ON o.ObjectID = cx.ID AND cx.TableID = 108
	WHERE pl.PackageID = 15916
	AND cx.RoleID = 1
)

------------------------------------------------------------------------------- Asian Art - Beatrice

SELECT
'Stage 1' AS Stage,
p.PackageID,
p.Name,
p.[Owner],
o.CuratorApproved,
o.Accountability AS DataStandardsApproved,
COUNT(pl.ID) AS ObjectCount


FROM [Packages] AS p
INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
INNER JOIN Objects AS o ON pl.ID = o.ObjectID

WHERE p.PackageID IN
(
16615,	--BC_Standards Thompson
16249,	--BC_Standards 2013
16533,	--BC_Standards 2012-2010
16580,	--BC_Standards 2009-2008
15484	--TMS Cleanup - Asian Art
)

GROUP BY
p.PackageID,
p.Name,
p.[Owner],
o.CuratorApproved,
o.Accountability

-------------------------------------------------------------------------FINDING DUPLICATES

SELECT 
pl.ID AS ObjectID,
--p.Name,
COUNT(p.PackageID) AS PkgCount

FROM [Packages] AS p
INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
INNER JOIN Objects AS o ON pl.ID = o.ObjectID

WHERE p.PackageID IN
(
16615,	--BC_Standards Thompson
16249,	--BC_Standards 2013
16533,	--BC_Standards 2012-2010
16580,	--BC_Standards 2009-2008
15484	--TMS Cleanup - Asian Art
)

GROUP BY
pl.ID
--p.Name

HAVING COUNT(p.PackageID) > 1


------------------------------------------------------------------------------------This is the start....

SELECT
s.Stage,
s.Dept,
COUNT(s.ID) AS ObjectCount

FROM

(

	SELECT
	'Stage I'	AS Stage,
	'Asian Art'	AS Dept,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID

	WHERE p.PackageID = 15484

	UNION

	SELECT
	'Stage I'	AS Stage,
	'Asian Art'	AS Dept,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID

	WHERE p.PackageID = 16615

	UNION

	SELECT
	'Stage I'	AS Stage,
	'Asian Art'	AS Dept,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID

	WHERE p.PackageID = 16249

	UNION

	SELECT
	'Stage I'	AS Stage,
	'Asian Art'	AS Dept,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID

	WHERE p.PackageID = 16533

	UNION

	SELECT
	'Stage I'	AS Stage,
	'Asian Art'	AS Dept,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID

	WHERE p.PackageID = 16580

	UNION

	SELECT
	'Stage I'	AS Stage,
	'Asian Art'	AS Dept,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID

	WHERE p.PackageID = 15484
	
	UNION

	SELECT
	'Stage I'	AS Stage,
	'Bayou Bend'	AS Dept,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID

	WHERE p.PackageID = 14402
	
	UNION

	SELECT
	'Stage I'	AS Stage,
	'Blaffer'	AS Dept,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID

	WHERE p.PackageID = 12200

	UNION

	SELECT
	'Stage I'	AS Stage,
	'Blaffer'	AS Dept,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID

	WHERE p.PackageID = 14594


	UNION

	SELECT
	'Stage I'	AS Stage,
	'Latin American'	AS Dept,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID

	WHERE p.PackageID = 14616


	UNION

	SELECT
	'Stage I'	AS Stage,
	'Latin American'	AS Dept,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID

	WHERE p.PackageID = 14617

	UNION

	SELECT
	'Stage I'	AS Stage,
	'Latin American'	AS Dept,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID

	WHERE p.PackageID = 14618
	

	UNION

	SELECT
	'Stage I'	AS Stage,
	'Photography'	AS Dept,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID

	WHERE p.PackageID = 14543


	UNION

	SELECT
	'Stage I'	AS Stage,
	'Rienzi'	AS Dept,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID

	WHERE p.PackageID = 14614

	UNION

	SELECT
	'Stage I'	AS Stage,
	'Antiquities'	AS Dept,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID

	WHERE p.PackageID = 14613

	
	
) AS s

GROUP BY 
s.Dept,
s.Stage








