USE [TMS]
GO

/****** Object:  View [dbo].[vListViewClassifications]    Script Date: 06/24/2014 12:41:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--CREATE VIEW [dbo].[vListViewClassifications] AS

SELECT

cl.ClassificationID,
CASE	WHEN cl.SubClassification	IS NULL OR cl.SubClassification = ''
		THEN cl.Classification
			
		WHEN cl.SubClassification2	IS NULL OR cl.SubClassification2 = ''
		THEN cl.Classification + '-' + cl.SubClassification
			
		WHEN cl.SubClassification3	IS NULL OR cl.SubClassification3 = ''
		THEN cl.Classification + '-' + cl.SubClassification + '-' + cl.SubClassification2
			
ELSE cl.Classification + '-' + cl.SubClassification + '-' + cl.SubClassification2 + '-' + cl.SubClassification3
END		AS Classification

FROM	Classifications	AS cl



GO


