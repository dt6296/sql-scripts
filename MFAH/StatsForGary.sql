/*

SELECT * FROM
(
	SELECT
	ObjectID,ComponentID,ComponentNumber,Date,TransType,TransStatus,Site,Room,UnitType,
	RANK()OVER(PARTITION BY ObjectID ORDER BY Date DESC) AS RankByDate
	FROM MFAHv_OBJ_LocationHistory
	--WHERE ObjectID = 82991
	WHERE DATE <= '2016-10-01'
)
AS sq
WHERE RankByDate = 1
AND Site = 'ROSINE BUILDING'
AND Room = 'ROOM 214'
AND UnitType = 'SHELF 006'




SELECT AccessionNumber,ObjectID,ComponentID,ComponentNumber,CurLocationString FROM MFAHv_OBJ_Location
WHERE ObjectID IN
(
82045,
82988,
82990,
82991,
41023
)


-------------------------------- Another approach putting begin and end locations side-by-side --------------------------

------------------------------------------------------------------------------------------------------------

SELECT * FROM 
(
SELECT
olh.ObjLocationID,
olh.ObjectID,
o.ObjectNumber,
olh.Date AS LocationBeginDate,
olh.Site AS BeginSite,
olh.Room AS BeginRoom,
RANK()OVER(PARTITION BY olh.ObjectID ORDER BY Date ASC, ObjLocationID ASC) AS RankByBeginDate 

FROM MFAHv_OBJ_LocationHistory AS olh
INNER JOIN Objects AS o ON olh.ObjectID = o.ObjectID

WHERE o.ObjectNumber = '72.20'
AND olh.Inactive = 0
)	AS lbd

INNER JOIN
(
	SELECT * FROM
	(
		SELECT
--		olh.ObjLocationID,
--		olh.ObjectID,
--		o.ObjectNumber,
		olh.Date AS LocationEndDate,
		olh.Site AS EndSite,
		olh.Room AS EndRoom,
		RANK()OVER(PARTITION BY olh.ObjectID ORDER BY Date ASC, ObjLocationID ASC) -1 AS RankByEndDate

		FROM MFAHv_OBJ_LocationHistory AS olh
		INNER JOIN Objects AS o ON olh.ObjectID = o.ObjectID

		WHERE o.ObjectNumber = '72.20'
		AND olh.Inactive = 0
	) AS sled
) AS led ON lbd.RankByBeginDate = led.RankByEndDate

UNION

		SELECT TOP 1
		olh.ObjLocationID,
		olh.ObjectID,
		o.ObjectNumber,
		olh.Date AS LocationBeginDate,
		olh.Site AS BeginSite,
		olh.Room AS BeginRoom,
		RANK()OVER(PARTITION BY olh.ObjectID ORDER BY Date DESC, ObjLocationID DESC) AS RankByBeginDate,
--		olh.ObjLocationID,
--		olh.ObjectID,
--		o.ObjectNumber,
		GETDATE() AS LocationEndDate,
olh.Site AS EndSite,
olh.Room AS EndRoom,
999 AS RankByEndDate
		FROM MFAHv_OBJ_LocationHistory AS olh
		INNER JOIN Objects AS o ON olh.ObjectID = o.ObjectID
		WHERE o.ObjectNumber = '72.20'
		AND olh.Inactive = 0

ORDER BY LocationEndDate, RankByEndDate



-----------------------------------------------------------------------------------------------------------

SELECT * FROM 
(
SELECT
olh.ObjLocationID,
olh.ObjectID,
o.ObjectNumber,
olh.Date AS LocationBeginDate,
olh.Site AS BeginSite,
olh.Room AS BeginRoom,
RANK()OVER(PARTITION BY olh.ObjectID ORDER BY Date ASC, ObjLocationID ASC) AS RankByBeginDate 

FROM MFAHv_OBJ_LocationHistory AS olh
INNER JOIN Objects AS o ON olh.ObjectID = o.ObjectID

WHERE olh.Inactive = 0
AND o.ObjectStatusID IN (2,27)

)	AS lbd

INNER JOIN
(
	SELECT * FROM
	(
		SELECT
--		olh.ObjLocationID,
--		olh.ObjectID,
--		o.ObjectNumber,
		olh.Date AS LocationEndDate,
		olh.Site AS EndSite,
		olh.Room AS EndRoom,
		RANK()OVER(PARTITION BY olh.ObjectID ORDER BY Date ASC, ObjLocationID ASC) -1 AS RankByEndDate

		FROM MFAHv_OBJ_LocationHistory AS olh
		INNER JOIN Objects AS o ON olh.ObjectID = o.ObjectID

		WHERE olh.Inactive = 0
		AND o.ObjectStatusID IN (2,27)

		AND (olh.Site = 'BECK BUILDING')
		AND (olh.Room LIKE '2%')
	) AS sled
) AS led ON lbd.RankByBeginDate = led.RankByEndDate

WHERE (lbd.BeginSite = 'BECK BUILDING' OR led.EndSite = 'BECK BUILDING')
AND (lbd.BeginRoom LIKE '2%' OR led.EndRoom LIKE '2%')


/*
UNION

		SELECT TOP 1
		olh.ObjLocationID,
		olh.ObjectID,
		o.ObjectNumber,
		olh.Date AS LocationBeginDate,
		olh.Site AS BeginSite,
		olh.Room AS BeginRoom,
		RANK()OVER(PARTITION BY olh.ObjectID ORDER BY Date DESC, ObjLocationID DESC) AS RankByBeginDate,
--		olh.ObjLocationID,
--		olh.ObjectID,
--		o.ObjectNumber,
		GETDATE() AS LocationEndDate,
		olh.Site AS EndSite,
		olh.Room AS EndRoom,
		999 AS RankByEndDate
		FROM MFAHv_OBJ_LocationHistory AS olh
		INNER JOIN Objects AS o ON olh.ObjectID = o.ObjectID
		WHERE olh.Inactive = 0
		AND o.ObjectStatusID IN (2,27)
*/


