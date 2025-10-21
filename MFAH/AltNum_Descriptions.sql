
SELECT * FROM AltNums ORDER BY Description, Remarks



SELECT
TableID, ID, AltNumID, AltNum,
Description, Remarks, LoginID, EnteredDate
FROM AltNums
--GROUP BY Description, Remarks, TableID, AltNum
ORDER BY TableID, Description, Remarks

SELECT DISTINCT Description, COUNT(*) AS Records FROM AltNums WHERE TableID = 108 GROUP BY Description ORDER BY Description


----------------------------------------------------------------------------- ULAN	DONE

SELECT 
a.AltNum,
a.Description
FROM AltNums AS a
WHERE a.TableID = 23
AND a.AltNum = 'ULAN'	-- 9526
ORDER BY a.Description

SELECT 
a.AltNum,
a.Description
FROM AltNums AS a
WHERE a.TableID = 23
AND (a.Description LIKE '500%' OR a.Description = 'None')	--9516

--UPDATE AltNums
SET AltNum = Description
WHERE TableID = 23
AND AltNum = 'ULAN'	-- 9526

--UPDATE AltNums
SET Description = 'ULAN'
WHERE TableID = 23
AND (Description LIKE '500%' OR Description = 'None')	--9516


----------------------------------------------------------------------- Temporary Receipt Number   DONE

SELECT
*
FROM AltNums
WHERE Description LIKE 'temp%'	--	44603

SELECT DISTINCT Description FROM AltNums WHERE Description LIKE 'temp%'	--	51

--UPDATE AltNums
SET Description = 'Temporary Receipt Number'
WHERE Description LIKE 'temp%'					-- 44603



SELECT *
FROM AltNums
WHERE Description LIKE 'te%rec%'
AND Description <> 'Temporary Receipt Number'	--	15

UPDATE AltNums
SET Description = 'Temporary Receipt Number'
WHERE Description LIKE 'te%rec%'
AND Description <> 'Temporary Receipt Number'	--	15




----------------------------------------------------------------------------- Accession Number

SELECT *, Description + ' ' + ISNULL(Remarks,'')
FROM AltNums
WHERE Description LIKE '%acc%'
AND Description <> 'Nonaccessioned property #'
AND Description <> 'Display Accession Number' 
AND Description <> 'Blaffer Foundation Acc. #:' 
AND Description NOT LIKE '%previous%'
AND Description NOT LIKE '%former%'
AND Description NOT LIKE '%incorrect%'					--	2120


--UPDATE AltNums
SET Remarks = Description + ' ' + ISNULL(Remarks,'')
WHERE Description LIKE '%acc%'
AND Description <> 'Nonaccessioned property #'
AND Description <> 'Display Accession Number' 
AND Description <> 'Blaffer Foundation Acc. #:' 
AND Description NOT LIKE '%previous%'
AND Description NOT LIKE '%former%'
AND Description NOT LIKE '%incorrect%'

--UPDATE AltNums
SET Description = 'Accession Number'
WHERE Description LIKE '%acc%'
AND Description <> 'Nonaccessioned property #'
AND Description <> 'Display Accession Number' 
AND Description <> 'Blaffer Foundation Acc. #:' 
AND Description NOT LIKE '%previous%'
AND Description NOT LIKE '%former%'
AND Description NOT LIKE '%incorrect%'


----------------------------------------------------------------------------- Inventory Number

SELECT
*
FROM AltNums
WHERE Description LIKE '%inv%'

--UPDATE AltNums
SET Remarks = Description + ' ' + ISNULL(Remarks,'')
WHERE Description LIKE '%inv%'

--UPDATE AltNums
SET Description = 'Inventory Number'
WHERE Description LIKE '%inv%'




