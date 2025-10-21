USE [TMS]
GO

/****** Object:  View [dbo].[MFAHv_OCM_Object-TitleDisplayed]    Script Date: 04/08/2014 12:36:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--CREATE VIEW [dbo].[MFAHv_OCM_Object-TitleDisplayed]
--AS

SELECT
ot.ObjectID,
ot.TitleID,
ot.Title,
ot.TitleTypeID,
tt.TitleType,
ot.LanguageID,
l.Language,
ot.Remarks,
ot.Active,
CASE WHEN ot.Active = 1 THEN 'Active' ELSE 'Inactive' END AS ActiveLabel,
ot.EnteredDate,
ot.LoginID,
ot.DisplayOrder,
ot.Displayed,
CASE WHEN ot.Displayed = 1 THEN 'Displayed' ELSE 'Not Displayed' END AS DisplayedLabel,
ot.SysTimeStamp
FROM ObjTitles AS ot
LEFT OUTER JOIN TitleTypes AS tt ON ot.TitleTypeID = tt.TitleTypeID
LEFT OUTER JOIN Languages AS l ON ot.LanguageID = l.LanguageID

WHERE ot.Displayed = 1
AND ot.ObjectID = 110421


 


SELECT duesid, dueskey
FROM
(
	SELECT duesid, dueskey, RANK() OVER(PARTITION BY duesid ORDER BY duesprocdt) AS RankByDate
	FROM dues_full
	WHERE duesacctno = '40010' 
) AS d
WHERE d.RankByDate = 1