ORDER BY lbd.SortNumber, LocationEndDate, RankByEndDate


---------------------------------------------------------------------------------------------------------------------------

SELECT * FROM 
(
	SELECT
	olh.ObjLocationID,
	olh.ObjectID,
	o.ObjectNumber,
	o.SortNumber,
	olh.Date AS LocationBeginDate,
	olh.Site AS BeginSite,
	olh.Room AS BeginRoom,
	RANK()OVER(PARTITION BY olh.ObjectID ORDER BY Date ASC, ObjLocationID ASC) AS RankByBeginDate 

	FROM MFAHv_OBJ_LocationHistory AS olh
	INNER JOIN Objects AS o ON olh.ObjectID = o.ObjectID

	WHERE olh.Inactive = 0
	AND o.ObjectStatusID IN (2,27)
)	AS lbd

INNER JOIN
(
	SELECT * FROM
	(
		SELECT
--		olh.ObjLocationID,
--		olh.ObjectID,
--		o.ObjectNumber,
		olh.Date AS LocationEndDate,
		olh.Site AS EndSite,
		olh.Room AS EndRoom,
		RANK()OVER(PARTITION BY olh.ObjectID ORDER BY Date ASC, ObjLocationID ASC) -1 AS RankByEndDate

		FROM MFAHv_OBJ_LocationHistory AS olh
		INNER JOIN Objects AS o ON olh.ObjectID = o.ObjectID

		WHERE olh.Inactive = 0
		AND o.ObjectStatusID IN (2,27)

		AND (olh.Site = 'BECK BUILDING')
		AND (olh.Room LIKE '2%')
	) AS sled
) AS led ON lbd.RankByBeginDate = led.RankByEndDate

ORDER BY SortNumber, LocationEndDate, RankByEndDate


---------------------------------------------------------------------------------------------


SELECT 
ol.ObjLocationID,
ol.ComponentID,
o.ObjectID,
o.ObjectNumber,
o.SortNumber,
ol.TransDate,
ol.LocationID,
l.Site,
l.Room,
ol.PrevObjLocID,
ol.NextObjLocID

FROM ObjLocations AS ol
INNER JOIN Locations AS l ON ol.LocationID = l.LocationID
INNER JOIN ObjComponents AS oc ON ol.ComponentID = oc.ComponentID
INNER JOIN Objects AS o ON oc.ObjectID = o.ObjectID	

WHERE ol.LocationID IN
(
	SELECT 
	LocationID--,Site,Room
	FROM Locations
	WHERE Site = 'BECK BUILDING'
	AND Room LIKE '2%'
)





SELECT * FROM ObjLocationView WHERE ComponentNumber = '72.20'


SELECT * FROM ObjComponents WHERE ComponentNumber = '72.20'



SELECT * FROM [dbo].[vgsrpObjLocationsS_RO] WHERE ComponentID = 1
ORDER BY TransDate,ObjLocationID

