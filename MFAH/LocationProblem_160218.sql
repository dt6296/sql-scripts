


/*


SELECT * FROM ConAddress
WHERE ConstituentID = 0

SELECT * FROM ConAddress
WHERE ConAddressID = 51


SELECT * FROM Locations
WHERE Site IS NULL

SELECT * FROM ConAddress
WHERE ConAddressID = 15176

*/




SELECT
l.LocationID,
l.LocationString,
l.EnteredDate	AS l_EnteredDate,
l.LoginID		AS l_LoginID,
l.AddressID,
ca.ConAddressID,
ca.ShortName,
ca.StreetLine1,
ca.IsLocation,
ca.EnteredDate	AS ca_EnteredDate,
ca.LoginID		AS ca_LoginID
FROM Locations AS l
FULL OUTER JOIN ConAddress AS ca ON l.AddressID = ca.ConAddressID
WHERE (l.Site IS NULL
AND LocationID = 12098)	--  originally "01 LAW BUILDING" location
OR ca.ConAddressID = 51	--	LAW address




SELECT * FROM ConAddress WHERE ConAddressID = 51
SELECT * FROM Locations WHERE LocationID = 12098


/*  - in order of execution

UPDATE ConAddress
SET ShortName = '01 LAW BUILDING'	-- from '13 HARWIN WAREHOUSE'
WHERE ConAddressID = 51


UPDATE Locations 
SET LocationString = '01 LAW BUILDING', AddressID = 51  -- from '13 HARWIN WAREHOUSE' and 15176
WHERE LocationID = 12098


UPDATE Locations 
SET LocationString = '13 HARWIN WAREHOUSE'
WHERE LocationID = 12098

UPDATE ConAddress
SET ShortName = '13 HARWIN WAREHOUSE'	
WHERE ConAddressID = 51

UPDATE Locations 
SET AddressID = 15176  -- from '13 HARWIN WAREHOUSE' and 15176
WHERE LocationID = 12098

*/

Select * from ConAddress where streetLine1 like '01%'

select * from Constituents where DisplayName like 'The Museum of fine arts%'

Select * from ConAddress where ConstituentID = 0

Select addressID,  LocationString from locations where AddressID = 15176

Select 


SELECT * FROM Locations
WHERE Site LIKE '%LAW BUILDING%'


--Update ConAddress set ShortName = '01 LAW BUILDING' WHERE CONADDRESSID = 51

--UPDATE LOCATIONS SET ADDRESSID = 51 WHERE ADDRESSID = 15176

SELECT * FROM LOCATIONS where AddressID = 15176

SELECT * FROM LOCATIONS where AddressID = 51


