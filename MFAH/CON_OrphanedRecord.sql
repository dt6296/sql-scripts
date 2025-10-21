


SELECT * FROM Constituents WHERE AlphaSort LIKE '%Goodman%'
11041,25366

11041 Marian Goodman Gallery
25366 Marion Goodman Gallery
 


SELECT
cx.ConXrefID,
cx.ID,
cx.RoleID,
cx.TableID,
cxd.ConstituentID

FROM ConXrefs AS cx
LEFT OUTER JOIN ConXrefDetails AS cxd ON cx.ConXrefID = cxd.ConXrefID

WHERE cxd.ConstituentID IN (11041,25366)
 


SELECT * FROM ObjDeaccession WHERE RecipientConID = 25366	--NULL


SELECT * FROM ConAddress WHERE ConstituentID = 25366		--NULL
SELECT * FROM ConAltNames WHERE ConstituentID = 25366		--Primary Name (required of all constituents)
SELECT * FROM ConAttributeXrefs WHERE ConstituentID = 25366	--NULL
SELECT * FROM ConDates WHERE ConstituentID = 25366			--NULL
SELECT * FROM ConEMail WHERE ConstituentID = 25366			--NULL
SELECT * FROM ConGeography WHERE ConstituentID = 25366		--NULL
SELECT * FROM ConPhones WHERE ConstituentID = 25366			--NULL
SELECT * FROM ConstUserAnonymityRights WHERE ID = 25366		--NULL
SELECT * FROM ConXrefDetails WHERE ConstituentID = 25366	--NULL
SELECT * FROM ConXrefs WHERE ID = 25366						--ObjectID
SELECT * FROM ConXrefSets WHERE ID = 25366					--ObjectID
SELECT * FROM CostDetails WHERE ConstituentID = 25366		--NULL
SELECT * FROM DateEntries WHERE ID = 25366					--NULL


SELECT * FROM DelObjAccession WHERE OriginalEntityID = 25366 OR CurrentEntityID = 25366	--NULL

SELECT * FROM DelObjConXrefs WHERE ConstituentID = 25366	--NULL

SELECT * FROM Loans WHERE ConstituentIDOld = 25366			--NULL

SELECT * FROM ObjAccession WHERE OriginalEntityID = 25366 OR CurrentEntityID = 25366	--NULL
SELECT * FROM ObjDeaccession WHERE RecipientConID = 25366	--NULL

SELECT * FROM Transactions WHERE ConstituentID = 25366		--NULL
SELECT * FROM TransDistributions WHERE ConstituentID = 25366 OR EntityID = 25366	--NULL







