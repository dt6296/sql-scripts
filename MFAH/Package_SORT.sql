


MFAHv_Packages

SELECT 
PackageID,
Name,
ItemCount
FROM Packages
UNION
SELECT
0,
'No Package',
(SELECT COUNT(*) FROM Objects)


MFAHv_PackageList

SELECT
PackageListID,
PackageID,
ID,
MainData,
OrderPOS
FROM PackageList
WHERE TableID = 108

UNION

SELECT
0,
0,
ObjectID,
ObjectNumber,
ROW_NUMBER() OVER (ORDER BY SortNumber) AS OrderPOS
FROM Objects

