



SELECT * FROM Departments


SELECT * FROM Objects WHERE DepartmentID = 111


SELECT * FROM ObjGeography WHERE ObjectID IN
(SELECT ObjectID FROM Objects WHERE DepartmentID = 113)

SELECT DepartmentID, 

SELECT * FROM ObjContext

SELECT DISTINCT COUNT(o.ObjectID) AS ObjectCount, Department, 
Culture, Style, Reign, Dynasty, Period, Movement, Nationality, School, 
Continent, SubContinent, Country, Region, River, og.State, County, City, Locale, Building, Excavation, Locus, 
Township, PoliticalRegion, Nation, RegionalCorp, VillageCorporation, CulturalRegion, SubRegion
FROM Objects AS o
LEFT OUTER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID
LEFT OUTER JOIN ObjContext AS oc ON o.ObjectID = oc.ObjectID
LEFT OUTER JOIN ObjGeography AS og ON o.ObjectID = og.ObjectID 
WHERE o.ObjectID IN
(SELECT ObjectID FROM Objects WHERE DepartmentID IN (111, 15))
GROUP BY Department, Culture, Style, Reign, Dynasty, Period, Movement, Nationality, School, Continent, SubContinent, Country, Region, River, og.State, County, City, Locale, Building, Excavation, Locus, 
Township, PoliticalRegion, Nation, RegionalCorp, VillageCorporation, CulturalRegion, SubRegion





--African Art and African Art, Glassell Collection
SELECT DISTINCT COUNT(o.ObjectID) AS ObjectCount, Department, 
Culture, Style, Reign, Dynasty, Period, Movement, Nationality, School, 
Continent, SubContinent, Country, Region, River, og.State, County, City, Locale, Building, Excavation, Locus, 
Township, PoliticalRegion, Nation, RegionalCorp, VillageCorporation, CulturalRegion, SubRegion
FROM Objects AS o
LEFT OUTER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID
LEFT OUTER JOIN ObjContext AS oc ON o.ObjectID = oc.ObjectID
LEFT OUTER JOIN ObjGeography AS og ON o.ObjectID = og.ObjectID 
WHERE o.ObjectID IN
(SELECT ObjectID FROM Objects WHERE DepartmentID IN (111, 15))
GROUP BY Department, Culture, Style, Reign, Dynasty, Period, Movement, Nationality, School, Continent, SubContinent, Country, Region, River, og.State, County, City, Locale, Building, Excavation, Locus, 
Township, PoliticalRegion, Nation, RegionalCorp, VillageCorporation, CulturalRegion, SubRegion

--Art of the Americas and Art of the Americas, Glassell Collection
SELECT DISTINCT COUNT(o.ObjectID) AS ObjectCount, 
Department, Culture, Style, Reign, Dynasty, Period, Movement, Nationality, School, 
Continent, SubContinent, Country, Region, River, og.State, County, City, Locale, Building, Excavation, Locus, 
Township, PoliticalRegion, Nation, RegionalCorp, VillageCorporation, CulturalRegion, SubRegion
FROM Objects AS o
LEFT OUTER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID
LEFT OUTER JOIN ObjContext AS oc ON o.ObjectID = oc.ObjectID
LEFT OUTER JOIN ObjGeography AS og ON o.ObjectID = og.ObjectID 
WHERE o.ObjectID IN
(SELECT ObjectID FROM Objects WHERE DepartmentID IN (113, 16))
GROUP BY Department, Culture, Style, Reign, Dynasty, Period, Movement, Nationality, School, Continent, SubContinent, Country, Region, River, og.State, County, City, Locale, Building, Excavation, Locus, 
Township, PoliticalRegion, Nation, RegionalCorp, VillageCorporation, CulturalRegion, SubRegion


SELECT ConstituentID, DisplayName, Nationality, School, CultureGroup
FROM Constituents

SELECT DISTINCT COUNT(ConstituentID) AS ConstCount, Nationality, School, CultureGroup
FROM Constituents
GROUP BY Nationality, School, CultureGroup




SELECT * FROM ObjectPackages WHERE Name LIKE 'Dave%' --13219

SELECT * FROM ObjPkgList WHERE ObjectPackageID = 13219

SELECT * FROM ConGeoCodes --(0, Place; 1, Birth place; 2, Death place; 3, Active)


SELECT 
--Object
d.Department, o.ObjectID, o.ObjectNumber, 

--Object - Geography - Physical
og.Continent, 
og.SubContinent, 
og.Region, 
og.SubRegion,
og.River,

--Object - Geography - Cultural
og.CulturalRegion,

--Object - Geography - Political
og.Nation, 
og.Country, 
og.PoliticalRegion, 
og.RegionalCorp, 
og.State,
og.County,
og.City,
og.Township, 
og.VillageCorporation, 

--Object - Cultural Context
oc.Culture, oc.Nationality, oc.School, oc.Style, oc.Period, oc.Movement, oc.Reign, oc.Dynasty,

--Constituent
c.ConstituentID, c.DisplayName, 


--Constituent - Geography - Physical
cgc.ConGeoCode, 
cg.Continent, 
cg.SubContinent,
cg.Region,
cg.SubRegion,
cg.River,

--Constituent - Geography - Cultural
cg.CulturalRegion, 

--Constituent - Geography - Political
cg.Nation, 
cg.Country, 
cg.PoliticalRegion, 
cg.RegionalCorp,
cg.State,
cg.County,
cg.City,
cg.Township,
cg.VillageCorporation,


--Constituent - Cultural Context
c.CultureGroup, c.Nationality, c.School

FROM ObjPkgList					AS op
INNER JOIN Objects				AS o	ON op.ObjectID		= o.ObjectID
INNER JOIN ConXrefs				AS cx	ON o.ObjectID		= cx.ID
INNER JOIN Constituents			AS c	ON cx.ConstituentID	= c.ConstituentID
LEFT OUTER JOIN ConGeography	AS cg	ON c.ConstituentID	= cg.ConstituentID
LEFT OUTER JOIN ConGeoCodes		AS cgc	ON cg.GeoCodeID		= cgc.ConGeoCodeID
LEFT OUTER JOIN Departments		AS d	ON o.DepartmentID	= d.DepartmentID
LEFT OUTER JOIN ObjContext		AS oc	ON o.ObjectID		= oc.ObjectID
LEFT OUTER JOIN ObjGeography	AS og	ON o.ObjectID		= og.ObjectID 
WHERE	op.ObjectPackageID	= 13219
AND		cx.RoleTypeID		= 1

ORDER BY Department, c.ConstituentID









