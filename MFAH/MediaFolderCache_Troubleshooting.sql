

--	MediaFolderCache TIFFs 013 troubleshooting


SELECT * FROM FSFolderCache WHERE FSFolderCacheID = 11 ORDER BY EnteredDate DESC



SELECT * FROM FSFileCache ORDER BY Created DESC



SELECT * FROM MediaFiles WHERE FileName = '0-9 2.png'
SELECT * FROM MediaRenditions WHERE RenditionID = 346984
SELECT * FROM MediaXrefs WHERE MediaMasterID = 335151
SELECT ObjectNumber FROM Objects WHERE ObjectID = 144389


/* bad file name
EX.2019.BM.011.jpg
FSFolderCacheID = 11 - Exhibitions
*/


SELECT * FROM FSFileCache WHERE FSFolderCacheID = 1627 -- nothing

SELECT * FROM MediaProcessFailures ORDER BY EnteredDate DESC

SELECT * FROM MediaRenditions WHERE MediaMasterID = 224284




