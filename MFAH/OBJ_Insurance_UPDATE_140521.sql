


/*

Update Object Insurance codes.
All assigned valuations should be recoded to "Insurance Value"
except for the following:

		(to be manually moved to another table)
		count	code	value
		 -   	NULL	Cost: Additional Insurance Premium
			1	18		Cost: Matting/Framing
		1,474	15		Cost: Shipping/Crating/Import Fees
			4	19		Cost: Storage Housing


		Keep these values
		count	code	value
		  610	12		3rd Party Appraisal for Indemnity
		  250	14		One Great Night funded price
		9,701	 4		Purchase Price
		  294	13		Value for Indemnity

DO NOT UPDATE THESE
count	code	value
13,139	 0		(not assigned)
55,817	 7		Insurance Value


UPDATE THE FOLLOWING
count	code	value
    43	 6		Appraisal
 1,766	10		Current Insurance Value
10,974	 3		Current System Value
18,522	 2		Current Value
     3	 9		Frame Value Only
 2,060	 5		Initial System Value
 8,769	 1		Initial Value
   116	 8		Insurance Appraisal
    51	16		Lending Institution
   344 	11		Previous Insurance Value

42,648 	TOTAL to be updated to 7 - Insurance Value

*/

SELECT COUNT(oi.ValuationPurposeID)
FROM ObjInsurance AS oi
WHERE oi.ValuationPurposeID IN
(6,10,3,2,9,5,1,8,16,11)

--42648

SELECT oi.ValuationPurposeID, oi.ValueNotes
FROM ObjInsurance AS oi
WHERE oi.ValuationPurposeID IN
(6,10,3,2,9,5,1,8,16,11)

SELECT
oi.ObjInsuranceID, oi.ValueNotes
FROM ObjInsurance AS oi
WHERE oi.ValueNotes LIKE '%DMU 2010%'
--99711

SELECT
oi.ObjInsuranceID,
oi.ValueNotes,
REPLACE(oi.ValueNotes,'DMU 2010','')
FROM ObjInsurance AS oi
WHERE oi.ValueNotes LIKE '%DMU 2010%'


SELECT 
oi.ObjInsuranceID,
oi.ValueNotes

INTO MFAHt_ObjInsurance_ValueNotes_140521

FROM ObjInsurance AS oi
WHERE oi.ValueNotes LIKE '%DMU 2010%'

--
--(99711 row(s) affected)

--UPDATE ObjInsurance
SET ValueNotes = REPLACE(ValueNotes,'DMU 2010','')
WHERE ValueNotes LIKE '%DMU 2010%'

--(99711 row(s) affected)

SELECT
oi.ObjInsuranceID, oi.ValueNotes
FROM ObjInsurance AS oi
WHERE oi.ValueNotes LIKE '%DMU 2010%'
--0


-----------------------------------------------------

SELECT
oi.ObjInsuranceID,
oi.ValuationPurposeID,
vp.ValuationPurpose,
oi.ValueNotes,

CASE WHEN oi.ValueNotes IS NULL THEN '(Recoded 5/21/2014 from "' + CAST(oi.ValuationPurposeID AS VARCHAR(10)) + ': ' + vp.ValuationPurpose + '")'
ELSE
REPLACE(oi.ValueNotes,oi.ValueNotes,oi.ValueNotes + '  (Recoded 5/21/2014 from "' + CAST(oi.ValuationPurposeID AS VARCHAR(10)) + ': ' + vp.ValuationPurpose + '")')
END
	
FROM ObjInsurance AS oi
INNER JOIN ValuationPurposes AS vp ON oi.ValuationPurposeID = vp.ValuationPurposeID
WHERE oi.ValuationPurposeID IN
(6,10,3,2,9,5,1,8,16,11)





--UPDATE
ObjInsurance

SET
ValuationPurposeID = 7,
ValueNotes = 
	CASE WHEN oi.ValueNotes IS NULL THEN '(Recoded 5/21/2014 from "' + CAST(oi.ValuationPurposeID AS VARCHAR(10)) + ': ' + vp.ValuationPurpose + '")'
	ELSE
	REPLACE(oi.ValueNotes,oi.ValueNotes,oi.ValueNotes + '  (Recoded 5/21/2014 from "' + CAST(oi.ValuationPurposeID AS VARCHAR(10)) + ': ' + vp.ValuationPurpose + '")')
	END

FROM ObjInsurance AS oi
INNER JOIN ValuationPurposes AS vp ON oi.ValuationPurposeID = vp.ValuationPurposeID

WHERE oi.ValuationPurposeID IN
(6,10,3,2,9,5,1,8,16,11)

--(42644 row(s) affected)



SELECT COUNT(oi.ValuationPurposeID)
FROM ObjInsurance AS oi
WHERE oi.ValuationPurposeID IN
(6,10,3,2,9,5,1,8,16,11)

--0



SELECT COUNT(oi.ObjInsuranceID) AS RecordCount, oi.ValuationPurposeID, vp.ValuationPurpose
FROM ObjInsurance AS oi
RIGHT OUTER JOIN ValuationPurposes AS vp ON oi.ValuationPurposeID = vp.ValuationPurposeID
GROUP BY oi.ValuationPurposeID, vp.ValuationPurpose
ORDER BY vp.ValuationPurpose