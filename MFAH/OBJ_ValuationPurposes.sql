
--Object Insurance Valuation Purposes


/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ValuationPurposeID]
      ,[ValuationPurpose]
      ,[LoginId]
      ,[EnteredDate]
      ,[SysTimeStamp]
      ,[System]
  FROM [TMS].[dbo].[ValuationPurposes]
  
  




SELECT COUNT(oi.ObjInsuranceID) AS RecordCount, oi.ValuationPurposeID, vp.ValuationPurpose
FROM ObjInsurance AS oi
RIGHT OUTER JOIN ValuationPurposes AS vp ON oi.ValuationPurposeID = vp.ValuationPurposeID
GROUP BY oi.ValuationPurposeID, vp.ValuationPurpose
ORDER BY vp.ValuationPurpose