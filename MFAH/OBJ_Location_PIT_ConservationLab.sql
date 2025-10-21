SELECT o.ObjectNumber, sq.* FROM
(
	SELECT
	ObjectID,ComponentID,ComponentNumber,Date,TransType,TransStatus,Site,Room,UnitType,
	RANK()OVER(PARTITION BY ObjectID ORDER BY Date DESC) AS RankByDate
	FROM MFAHv_OBJ_LocationHistory
	--WHERE ObjectID = 82991
	WHERE DATE >= '2016-07-01'
	--AND ComponentNumber LIKE '2017.19.%'
)
AS sq
INNER JOIN Objects AS o ON sq.ObjectID = o.ObjectID

WHERE Site = 'BECK BUILDING'
AND Room = 'CONSERVATION LAB'
--AND RankByDate = 1

ORDER BY o.SortNumber


--SELECT * FROM Locations WHERE Room = 'CONSERVATION LAB'



SELECT
ObjectID,ComponentID,ComponentNumber,Date,TransType,TransStatus,Site,Room,UnitType
FROM MFAHv_OBJ_LocationHistory
WHERE Site = 'BECK BUILDING' AND Room = 'CONSERVATION LAB'
AND Date >= '2016-07-01'




SELECT
ObjectID,ComponentID,ComponentNumber,Date,TransType,TransStatus,Site,Room,UnitType
FROM MFAHv_OBJ_LocationHistory
WHERE ComponentNumber = 'TR:270-2017'





-- Everything ever in CONSERVATION LAB -- 15773

SELECT
ObjectID,ComponentID,ComponentNumber,Date,TransType,TransStatus,Site,Room,UnitType
FROM MFAHv_OBJ_LocationHistory
WHERE Site = 'BECK BUILDING' AND Room = 'CONSERVATION LAB'



SELECT
ObjectID,ComponentID,ComponentNumber,Date,TransType,TransStatus,Site,Room,UnitType,
RANK()OVER(PARTITION BY ObjectID ORDER BY Date DESC) AS RankByDate
FROM MFAHv_OBJ_LocationHistory

WHERE ObjectID IN
(
	SELECT
	ObjectID--,ComponentID,ComponentNumber,Date,TransType,TransStatus,Site,Room,UnitType
	FROM MFAHv_OBJ_LocationHistory
	WHERE Site = 'BECK BUILDING' AND Room = 'CONSERVATION LAB'
)

AND Date >= '2016-07-01' 


SELECT * FROM
(
	SELECT
	ObjectID,ComponentID,ComponentNumber,Date,TransType,TransStatus,Site,Room,UnitType,
	RANK()OVER(PARTITION BY ObjectID ORDER BY Date DESC) AS RankByDate
	FROM MFAHv_OBJ_LocationHistory

	WHERE ObjectID IN
	(
		SELECT
		ObjectID--,ComponentID,ComponentNumber,Date,TransType,TransStatus,Site,Room,UnitType
		FROM MFAHv_OBJ_LocationHistory
		WHERE Site = 'BECK BUILDING' AND Room = 'CONSERVATION LAB'
	)
) AS oq

WHERE RankByDate = 1
AND Site = 'BECK BUILDING' AND Room = 'CONSERVATION LAB'



----------------------------------------I think this is it.--------------All objects that were in Conservation Lab at some point during FY 2017


