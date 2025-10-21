


--	Objects
SELECT ObjectID FROM Objects 
WHERE GSRowVersion > (SELECT MAX(MFAH_DBTS) FROM MFAHt_DBTS)

UNION

--	Object Context
SELECT ObjectID FROM ObjContext
WHERE GSRowVersion > (SELECT MAX(MFAH_DBTS) FROM MFAHt_DBTS)

UNION

--	Object Historical Dates
SELECT ObjectID FROM ObjDates
WHERE GSRowVersion > (SELECT MAX(MFAH_DBTS) FROM MFAHt_DBTS)

UNION

--	Object Rights
SELECT ObjectID FROM ObjRights AS ocr
WHERE ocr.GSRowVersion > (SELECT MAX(MFAH_DBTS) FROM MFAHt_DBTS)

UNION

--	Object Titles
SELECT ObjectID FROM ObjTitles
WHERE GSRowVersion > (SELECT MAX(MFAH_DBTS) FROM MFAHt_DBTS)

UNION

--	Object-Constituent Links
SELECT ID FROM ConXrefs
WHERE GSRowVersion > (SELECT MAX(MFAH_DBTS) FROM MFAHt_DBTS)
AND TableID = 108

UNION

--	Object-Constituent Data
SELECT cx.ID FROM ConXrefDetails AS cxd
INNER JOIN ConXrefs AS cx ON cx.ConXrefID = cxd.ConXrefID
WHERE cxd.GSRowVersion > (SELECT MAX(MFAH_DBTS) FROM MFAHt_DBTS)
AND cx.TableID = 108

UNION

--	Object Locations
SELECT oc.ObjectID FROM ObjLocations AS ol
INNER JOIN ObjComponents AS oc ON ol.ComponentID = oc.ComponentID
WHERE ol.GSRowVersion > (SELECT MAX(MFAH_DBTS) FROM MFAHt_DBTS)

UNION

--	New media
SELECT mx.ID AS ObjectID FROM MediaXrefs AS mx
WHERE mx.GSRowVersion > (SELECT MAX(MFAH_DBTS) FROM MFAHt_DBTS)
AND mx.TableID = 108

UNION

--	Updated media
SELECT mx.ID AS ObjectID	FROM MediaXrefs				AS mx								
LEFT OUTER JOIN	MediaMaster				AS mm	ON	mx.MediaMasterID = mm.MediaMasterID
LEFT OUTER JOIN	MediaRenditions			AS mr	ON	mm.MediaMasterID = mr.MediaMasterID
WHERE mr.GSRowVersion > (SELECT MAX(MFAH_DBTS) FROM MFAHt_DBTS)
AND	mx.TableID = 108

