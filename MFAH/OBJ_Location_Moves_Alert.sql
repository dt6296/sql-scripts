










SELECT
o.ObjectID,
o.ObjectNumber,
o.SortNumber,
o.Department,
oc.CultureSchoolName_Suffix,
o.TitleDateDisplay,
o.ThumbBLOB,
olac.CurRoom,
olac.ComponentNumber,
olac.ComponentName,
olac.TransDate,
olac.Handler

FROM MFAHv_OBJ_Location_ActiveComponent AS olac
INNER JOIN MFAHv_OBJ AS o ON olac.ObjectID = o.ObjectID
LEFT OUTER JOIN MFAHv_OBJ_Constituent AS oc ON o.ObjectID = oc.o_ObjectID AND oc.cx_RoleTypeID = 1 AND oc.cx_DisplayOrder = 1

WHERE olac.GSRowVersion BETWEEN 
	(SELECT MIN(MFAH_DBTS) FROM MFAHt_DBTS WHERE MFAH_DBTS IN (SELECT TOP 2 MFAH_DBTS FROM MFAHt_DBTS ORDER BY MFAH_DBTS DESC))
	AND
	(SELECT MAX(MFAH_DBTS) FROM MFAHt_DBTS)
AND CurLocationID IN
(
	SELECT LocationID FROM MFAHv_LOC
	WHERE SubSite_Room IN 
	(
		'CONSERVATION LAB',
		'DECORATIVE ARTS CONSERVATION',
		'FRAMING',
		'OBJECT AND SCULPTURE CONSERVATION',
		'PAINTINGS CONSERVATION (GALLERY 202)',
		'PHOTOGRAPHY STUDIO'
	)
)
