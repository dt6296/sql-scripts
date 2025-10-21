


SELECT DISTINCT
bc.TableID,
ddt.TableName
FROM BCLabels AS bc
INNER JOIN DDTables AS ddt ON bc.TableID = ddt.TableID

/*

TableID	TableName
26		Crates
83		Locations
94		ObjComponents

*/

-- USE ObjContext.LongText10 for Barcodes


SELECT LongText10 FROM ObjContext WHERE LongText10 IS NOT NULL


SELECT
o.ObjectID,
o.ObjectNumber,
ISNULL(RTRIM(LTRIM(bcoc.LabelUUID)),'') AS Component,
ISNULL(RTRIM(LTRIM(bcl.LabelUUID)),'') AS Location,
ISNULL(RTRIM(LTRIM(bcc.LabelUUID)),'') AS Crate,

ISNULL(RTRIM(LTRIM(bcoc.LabelUUID)),'') + ' ' +
ISNULL(RTRIM(LTRIM(bcl.LabelUUID)),'') + ' ' +
ISNULL(RTRIM(LTRIM(bcc.LabelUUID)),'') AS Barcodes

FROM ObjContext					AS oc
INNER JOIN Objects				AS o	ON oc.ObjectID = o.ObjectID
INNER JOIN ObjComponents		AS cmp	ON o.ObjectID = cmp.ObjectID
LEFT OUTER JOIN BCLabels		AS bcoc	ON cmp.ComponentID = bcoc.ID AND bcoc.TableID = 94

LEFT OUTER JOIN ObjLocations	AS oloc	ON cmp.CurrentObjLocID = oloc.ObjLocationID
LEFT OUTER JOIN BCLabels		AS bcl	ON oloc.LocationID = bcl.ID AND bcl.TableID = 83

LEFT OUTER JOIN ObjLocations	AS olc	ON cmp.CurrentObjLocID = olc.ObjLocationID AND olc.CrateID > 1
LEFT OUTER JOIN	BCLabels		AS bcc	ON olc.CrateID = bcc.ID AND bcc.TableID = 26

--WHERE o.ObjectNumber LIKE ('TEST.DAVE.%') 
WHERE o.ObjectID = 130056





-- The barcode labels don't appear until I scroll through the component record ?!

-- Only 10854 records in BCLabels table, the above were created today as I scrolled through the records.  :(

SELECT
o.ObjectID,
o.ObjectNumber,
ISNULL(RTRIM(LTRIM(bcoc.LabelUUID)),'') AS Component
FROM Objects					AS o
INNER JOIN ObjComponents		AS cmp	ON o.ObjectID = cmp.ObjectID
LEFT OUTER JOIN BCLabels		AS bcoc	ON cmp.ComponentID = bcoc.ID AND bcoc.TableID = 94
WHERE o.ObjectNumber LIKE ('TEST.DAVE.%') 



SELECT * FROM BCLabels
