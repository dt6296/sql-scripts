/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ObjectID]
      ,[KeywordNotes]
      ,[KeywordReviewNotes]
  FROM [TMS].[dbo].[MFAHt_IMPORT_Keywords]

  ORDER BY ObjectID

  DELETE FROM [MFAHt_IMPORT_Keywords]

  SELECT * FROM [MFAHt_IMPORT_Keywords] WHERE ObjectID IN
  (
	  SELECT ObjectID
	  FROM [MFAHt_IMPORT_Keywords]
	  GROUP BY ObjectID
	  HAVING COUNT(ObjectID) > 1
  )



  SELECT
  oc.ObjectID,
  oc.LongText10, KeywordNotes,
  oc.ShortText1, KeywordReviewNotes

  FROM ObjContext AS oc
  INNER JOIN MFAHt_IMPORT_Keywords AS k ON oc.ObjectID = k.ObjectID

  WHERE oc.ObjectID NOT IN
    (
	  SELECT ObjectID
	  FROM [MFAHt_IMPORT_Keywords]
	  GROUP BY ObjectID
	  HAVING COUNT(ObjectID) > 1
  )




--UPDATE ObjContext
SET LongText10 = KeywordNotes,
ShortText1 = KeywordReviewNotes
  
FROM ObjContext AS oc
INNER JOIN MFAHt_IMPORT_Keywords AS k ON oc.ObjectID = k.ObjectID

WHERE oc.ObjectID NOT IN
(
	  SELECT ObjectID
	  FROM [MFAHt_IMPORT_Keywords]
	  GROUP BY ObjectID
	  HAVING COUNT(ObjectID) > 1
)

-- 2018 imported 11/25/2019 2:00 PM, 422 records.
-- 2019 imported 02/17/2020 9:30 AM, 522 records, 1 duplicate ObjectID = 142216, (2019.12)
-- 2016 imported 03/11/2020 1:15 PM , 281 records, no duplicates
