select * from dbo.ThesaurusBases


select * from dbo.Associations		--0
select * from dbo.DDLanguages		--13
select * from dbo.Relationships		--0
select * from dbo.Sources			--0
select * from dbo.TermClasses		--1, TermClassID = 0, ThesaurusBaseID = -1, TermClass = [not entered]
select * from dbo.TermLanguages		--1, [not assigned]
select * from dbo.TermMaster		--36,340 (ID, source term ID, enterd/modified, scope, history, ThesBaseID, node depth, classid, children...)
select * from dbo.TermMasterDates	--2, both by DPearce?
select * from dbo.TermMasterGeo		--0
select * from dbo.TermMasterLevel	--8, 5 by DTHompson, 3 by DPearce?
select * from dbo.Terms				--164,032 terms
select * from dbo.TermSourceXrefs	--0	
select * from dbo.TermTypes			--17, TermTypeID, TermTypeMnemonic, TermType (descriptor, alternate, related, use for, ...)
select * from dbo.ThesaurusBases	--2, AAT and "Authorities"
select * from dbo.TMTypeXrefDates	--0
select * from dbo.TMTypeXrefs		--0



sp_columns TermMaster
sp_columns TermTypes
sp_columns Terms

select * from Terms where Term like ('%amphora%') TermTypeID = 9 and Term like ('%amphora%')
select * from Terms where Term like ('%vase%') 

select * from Terms where TermID = 101579



SELECT     Terms.TermID, Terms.TermMasterID, Terms.TermTypeID, Terms.Term, Terms_1.Term AS [Terms_1.Term], TermTypes.TermType, 
                      Terms.CandidateTerm, Terms.LocalTerm, TermMaster.CN, TermMaster.ScopeNote, TermMaster.HistoryNote, TermMaster.ThesaurusBaseID, 
                      TermMaster.Description, Terms_1.CandidateTerm AS Expr1, Terms_1.LocalTerm AS Expr2
FROM         Terms INNER JOIN
                      TermTypes ON Terms.TermTypeID = TermTypes.TermTypeID INNER JOIN
                      TermMaster ON Terms.TermMasterID = TermMaster.TermMasterID INNER JOIN
                      Terms AS Terms_1 ON TermMaster.TermMasterID = Terms_1.TermID
WHERE     (TermMaster.ThesaurusBaseID = 1) AND (Terms.Term LIKE '%vase%') OR
                      (TermMaster.ThesaurusBaseID = 1) AND (Terms_1.Term LIKE '%vase%')


SELECT     Objects.ObjectID, ThesXrefs.*
FROM         Objects INNER JOIN
                      ThesXrefs ON Objects.ObjectID = ThesXrefs.ID
WHERE     (Objects.ObjectID = 101685)


select 
TMS.dbo.Objects.ObjectID, 
TMS.dbo.Objects.ObjectNumber, 
TMS.dbo.Objects.DepartmentID, 
TMS.dbo.Objects.ObjectStatusID, 
TMS.dbo.Objects.ClassificationID, 
TMS.dbo.Objects.SubClassID, 
TMS.dbo.Objects.Type,
TMS.dbo.Objects.ObjectName, 
TMS.dbo.Objects.Dated, 
TMS.dbo.Objects.Title, 
TMS.dbo.Objects.Medium, 
TMS.dbo.Objects.Dimensions, 
TMS.dbo.Objects.Description, 
TMS.dbo.ThesXrefs.ThesXrefID, 
TMS.dbo.ThesXrefs.ThesXrefTypeID, 
TMS.dbo.ThesXrefs.TableID, 
TMS.dbo.ThesXrefs.TermID
from TMS.dbo.Objects 
INNER JOIN TMS.dbo.ThesXrefs ON TMS.dbo.Objects.ObjectID = TMS.dbo.ThesXrefs.ID
where TMS.dbo.ThesXrefs.TermID in
(
SELECT     Terms.TermID
FROM         Terms INNER JOIN
                      TermTypes ON Terms.TermTypeID = TermTypes.TermTypeID INNER JOIN
                      TermMaster ON Terms.TermMasterID = TermMaster.TermMasterID INNER JOIN
                      Terms AS Terms_1 ON TermMaster.TermMasterID = Terms_1.TermID
WHERE     (TermMaster.ThesaurusBaseID = 1) AND (Terms.Term LIKE '%vase%') OR
                      (TermMaster.ThesaurusBaseID = 1) AND (Terms_1.Term LIKE '%vase%')
)

