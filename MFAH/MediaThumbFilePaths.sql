




SELECT
mr.RenditionID,
mr.RenditionNumber,
mr.ThumbPathID,
mp.Path AS ThumbFilePath,
mr.ThumbFileName,
mf.FileID,
mf.RenditionID,
mf.PathID,
mf.FileName,
mf.ArchVolName,
o.ObjectID,
o.ObjectNumber

FROM MediaRenditions AS mr
LEFT OUTER JOIN MediaFiles AS mf ON mr.RenditionID = mf.RenditionID
LEFT OUTER JOIN MediaPaths AS mp ON mr.ThumbPathID = mp.PathID
LEFT OUTER JOIN MediaXrefs AS mx ON mr.MediaMasterID = mx.MediaMasterID AND mx.TableID = 108
LEFT OUTER JOIN Objects AS o ON mx.ID = o.ObjectID

--WHERE mf.ArchVolName LIKE 'Migrated_2016%'
WHERE mr.ThumbPathID = 1


ORDER BY RenditionNumber

--AND o.ObjectID = 44214


--	ThumbPathID = 122	= \\mfah.local\sf\DATA\TMS IMAGES\MigrationFromPortfolio

--	ThumbPathID = 58	= \\mfah.local\sf\data\TMS IMAGES\IMAGES\SCREEN\192X192
--	ThumbPathID = 1		= \\mfah.local\sf\data\TMS IMAGES\IMAGES\SCREEN\192X192\

SELECT * FROM MediaPaths








