

SELECT TOP 1000 ExhMnemonic, 
STUFF((SELECT ', ' + Constituents.DisplayName
FROM  Exhibitions E1
    INNER JOIN ExhConXrefs ON E1.ExhibitionID = ExhConXrefs.ExhibitionID
    INNER JOIN Constituents ON Constituents.ConstituentID = ExhConXrefs.ConstituentID
    WHERE ExhConXrefs.RoleID = 3 AND (E1.ExhMnemonic = E2.ExhMnemonic)
    FOR XML PATH (''))
    ,1,2,'') AS DisplayName
FROM  Exhibitions E2
GROUP BY ExhMnemonic




SELECT TOP 100
oc.o_ObjectID,

STUFF((	SELECT '; ' + oc2.DisplayName
		FROM MFAHv_OBJ_Constituent AS oc2
		WHERE oc2.o_ObjectID = 110421
		FOR XML PATH ('')),1,2,'') AS DisplayName

FROM MFAHv_OBJ_Constituent AS oc

WHERE oc.cx_RoleTypeID = 1
AND oc.o_ObjectID IN (110421)

GROUP BY oc.o_ObjectID





SELECT TOP 100
STUFF((	SELECT '; ' + oc2.DisplayName
		FROM MFAHv_OBJ_Constituent AS oc2
		WHERE oc2.o_ObjectID = 110421
		FOR XML PATH ('')),1,2,'') AS DisplayName

FROM MFAHv_OBJ_Constituent AS oc

WHERE oc.cx_RoleTypeID = 1
AND oc.o_ObjectID = 110421

GROUP BY oc.o_ObjectID



SELECT
	REPLACE(STUFF((
			SELECT ' '
			+ p.PhoneNumber + ' (' 
			+ ISNULL(p.Description,'')
			+ (CASE WHEN p.PhoneType = '(not assigned)' THEN '' ELSE '  ' + p.PhoneType END)  + ')'
			+ CHAR(10) --+ CHAR(13)

			FROM MFAHv_CON_Phone AS p
			WHERE p.ConstituentID = 23
			FOR XML PATH ('')),1,1,''),'&amp;','&')

SELECT
STUFF((	SELECT '; ' + an.AltNum
		FROM AltNums AS an
		WHERE an.TableID = 108
		AND an.ID = 110421
		FOR XML PATH ('')),1,1,'')