-------------------------------------------------------------------------------------------------------------

--	USE THIS FOR A SPECIFIC GALLERY/LOCATION


USE TMS

DECLARE
@BeginDate			DATETIME,
@EndDate			DATETIME,
@Site				NVARCHAR(64),
@Room				NVARCHAR(64)

SET	@BeginDate		=	'2017-07-01 00:00'
SET	@EndDate		=	'2018-06-30 23:59'
SET	@Site			=	'BECK BUILDING'
SET	@Room			=	'2%'

/*
SELECT
col.ObjLocationID,
o.ObjectID,
o.ObjectNumber,
os.ObjectStatus,

col.LocationID AS CurrentLocationID,
col.TransDate AS DateIN,
cl.Site AS CurrentSite,
cl.Room AS CurrentRoom,

ISNULL(col.NextObjLocID,999999) AS NextObjLocID,
nol.TransDate AS DateOUT,
nl.Site AS NextSite,
nl.Room AS NextRoom,

CASE	WHEN (col.TransDate	>=	@BeginDate	AND nol.TransDate <=	@EndDate)									THEN 'A' 
		WHEN (col.TransDate	<	@BeginDate	AND col.TransDate >		@BeginDate	AND nol.TransDate <	@EndDate)	THEN 'B' 
		WHEN (col.TransDate	<	@EndDate	AND col.TransDate >		@BeginDate	AND nol.TransDate >	@EndDate)	THEN 'C' 
		WHEN (col.TransDate	<	@BeginDate	AND nol.TransDate >		@EndDate)									THEN 'D'
		ELSE 'Undetermined' END  AS Category
*/
SELECT DISTINCT o.ObjectID

FROM vgsrpObjLocationsS_RO AS col
INNER JOIN ObjComponents AS oc ON col.ComponentID = oc.ComponentID
INNER JOIN Objects AS o ON oc.ObjectID = o.ObjectID
INNER JOIN ObjectStatuses AS os ON o.ObjectStatusID = os.ObjectStatusID
INNER JOIN Locations AS cl ON col.LocationID = cl.LocationID

INNER JOIN vgsrpObjLocationsS_RO AS pol ON col.PrevObjLocID = pol.ObjLocationID
INNER JOIN Locations AS pl ON pol.LocationID = pl.LocationID

INNER JOIN vgsrpObjLocationsS_RO AS nol ON col.NextObjLocID = nol.ObjLocationID
INNER JOIN Locations AS nl ON nol.LocationID = nl.LocationID

WHERE --o.ObjectID = 1
(
	(col.TransDate >=	@BeginDate	AND nol.TransDate <=	@EndDate)
	OR
	(col.TransDate <	@BeginDate	AND col.TransDate >		@BeginDate	AND nol.TransDate <	@EndDate)
	OR
	(col.TransDate <	@EndDate	AND col.TransDate >		@BeginDate	AND nol.TransDate >	@EndDate)
	OR
	(col.TransDate <	@BeginDate	AND nol.TransDate >		@EndDate)
)
AND
(
	(cl.Site = @Site AND cl.Room LIKE @Room)
	--OR
	--(nl.Site = @Site AND nl.Room LIKE @Room)
)
--AND o.ObjectID = 1

--ORDER BY o.SortNumber,col.TransDate,col.ObjLocationID


-----------------------------------------------------------------------------------

-- The following is insufficient because it only pulls objects that were moved
-- to an on-view location during the FY, and does not take into account those
-- already on-view at the beginning of the FY.


SELECT
DISTINCT o.ObjectID, o.ObjectNumber, lp.LocPurpose

FROM ObjLocations AS ol
INNER JOIN ObjComponents AS oc ON ol.ComponentID = oc.ComponentID
INNER JOIN Objects AS o ON oc.ObjectID = o.ObjectID
INNER JOIN Locations AS l ON ol.LocationID = l.LocationID
LEFT OUTER JOIN LocPurposes AS lp ON ol.LocPurposeID = lp.LocPurposeID

WHERE 
(
l.UnitPosition = 'on view' OR
l.UnitType = 'on view' OR
l.UnitNumber = 'on view'
)
AND ol.TransDate BETWEEN '2017-07-01 00:00:00' AND '2018-06-30 23:59:59'



SELECT * FROM Locations AS l
WHERE 
(
l.UnitPosition = 'on view' OR
l.UnitType = 'on view' OR
l.UnitNumber = 'on view'
)
*/


