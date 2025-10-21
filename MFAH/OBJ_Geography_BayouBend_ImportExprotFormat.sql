




--SELECT * FROM Packages WHERE Name LIKE '2019-06-04 Texas pottery, TMS vs Hill Archive'



SELECT
o.ObjectID,
o.ObjectNumber AS [Object Number],
o.SortNumber AS [Sort Number],
oc.DisplayName AS Constituent,
o.Title,
o.Dated,
o.Medium,
o.Description,
o.Markings AS [Mark(s)],
o.Inscribed AS [Inscription(s)],
og.Country AS [Geo - Nation/Country],
og.State AS [Geo - American State],
og.County AS [Geo - American County],
og.City AS [Geo - Inhabited Place]

FROM Objects AS o
LEFT OUTER JOIN MFAHv_OBJ_Constituent AS oc ON o.ObjectID = oc.o_ObjectID 
											AND oc.cx_RoleID = 413 -- Maker
											AND oc.cx_DisplayOrder = 1 
LEFT OUTER JOIN ObjGeography AS og ON o.ObjectID = og.ObjectID AND og.GeoCodeID = 37 -- Made in

WHERE o.ObjectID IN
(SELECT ID FROM PackageList WHERE PackageID = 243367)

ORDER BY o.SortNumber

