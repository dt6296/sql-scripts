









SELECT DISTINCT
s.ShipmentID,
s.ShipmentNumber,
--sc.CrateHierID,
sc.CrateID,
sc.CrateLocationID,
c.CrateID,
c.CrateNumber,
c.ContentsAbbrev,
c.Description,
c.SortNumber AS CrateSortNumber,
c.LocationID,
l.LocationString

FROM Shipments AS s
LEFT OUTER JOIN ShipCrateHiers AS sc ON s.ShipmentID = sc.ShipmentID
LEFT OUTER JOIN Crates AS c ON sc.CrateID = c.CrateID
LEFT OUTER JOIN Locations AS l ON c.LocationID = l.LocationID

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





