

SELECT
r.RoleID,
r.Role,
rt.RoleTypeID,
rt.RoleType

FROM Roles AS r
INNER JOIN RoleTypes AS rt ON r.RoleTypeID = rt.RoleTypeID

ORDER BY r.Role, rt.RoleType

RoleID 19, 421, 427






SELECT
-----Political Geography

og.Nation,
og.Country,
og.PoliticalRegion,
og.State,

COALESCE(og.Nation,og.Country,og.PoliticalRegion,og.State,'')	AS CPS1,
COALESCE(og.Country,og.PoliticalRegion,og.State,'')				AS CPS2,
COALESCE(og.PoliticalRegion,og.State,'')						AS CPS3,
COALESCE(og.State,'')											AS CPS4,

COALESCE(og.Nation,', ',og.Country,'')			AS cp,




--COALESCE(og.Nation,og.Country)			AS c1,
--COALESCE(og.Country,PoliticalRegion)	AS c2,
--COALESCE(og.PoliticalRegion,og.State)	AS c3,

--COALESCE(og.Nation,og.Country,og.PoliticalRegion,og.State)	+ ', ' +
--COALESCE(PoliticalRegion,og.State)	AS c4

FROM ObjGeography AS og
LEFT OUTER JOIN GeoCodes AS gc ON og.GeoCodeID = gc.GeoCodeID

WHERE og.ObjectID IN (110421, 2, 45089)

GO