----------------------------------------------------------------------------
/*
-- USE THIS FOR ANYTHING ON VIEW DURING A SPECIFIC TIME PERIOD.


USE TMS

DECLARE
@BeginDate			DATETIME,
@EndDate			DATETIME


SET	@BeginDate		=	'2017-07-01 00:00'
SET	@EndDate		=	'2018-06-30 23:59'



SELECT DISTINCT
o.ObjectID, o.SortNumber, o.ObjectNumber, 
--cl.LocationString, --pl.LocationString, nl.LocationString,
--c.Classification, oct.Culture AS ObjectCulture,
--ocon.c_DisplayName AS ArtistMaker, ocon.c_CultureGroup AS CultureGroup, 
--ct.ConstituentType, ocon.can_AlphaSort,

CASE WHEN ocon.ConstituentTypeID = 1 AND cg.Gender IS NULL THEN 'not recorded' ELSE
CASE WHEN ocon.ConstituentTypeID = 1 AND cg.Gender IS NOT NULL THEN cg.Gender ELSE
CASE WHEN ocon.ConstituentTypeID <> 1 THEN 'N/A' ELSE
'undetermined' END END END AS Gender,

CASE WHEN col.TransDate >=	@BeginDate	AND nol.TransDate <=	@EndDate THEN 1 ELSE 0 END AS t_During,
CASE WHEN (col.TransDate <	@BeginDate	AND col.TransDate >		@BeginDate	AND nol.TransDate <	@EndDate) THEN 1 ELSE 0 END AS T2,
CASE WHEN (col.TransDate <	@EndDate	AND col.TransDate >		@BeginDate	AND nol.TransDate >	@EndDate) THEN 1 ELSE 0 END AS T3,
CASE WHEN (col.TransDate <	@BeginDate	AND nol.TransDate >		@EndDate) THEN 1 ELSE 0 END AS T4

FROM vgsrpObjLocationsS_RO AS col
INNER JOIN ObjComponents AS oc ON col.ComponentID = oc.ComponentID
INNER JOIN Objects AS o ON oc.ObjectID = o.ObjectID
INNER JOIN ObjectStatuses AS os ON o.ObjectStatusID = os.ObjectStatusID
INNER JOIN Classifications AS c ON o.ClassificationID = c.ClassificationID
INNER JOIN ObjContext AS oct ON o.ObjectID = oct.ObjectID
LEFT OUTER JOIN MFAHv_OBJ_Constituent AS ocon ON o.ObjectID = ocon.o_ObjectID
												AND ocon.cx_RoleTypeID = 1 -- Object-related
LEFT OUTER JOIN ConTypes AS ct ON ocon.c_ConstituentTypeID = ct.ConstituentTypeID
LEFT OUTER JOIN MFAHv_CON_Gender AS cg ON ocon.c_ConstituentID = cg.ConstituentID


INNER JOIN Locations AS cl ON col.LocationID = cl.LocationID

INNER JOIN vgsrpObjLocationsS_RO AS pol ON col.PrevObjLocID = pol.ObjLocationID
INNER JOIN Locations AS pl ON pol.LocationID = pl.LocationID

INNER JOIN vgsrpObjLocationsS_RO AS nol ON col.NextObjLocID = nol.ObjLocationID
INNER JOIN Locations AS nl ON nol.LocationID = nl.LocationID

WHERE --o.ObjectID = 1
(
	(col.TransDate >=	@BeginDate	AND nol.TransDate <=	@EndDate)
	OR
	(col.TransDate <	@BeginDate	AND col.TransDate >		@BeginDate	AND nol.TransDate <	@EndDate)
	OR
	(col.TransDate <	@EndDate	AND col.TransDate >		@BeginDate	AND nol.TransDate >	@EndDate)
	OR
	(col.TransDate <	@BeginDate	AND nol.TransDate >		@EndDate)
)
AND
(
cl.UnitPosition = 'on view' OR
cl.UnitType = 'on view' OR
cl.UnitNumber = 'on view'
)

--ORDER BY o.SortNumber, ocon.can_AlphaSort
--ORDER BY ocon.can_AlphaSort

*/
---------------------------------------------------------------------------------------------------------- USE THIS!!! 8/20/2020
-- The above queries didn't work, even the ones I thought that did. :(



USE TMS

DECLARE
@BeginDate			DATETIME,
@EndDate			DATETIME


