








SELECT * FROM Packages WHERE Name LIKE 'Look%'
SELECT * FROM Packages WHERE Name LIKE 'LTA/MS%'

SELECT DISTINCT PackageType FROM Packages

SELECT * FROM PackageFolders

SELECT * FROM PackageFolderXrefs WHERE PackageID = 38275
SELECT * FROM PackageFolderXrefs WHERE PackageID = 14311

--UPDATE PackageFolderXrefs SET FolderID = 5 WHERE PackageFolderXrefID = 12413

SELECT * FROM PackageFolderXrefs WHERE PackageFolderXrefID = 12413