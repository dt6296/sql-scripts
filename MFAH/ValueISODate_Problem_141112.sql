




SELECT DISTINCT

--ApprovalISODate1
--ApprovalISODate2
--AccessionISODate

--dbo.MFAHfx_ISOtoDATETIME(AccessionISODate)


FROM ObjAccession

ORDER BY 
--dbo.MFAHfx_ISOtoDATETIME(AccessionISODate)
 DESC


SELECT DISTINCT ApprovalISODate1
FROM ObjAccession
WHERE LEN(ApprovalISODate1) <>10
ORDER BY ApprovalISODate1 DESC

SELECT DISTINCT ApprovalISODate2
FROM ObjAccession
WHERE LEN(ApprovalISODate2) <>10
ORDER BY ApprovalISODate2 DESC

SELECT DISTINCT AccessionISODate
FROM ObjAccession
WHERE LEN(AccessionISODate) <> 10
ORDER BY AccessionISODate DESC


SELECT DISTINCT AccessionISODate, LEN(AccessionISODate)
FROM ObjAccession
WHERE AccessionISODate LIKE '2000%'
--WHERE LEN(AccessionISODate) <>10
ORDER BY AccessionISODate DESC






SELECT DISTINCT dbo.MFAHfx_ISOtoDATETIME(ApprovalISODate1)
FROM ObjAccession
WHERE LEN(ApprovalISODate1) <>10
ORDER BY dbo.MFAHfx_ISOtoDATETIME(ApprovalISODate1) DESC

SELECT DISTINCT dbo.MFAHfx_ISOtoDATETIME(ApprovalISODate2)
FROM ObjAccession
WHERE LEN(ApprovalISODate2) <>10
ORDER BY dbo.MFAHfx_ISOtoDATETIME(ApprovalISODate2) DESC

SELECT DISTINCT dbo.MFAHfx_ISOtoDATETIME(AccessionISODate)
FROM ObjAccession
WHERE LEN(AccessionISODate) <>10
ORDER BY dbo.MFAHfx_ISOtoDATETIME(AccessionISODate) DESC


SELECT DISTINCT dbo.MFAHfx_ISOtoDATETIME(AccessionISODate)
FROM ObjAccession
WHERE AccessionISODate = '2000'
ORDER BY dbo.MFAHfx_ISOtoDATETIME(AccessionISODate) DESC



SELECT * FROM ObjAccession WHERE AccessionISODate = '2000'

SELECT dbo.MFAHfx_ISOtoDATETIME(AccessionISODate) FROM ObjAccession WHERE AccessionISODate = '0987'

SELECT ObjectNumber FROM Objects WHERE ObjectID IN
(
48186,
50914,
50916,
50919,
50920,
57691
)


SELECT dbo.MFAHfx_ISOtoDATETIME(AccessionISODate) FROM ObjAccession WHERE ObjectID = 50921



SELECT DISTINCT dbo.MFAHfx_ISOtoDATETIME(ValueISODate)
FROM ObjInsurance
WHERE LEN(ValueISODate) = 10
ORDER BY dbo.MFAHfx_ISOtoDATETIME(ValueISODate) DESC



SELECT DISTINCT 
ValueISODate
FROM ObjInsurance
--WHERE LEN(ValueISODate) <> 10
ORDER BY ValueISODate ASC


SELECT dbo.MFAHfx_ISOtoDATETIME(ValueISODate) FROM ObjInsurance WHERE ValueISODate = '1797-07-27'

SELECT * FROM ObjInsurance WHERE ValueISODate = '1012-12-31'
SELECT * FROM Objects WHERE ObjectID = 19494 --BF.1979.5


SELECT * FROM ObjInsurance WHERE ValueISODate = '0133-03-19'
SELECT * FROM Objects WHERE ObjectID = 101179 --2012.439.19


SELECT * FROM ObjInsurance WHERE ValueISODate = '0122-10-09'
SELECT * FROM Objects WHERE ObjectID = 91616 --2012.349


SELECT * FROM ObjInsurance WHERE ValueISODate = '0108-06-28'
SELECT * FROM Objects WHERE ObjectID = 91553 --2008.288


SELECT * FROM ObjInsurance WHERE ValueISODate = '0107-04-17'
SELECT * FROM Objects WHERE ObjectID = 81179 --2007.348



SELECT * FROM ObjInsurance WHERE ValueISODate = '0106-05-30'
SELECT * FROM Objects WHERE ObjectID = 58620 --2002.4101


SELECT * FROM ObjInsurance WHERE ValueISODate = '0103-06-30'
SELECT * FROM Objects WHERE ObjectID = 61817 --2003.308


SELECT * FROM ObjInsurance WHERE ValueISODate = '0103-04-21'
SELECT * FROM Objects WHERE ObjectID = 22797 --2002.3492


SELECT * FROM ObjInsurance WHERE ValueISODate = '0101-12-06'
SELECT * FROM Objects WHERE ObjectID = 31594 --96.20.6



SELECT * FROM ObjInsurance WHERE ValueISODate = '0190'
SELECT * FROM Objects WHERE ObjectID = 13859 --90.153



SELECT * FROM ObjInsurance WHERE ValueISODate = '0232-07-07'
SELECT * FROM Objects WHERE ObjectID = 86571 --2006.356



SELECT * FROM ObjInsurance WHERE ValueISODate = '0100'
SELECT * FROM Objects WHERE ObjectID = 84523 --2006.717.3

SELECT * FROM ObjInsurance WHERE ValueISODate = '0987'
SELECT * FROM Objects WHERE ObjectID = 11643 --87.373


SELECT * FROM ObjInsurance WHERE ValueISODate = '19982 AD'
SELECT * FROM Objects WHERE ObjectID = 6230 --82.269


SELECT * FROM ObjInsurance WHERE ObjInsuranceID = 6147


--UPDATE ObjInsurance
SET CurrencyRateISODate = '1982'
--SELECT * FROM ObjInsurance
WHERE ObjInsuranceID = 6147

SELECT DISTINCT 
dbo.MFAHfx_ISOtoDATETIME(ValueISODate)
FROM ObjInsurance
WHERE LEN(ValueISODate) <> 10
ORDER BY dbo.MFAHfx_ISOtoDATETIME(ValueISODate) DESC



SELECT * FROM ObjInsurance WHERE LEN(ValueISODate) <> 10 ORDER BY ValueISODate DESC

SELECT ObjectNumber FROM Objects WHERE ObjectID = 74639  --2005.328





----------------------------------------------------------

SELECT DISTINCT
ReportStatus
FROM MFAHvr_OBJ_Value_Acquisitions

SELECT DISTINCT
ObjectStatus
FROM MFAHvr_OBJ_Value_Acquisitions

SELECT DISTINCT
FY
FROM MFAHvr_OBJ_Value_Acquisitions





SELECT DISTINCT
ObjectStatus
FROM MFAHv_OBJ_Value

SELECT DISTINCT
FY
FROM MFAHv_OBJ_Value












