

--Photography Donors


SELECT DISTINCT ad.cx_Role, ad.can_DisplayName, ad.can_AlphaSort, COUNT(ad.ObjectID) AS ObjectCount,
ca.DisplayAddress, ca.AddressType, ca.StreetLine1, ca.StreetLine2, ca.StreetLine3, ca.City, ca.State, ca.Country,ca.ZipCode


FROM MFAHv_OBJ_AcquisitionDonor AS ad
INNER JOIN Objects AS o ON ad.ObjectID = o.ObjectID
LEFT OUTER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID
LEFT OUTER JOIN MFAHv_CON_Address AS ca ON ad.c_ConstituentID = ca.ConstituentID
										AND ca.Active = 1
										--AND ca.DefaultMailing = 1

WHERE o.DepartmentID IN (11,153)

GROUP BY ad.cx_Role, ad.can_DisplayName, ad.can_AlphaSort, ca.DisplayAddress, ca.AddressType, ca.StreetLine1, ca.StreetLine2, ca.StreetLine3, ca.City, ca.State, ca.Country,ca.ZipCode

ORDER BY ad.can_AlphaSort
