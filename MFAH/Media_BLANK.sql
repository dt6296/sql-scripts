









SELECT 
mm.MediaMasterID

FROM MediaMaster AS mm
LEFT OUTER JOIN MediaRenditions AS mr ON mm.MediaMasterID = mr.MediaMasterID

WHERE mr.MediaMasterID IS NULL





SELECT 
mm.MediaMasterID,
mr.RenditionNumber

FROM MediaMaster AS mm
LEFT OUTER JOIN MediaRenditions AS mr ON mm.MediaMasterID = mr.MediaMasterID
LEFT OUTER JOIN MediaFiles AS mf ON mr.RenditionID = mf.RenditionID

WHERE mf.RenditionID IS NULL
AND mr.LoginID = 'Conversion'

ORDER BY mm.MediaMasterID






SELECT * FROM MFAHv_Media WHERE ID = 1159  --21

SELECT * FROM MediaXrefs WHERE ID = 1159




SELECT
mx.MediaXrefID,
mx.MediaMasterID,
mx.ID,
mx.TableID,
o.ObjectNumber

FROM MediaXrefs AS mx
LEFT OUTER JOIN Objects AS o ON mx.ID = o.ObjectID AND mx.TableID = 108

WHERE mx.MediaMasterID IN
(
	SELECT 
	mm.MediaMasterID
	FROM MediaMaster AS mm
	LEFT OUTER JOIN MediaRenditions AS mr ON mm.MediaMasterID = mr.MediaMasterID
	LEFT OUTER JOIN MediaFiles AS mf ON mr.RenditionID = mf.RenditionID
	WHERE mf.RenditionID IS NULL
	AND mr.LoginID = 'Conversion'
)


