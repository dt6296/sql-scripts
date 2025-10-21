
SELECT     
c.ConstituentID, 
CASE WHEN len(ISNULL(c.Nationality, '')) = 0 THEN 
			CASE	WHEN BeginDate = 0 AND EndDate = 0 THEN '' 
					WHEN BeginDate <> 0 AND EndDate = 0 THEN 'born ' + CAST(BeginDate AS nvarchar) 
					WHEN BeginDate = 0 AND EndDate <> 0 THEN 'died ' + CAST(EndDate AS nvarchar) 
					ELSE CAST(BeginDate AS nvarchar) + ' - ' + CAST(EndDate AS nvarchar) 
			END 
		ELSE c.Nationality + CASE 
			WHEN BeginDate = 0 AND EndDate = 0 THEN '' 
			WHEN BeginDate <> 0 AND EndDate = 0 THEN ', born ' + CAST(BeginDate AS nvarchar) 
			WHEN BeginDate = 0 AND EndDate <> 0 THEN ', died ' + CAST(EndDate AS nvarchar) 
			ELSE ', ' + CAST(BeginDate AS nvarchar) + ' - ' + CAST(EndDate AS nvarchar) 
		END
END AS DisplayBio, 

CASE 
	WHEN BeginDate = 0 AND EndDate = 0 THEN '' 
	WHEN BeginDate <> 0 AND EndDate = 0 THEN 'born ' + CAST(BeginDate AS NVARCHAR) 
	WHEN BeginDate = 0 AND EndDate <> 0 THEN 'died ' + CAST(EndDate AS NVARCHAR) 
	ELSE CAST(BeginDate AS NVARCHAR) + '–' + CAST(EndDate AS NVARCHAR) 
END AS DisplayDates,

c.DisplayName

FROM MFAHv_OBJ									AS o
LEFT OUTER JOIN MFAHv_OBJ_Dimensions_cm			AS d	ON o.ObjectID = d.ID	AND TableID = 108
LEFT OUTER JOIN MFAHv_OBJ_Maker_FirstDisplayed	AS om	ON o.ObjectID = om.ObjectID
LEFT OUTER JOIN Constituents					AS c	ON om.ConstituentID = c.ConstituentID
LEFT OUTER JOIN MFAHv_OBJ_Constituent			AS oc	ON om.ConXrefID = oc.cx_ConXrefID
LEFT OUTER JOIN MFAHv_OBJ_Rights				AS obr	ON o.ObjectID = obr.ObjectID

WHERE o.ObjectID IN (117874,106103,95002,45831,60091,76946,17311,116879,6104)