----- UPDATE THESE FOR THE APPROPRIATE TIME PERIOD	----- 
SET	@BeginDate		=	'2020-07-01 00:00'
SET	@EndDate		=	'2020-10-11 23:59'



SELECT DISTINCT

o.ObjectID, o.SortNumber, CAST(o.ObjectNumber AS VARCHAR(100)) AS ObjectNumber,
cl.LocationString,
c.Classification, oct.Culture AS ObjectCulture,


ocon.c_DisplayName AS ArtistMaker, ocon.c_CultureGroup AS CultureGroup, 
ct.ConstituentType, ocon.can_AlphaSort,
CASE WHEN ocon.ConstituentTypeID = 1 AND cg.Gender IS NULL THEN 'not recorded' ELSE
CASE WHEN ocon.ConstituentTypeID = 1 AND cg.Gender IS NOT NULL THEN cg.Gender ELSE
CASE WHEN ocon.ConstituentTypeID <> 1 THEN 'N/A' ELSE
'undetermined' END END END AS Gender /*,


CASE WHEN (cl.UnitType = 'on view' OR cl.UnitPosition = 'on view')
AND col.Inactive = 0
AND col.TransDate < @EndDate 
AND col.DateOut >= @BeginDate THEN 1 ELSE 0 END AS Exhibited
*/

FROM ObjLocations AS col
LEFT OUTER JOIN ObjComponents AS oc ON col.ComponentID = oc.ComponentID
LEFT OUTER JOIN Objects AS o ON oc.ObjectID = o.ObjectID
LEFT OUTER JOIN ObjectStatuses AS os ON o.ObjectStatusID = os.ObjectStatusID
LEFT OUTER JOIN Classifications AS c ON o.ClassificationID = c.ClassificationID
LEFT OUTER JOIN ObjContext AS oct ON o.ObjectID = oct.ObjectID
LEFT OUTER JOIN Locations AS cl ON col.LocationID = cl.LocationID

LEFT OUTER JOIN MFAHv_OBJ_Constituent AS ocon ON o.ObjectID = ocon.o_ObjectID
												AND ocon.cx_RoleTypeID = 1 -- Object-related
LEFT OUTER JOIN ConTypes AS ct ON ocon.c_ConstituentTypeID = ct.ConstituentTypeID
LEFT OUTER JOIN MFAHv_CON_Gender AS cg ON ocon.c_ConstituentID = cg.ConstituentID

WHERE 
CASE WHEN (cl.UnitType = 'on view' OR cl.UnitPosition = 'on view')
AND col.Inactive = 0
AND col.TransDate < @EndDate 
AND col.DateOut >= @BeginDate THEN 1 ELSE 0 END = 1

AND o.ObjectID IS NOT NULL
--AND o.ObjectID IN (46248,46253,46239)

ORDER BY o.SortNumber, ocon.can_AlphaSort
--ORDER BY ocon.can_AlphaSort

GO


-------------------------------------------------------	10/11/2020 for Beck and Law



USE TMS

DECLARE
@BeginDate			DATETIME,
@EndDate			DATETIME

SET	@BeginDate		=	'2020-07-01 00:00'
SET	@EndDate		=	'2020-10-11 23:59'

SELECT DISTINCT

o.ObjectID, o.SortNumber, CAST(o.ObjectNumber AS VARCHAR(100)) AS ObjectNumber,
cl.LocationString, cl.Site,
c.Classification, oct.Culture AS ObjectCulture/*,


ocon.c_DisplayName AS ArtistMaker, ocon.c_CultureGroup AS CultureGroup, ocon.c_Nationality,
ct.ConstituentType, ocon.can_AlphaSort,
CASE WHEN ocon.ConstituentTypeID = 1 AND cg.Gender IS NULL THEN 'not recorded' ELSE
CASE WHEN ocon.ConstituentTypeID = 1 AND cg.Gender IS NOT NULL THEN cg.Gender ELSE
CASE WHEN ocon.ConstituentTypeID <> 1 THEN 'N/A' ELSE
'undetermined' END END END AS Gender, cl.Site ,


CASE WHEN (cl.UnitType = 'on view' OR cl.UnitPosition = 'on view')
AND col.Inactive = 0
AND col.TransDate < @EndDate 
AND col.DateOut >= @BeginDate THEN 1 ELSE 0 END AS Exhibited
*/

