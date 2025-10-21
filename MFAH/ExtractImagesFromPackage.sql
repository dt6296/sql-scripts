










SELECT * FROM Packages  WHERE Name LIKE 'Maquettes%'	--	135986	Maquettes for Craft in New Building



SELECT
pl.ID,
o.ObjectNumber,
mx.MediaXrefID,
mx.MediaMasterID,
mr.MediaTypeID,
mt.MediaType,
mr.RenditionID,
mr.RenditionNumber,
mf.PathID,
mp.Path,
mp.PhysicalPath,
mf.FileName,
mf.FileSize

FROM PackageList AS pl
LEFT OUTER JOIN Objects AS o ON pl.ID = o.ObjectID AND pl.TableID = 108
LEFT OUTER JOIN MediaXrefs AS mx ON o.ObjectID = mx.ID AND mx.TableID = 108
LEFT OUTER JOIN MediaMaster AS mm ON mx.MediaMasterID = mm.MediaMasterID
LEFT OUTER JOIN MediaRenditions AS mr ON mm.MediaMasterID = mr.MediaMasterID
LEFT OUTER JOIN MediaFiles AS mf ON mr.PrimaryFileID = mf.FileID
LEFT OUTER JOIN MediaPaths AS mp ON mf.PathID = mp.PathID
LEFT OUTEr JOIN MediaTypes AS mt ON mr.MediaTypeID = mt.MediaTypeID

WHERE pl.PackageID = 135986
AND mr.MediaTypeID = 1


























