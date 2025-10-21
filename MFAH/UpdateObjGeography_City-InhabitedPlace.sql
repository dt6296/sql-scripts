


-- What's the PackageID?
SELECT * FROM Packages WHERE Name LIKE '2020-01-03 NYC%'		-- 275820

-- Which records will be updated?
SELECT REPLACE(City,'City','') AS NewValue, * FROM ObjGeography WHERE ObjectID IN
(
	SELECT ID FROM PackageList WHERE PackageID = 275820
)
AND City = 'New York City'


-- Update the records!
--UPDATE ObjGeography
SET City = REPLACE(City,'City','')
WHERE ObjectID IN
(
	SELECT ID FROM PackageList WHERE PackageID = 275820
)
AND City = 'New York City'



