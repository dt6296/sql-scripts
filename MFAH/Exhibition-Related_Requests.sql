



/*

SELECT * FROM UserFieldGroups WHERE ContextID = 37 -- HIST_EVENT_GENERAL_FLEXFIELDS

SELECT * FROM UserFieldGroupXrefs WHERE UserFieldGroupID IN
(
	SELECT UserFieldGroupID FROM UserFieldGroups WHERE ContextID = 37
) 




SELECT * FROM UserFields
WHERE UserFieldID IN
(
	SELECT UserFieldID FROM UserFieldGroupXrefs WHERE UserFieldGroupID IN
		(SELECT UserFieldGroupID FROM UserFieldGroups WHERE ContextID = 37)
) 

*/

/*
SELECT
ufg.ContextID,
ufg.UserFieldGroupID,
ufg.GroupName,
uf.UserFieldID,
uf.UserFieldName,
ufg.DisplayOrder AS ufg_DisplayOrder,
ufgx.DisplayOrder AS ufgx_DisplayOrder,
uf.DisplayOrder AS uf_DisplayOrder

FROM UserFields AS uf
LEFT OUTER JOIN UserFieldGroupXrefs AS ufgx ON uf.UserFieldID = ufgx.UserFieldID
LEFT OUTER JOIN UserFieldGroups AS ufg ON ufgx.UserFieldGroupID = ufg.UserFieldGroupID

WHERE ufg.ContextID = 37
AND 
	ufg.UserFieldGroupID = 95	--	EVT_Admin

OR	ufg.UserFieldGroupID IN (67,68,69,70)	--	AVR
--OR	ufg.UserFieldGroupID IN (75,76,77,78)	--	DPR
--OR	ufg.UserFieldGroupID IN (79,80,81,82)	--	IGR
--OR	ufg.UserFieldGroupID IN (83,84,85,86)	--	LIR


--	ufg.UserFieldGroupID = 67	--	AVR_General
--	ufg.UserFieldGroupID = 68	--	AVR_ForAVDeptUse
--	ufg.UserFieldGroupID = 69	--	AVR_Specifications
--	ufg.UserFieldGroupID = 70	--	AVR_Budget


--	ufg.UserFieldGroupID = 75	--	DPR_Design
--	ufg.UserFieldGroupID = 76	--	DPR_Production
--	ufg.UserFieldGroupID = 77	--	DPR_ForDesignDeptUse
--	ufg.UserFieldGroupID = 78	--	DPR_ForProductionDeptUse

--	ufg.UserFieldGroupID = 79	--	IGR_Labels
--	ufg.UserFieldGroupID = 80	--	IGR_AdditionalInstallationElements
--	ufg.UserFieldGroupID = 81	--	IGR_ForGraphicsPublicationsDeptUse
--	ufg.UserFieldGroupID = 82	--	IGR_NameBudget

--	ufg.UserFieldGroupID = 83	--	L&I_InterpretiveElements
--	ufg.UserFieldGroupID = 84	--	L&I_Evaluation
--	ufg.UserFieldGroupID = 85	--	L&I_AvailableForUse
--	ufg.UserFieldGroupID = 86	--	L&I_ExhibitionsDeptUse


ORDER BY ufg.DisplayOrder, ufgx.DisplayOrder, uf.DisplayOrder
*/

------------------------------------------------------------------------

SELECT
ufg.ContextID,
ufg.UserFieldGroupID,
ufg.GroupName,
uf.UserFieldID,
uf.UserFieldName,
ufg.DisplayOrder AS ufg_DisplayOrder,
ufgx.DisplayOrder AS ufgx_DisplayOrder,
uf.DisplayOrder AS uf_DisplayOrder,
ufx.FieldValue,
ufx.ValueDate,
ufx.ValueRemarks,
ufx.NumericFieldValue,
he.HistEventID,
he.EventName

FROM UserFields AS uf
LEFT OUTER JOIN UserFieldGroupXrefs AS ufgx ON uf.UserFieldID = ufgx.UserFieldID
LEFT OUTER JOIN UserFieldGroups AS ufg ON ufgx.UserFieldGroupID = ufg.UserFieldGroupID
LEFT OUTER JOIN UserFieldXrefs AS ufx ON uf.UserFieldID = ufx.UserFieldID
LEFT OUTER JOIN HistEvents AS he ON ufx.ID = he.HistEventID AND ufx.ContextID = 37


WHERE ufg.ContextID = 37
AND 
(	ufg.UserFieldGroupID = 95	--	EVT_Admin

OR	ufg.UserFieldGroupID IN (67,68,69,70)	--	AVR
--OR	ufg.UserFieldGroupID IN (75,76,77,78)	--	DPR
--OR	ufg.UserFieldGroupID IN (79,80,81,82)	--	IGR
--OR	ufg.UserFieldGroupID IN (83,84,85,86)	--	LIR
)
AND ufx.ID = 33

ORDER BY ufg.DisplayOrder, ufgx.DisplayOrder, uf.DisplayOrder