

SELECT
an.AltNumDescriptionID,
ad.AltNumDescription,
COUNT(*) AS Occurrences

FROM AltNums AS an
INNER JOIN AltNumDescriptions AS ad ON an.AltNumDescriptionID = ad.AltNumDescriptionID

GROUP BY 
an.AltNumDescriptionID,
ad.AltNumDescription










--------------------------------------------------------------------------------------------------- Find AltNumIDs

SELECT * FROM AltNumDescriptions WHERE AltNumDescription LIKE 'Previous Number'				 	--	745
SELECT * FROM AltNumDescriptions WHERE AltNumDescription LIKE 'Source Number'					--	827




--------------------------------------------------------------------------------------------------- Append old AltNumDescription to AltNum Remarks

--UPDATE AltNums SET Remarks = ISNULL(an.Remarks,'') + ' (' + ad.AltNumDescription + ')'
--SELECT an.*, ISNULL(an.Remarks,'') + ' (' + ad.AltNumDescription + ')'
FROM AltNums AS an
INNER JOIN AltNumDescriptions AS ad ON an.AltNumDescriptionID = ad.AltNumDescriptionID
WHERE ad.AltNumDescriptionID = 827 
AND an.TableID = 108

--------------------------------------------------------------------------------------------------- Change the AltNums.AltNumDescriptionID

--UPDATE AltNums 
SET AltNumDescriptionID = 745
WHERE AltNumDescriptionID IN (827)
AND TableID = 108

--------------------------------------------------------------------------------------------------- Double-check descriptions

SELECT an.AltNumID, an.AltNum, an.AltNumDescriptionID, an.Description_OLD, an.Remarks, ad.AltNumDescription AS NEW_AltNumDescription
FROM AltNums AS an
LEFT OUTER JOIN AltNumDescriptions AS ad ON an.AltNumDescriptionID = ad.AltNumDescriptionID
WHERE an.Remarks LIKE '%Source Number%'
AND an.TableID = 108




SELECT * FROM AltNums WHERE Description_OLD LIKE '%for a new world%'
--UPDATE AltNums SET Remarks = Description_OLD WHERE Description_OLD LIKE '%for a new world%'
--------------------------------------------------------------------------------------------------- Delete the unused AltNumDescriptions

SELECT * FROM AltNums AS an			-- check that there aren't any AltNums with the old AltNumDescription
--DELETE FROM AltNumDescriptions
WHERE AltNumDescriptionID IN
(
	SELECT
	ad.AltNumDescriptionID--, ad.AltNumDescription
	FROM AltNumDescriptions AS ad
	LEFT OUTER JOIN AltNums AS an ON ad.AltNumDescriptionID = an.AltNumDescriptionID
	WHERE an.AltNumDescriptionID IS NULL
	AND ad.TableID = 108
)


---------------------------------------------------------------------------------------------------

SELECT
AltNumDescriptionID,
AltNumDescription

FROM AltNumDescriptions

WHERE AltNumDescriptionID IN
(
	SELECT
	ad.AltNumDescriptionID--, ad.AltNumDescription
	FROM AltNumDescriptions AS ad
	LEFT OUTER JOIN AltNums AS an ON ad.AltNumDescriptionID = an.AltNumDescriptionID
	WHERE an.AltNumDescriptionID IS NULL
)


---------------------------------------------------------------------------------------------------

SELECT COUNT(*) FROM AltNums


