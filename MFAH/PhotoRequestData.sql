


SELECT 
p.ProjectID,
p.DepartmentID,
d.Department,
p.ProjectNumber,
p.SortNumber,
p.Title,
p.StatusID,
ps.ProjectStatus,
p.StatusISODate,
p.ProjectTypeID,
pt.ProjectType,
p.Locked,
p.BeginISODate,
p.EndISODate,
p.LoginID,
p.EnteredDate,
p.GSRowVersion,
prs.ID,
prs.PhotographyRequestDate_269,
prs.PhotographyDeadlineDate_270,
prs.Purpose_271,
prs.OtherInformation_272

FROM Projects AS p
INNER JOIN Departments AS d ON p.DepartmentID = d.DepartmentID
INNER JOIN ProjectStatuses AS ps ON p.StatusID = ps.ProjectStatusID
INNER JOIN ProjectTypes AS pt ON p.ProjectTypeID = pt.ProjectTypeID
LEFT OUTER JOIN
(
	SELECT 
	prs.ID,
	prs.PhotographyRequestDate_269,
	prs.PhotographyDeadlineDate_270,
	prs.Purpose_271,
	prs.OtherInformation_272
	FROM vgsFF_58_50 AS prs

)	AS prs ON p.ProjectID = prs.ID

WHERE p.ProjectID = 31

-----------------------------------------------------

SELECT
uf.UserFieldID,
uf.UserFieldName,
uf.UserFieldType,
ufx.UserFieldXrefID,
ufx.ID,
ufx.ContextID,
ddc.Context,
ddc.ContextType,
ufx.ValueDate,
ufx.FieldValue,
ufx.ValueRemarks,
ufx.NumericFieldValue,
ufx.LoginID,
ufx.EnteredDate,
ufx.UserFieldGroupID,
ufg.GroupName,
ufx.Location,
ufx.GSRowVersion 
FROM UserFields					AS uf
LEFT OUTER JOIN UserFieldXrefs	AS ufx ON uf.UserFieldID = ufx.UserFieldID
LEFT OUTER JOIN UserFieldGroups	AS ufg ON ufx.UserFieldGroupID = ufg.UserFieldGroupID
LEFT OUTER JOIN DDContexts			AS ddc ON ufx.ContextID = ddc.ContextID
WHERE uf.UserFieldID IN (265,266,267,268)

---------------------------------------------------



SELECT
pitem.ProjectItemXrefID,
pitem.ProjectID,
pitem.ItemID,
pitem.TableID,
o.ObjectNumber,
o.SortNumber,
pitem.ProjectItemStatusID,
pis.ItemStatus,
pitem.StatusISODate,
pitem.StatusLoginID,
pitem.PrimaryConXrefID,
pitem.RequestorConXrefID,
pitem.DueISODate,
pitem.RequestISODate,
pitem.Cost,
pitem.DurationDays,
pitem.AssociatedConXrefID1,
pitem.AssociatedConXrefID2,
pitem.LoginID,
pitem.EnteredDate,
pitem.GSRowVersion,
o.ThumbBlob

FROM ProjectItems AS pitem
INNER JOIN ProjectItemStatuses AS pis ON pitem.ProjectItemStatusID = pis.ProjectItemStatusID
LEFT OUTER JOIN MFAHv_OBJ_Tombstone2 AS o ON pitem.ItemID = o.ObjectID AND pitem.TableID = 108

WHERE pitem.ProjectID = 31







