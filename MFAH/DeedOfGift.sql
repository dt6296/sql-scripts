/*

SELECT * FROM ReportIDS WHERE ID = 110421

SELECT 
rids.ID,
ss.SUM_SQRT_ID
FROM ReportIDS AS rids
CROSS JOIN
(
	SELECT 
	SUM(SQRT(ID)) AS SUM_SQRT_ID
	FROM ReportIDs 
	WHERE ReportGUID = '48AA4706CF9342BAA0A6795858AD5320'
)
AS ss
WHERE ReportGUID = '48AA4706CF9342BAA0A6795858AD5320'

SELECT
ri.ID
FROM ReportIDs AS ri
WHERE ri.ReportGUID = '48AA4706CF9342BAA0A6795858AD5320'


*/
--------------------------------------------------------------------------------------------------------------------	Donor Name Check

SELECT
'DonorNameCheck' AS Attribute,
CASE WHEN SUM(NameIDcheck.ck) = 0 THEN 0 ELSE 1 END AS Value,
CASE WHEN SUM(NameIDcheck.ck) = 0 THEN 'Donor names match.' ELSE 'Donor names do not match!' END AS Label

FROM
(
	SELECT DISTINCT
	oad.ObjectID,
	cj.SUM_SQRT_NameID,
	SUM(SQRT(oad.cxd_NameID)) AS SUM_SQRT_NameIDck,
	CASE WHEN cj.SUM_SQRT_NameID = SUM(SQRT(oad.cxd_NameID)) THEN 0 ELSE 1 END AS ck

	FROM MFAHv_OBJ_AcquisitionDonor AS oad

	CROSS JOIN
	(
		SELECT DISTINCT
		SUM(SQRT(ad.cxd_NameID)) AS SUM_SQRT_NameID
		FROM MFAHv_OBJ_AcquisitionDonor AS ad
		INNER JOIN ReportIDs AS ri ON ad.ObjectID = ri.ID
		WHERE ReportGUID = '4E11CBD35ACE439B9E4BC3B03248CCDC'
		AND ad.cx_Active = 1
		AND ad.cx_Displayed = 1
		GROUP BY ad.ObjectID
	)
	AS cj

	WHERE oad.ObjectID IN
	(
		SELECT
		ri.ID
		FROM ReportIDs AS ri
		WHERE ri.ReportGUID = '4E11CBD35ACE439B9E4BC3B03248CCDC'
	)
	AND oad.cx_Active = 1
	AND oad.cx_Displayed = 1

	GROUP BY 
	oad.ObjectID,
	cj.SUM_SQRT_NameID

) AS NameIDcheck


UNION

--------------------------------------------------------------------------------------------------------------------	Accession Date Check

SELECT
'AccessionDateCheck' AS Attribute,
CASE WHEN SUM(AccDateCK.ck) = 0 THEN 0 ELSE 1 END AS Value,
CASE WHEN SUM(AccDateCK.ck) = 0 THEN 'Accession dates match.' ELSE 'Accession dates do not match!' END AS Label

FROM

(
	SELECT DISTINCT
	o.ObjectID,
	cj.SUM_SQRT_AccDate,
	SUM(SQRT(DATEDIFF(DD,o.AccessionDate,GETDATE()))) AS SUM_SQRT_AccDateCK,
	CASE WHEN cj.SUM_SQRT_AccDate = SUM(SQRT(DATEDIFF(DD,o.AccessionDate,GETDATE()))) THEN 0 ELSE 1 END AS ck

	FROM MFAHv_OBJ AS o

	CROSS JOIN
	(
		SELECT DISTINCT
		SUM(SQRT(DATEDIFF(DD,cjo.AccessionDate,GETDATE()))) AS SUM_SQRT_AccDate
		FROM MFAHv_OBJ AS cjo
		INNER JOIN ReportIDs AS ri ON cjo.ObjectID = ri.ID
		WHERE ReportGUID = '4E11CBD35ACE439B9E4BC3B03248CCDC'
		GROUP BY cjo.ObjectID
	)
	AS cj

	WHERE o.ObjectID IN
	(
		SELECT
		ri.ID
		FROM ReportIDs AS ri
		WHERE ri.ReportGUID = '4E11CBD35ACE439B9E4BC3B03248CCDC'
	)

	GROUP BY 
	o.ObjectID,
	cj.SUM_SQRT_AccDate

) AS AccDateCK



UNION


---------------------------------------------------------------------------------------------------------------- Ordinal Numbers


SELECT DISTINCT
'AccessionDateOrdinal' AS Attribute,
DATEPART(DD,o.AccessionDate) AS Value,
CASE	WHEN DATEPART(DD,o.AccessionDate) IN (11,12,13)
		THEN CAST(DATEPART(DD,o.AccessionDate) AS VARCHAR(10)) + 'th'
		WHEN DATEPART(DD,o.AccessionDate) % 10 = 1 THEN CAST(DATEPART(DD,o.AccessionDate) AS VARCHAR(10)) + 'st'
		WHEN DATEPART(DD,o.AccessionDate) % 10 = 2 THEN CAST(DATEPART(DD,o.AccessionDate) AS VARCHAR(10)) + 'nd'
		WHEN DATEPART(DD,o.AccessionDate) % 10 = 3 THEN CAST(DATEPART(DD,o.AccessionDate) AS VARCHAR(10)) + 'rd'
		ELSE CAST(DATEPART(DD,o.AccessionDate) AS VARCHAR(10)) + 'th'
		END AS Label
FROM MFAHv_OBJ AS o
INNER JOIN ReportIDs AS ri ON o.ObjectID = ri.ID AND ri.ReportGUID = '4E11CBD35ACE439B9E4BC3B03248CCDC'