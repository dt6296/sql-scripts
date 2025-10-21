

-- Objects with Document as Primary Media


SELECT
mx.MediaXrefID,
mx.MediaMasterID,
mx.ID,
mx.TableID,
t.TableName,
o.ObjectID,
o.ObjectNumber,
mx.PrimaryDisplay,
mr.RenditionNumber,
mf.FileName,
mf.FormatID,
ft.Format AS MediaFormat,
mr.MediaTypeID,
mt.MediaType,
mm.ApprovedForWeb

FROM MediaXrefs AS mx
INNER JOIN DDTables AS t ON mx.TableID = t.TableID
INNER JOIN Objects AS o ON mx.ID = o.ObjectID AND mx.TableID = 108
INNER JOIN MediaRenditions AS mr ON mx.MediaMasterID = mr.MediaMasterID
INNER JOIN MediaMaster AS mm ON mr.MediaMasterID = mm.MediaMasterID
INNER JOIN MediaFiles AS mf ON mr.RenditionID = mf.RenditionID
INNER JOIN MediaFormats AS ft ON mf.FormatID = ft.FormatID
INNER JOIN MediaTypes AS mt ON mr.MediaTypeID = mt.MediaTypeID

WHERE mt.MediaTypeID = 4
AND PrimaryDisplay = 1

ORDER BY o.SortNumber