SELECT DISTINCT q.ObjectID, q.ObjectNumber, o.SortNumber, o.Classification, o.ArtistName, o.TitleFirstActiveDisplayed, o.Dated, 
REPLACE(REPLACE(REPLACE(o.Medium,CHAR(10),''),CHAR(09),''),CHAR(13),'') AS Medium
FROM
(
	SELECT
	o.ObjectID, o.ObjectNumber, olh.Date, olh.Site, olh.Room,
	RANK()OVER(PARTITION BY olh.ObjectID ORDER BY Date DESC) AS RankByDate
	FROM MFAHv_OBJ_LocationHistory AS olh
	INNER JOIN Objects AS o ON olh.ObjectID = o.ObjectID
	WHERE olh.ObjectID IN
	(
		SELECT
		ObjectID--,ComponentID,ComponentNumber,Date,TransType,TransStatus,Site,Room,UnitType
		FROM MFAHv_OBJ_LocationHistory
		WHERE Site = 'BECK BUILDING' AND Room = 'CONSERVATION LAB'		-- objects ever in CONSERVATION LAB
	)
	AND Date >= '2016-07-01'											-- object moved into CONSERVATION LAB FY2017					

	UNION

	SELECT * FROM
	(
		SELECT
		o.ObjectID, o.ObjectNumber, olh.Date, olh.Site, olh.Room,
		RANK()OVER(PARTITION BY olh.ObjectID ORDER BY Date DESC) AS RankByDate
		FROM MFAHv_OBJ_LocationHistory AS olh
		INNER JOIN Objects AS o ON olh.ObjectID = o.ObjectID
		WHERE olh.ObjectID IN
		(
			SELECT
			ObjectID--,ComponentID,ComponentNumber,Date,TransType,TransStatus,Site,Room,UnitType
			FROM MFAHv_OBJ_LocationHistory
			WHERE Site = 'BECK BUILDING' AND Room = 'CONSERVATION LAB'		-- objects ever in CONSERVATION LAB
		)
	) AS oq
	WHERE oq.RankByDate = 1													-- and still there
	AND oq.Site = 'BECK BUILDING' AND oq.Room = 'CONSERVATION LAB'

	UNION

	SELECT
	ol.ObjectID, ol.AccessionNumber AS ObjectNumber,ol.TransDate AS Date, CurSite AS Site,CurRoom AS Room,
	RANK()OVER(PARTITION BY ol.ObjectID ORDER BY TransDate DESC) AS RankByDate
	FROM MFAHv_OBJ_Location AS ol 
	INNER JOIN Objects AS o ON ol.ObjectID = o.ObjectID
	INNER JOIN Classifications AS c ON o.ClassificationID = c.ClassificationID
	WHERE CurSite = 'BECK BUILDING' AND CurRoom = 'CONSERVATION LAB'		-- objects currently in CONSERVATION LAB

	
) AS q
INNER JOIN MFAHv_OBJ_Tombstone2 AS o ON q.ObjectID = o.ObjectID
ORDER BY o.SortNumber



-----------------------------------------------------------------------------------------------


SELECT DISTINCT q.ObjectID, q.ObjectNumber, o.SortNumber, o.Classification, o.ArtistName, o.TitleFirstActiveDisplayed, o.Dated, 
REPLACE(REPLACE(REPLACE(o.Medium,CHAR(10),''),CHAR(09),''),CHAR(13),'') AS Medium
FROM
(
	SELECT
	o.ObjectID, o.ObjectNumber, olh.Date, olh.Site, olh.Room,
	RANK()OVER(PARTITION BY olh.ObjectID ORDER BY Date DESC) AS RankByDate
	FROM MFAHv_OBJ_LocationHistory AS olh
	INNER JOIN Objects AS o ON olh.ObjectID = o.ObjectID
	WHERE olh.ObjectID IN
	(
		SELECT
		ObjectID--,ComponentID,ComponentNumber,Date,TransType,TransStatus,Site,Room,UnitType
		FROM MFAHv_OBJ_LocationHistory
		WHERE Site = 'BECK BUILDING' AND Room LIKE '2%'					-- objects ever in BECK 2nd FLOOR GALLERIES
	)
	AND Date >= '2016-07-01'											-- object moved into BECK 2nd FLOOR GALLERIES FY2017					

	UNION

	SELECT * FROM
	(
		SELECT
		o.ObjectID, o.ObjectNumber, olh.Date, olh.Site, olh.Room,
		RANK()OVER(PARTITION BY olh.ObjectID ORDER BY Date DESC) AS RankByDate
		FROM MFAHv_OBJ_LocationHistory AS olh
		INNER JOIN Objects AS o ON olh.ObjectID = o.ObjectID
		WHERE olh.ObjectID IN
		(
			SELECT
			ObjectID--,ComponentID,ComponentNumber,Date,TransType,TransStatus,Site,Room,UnitType
			FROM MFAHv_OBJ_LocationHistory
			WHERE Site = 'BECK BUILDING' AND Room LIKE '2%'				-- objects ever in BECK 2nd FLOOR GALLERIES
		)
	) AS oq
	WHERE oq.RankByDate = 1												-- and still there
	AND oq.Site = 'BECK BUILDING' AND oq.Room LIKE '2%'

	UNION

	SELECT
	ol.ObjectID, ol.AccessionNumber AS ObjectNumber,ol.TransDate AS Date, CurSite AS Site,CurRoom AS Room,
	RANK()OVER(PARTITION BY ol.ObjectID ORDER BY TransDate DESC) AS RankByDate
	FROM MFAHv_OBJ_Location AS ol 
	INNER JOIN Objects AS o ON ol.ObjectID = o.ObjectID
	INNER JOIN Classifications AS c ON o.ClassificationID = c.ClassificationID
	WHERE CurSite = 'BECK BUILDING' AND CurRoom LIKE '2%'					-- objects currently in BECK 2nd FLOOR GALLERIES

	
) AS q
INNER JOIN MFAHv_OBJ_Tombstone2 AS o ON q.ObjectID = o.ObjectID
ORDER BY o.SortNumber

