



------------------------		BEGIN ROW 488		-------------------------------------------------------	!!!!!



USE [TMS]
GO

/****** Object:  View [dbo].[MFAHv_MediaFile_Metadata]    Script Date: 9/13/2018 11:52:29 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






--ALTER VIEW [dbo].[MFAHv_MediaFile_Metadata] AS

/*

Created		9/12/2018	Dave Thompson
						This returns MediaFile Metadata from the FileProperties table and the Media Metadata tab in TMS.
						I wrote this view separately to speed up retrieval of metadata in Media Studio list views.
						Trying to put this directly into MFAHv_Media slowed the retrieval time.
						Writing it with PIVOT on the FileProperties table sped things up dramatically.

*/

SELECT
MediaMasterID,
RenditionID,
RenditionNumber,
FileID,
Make AS CameraMake,
Model AS CameraModel,
XResolution,
YResolution,
ResolutionUnit

FROM

(
	SELECT DISTINCT
	mm.MediaMasterID,
	mr.RenditionID,
	mr.RenditionNumber,
	fp.FileID,
	fp.PropertyName, --fp.PropertyType,
	fp.PropertyValue

	FROM		MediaMaster		AS mm
	INNER JOIN	MediaRenditions AS mr	ON mm.PrimaryRendID = mr.RenditionID
	INNER JOIN	FileProperties	AS fp	ON mr.PrimaryFileID = fp.FileID			--WHERE fp.FileID = 199012 ORDER BY fp.PropertyType, fp.PropertyName

	WHERE	((PropertyType IN ('IFD0','ExifIFD','Photoshop') AND PropertyName IN ('Model','Make'))
	OR		(PropertyType IN ('ExifIFD','Photoshop','JFIF') AND PropertyName IN ('XResolution','YResolution','ResolutionUnit'))) --AND mm.MediaMasterID IN (247062,240454,240450)--AND mm.MediaMasterID = 260488
)	AS SourceTable
PIVOT
(
	MAX(PropertyValue) FOR PropertyName IN (Make, Model, XResolution, YResolution, ResolutionUnit)
) AS PivotTable



--WHERE MediaMasterID IN (247062,240454,240450)
--= 260488

GO

/*
SELECT * FROM MediaMaster WHERE MediaMasterID = 247062

SELECT * FROM FileProperties 

SELECT * FROM MediaXrefs WHERE ID = 133722 AND TableID = 108
*/








/*


SELECT
mx.MEdiaXrefID,
mx.MediaMasterID,
mm.DisplayRendID,
mm.PrimaryRendID,
mr.RenditionID,
mr.PrimaryFileID,
mr.RenditionNumber,
mf.*


FROM MediaXrefs AS mx
LEFT OUTER JOIN MediaMaster AS mm ON mx.MediaMasterID = mm.MediaMasterID
LEFT OUTER JOIN MediaRenditions AS mr ON mm.MediaMasterID = mr.MediaMasterID
LEFT OUTER JOIN MediaFiles AS mf ON mr.PrimaryFileID = mf.FileID

WHERE mx.ID = 15364 AND TableID = 108


SELECT * FROM FileProperties WHERE FileID IN (179037,185625,179033)
ORDER BY FileID, PropertyType, PropertyName


SELECT * FROM FileProperties WHERE FileID IN (179037,185625,179033)
ORDER BY FileID, PropertyType, PropertyName

*/




SELECT
mx.MediaXrefID,
mx.MediaMasterID,
mx.PrimaryDisplay,
' | ',
mm.DisplayRendID,
mm.PrimaryRendID,
' | ',
mr.RenditionID,
mr.RenditionNumber,
mr.ParentRendID,
mr.PrimaryFileID,
mr.MediaTypeID,
mt.MediaType,
' | ',

mf.*


FROM			MediaXrefs		AS mx
LEFT OUTER JOIN	MediaMaster		AS mm	ON	mx.MediaMasterID = mm.MediaMasterID
LEFT OUTER JOIN	MediaRenditions	AS mr	ON	mm.MediaMasterID = mr.MediaMasterID
LEFT OUTER JOIN	MediaFiles		AS mf	ON	mr.PrimaryFileID = mf.FileID
LEFT OUTER JOIN	MediaTypes		AS mt	ON	mr.MediaTypeID = mt.MediaTypeID

