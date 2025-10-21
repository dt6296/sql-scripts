SELECT * FROM
(
			SELECT 
			oc.o_ObjectID, 
			o.ObjectNumber,
			o.ObjectStatusID,
			os.ObjectStatus,
			o.DepartmentID,
			d.Department,
			ov.Value,
			oc.cx_Role,
			oc.c_DisplayName
				
			FROM MFAHv_OBJ_Constituent AS oc
			LEFT OUTER JOIN Objects AS o ON oc.o_ObjectID = o.ObjectID
			LEFT OUTER JOIN MFAHv_OBJ_Value_Current AS ov ON o.ObjectID = ov.ObjectID
			LEFT OUTER JOIN ObjectStatuses AS os ON o.ObjectStatusID = os.ObjectStatusID
			LEFT OUTER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID
			
			WHERE oc.cx_RoleTypeID = 2			-- Acquisition Related
			AND oc.cx_RoleID IN (2,16,14,24)		-- Donor, Donor(Anonymous), Funder, Funder(Anonymous)
			AND oc.c_DisplayName = 'Anne Wilkes Tucker'
			AND o.ObjectStatusID = 2
	) AS odf

INNER JOIN 

(
		SELECT 
	oc.o_ObjectID, 
	o.ObjectNumber,
	o.ObjectStatusID,
	os.ObjectStatus,
	o.DepartmentID,
	d.Department,
	ov.Value,
	oc.cx_Role,
	oc.c_DisplayName
				
	FROM MFAHv_OBJ_Constituent AS oc
	LEFT OUTER JOIN Objects AS o ON oc.o_ObjectID = o.ObjectID
	LEFT OUTER JOIN MFAHv_OBJ_Value_Current AS ov ON o.ObjectID = ov.ObjectID
	LEFT OUTER JOIN ObjectStatuses AS os ON o.ObjectStatusID = os.ObjectStatusID
	LEFT OUTER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID
			
	WHERE oc.cx_RoleTypeID = 2			-- Acquisition Related
	--AND oc.cx_RoleID IN (32)					-- Honoree
	AND oc.cx_RoleID NOT IN (2,16,14,24)		-- Donor, Donor(Anonymous), Funder, Funder(Anonymous)
	AND oc.c_DisplayName = 'Anne Wilkes Tucker'
	AND o.ObjectStatusID = 2
) AS oh ON odf.o_ObjectID = oh.o_ObjectID


