
-- Objects without (digital or physical) images, with location



SELECT
o.ObjectID,
o.ObjectNumber,
ol.CurLocationString,
ol.CurSite,
ol.CurRoom,
ol.CurUnitType,
ol.CurUnitNumber,
ol.CurUnitPosition

FROM Objects AS o
LEFT OUTER JOIN MFAHv_OBJ_Location_ActiveComponent_First AS ol ON o.ObjectID = ol.ObjectID

WHERE o.ObjectStatusID IN (2,27) -- Accessioned, Blaffer
AND o.ObjectID NOT IN
(
	SELECT 
	mx.ID
	FROM MediaXrefs AS mx 
	LEFT OUTER JOIN MediaRenditions AS mr ON mx.MediaMasterID = mr.MediaMasterID
	LEFT OUTER JOIN MediaMaster AS mm ON mr.MediaMasterID = mm.MediaMasterID
	LEFT OUTER JOIN MediaFiles AS mf ON mr.RenditionID = mf.RenditionID
	LEFT OUTER JOIN MediaFormats AS ft ON mf.FormatID = ft.FormatID
	LEFT OUTER JOIN MediaTypes AS mt ON mr.MediaTypeID = mt.MediaTypeID
	WHERE TableID = 108
	AND mt.MediaTypeID IN (1,28,29,30,31,32,33) 
)

ORDER BY o.SortNumber







SELECT * FROM MediaTypes