WHERE mr.ParentRendID <> -1							-- 11699

AND mx.ID IN (15364,44214) AND TableID = 108 --OR mr.ParentRendID <> -1



SELECT * FROM MediaRenditions WHERE ParentRendID <> -1		-- 11092

99545



SELECT *
FROM MediaMaster AS mm
LEFT OUTER JOIN MediaRenditions AS mr ON mm.MediaMasterID = mr.MediaMasterID
LEFT OUTER JOIN MediaXrefs AS mx ON mm.MediaMasterID = mx.MediaMasterID
WHERE mx.MediaMasterID IS NULL
AND DATEPART(yyyy,mm.EnteredDate) = 2000



--FROM KAREN

SELECT        
mm.MediaMasterID,
mrc.RenditionID,
mrc.ParentRendID,
mrc.RenditionNumber AS ChildRenditionNumber,
mrp.RenditionNumber AS ParentRenditionNumber

FROM				dbo.MediaRenditions	AS mrc
RIGHT OUTER JOIN	dbo.MediaRenditions	AS mrp	ON mrp.RenditionID = mrc.ParentRendID 
RIGHT OUTER JOIN	dbo.MediaMaster		AS mm	ON mrc.MediaMasterID = mm.MediaMasterID

WHERE        (mrc.ParentRendID <> - 1)		-- 11092


-----------------------------------------------------------------------------------------------------------

--	How many renditions are there?
SELECT
COUNT(*)
FROM MediaRenditions AS mr			--	251,438 rendition records


--	How many renditions have parent renditions and how many do not?
SELECT
COUNT(*)
FROM MediaRenditions AS mr			--	251,438 rendition records
--WHERE mr.ParentRendID = -1		--	 11,092	have Parent rendition
WHERE mr.ParentRendID <> -1			--	 11,092	have Parent rendition

--	Of those renditions that do have parents, how many are images?
SELECT
mr.RenditionID,
mr.ParentRendID,
mr.MediaTypeID
FROM MediaRenditions AS mr
WHERE mr.ParentRendID <> -1	
--AND mr.MediaTypeID <> 1			--	   506
AND mr.MediaTypeID = 1				--	10,586
									--	------		
									--	11,092	TOTAL


--	How many MediaXrefs are associated with renditions that have parents?
SELECT
mr.RenditionID,
mr.RenditionNumber,
mx.ID,
mx.TableID
FROM MediaRenditions AS mr
LEFT OUTER JOIN MediaXrefs AS mx ON mr.MediaMasterID = mx.MediaMasterID
WHERE mr.ParentRendID <> -1

--	11,092 record retrieved
--	12,067 MediaXrefs


--	Of renditions that have parents, how many have more than one MediaXref?
SELECT
mr.RenditionID,
COUNT(*) AS Xrefs
FROM MediaRenditions AS mr
LEFT OUTER JOIN MediaXrefs AS mx ON mr.MediaMasterID = mx.MediaMasterID
WHERE mr.ParentRendID <> -1
GROUP BY mr.RenditionID
HAVING COUNT(*) <> 1			-- 660

--	11,092 record retrieved
--	12,067 MediaXrefs


--	What tables are the MediaXrefs associated with?
SELECT
mx.TableID,
COUNT(*) AS Xrefs
FROM MediaRenditions AS mr
LEFT OUTER JOIN MediaXrefs AS mx ON mr.MediaMasterID = mx.MediaMasterID
WHERE mr.ParentRendID <> -1
GROUP BY 
mx.TableID

/*

TableID	Xrefs
  23	   16	Constituents
  89	    1	ObjAccession
  81	  261	Loans
  47	   17	Exhibitions
NULL	  368
 108	11390	Objects
  97	   14	CondLineItems

*/


SELECT
mr.RenditionID,
mr.ParentRendID
FROM MediaRenditions AS mr
WHERE mr.ParentRendID <> -1


