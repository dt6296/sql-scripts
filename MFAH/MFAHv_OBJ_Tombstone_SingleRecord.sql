
/*
MFAHv_OBJ_Tombstone_SingleRecord
Custom MFAH View

Created		3/22/2016	Dave Thompson
						This is intended to return the first object-maker for a given object.
						One problem is that a single maker can have multiple roles when making
						an object (ObjectID = 2471)
						I'm making this because vListViewObjects uses Attribution, and doesn't
						have our name constructions, or a thumbnail.
*/

SELECT

o.ObjectID,
o.ObjectNumber,
o.SortNumber,
oc.can_DisplayName,
oc.Prefix_CultureSchoolName_Date_Suffix,
oc.can_AlphaSort,
otfd.Title,
o.Dated,
CAST(o.Medium AS NVARCHAR(4000))		AS Medium,
CAST(o.Dimensions AS NVARCHAR(4000))	AS Dimensions,
CAST(o.CreditLine AS NVARCHAR(4000))	AS CreditLine,
mr.ThumbBLOB,

''



FROM			Objects							AS o
LEFT OUTER JOIN MFAHv_OBJ_Maker_FirstDisplayed	AS omfd	ON	o.ObjectID = omfd.ObjectID
LEFT OUTER JOIN MFAHv_OBJ_Constituent			AS oc	ON	omfd.ObjectID = oc.o_ObjectID
														AND omfd.ConstituentID = oc.c_ConstituentID
														AND oc.cx_DisplayOrder = 1
--														AND	oc.cx_RoleTypeID = 1						--	Object Related

LEFT OUTER JOIN MFAHv_OBJ_Title_FirstDisplayed	AS otfd	ON	o.ObjectID = otfd.ObjectID

LEFT OUTER JOIN MediaXrefs						AS mx	ON	o.ObjectID = mx.ID 
														AND mx.TableID = 108							--	Objects Table
														AND mx.PrimaryDisplay = 1
LEFT OUTER JOIN MediaMaster						AS mm	ON	mx.MediaMasterID = mm.MediaMasterID
LEFT OUTER JOIN MediaRenditions					AS mr	ON	mm.DisplayRendID = mr.RenditionID

WHERE o.ObjectID IN (129555,131458,131456,2471)




/*
SELECT * FROM MFAHv_OBJ_Constituent
WHERe o_ObjectID = 2471
*/

------------------------------------------------

	
SELECT COUNT(*) FROM MFAHv_OBJ		--	124385


SELECT ObjectID, ObjectNumber
FROM MFAHv_OBJ
GROUP BY ObjectID, ObjectNumber
HAVING COUNT(*) > 1					--	0



SELECT * FROM MFAHv_OBJ
WHERE ObjectID IN (2471,4529)



