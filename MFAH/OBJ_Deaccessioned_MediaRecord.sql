






SELECT DISTINCT
o.ObjectID,o.ObjectNumber
FROM Objects AS o 
WHERE o.ObjectStatusID = 3			-- 6695 deaccessioned records



SELECT DISTINCT
o.ObjectID,o.ObjectNumber
FROM Objects AS o 
INNER JOIN MediaXrefs AS mx ON o.ObjectID = mx.ID AND TableID = 108		-- 5296 have media records
WHERE o.ObjectStatusID = 3												-- 6695 deaccessioned records
AND mx.MediaMasterID = 60074											-- 3911 have the deaccessioned image





SELECT DISTINCT
o.ObjectID,o.ObjectNumber
FROM Objects AS o 
INNER JOIN MediaXrefs AS mx ON o.ObjectID = mx.ID AND TableID = 108		-- 5296 have media records
WHERE o.ObjectStatusID <> 3												-- 93671 other than deaccessioned records
AND mx.MediaMasterID = 60074											-- 59 have the deaccessioned image


SELECT o.ObjectNumber, mx.* FROM MediaXrefs AS mx INNER JOIN Objects AS o ON mx.ID = o.ObjectID AND mx.TableID = 108
WHERE TableID = 108
AND ID IN
(
	SELECT DISTINCT
	o.ObjectID--,o.ObjectNumber
	FROM Objects AS o 
	INNER JOIN MediaXrefs AS mx ON o.ObjectID = mx.ID AND TableID = 108		-- 5296 have media records
	WHERE o.ObjectStatusID <> 3												-- 93671 other than deaccessioned records
	AND mx.MediaMasterID = 60074											-- 59 have the deaccessioned image
)
AND MediaMasterID = 60074													-- a couple deaccessioned images are primary (1 is the only media)
																			-- DELETE the deaccessioned image from these records!




--DELETE FROM MediaXrefs WHERE MediaXrefID IN
--SELECT o.ObjectNumber, mx.* FROM MediaXrefs AS mx INNER JOIN Objects AS o ON mx.ID = o.ObjectID AND mx.TableID = 108
(
	SELECT mx.MediaXrefID FROM MediaXrefs AS mx INNER JOIN Objects AS o ON mx.ID = o.ObjectID AND mx.TableID = 108
	WHERE TableID = 108
	AND ID IN
	(
		SELECT DISTINCT
		o.ObjectID--,o.ObjectNumber
		FROM Objects AS o 
		INNER JOIN MediaXrefs AS mx ON o.ObjectID = mx.ID AND TableID = 108		-- 5296 have media records
		WHERE o.ObjectStatusID <> 3												-- 93671 other than deaccessioned records
		AND mx.MediaMasterID = 60074											-- 60 have the deaccessioned image
	)
	AND MediaMasterID = 60074													-- a couple deaccessioned images are primary (1 is the only media)
																				-- DELETED the deaccessioned image from these records!
)
--	(60 row(s) affected)


----------------------------------------------------------------------------------------------------






SELECT mm.* FROM MediaMaster AS mm WHERE mm.MediaMasterID = 60074
MediaMasterID	DisplayRendID	PrimaryRendID
60074			71313			71313



-- Deaccessioned media image

SELECT * FROM MediaXrefs AS mx WHERE MediaMasterID = 60074 AND TableID = 108		--	3911 deaccessioned objects have the deaccessioned image.


-- Deaccessioned objects that do not have the Deaccessioned image -- 2784

SELECT
o.ObjectID,
o.ObjectNumber
FROM Objects AS o 
WHERE o.ObjectStatusID = 3		-- Deaccessioned objects
AND o.ObjectID NOT IN
(
	SELECT ID FROM MediaXrefs AS mx WHERE MediaMasterID = 60074 AND TableID = 108	-- 2784 deacc objects do not have deacc image
)
																					-- 6695 deaccessioned objects total

																	-- 1385