SELECT * FROM MediaMaster AS mm


SELECT 
mm.MediaMasterID,
mm.DisplayRendID,
mm.PrimaryRendID,
mr.RenditionID,
mr.RenditionNumber,
mr.ParentRendID

FROM MediaMaster AS mm
LEFT OUTER JOIN MediaRenditions AS mr ON mm.MediaMasterID = mr.MediaMasterID

WHERE mm.MediaMasterID = 23949

ORDER BY mm.MediaMasterID,mr.RenditionID

/*
MediaMasterID	DisplayRendID	PrimaryRendID	RenditionID	RenditionNumber	ParentRendID
23949			33615			33614			33614		526-86a			-1
23949			33615			33614			33615		526-86a-A		33614
*/

--UPDATE MediaMaster SET PrimaryRendID = 33615 WHERE MediaMasterID = 23949							Reset the Primary Rendition ID

/*
MediaMasterID	DisplayRendID	PrimaryRendID	RenditionID	RenditionNumber	ParentRendID
23949			33615			33615			33614		526-86a			-1
23949			33615			33615			33615		526-86a-A		33614
*/

--UPDATE MediaRenditions SET ParentRendID = -1 WHERE RenditionID = 33615							Remove the link to the former Parent Rendition

/*
MediaMasterID	DisplayRendID	PrimaryRendID	RenditionID	RenditionNumber	ParentRendID
23949			33615			33615			33614		526-86a			-1
23949			33615			33615			33615		526-86a-A		-1
*/

--DELETE FROM MediaRenditions WHERE RenditionID = 33614

/*
MediaMasterID	DisplayRendID	PrimaryRendID	RenditionID	RenditionNumber	ParentRendID			Delete the former Parent Rendition
23949			33615			33615			33615		526-86a-A		-1
*/

---------------------------------------------------------------------------------------------------------------------------------------------------


SELECT 
mm.MediaMasterID,
mm.DisplayRendID,
mm.PrimaryRendID,
mr.RenditionID,
mr.RenditionNumber,
mr.ParentRendID

FROM MediaMaster AS mm
LEFT OUTER JOIN MediaRenditions AS mr ON mm.MediaMasterID = mr.MediaMasterID

WHERE mm.MediaMasterID = 57

ORDER BY mm.MediaMasterID,mr.RenditionID

/*

MediaMasterID	DisplayRendID	PrimaryRendID	RenditionID	RenditionNumber	ParentRendID				Starting State
57				95				94				94			31-103			-1
57				95				94				95			31-103-A		94

*/

--UPDATE
--SELECT * FROM 
MediaMaster 
SET PrimaryRendID = DisplayRendID 
WHERE PrimaryRendID <> DisplayRendID AND MediaMasterID = 57

/*

MediaMasterID	DisplayRendID	PrimaryRendID	RenditionID	RenditionNumber	ParentRendID				AFter resetting PrimaryRendID
57				95				95				94			31-103			-1
57				95				95				95			31-103-A		94

*/

--UPDATE MediaRenditions SET ParentRendID = -1 WHERE MediaMasterID = 57

/*
MediaMasterID	DisplayRendID	PrimaryRendID	RenditionID	RenditionNumber	ParentRendID
57				95				95				94			31-103			-1
57				95				95				95			31-103-A		-1
*/


--DELETE FROM MediaRenditions WHERE RenditionID = 94 AND MediaMasterID = 57								Delete the bad rendition record

---------	!!!!!!!!	The problem with the above is that my last statement, the delete statement, assumes
---------				that I know the RenditionID to delete. I do in these cases because I'm working with
---------				a single record, but I can't do that in a big recordset.									!!!!!!!!!!!!




