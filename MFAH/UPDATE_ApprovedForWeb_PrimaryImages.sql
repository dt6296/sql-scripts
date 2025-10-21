--  UPDATE ApprovedForWeb for Primary Images of accessioned objects

SELECT
o.ObjectID,
o.ObjectNumber,
o.PublicAccess,
mx.MediaXrefID,
mx.MediaMasterID,
mm.ApprovedForWeb,
mx.PrimaryDisplay,
mx.Rank,
mx.Remarks			AS mx_Remarks,
mm.DisplayRendID,
mm.PrimaryRendID,
mm.PublicCaption,
mm.Copyright,
mm.Restrictions,
mm.Description,
mm.MediaView,
mm.Remarks			AS mm_Remarks,
mr.RenditionID,
mr.RenditionNumber,
mr.ParentRendID,
mr.MediaTypeID,
mt.MediaType


FROM			Objects					AS o
LEFT OUTER JOIN MediaXrefs				AS mx	ON	o.ObjectID = mx.ID
												AND	mx.TableID = 108
LEFT OUTER JOIN	MediaMaster				AS mm	ON	mx.MediaMasterID = mm.MediaMasterID
LEFT OUTER JOIN	MediaRenditions			AS mr	ON	mm.MediaMasterID = mr.MediaMasterID
LEFT OUTER JOIN	MediaTypes				AS mt	ON	mr.MediaTypeID = mt.MediaTypeID


WHERE mr.MediaTypeID = 1
AND o.ObjectStatusID IN (2,27)
AND o.DepartmentID = 3	-- Bayou Bend
AND o.PublicAccess = 1
AND mx.PrimaryDisplay = 1
AND mm.ApprovedForWeb = 0

ORDER BY o.SortNumber DESC

--60579


UPDATE MediaMaster
SET ApprovedForWeb = 1
FROM			Objects					AS o
LEFT OUTER JOIN MediaXrefs				AS mx	ON	o.ObjectID = mx.ID
												AND	mx.TableID = 108
LEFT OUTER JOIN	MediaMaster				AS mm	ON	mx.MediaMasterID = mm.MediaMasterID
LEFT OUTER JOIN	MediaRenditions			AS mr	ON	mm.MediaMasterID = mr.MediaMasterID
LEFT OUTER JOIN	MediaTypes				AS mt	ON	mr.MediaTypeID = mt.MediaTypeID
WHERE mr.MediaTypeID = 1
AND o.ObjectStatusID IN (2,27)
AND o.DepartmentID = 3	-- Bayou Bend
AND o.PublicAccess = 1
AND mx.PrimaryDisplay = 1
AND mm.ApprovedForWeb = 0



SELECT COUNT(*) FROM MediaMaster WHERE ApprovedForWeb = 1