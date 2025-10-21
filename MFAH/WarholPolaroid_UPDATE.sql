




SELECT
o.ObjectID,
o.ObjectNumber,
mm.ApprovedForWeb,
mx.PrimaryDisplay,
mr.RenditionNumber,
CASE WHEN mr.RenditionNumber = 'TR1312-2013-152q' THEN 1 ELSE
CASE WHEN mr.RenditionNumber LIKE '%a' THEN 1 ELSE 0 END END AS IsPrimary

FROM MFAHv_OBJ AS o
INNER JOIN MediaXrefs AS mx ON o.ObjectID = mx.ID AND mx.TableID = 108
INNER JOIN MediaRenditions AS mr ON mx.MediaMasterID = mr.MediaMasterID
INNER JOIN MediaMaster AS mm ON mx.MediaMasterID = mm.MediaMasterID

WHERE o.ObjectNumber LIKE '2014.660.%'
AND o.ObjectNumber NOT IN ('2014.660.162','2014.660.1-.429')
AND mr.MediaTypeID = 1	-- Image







UPDATE MediaXrefs
SET PrimaryDisplay =
(CASE WHEN RenditionNumber = 'TR1312-2013-152q' THEN 1 ELSE
CASE WHEN RenditionNumber LIKE '%a' THEN 1 ELSE 0 END END)

FROM MFAHv_OBJ AS o
INNER JOIN MediaXrefs AS mx ON o.ObjectID = mx.ID AND mx.TableID = 108
INNER JOIN MediaRenditions AS mr ON mx.MediaMasterID = mr.MediaMasterID

WHERE o.ObjectNumber LIKE '2014.660.%'
AND o.ObjectNumber NOT IN ('2014.660.162','2014.660.1-.429')
AND mr.MediaTypeID = 1	-- Image





UPDATE MediaMaster
SET ApprovedForWeb = 1

--SELECT o.ObjectID,o.ObjectNumber,mm.ApprovedForWeb,mx.PrimaryDisplay,mr.RenditionNumber

FROM MFAHv_OBJ AS o
INNER JOIN MediaXrefs AS mx ON o.ObjectID = mx.ID AND mx.TableID = 108
INNER JOIN MediaRenditions AS mr ON mx.MediaMasterID = mr.MediaMasterID
INNER JOIN MediaMaster AS mm ON mx.MediaMasterID = mm.MediaMasterID

WHERE o.ObjectNumber LIKE '2014.660.%'
AND mr.MediaTypeID = 1	-- Image



