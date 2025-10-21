SELECT DISTINCT
o_ObjectID

FROM MFAHv_OBJ_Constituent

WHERE cx_RoleTypeID = 1
AND cxd_ConstituentID = 1396

--384 - verified


SELECT DISTINCT
o_ObjectID

FROM MFAHv_OBJ_Constituent

WHERE cx_RoleTypeID = 1
AND cxd_ConstituentID = 2152

--127 verified


-- Update OBJECT approved for web


--UPDATE Objects
SET PublicAccess = 1
--SELECT ObjectID, PublicAccess, ObjectNumber FROM Objects
WHERE ObjectID IN
(
	SELECT DISTINCT
	o_ObjectID
	FROM MFAHv_OBJ_Constituent
	WHERE cx_RoleTypeID = 1
	AND cxd_ConstituentID = 1396
	AND cxd_ConstituentID = 2152
)



-- Update MEDIA approved for web

SELECT mm.* FROM MediaMaster AS mm
INNER JOIN MediaXrefs AS mx ON mm.MediaMasterID = mx.MediaMasterID
WHERE mx.MediaXrefID IN

UPDATE MediaMaster
SET ApprovedForWeb = 0
FROM MediaMaster AS mm
INNER JOIN MediaXrefs AS mx ON mm.MediaMasterID = mx.MediaMasterID
WHERE mx.MediaXrefID IN

(
	SELECT MediaXrefID FROM MFAHv_OBJ_Image
	WHERE ObjectID IN
	(
		SELECT DISTINCT
		o_ObjectID
		FROM MFAHv_OBJ_Constituent
		WHERE cx_RoleTypeID = 1
		--AND cxd_ConstituentID = 1396  --Diane Arbus
		AND cxd_ConstituentID = 2152	--Irving Penn
	)
	AND ApprovedForWeb = 1
)
