
--SELECT * FROM Exhibitions WHERE ExhTitle LIKE 'FY2021:Kinder: Inaugural%'


SELECT DISTINCT 
o.ExhibitionID,
e.ExhTitle,
c.ConstituentID, 
c.EndDate, 
c.AlphaSort, 
c.DisplayName, 
c.DisplayDate,
can.Institution, 
can.NameTitle, 
can.salutation, 
can.FirstName, 
can.LastName, 
can.Suffix,
at.AddressType, 
CASE WHEN ca.Active = 1 THEN 'Yes' ELSE CASE WHEN ca.Active = 0 THEN 'No' ELSE CAST(ca.Active AS VARCHAR(5)) END END AS IsActive, 
ca.StreetLine1, 
ca.StreetLine2, 
ca.StreetLine3, 
ca.City, 
ca.[State], 
country.Country, 
ca.ZipCode,
dbo.MFAHfx_ConcatEmail(c.ConstituentID) AS Email

FROM ConXrefDetails AS cxd
INNER JOIN ConXrefs AS cx ON cxd.ConXrefID = cx.ConXrefID
INNER JOIN 
(
	SELECT ObjectID, ExhibitionID FROM ExhObjXrefs
	WHERE ExhibitionID IN
	(
		SELECT ExhibitionID FROM Exhibitions WHERE ExhTitle LIKE 'FY2021:Kinder: Inaugural%'
	) 
) AS o
ON cx.ID = o.ObjectID AND cx.TableID = 108 AND cx.RoleTypeID = 1
INNER JOIN Constituents AS c ON cxd.ConstituentID = c.ConstituentID
LEFT OUTER JOIN ConAltNames AS can ON c.ConstituentID = can.ConstituentID
									AND can.NameType = 'Primary Name'
LEFT OUTER JOIN ConAddress AS ca ON c.ConstituentID = ca.ConstituentID
AND ca.Active = 1
LEFT OUTER JOIN AddressTypes AS at ON ca.AddressTypeID = at.AddressTypeID
LEFT OUTER JOIN Countries AS country ON ca.CountryID = country.CountryID
LEFT OUTER JOIN Exhibitions AS e ON o.ExhibitionID = e.ExhibitionID

WHERE (c.EndDate IS  NULL OR c.EndDate = 0)

ORDER BY c.AlphaSort