SELECT     TMS.dbo.Objects.ObjectID, SearchedTerms.Term AS SearchedTerm, OtherTerms.Term AS OtherTerm, TMS.dbo.Objects.ObjectNumber, 
                      TMS.dbo.Objects.DepartmentID, TMS.dbo.Objects.ObjectStatusID, TMS.dbo.Objects.ClassificationID, TMS.dbo.Objects.SubClassID, 
                      TMS.dbo.Objects.Type, TMS.dbo.Objects.ObjectName, TMS.dbo.Objects.Dated, TMS.dbo.Objects.Title, TMS.dbo.Objects.Medium, 
                      TMS.dbo.Objects.Dimensions, TMS.dbo.Objects.Description, TMS.dbo.ThesXrefs.ThesXrefID, TMS.dbo.ThesXrefs.ThesXrefTypeID, 
                      TMS.dbo.ThesXrefs.TableID, TMS.dbo.ThesXrefs.TermID
FROM         TMS.dbo.Objects INNER JOIN
                      TMS.dbo.ThesXrefs ON TMS.dbo.Objects.ObjectID = TMS.dbo.ThesXrefs.ID INNER JOIN
                      Terms AS SearchedTerms ON TMS.dbo.ThesXrefs.TermID = SearchedTerms.TermID INNER JOIN
                      TermMaster AS SearchedTermMaster ON SearchedTerms.TermMasterID = SearchedTermMaster.TermMasterID INNER JOIN
                      Terms AS OtherTerms ON SearchedTermMaster.TermMasterID = OtherTerms.TermID
WHERE     (TMS.dbo.ThesXrefs.TermID IN
                          (SELECT     Terms_2.TermID
                            FROM          Terms AS Terms_2 INNER JOIN
                                                   TermTypes ON Terms_2.TermTypeID = TermTypes.TermTypeID INNER JOIN
                                                   TermMaster AS TermMaster_1 ON Terms_2.TermMasterID = TermMaster_1.TermMasterID INNER JOIN
                                                   Terms AS Terms_1 ON TermMaster_1.TermMasterID = Terms_1.TermID
                            WHERE      (TermMaster_1.ThesaurusBaseID = 1) AND (Terms_2.Term LIKE '%vase%') OR
                                                   (TermMaster_1.ThesaurusBaseID = 1) AND (Terms_1.Term LIKE '%vase%')))




SELECT     
TermsSearched.Term,
TMS.dbo.Objects.ObjectID, 
TMS.dbo.Objects.ObjectNumber, 
TMS.dbo.Objects.DepartmentID, 
TMS.dbo.Objects.ObjectStatusID, 
TMS.dbo.Objects.ClassificationID, 
TMS.dbo.Objects.SubClassID, 
TMS.dbo.Objects.Type,
TMS.dbo.Objects.ObjectName, 
TMS.dbo.Objects.Dated, 
TMS.dbo.Objects.Title, 
TMS.dbo.Objects.Medium, 
TMS.dbo.Objects.Dimensions, 
TMS.dbo.Objects.Description, 
TMS.dbo.ThesXrefs.ThesXrefID, 
TMS.dbo.ThesXrefs.ThesXrefTypeID, 
TMS.dbo.ThesXrefs.TableID, 
TMS.dbo.ThesXrefs.TermID
FROM         
TMS.dbo.Objects INNER JOIN TMS.dbo.ThesXrefs ON TMS.dbo.Objects.ObjectID = TMS.dbo.ThesXrefs.ID
INNER JOIN Terms as TermsSearched on TMS.dbo.ThesXrefs.TermId = TermsSearched.TermID
WHERE     
TMS.dbo.ThesXrefs.TermID in
(
SELECT     TermsMatched.TermID
FROM         Terms as TermsMatched INNER JOIN
                      TermTypes ON TermsMatched.TermTypeID = TermTypes.TermTypeID INNER JOIN
                      TermMaster ON TermsMatched.TermMasterID = TermMaster.TermMasterID INNER JOIN
                      Terms AS Terms_1 ON TermMaster.TermMasterID = Terms_1.TermID
WHERE     (TermMaster.ThesaurusBaseID = 1) AND (TermsMatched.Term LIKE '%vase%') OR
                      (TermMaster.ThesaurusBaseID = 1) AND (Terms_1.Term LIKE '%vase%'))