FROM ObjLocations AS col
LEFT OUTER JOIN ObjComponents AS oc ON col.ComponentID = oc.ComponentID
LEFT OUTER JOIN Objects AS o ON oc.ObjectID = o.ObjectID
LEFT OUTER JOIN ObjectStatuses AS os ON o.ObjectStatusID = os.ObjectStatusID
LEFT OUTER JOIN Classifications AS c ON o.ClassificationID = c.ClassificationID
LEFT OUTER JOIN ObjContext AS oct ON o.ObjectID = oct.ObjectID
LEFT OUTER JOIN Locations AS cl ON col.LocationID = cl.LocationID

LEFT OUTER JOIN MFAHv_OBJ_Constituent AS ocon ON o.ObjectID = ocon.o_ObjectID
												AND ocon.cx_RoleTypeID = 1 -- Object-related
LEFT OUTER JOIN ConTypes AS ct ON ocon.c_ConstituentTypeID = ct.ConstituentTypeID
LEFT OUTER JOIN MFAHv_CON_Gender AS cg ON ocon.c_ConstituentID = cg.ConstituentID

WHERE 
CASE WHEN (cl.UnitType = 'on view' OR cl.UnitPosition = 'on view')
AND col.Inactive = 0
AND col.TransDate < @EndDate 
AND col.DateOut >= @BeginDate THEN 1 ELSE 0 END = 1

AND o.ObjectID IS NOT NULL
--AND o.ObjectID IN (46248,46253,46239)

AND o.ObjectID NOT IN 
(
	SELECT eox.ObjectID 
	FROM Exhibitions AS e
	INNER JOIN ExhObjXrefs AS eox ON e.ExhibitionID = eox.ExhibitionID
	WHERE e.EndISODate >= '2020-10-13 00:00:00'	-- 3239
)

AND (cl.Site LIKE '%BECK%')

ORDER BY o.SortNumber
--ORDER BY ocon.can_AlphaSort

GO


----------------------------------------------------------------------- For Kinder...



USE TMS

SELECT DISTINCT

o.ObjectID, o.SortNumber, CAST(o.ObjectNumber AS VARCHAR(100)) AS ObjectNumber,
c.Classification, oct.Culture AS ObjectCulture/*,

ocon.c_DisplayName AS ArtistMaker, ocon.c_CultureGroup AS CultureGroup, 
ct.ConstituentType, ocon.can_AlphaSort,
CASE WHEN ocon.ConstituentTypeID = 1 AND cg.Gender IS NULL THEN 'not recorded' ELSE
CASE WHEN ocon.ConstituentTypeID = 1 AND cg.Gender IS NOT NULL THEN cg.Gender ELSE
CASE WHEN ocon.ConstituentTypeID <> 1 THEN 'N/A' ELSE
'undetermined' END END END AS Gender
*/

FROM ExhObjXrefs AS eox
LEFT OUTER JOIN Objects AS o ON eox.ObjectID = o.ObjectID
LEFT OUTER JOIN ObjectStatuses AS os ON o.ObjectStatusID = os.ObjectStatusID
LEFT OUTER JOIN Classifications AS c ON o.ClassificationID = c.ClassificationID
LEFT OUTER JOIN ObjContext AS oct ON o.ObjectID = oct.ObjectID
LEFT OUTER JOIN MFAHv_OBJ_Constituent AS ocon ON o.ObjectID = ocon.o_ObjectID
												AND ocon.cx_RoleTypeID = 1 -- Object-related
LEFT OUTER JOIN ConTypes AS ct ON ocon.c_ConstituentTypeID = ct.ConstituentTypeID
LEFT OUTER JOIN MFAHv_CON_Gender AS cg ON ocon.c_ConstituentID = cg.ConstituentID

WHERE eox.ExhibitionID IN
	(SELECT ExhibitionID FROM Exhibitions WHERE ExhTitle LIKE 'FY2021:Kinder%')

AND o.ObjectID IS NOT NULL
--AND o.ObjectID IN (46248,46253,46239)

ORDER BY o.SortNumber--, ocon.can_AlphaSort
--ORDER BY ocon.can_AlphaSort

GO



SELECT COUNT(*) FROM ExhObjXrefs WHERE ExhibitionID IN
(SELECT ExhibitionID FROM Exhibitions WHERE ExhTitle LIKE 'FY2021:Kinder%')


SELECT eox.ObjectID 
FROM Exhibitions AS e
INNER JOIN ExhObjXrefs AS eox ON e.ExhibitionID = eox.ExhibitionID
WHERE e.EndISODate >= '2020-10-13 00:00:00'	-- 3239