SELECT o.ObjectID, o.ObjectNumber FROM Objects AS o
WHERE o.ObjectID IN
(
	SELECT DISTINCT mx.ID FROM MediaXrefs AS mx WHERE mx.MediaMasterID = 60074 AND mx.TableID = 108 GROUP BY mx.ID HAVING SUM(mx.PrimaryDisplay) = 0 
)

-- This means that some objects have a deaccessioned image, but that image is not the primary.



SELECT DISTINCT ID FROM MediaXrefs AS mx WHERE MediaMasterID = 60074 AND TableID = 108	-- 3911 objects have deaccessioned images
SELECT DISTINCT o.ObjectID, o.ObjectNumber FROM Objects AS o WHERE o.ObjectStatusID = 3	-- 6695 objects are deaccessioned















--	Deaccessioned object, Has Media

SELECT DISTINCT
o.ObjectID, o.ObjectNumber
FROM Objects AS o
INNER JOIN MediaXrefs AS mx ON o.ObjectID = mx.ID AND mx.TableID = 108
WHERE o.ObjectStatusID = 3																-- 5665 deaccessioned objects have media records
																						-- uncheck the primaries for all these records

--	Deaccessioned object, Has NO Media

SELECT DISTINCT
o.ObjectID, o.ObjectNumber
FROM Objects AS o
LEFT OUTER JOIN MediaXrefs AS mx ON o.ObjectID = mx.ID AND mx.TableID = 108
WHERE o.ObjectStatusID = 3
AND mx.ID IS NULL																		-- 1033 deaccessioned objects do not have any media
																						-- link the deaccessioned image to all of these

--	Deaccessioned object, Has Media, No Deaccessioned Image

SELECT DISTINCT
o.ObjectID, o.ObjectNumber
FROM Objects AS o
INNER JOIN MediaXrefs AS mx ON o.ObjectID = mx.ID AND mx.TableID = 108
WHERE o.ObjectStatusID = 3																-- 5296 deaccessioned objects have media records
AND o.ObjectID NOT IN
(
SELECT DISTINCT ID FROM MediaXrefs AS mx WHERE MediaMasterID = 60074 AND TableID = 108	-- 3911 objects have deaccessioned images
)
																						-- 1329 do not have deaccessioned images

--	Deaccessioned object, Has Media, Has Deaccessioned Image

SELECT DISTINCT
o.ObjectID,o.ObjectNumber
FROM Objects AS o 
INNER JOIN MediaXrefs AS mx ON o.ObjectID = mx.ID AND TableID = 108		-- 5296 have media records
WHERE o.ObjectStatusID = 3												-- 6695 deaccessioned records
AND mx.MediaMasterID = 60074											-- 4336 have the deaccessioned image



-- Deaccessioned object, Has Media, Has Deaccessioned Image, Is Primary


SELECT DISTINCT
o.ObjectID, PrimaryDisplay--,o.ObjectNumber
FROM Objects AS o 
INNER JOIN MediaXrefs AS mx ON o.ObjectID = mx.ID AND TableID = 108		-- 5296 have media records
WHERE o.ObjectStatusID = 3												-- 6695 deaccessioned records
AND mx.MediaMasterID = 60074											-- 3911 have the deaccessioned image
AND PrimaryDisplay = 1													-- 4203 deaccessioned image is primary




-- Deaccessioned object, Has Media, Has Deaccessioned Image, Is NOT Primary

SELECT DISTINCT
o.ObjectID, PrimaryDisplay--,o.ObjectNumber
FROM Objects AS o 
INNER JOIN MediaXrefs AS mx ON o.ObjectID = mx.ID AND TableID = 108		-- 5296 have media records
WHERE o.ObjectStatusID = 3												-- 6695 deaccessioned records
AND mx.MediaMasterID = 60074											-- 3911 have the deaccessioned image
AND PrimaryDisplay = 0													-- 133 deaccessioned is NOT primary


-- Need to find the primary non-deaccessioned image MediaXrefs and uncheck PrimaryDisplay

