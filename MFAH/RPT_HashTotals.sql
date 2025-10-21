

SELECT 
p.PackageID,p.Name,p.ItemCount,pl.ID AS ObjectID,pl.OrderPos,r.HashTotal,p.HashTotal2
FROM
(
	SELECT
	p.PackageID,p.Name,p.ItemCount,p.PackageType,SUM(pl.ID) AS HashTotal,SUM(pl.ID)+p.PackageID AS HashTotal2
	FROM Packages AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	WHERE pl.TableID = 108
	AND p.PackageType = 1
	GROUP BY
	p.PackageID,p.Name,p.ItemCount,p.PackageType
) AS p
INNER JOIN
(
	SELECT
	SUM(ID) AS HashTotal,SessionID
	FROM ReportIDs AS rid
	GROUP BY
	ReportGUID,	SessionID
) AS r ON p.HashTotal = r.HashTotal
INNER JOIN
PackageList AS pl
ON p.PackageID = pl.PackageID

WHERE p.PackageID = 117368




	SELECT
	p.PackageID,p.Name,p.ItemCount,p.PackageType,SUM(pl.ID) AS HashTotal,SUM(pl.ID)+p.PackageID AS HashTotal2
	FROM Packages AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	WHERE pl.TableID = 108
	AND p.PackageType = 1
	AND p.PackageID = 117368
	GROUP BY
	p.PackageID,p.Name,p.ItemCount,p.PackageType
	


	
	SELECT
	SUM(ID) AS HashTotal,SessionID
	FROM ReportIDs AS rid
	GROUP BY
	ReportGUID,	SessionID




SELECT r1.* 
FROM MFAHv_RPT_HashTotal AS r1
INNER JOIN
(
	SELECT
	p.PackageID,p.Name,p.ItemCount,p.PackageType,SUM(pl.ID) AS HashTotal,SUM(pl.ID)+p.PackageID AS HashTotal2
	FROM Packages AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	WHERE pl.TableID = 108
	AND p.PackageType = 1
	--AND p.PackageID = 117368
	GROUP BY
	p.PackageID,p.Name,p.ItemCount,p.PackageType
)	AS r2 ON r1.HashTotal2 = r2.HashTotal2





-------------------------------------------------------------------------------



SELECT * FROM ReportIDs

SELECT * FROM MFAHv_PKG_HashTotal WHERE HashTotal = 1011211





SELECT
pht.*
FROM MFAHv_PKG_HashTotal AS pht
INNER JOIN
(
	SELECT
	r.ReportGUID,
	r.SessionID,
	SUM(CAST(ID AS BIGINT)) AS HashTotal
	FROM ReportIDs AS r
	GROUP BY
	r.ReportGUID,
	r.SessionID
)	AS rpt ON pht.HashTotalP = (rpt.HashTotal + pht.PackageID)
