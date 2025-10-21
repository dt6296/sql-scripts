


DECLARE @SearchString varchar(50)
SET @SearchString = '%amphor%'

SELECT     SQTerms_2.TermID AS STermID, SQTerms_1.Term AS STerm1, SQTerms_2.Term AS STerm2
FROM         dbo.Terms AS SQTerms_2 INNER JOIN
                      dbo.TermMaster AS SQTermMaster ON SQTerms_2.TermMasterID = SQTermMaster.TermMasterID INNER JOIN
                      dbo.Terms AS SQTerms_1 ON SQTermMaster.TermMasterID = SQTerms_1.TermID
WHERE     (SQTerms_2.Term LIKE @SearchString) AND (SQTermMaster.ThesaurusBaseID = 1) OR
                      (SQTermMaster.ThesaurusBaseID = 1) AND (SQTerms_1.Term LIKE @SearchString)
ORDER BY SQTerms_2.TermID



SELECT     TMS.dbo.Objects.ObjectID, Terms.Term, Terms.TermID, TMS.dbo.ThesXrefs.TermID AS TXR_TermID, TMS.dbo.Objects.ObjectNumber, 
                      TMS.dbo.Objects.DepartmentID, TMS.dbo.Objects.ObjectStatusID, TMS.dbo.Objects.ClassificationID, TMS.dbo.Objects.SubClassID, 
                      TMS.dbo.Objects.Type, TMS.dbo.Objects.ObjectName, TMS.dbo.Objects.Dated, TMS.dbo.Objects.Title, TMS.dbo.Objects.Medium, 
                      TMS.dbo.Objects.Dimensions, TMS.dbo.Objects.Description, TMS.dbo.ThesXrefs.ThesXrefID, TMS.dbo.ThesXrefs.ThesXrefTypeID, 
                      TMS.dbo.ThesXrefs.TableID
FROM         Terms RIGHT OUTER JOIN
                      TMS.dbo.ThesXrefs ON Terms.TermID = TMS.dbo.ThesXrefs.TermID LEFT OUTER JOIN
                      TMS.dbo.Objects ON TMS.dbo.ThesXrefs.ID = TMS.dbo.Objects.ObjectID
WHERE Terms.TermID IN
(
--DECLARE @SearchString varchar(50)
--SET @SearchString = '%vase%'
SELECT     SQTerms_2.TermID    --,SQTerms_2.Term
FROM         dbo.Terms AS SQTerms_2 INNER JOIN
                      dbo.TermMaster AS SQTermMaster ON SQTerms_2.TermMasterID = SQTermMaster.TermMasterID INNER JOIN
                      dbo.Terms AS SQTerms_1 ON SQTermMaster.TermMasterID = SQTerms_1.TermID
WHERE     (SQTerms_2.Term LIKE @SearchString) AND (SQTermMaster.ThesaurusBaseID = 1) OR
                      (SQTermMaster.ThesaurusBaseID = 1) AND (SQTerms_1.Term LIKE @SearchString)
)
ORDER BY Terms.TermID


select * from terms where termid = 24952