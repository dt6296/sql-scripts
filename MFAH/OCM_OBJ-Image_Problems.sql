



SELECT COUNT(*) FROM MFAHv_OBJ	--92850
SELECT COUNT(*) FROM Objects	--120289
		

SELECT
ObjectID, ObjectNumber, COUNT(*) AS ObjectCount
FROM MFAHv_OBJ
GROUP BY ObjectID, ObjectNumber, SortNumber
HAVING COUNT(*) > 1
ORDER BY SortNumber

ObjectID	ObjectNumber		ObjectCount
116162		ex.2012.wp.170test	2
86591		2008.436			2
69634		CM#859				2
103			B.59.51.55			2




-- 1. run this 

SELECT ObjectID, ObjectNumber, MediaMasterID, MediaXrefID, PrimaryDisplay, RenditionID, ThumbBLOB, ObjectStatus, CuratorApproved
FROM MFAHv_OBJ WHERE ObjectID IN
(
SELECT
ObjectID--, ObjectNumber, COUNT(*) AS ObjectCount
FROM MFAHv_OBJ
GROUP BY ObjectID, ObjectNumber
HAVING COUNT(*) > 1
)
ORDER BY SortNumber




SELECT * 
FROM MFAHv_OBJ_Title_FirstDisplayed
WHERE ObjectID IN (116162,86591,69634,103)



SELECT * FROM MediaXrefs WHERE MediaXrefID = 152510
SELECT * FROM MediaXrefs WHERE MediaXrefID = 93405



--	Orphaned MediaXrefs

SELECT * FROM MediaXrefs WHERE TableID = 108 AND ID = 45182
SELECT * FROM MediaMaster WHERE MediaMasterID IN
(SELECT MediaMasterID FROM MediaXrefs WHERE TableID = 108 AND ID = 45182)

-- 2. run this with one of the results from 1.  Then chagne primary display in the record to correct.

SELECT * FROM MediaXrefs WHERE TableID = 108 AND ID = 11274
SELECT * FROM MediaMaster WHERE MediaMasterID IN
(
	SELECT MediaMasterID FROM MediaXrefs WHERE TableID = 108 AND ID = 11274
)




SELECT FileID
FROM MediaFiles
WHERE RenditionID NOT IN
(SELECT RenditionID FROM MediaRenditions)






------------	Brian's scripts





Select * from MediaRenditions
Where RenditionID = 4008

Select * from MediaMaster
Where DisplayRendID not in 
(Select RenditionID from MediaRenditions)
--And DisplayRendID <> -1


--Old MediaMasters from Conversion/year 2000
--who have lost their renditions
--Select * from MediaRenditions
Delete from MediaMaster
Where MediaMasterID in 
(1587,1589,2550,3632,
4556,4557,4562,4563,
4564,4604,4632,4633,
5792,5793,5794,5827,
5828,5829,5869,6037,
6334,6431,6432,6433,
6436,6483,6484,7311,
7471,7472,16954,17262,
17283,17285,17290,17292,
17434,17437,17475,17477,
17523,17526,17532,17700,
17949,17957,17960,17994,
17999,18001,18070,18177,
18178,18179,18180,18622,
18623,18624,18744,18750,
18752,18846,18847,18869,
18870,32076,32489)


Select * from MediaRenditions
--Delete from MediaMaster
Where MediaMasterID in 
(83818,84561,109359,151843,
154103,154137,154138,154139,
154144,186946,186948,186952,
186963,186964,186965,186966,
186967,187651,191990,195800,
195867,198389,198390,198391,
199498,199730,201491,201492,
201493,215187,215188,215189,
215191,215226,215397,215437,
215438,216543,216544,218193,
219960,220925,222089,222253,
222254,222255,222256,222257,
222258,222259,222260)

Select 'Files in TMS Missing Renditions' As Problem, 
Replace('\'+Path+'\'+FileName, '\\','\') As FullPath, FileName, FileDate, MF.LoginID
from  MediaFiles MF 
left outer join MediaPaths MP on MF.PathID = MP.PathID
Where RenditionID not in 
(Select RenditionID from MediaRenditions)


--Run this delete later after checking on the 24 files
/* 
Delete from  MediaFiles MF 
Where RenditionID not in 
(Select RenditionID from MediaRenditions)
*/


Select * from MediaRenditions
Where PrimaryFileID not in 
(Select FileID from MediaFiles)


--Check for problem rows (orphans)
Select * from MediaXrefs
Where MediaMasterID not in 
(Select MediaMasterID from MediaMaster)
Order by TableID, EnteredDate desc


--If the count jives with what you expect, 
--clean them up with this
Delete 
--select *
from MediaXrefs
Where MediaMasterID not in 
(Select MediaMasterID from MediaMaster)