----	Try again. :(			I think this works!

SELECT 
mm.MediaMasterID,
mm.DisplayRendID,
mm.PrimaryRendID,
' |' AS [  |],
mr.RenditionID,
mr.RenditionNumber,
mr.ParentRendID

FROM MediaMaster AS mm
LEFT OUTER JOIN MediaRenditions AS mr ON mm.MediaMasterID = mr.MediaMasterID

WHERE mm.MediaMasterID = 14838

ORDER BY mm.MediaMasterID,mr.RenditionID

/*

MediaMasterID	DisplayRendID	PrimaryRendID	|	RenditionID	RenditionNumber	ParentRendID
14838			20421			20420			|	20420		2001-18			-1
14838			20421			20420			|	20421		2001-18-A		20420

*/


-- First, update the MediaMaster record to use the correct PrimaryRendID

--UPDATE MediaMaster
SET PrimaryRendID = DisplayRendID
--SELECT mm.MediaMasterID, mm.DisplayRendID, mm.PrimaryRendID, mr.ParentRendID
FROM MediaMaster AS mm
INNER JOIN MediaRenditions AS mr ON mm. MediaMasterID = mr.MediaMasterID
WHERE mm.PrimaryRendID <> mm.DisplayRendID
AND mr.ParentRendID <> -1
AND mm.MediaMasterID = 14838

/*
MediaMasterID	DisplayRendID	PrimaryRendID	|	RenditionID	RenditionNumber	ParentRendID
14838			20421			20421			|	20420		2001-18			-1
14838			20421			20421			|	20421		2001-18-A		20420
*/


/*
-- I don't know what I was thinking here....
SELECT 
mm.MediaMasterID,
mm.DisplayRendID,
mm.PrimaryRendID,
' |'				AS [  |],
mrp.RenditionID		AS ParentRendID,
mrp.RenditionNumber	AS ParentRendNumber,
mrp.ParentRendID	AS ParentParentRendID,
' |'				AS [  |],
mrc.RenditionID		AS ChildRendID,
mrc.RenditionNumber	AS ChildRendNumber,
mrc.ParentRendID	AS ChildParentRendID

FROM MediaMaster AS mm
INNER JOIN MediaRenditions AS mrp ON mm.MediaMasterID = mrp.MediaMasterID AND mrp.ParentRendID = -1
INNER JOIN MediaRenditions AS mrc ON mrp.RenditionID = mrc.ParentRendID

WHERE mm.MediaMasterID = 14838

ORDER BY mm.MediaMasterID,mrp.RenditionID
*/



-- Second, unlink the child rendition from the parent rendition

--UPDATE MediaRenditions
SET ParentRendID = -1
--SELECT mm.MediaMasterID, mm.DisplayRendID, mm.PrimaryRendID, mr.RenditionID, mr.ParentRendID, mr.RenditionNumber
FROM MediaRenditions AS mr
INNER JOIN MediaMaster AS mm ON mr.MediaMasterID = mm.MediaMasterID
WHERE mr.RenditionID = mm.PrimaryRendID
AND mr.ParentRendID <> -1
AND mm.MediaMasterID = 14838


/*

MediaMasterID	DisplayRendID	PrimaryRendID	 |	RenditionID	RenditionNumber	ParentRendID
14838			20421			20421			 |	20420		2001-18			-1
14838			20421			20421			 |	20421		2001-18-A		-1

*/

-- Third, delete the empty rendition record

--DELETE FROM MediaRenditions FROM MediaRenditions AS mr
--SELECT mr.RenditionID, mr.RenditionNumber FROM MediaRenditions AS mr
INNER JOIN MediaMaster AS mm ON mm.MediaMasterID = mr.MediaMasterID
LEFT OUTER JOIN MediaFiles AS mf ON mr.RenditionID = mf.RenditionID
WHERE mf.RenditionID IS NULL
AND mm.MediaMasterID = 14838

/*

MediaMasterID	DisplayRendID	PrimaryRendID	|	RenditionID	RenditionNumber	ParentRendID
14838			20421			20421			|	20421		2001-18-A		-1

*/

-------------------------------------------------------------------------------------------------------------	!!!!!!
--											HERE ARE THE UPDATE SCRIPTS
-------------------------------------------------------------------------------------------------------------	!!!!!!

-- First, update the MediaMaster record to use the correct PrimaryRendID

--UPDATE MediaMaster
SET PrimaryRendID = DisplayRendID
--SELECT mm.MediaMasterID, mm.DisplayRendID, mm.PrimaryRendID, mr.ParentRendID
FROM MediaMaster AS mm
INNER JOIN MediaRenditions AS mr ON mm. MediaMasterID = mr.MediaMasterID
WHERE mm.PrimaryRendID <> mm.DisplayRendID
AND mr.ParentRendID <> -1
AND mm.MediaMasterID IN --(25242)
(
	SELECT
	mm.MediaMasterID
	FROM MediaMaster AS mm
	INNER JOIN MediaRenditions AS mr ON mm.MediaMasterID = mr.MediaMasterID
	WHERE mr.ParentRendID <> -1
	--ORDER BY mm.MediaMasterID
)



-- Second, unlink the child rendition from the parent rendition

--UPDATE MediaRenditions
SET ParentRendID = -1
--SELECT mm.MediaMasterID, mm.DisplayRendID, mm.PrimaryRendID, mr.RenditionID, mr.ParentRendID, mr.RenditionNumber
FROM MediaRenditions AS mr
INNER JOIN MediaMaster AS mm ON mr.MediaMasterID = mm.MediaMasterID
WHERE mr.RenditionID = mm.PrimaryRendID
AND mr.ParentRendID <> -1
AND mm.MediaMasterID IN --(25242)
(
	SELECT
	mm.MediaMasterID
	FROM MediaMaster AS mm
	INNER JOIN MediaRenditions AS mr ON mm.MediaMasterID = mr.MediaMasterID
	WHERE mr.ParentRendID <> -1
	--ORDER BY mm.MediaMasterID
)



-- Third, delete the empty rendition record

--DELETE FROM MediaRenditions FROM MediaRenditions AS mr
--SELECT mr.RenditionID, mr.RenditionNumber FROM MediaRenditions AS mr
INNER JOIN MediaMaster AS mm ON mm.MediaMasterID = mr.MediaMasterID
LEFT OUTER JOIN MediaFiles AS mf ON mr.RenditionID = mf.RenditionID
WHERE mf.RenditionID IS NULL
AND mm.MediaMasterID IN --(25242)
(
	SELECT
	mm.MediaMasterID
	FROM MediaMaster AS mm
	INNER JOIN MediaRenditions AS mr ON mm.MediaMasterID = mr.MediaMasterID
	WHERE mr.ParentRendID <> -1
	--ORDER BY mm.MediaMasterID
)


----------------------------------------------------------------------------------------------------- END

SELECT 
*

FROM MediaMaster AS mm
LEFT OUTER JOIN MediaRenditions AS mr ON mm.MediaMasterID = mr.MediaMasterID
LEFT OUTER JOIN MediaFiles AS mf ON mr.RenditionID = mf.RenditionID

WHERE mm.MediaMasterID IN 
(
	SELECT
	mm.MediaMasterID
	FROM MediaMaster AS mm
	INNER JOIN MediaRenditions AS mr ON mm.MediaMasterID = mr.MediaMasterID
	WHERE mr.ParentRendID <> -1
)




SELECT 
mm.MediaMasterID,
mr.RenditionNumber,
COUNT(*) AS Links

FROM MediaMaster AS mm
LEFT OUTER JOIN MediaRenditions AS mr ON mm.MediaMasterID = mr.MediaMasterID
LEFT OUTER JOIN MediaFiles AS mf ON mr.RenditionID = mf.RenditionID

WHERE mm.MediaMasterID IN 
(
	SELECT
	mm.MediaMasterID
	FROM MediaMaster AS mm
	INNER JOIN MediaRenditions AS mr ON mm.MediaMasterID = mr.MediaMasterID
	WHERE mr.ParentRendID <> -1
)

GROUP BY
mm.MediaMasterID,
mr.RenditionNumber

HAVING COUNT(*) > 1


SELECT *
FROM MediaMaster AS mm
LEFT OUTER JOIN MediaRenditions AS mr ON mm.MediaMasterID = mr.MediaMasterID
LEFT OUTER JOIN MediaFiles AS mf ON mr.RenditionID = mf.RenditionID
WHERE mm.MediaMasterID = 25242