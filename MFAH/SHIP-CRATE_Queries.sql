

SELECT DISTINCT
s.ShipmentID,
s.ShipmentNumber,
--sc.CrateHierID,
c.ProjectID,
cp.ProjectName,
c.TypeID,
ct.Type,
sc.CrateID,
sc.CrateLocationID,
c.CrateID,
c.CrateNumber,
c.SortNumber AS CrateSortNumber,
c.CrateHeightCM,
c.CrateHeightCM * 0.39370 AS CrateHeightIN,
c.CrateWidthCM,
c.CrateWidthCM * 0.39370 AS CrateWidthIN,
c.CrateDepthCM,
c.CrateDepthCM * 0.39370 AS CrateDepthIN,
c.CrateWeightKG,
c.CrateWeightKG * 2.2046 AS CrateWeightLBS,
c.ContentsAbbrev,
c.Description AS CrateDescription,
c.Remarks AS CrateRemarks,
c.Materials,
c.Condition,
c.ClimateControlled,
c.Oversize,
c.Stackable,
c.LocationID,
l.LocationString

FROM Shipments AS s
LEFT OUTER JOIN ShipCrateHiers AS sc ON s.ShipmentID = sc.ShipmentID
LEFT OUTER JOIN Crates AS c ON sc.CrateID = c.CrateID
LEFT OUTER JOIN Locations AS l ON c.LocationID = l.LocationID
LEFT OUTER JOIN CrateProjects AS cp ON c.ProjectID = cp.ProjectID
LEFT OUTER JOIN CrateTypes AS ct ON c.TypeID = ct.TypeID

WHERE s.ShipmentID = 1479
AND sc.CrateID IS NOT NULL



SELECT * FROM CrateProjects
SELECT * FROM CrateTypes




SELECT
COUNT(*) AS Crates,
c.ProjectID,
cp.ProjectName

FROM Crates AS c
LEFT OUTER JOIN CrateProjects AS cp ON c.ProjectID = cp.ProjectID

GROUP BY 
c.ProjectID,
cp.ProjectName





