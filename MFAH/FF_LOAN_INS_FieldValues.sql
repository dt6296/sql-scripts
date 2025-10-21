


SELECT
ufg.ContextID,
ddc.Context,
ufg.UserFieldGroupID,
ufg.GroupName,
ufgx.DisplayOrder,
uf.UserFieldID,
uf.UserFieldName,
ufx.ID,
ufx.FieldValue,
ufx.NumericFieldValue

FROM		UserFieldGroups		AS ufg
INNER JOIN	DDContexts			AS ddc	ON ufg.ContextID = ddc.ContextID
INNER JOIN	UserFieldGroupXrefs	AS ufgx	ON ufg.UserFieldGroupID = ufgx.UserFieldGroupID
INNER JOIN	UserFields			AS uf	ON ufgx.UserFieldID = uf.UserFieldID
INNER JOIN	UserFieldXrefs		AS ufx	ON uf.UserFieldID = ufx.UserFieldID

WHERE ufg.UserFieldGroupID IN (26,27,28,29,30,31,32,35)

ORDER BY ufg.GroupName, ufgx.DisplayOrder





SELECT DISTINCT
ID,
ufg.GroupName,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 191) AS TravelType,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 192) AS TravelExpense,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 207) AS TravelInsurance,
(SELECT CAST(CASE WHEN FieldValue = 1 THEN 'Yes' ELSE 'No' END AS NVARCHAR(3)) FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 207) AS TravelInsuranceYN,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 208) AS PerDiem,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 209) AS GroundTransportation,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 210) AS Hotel,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 211) AS NumberOfNights,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 212) AS OtherExpenses,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 213) AS OtherRequirements

FROM UserFieldXrefs AS ufx 
INNER JOIN UserFieldGroups AS ufg ON ufx.UserFieldGroupID = ufg.UserFieldGroupID

WHERE ufx.UserFieldGroupID = 29 -- Courier - Between Venues
AND ufx.ContextID = 2


UNION



SELECT DISTINCT
ID,
ufg.GroupName,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 183) AS TravelType,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 184) AS TravelExpense,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 221) AS TravelInsurance,
(SELECT CAST(CASE WHEN FieldValue = 1 THEN 'Yes' ELSE 'No' END AS NVARCHAR(3)) FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 221) AS TravelInsuranceYN,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 222) AS PerDiem,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 223) AS GroundTransportation,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 224) AS Hotel,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 225) AS NumberOfNights,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 226) AS OtherExpenses,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 227) AS OtherRequirements

FROM UserFieldXrefs AS ufx 
INNER JOIN UserFieldGroups AS ufg ON ufx.UserFieldGroupID = ufg.UserFieldGroupID

WHERE ufx.UserFieldGroupID = 27 -- Courier - Inbound
AND ufx.ContextID = 2


UNION

SELECT DISTINCT
ID,
ufg.GroupName,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 185) AS TravelType,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 186) AS TravelExpense,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 235) AS TravelInsurance,
(SELECT CAST(CASE WHEN FieldValue = 1 THEN 'Yes' ELSE 'No' END AS NVARCHAR(3)) FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 235) AS TravelInsuranceYN,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 236) AS PerDiem,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 237) AS GroundTransportation,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 238) AS Hotel,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 239) AS NumberOfNights,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 240) AS OtherExpenses,
(SELECT FieldValue FROM UserFieldXrefs WHERE ID = ufx.ID AND UserFieldID = 241) AS OtherRequirements

FROM UserFieldXrefs AS ufx 
INNER JOIN UserFieldGroups AS ufg ON ufx.UserFieldGroupID = ufg.UserFieldGroupID

WHERE ufx.UserFieldGroupID = 28 -- Courier - Outbound
AND ufx.ContextID = 2






