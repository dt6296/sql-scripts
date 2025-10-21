






SELECT TOP 75
SUM(InsuranceValue) AS Value,
COUNT(ObjectID) AS Objects,
DonorName,
c_ConstituentID AS ConstituentID,
ConstituentType
FROM [dbo].[MFAHvr_OBJ_Value_Gifts]
WHERE FY IN (2011,2012,2013,2014,2015) 
GROUP BY DonorName, ConstituentType, c_ConstituentID
ORDER BY SUM(InsuranceValue) DESC, COUNT(ObjectID) DESC
