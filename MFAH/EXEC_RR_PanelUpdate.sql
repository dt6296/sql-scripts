


SELECT * FROM Packages WHERE Name LIKE '%Unknown%'		-- 37626  Unknown Artist for Public Domain
 


SELECT * FROM StatusFlags WHERE ObjectID IN 
(
	SELECT ID FROM PackageList WHERE PackageID = 37626 AND TableID = 108		-- 2090
)


-- Copyright Protected 
-- make sure CreditLineRepro and Restrictions part of script are active!
EXEC TMS.dbo.MFAHsp_OBJ_RightsPanel_UpdateFromPackage 37256,1,1,'',''


-- Public Domain 
-- comment out CreditLineRepro and Restrictions parts of script!
EXEC TMS.dbo.MFAHsp_OBJ_RightsPanel_UpdateFromPackage 37626,2,24,'',''	