--UPDATE MediaXrefs
SET PrimaryDisplay = 0 -- SELECT * 
FROM MediaXrefs AS mx
INNER JOIN
(
	SELECT DISTINCT
	ID,MediaMasterID,PrimaryDisplay,MediaXrefID
	FROM MediaXrefs WHERE ID IN
	(
		SELECT DISTINCT
		o.ObjectID---, PrimaryDisplay--,o.ObjectNumber
		FROM Objects AS o 
		INNER JOIN MediaXrefs AS mx ON o.ObjectID = mx.ID AND TableID = 108		-- 5296 have media records
		WHERE o.ObjectStatusID = 3												-- 6695 deaccessioned records
		AND mx.MediaMasterID = 60074											-- 3911 have the deaccessioned image
		AND PrimaryDisplay = 0													-- 133 deaccessioned image is NOT primary
	)
	AND TableID = 108
	AND MediaMasterID <> 60074
	AND PrimaryDisplay = 1
) AS sq ON mx.MediaXrefID = sq.MediaXrefID	-- (133 row(s) affected)



-- Then check the deaccessioned image as PrimaryDisplay

--UPDATE MediaXrefs
SET PrimaryDisplay = 1
FROM MediaXrefs AS mx
INNER JOIN
(
	SELECT DISTINCT
	o.ObjectID, MediaMasterID, MediaXrefID, PrimaryDisplay--,o.ObjectNumber
	FROM Objects AS o 
	INNER JOIN MediaXrefs AS mx ON o.ObjectID = mx.ID AND TableID = 108		-- 5296 have media records
	WHERE o.ObjectStatusID = 3												-- 6695 deaccessioned records
	AND mx.MediaMasterID = 60074											-- 3911 have the deaccessioned image
	AND PrimaryDisplay = 0													-- 133 deaccessioned image is NOT primary
) AS sq ON mx.MediaXrefID = sq.MediaXrefID	-- (146 row(s) affected)








--------------------------------------------------------------------------



--	Uncheck the non-deaccession image primary display

SELECT * FROM MediaXrefs WHERE ID IN
(
	SELECT DISTINCT
	o.ObjectID--,o.ObjectNumber
	FROM Objects AS o 
	WHERE o.ObjectStatusID = 3																	-- 6695 deaccessioned objects
	AND o.ObjectID NOT IN
	(
		SELECT DISTINCT ID FROM MediaXrefs AS mx WHERE MediaMasterID = 60074 AND TableID = 108	-- 3911
	)
)	
AND TableID = 108
AND PrimaryDisplay = 1																			-- 1385


--UPDATE MediaXrefs 
SET PrimaryDisplay = 0	-- SELECT *
FROM MediaXrefs AS mx
INNER JOIN
(
SELECT * FROM MediaXrefs WHERE ID IN
(
	SELECT DISTINCT
	o.ObjectID--,o.ObjectNumber
	FROM Objects AS o 
	WHERE o.ObjectStatusID = 3																	-- 6695 deaccessioned objects
	AND o.ObjectID NOT IN
	(
		SELECT DISTINCT ID FROM MediaXrefs AS mx WHERE MediaMasterID = 60074 AND TableID = 108	-- 3911
	)
)	
AND TableID = 108
AND PrimaryDisplay = 1																			-- 1329
) AS sq ON mx.MediaXrefID = sq.MediaXrefID		--(1329 row(s) affected)



--	Then insert the new MediaXref and check it as primary display


--INSERT INTO MediaXrefs (MediaMasterID,ID,TableID,Rank,PrimaryDisplay,LoginID,EnteredDate)
SELECT DISTINCT
60074,			--	MediaMasterID
o.ObjectID,		--	ID
108,			--	TableID
0,				--	Rank
1,				--	PrimaryDisplay
'dthompson',	--	LoginID
GETDATE()		--	EnteredDate
FROM Objects AS o 
WHERE o.ObjectStatusID = 3
AND o.ObjectID NOT IN
(
	SELECT DISTINCT ID FROM MediaXrefs AS mx WHERE MediaMasterID = 60074 AND TableID = 108
)
-- (2362 row(s) affected)