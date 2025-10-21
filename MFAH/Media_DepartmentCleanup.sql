




SELECT 
COUNT(mm.MediaMasterID) AS Frequency,
mm.LoginID,
u.DisplayName,
mm.DepartmentID,
d.Department

FROM MediaMaster AS mm
LEFT OUTER JOIN Departments AS d ON mm.DepartmentID = d.DepartmentID
LEFT OUTER JOIN Users AS u ON mm.LoginID = u.Login

WHERE mm.DepartmentID = 160
AND u.DisplayName IS NOT NULL

GROUP BY
mm.LoginID,
u.DisplayName,
mm.DepartmentID,
d.Department


-- Another version of the above

SELECT DISTINCT
--mm.LoginID,
--u.DisplayName,
mm.DepartmentID,
d.Department,
COUNT(mm.MediaMasterID) AS Frequency

FROM MediaMaster AS mm
LEFT OUTER JOIN Departments AS d ON mm.DepartmentID = d.DepartmentID
LEFT OUTER JOIN Users AS u ON mm.LoginID = u.Login

GROUP BY
--mm.LoginID,
--u.DisplayName,
mm.DepartmentID,
d.Department

ORDER BY d.Department

------------------------------------




--	UPDATE MediaMaster
--SET DepartmentID = 165 -- Conservation
--SET DepartmentID = 163 -- Curatorial
--SET DepartmentID = 164 -- Registrars
SET DepartmentID = 162 -- Photographic and Imaging Services
WHERE DepartmentID = 160
AND LoginID = 'fbrooks'



------------------------------------------------------------------------------------------------------------

-- Not sure what this is...


--  SELECT * FROM Departments WHERE MainTableID = 318

SELECT * FROM Packages WHERE TableID = 318

SELECT * FROM PackageList WHERE PackageID = 88063 AND TableID = 318

SELECT *
FROM MediaMaster AS mm

-- First I find the PackageID.
SELECT PackageID FROM Packages WHERE Name = 'Migrated_20170517_0828' AND TableID = 318

PackageID
88063


--	Then I run the following SELECT statement to make sure I'm getting the correct records.
--	I place the UPDATE clause where I do so I don't have to rewrite code.
--	I comment out the UPDATE clause to avoid accidently running it.
--	Then, if the SELECT results looks okay, I highlight from UPDATE down to run the UPDATE statement.
--	Then I re-run the SELECT statement to make sure the records were updated.
--	It's kind of a paranoid way of doing it, but I like to try to make sure I get everything correct. ?

SELECT mm.*
--UPDATE MediaMaster SET DepartmentID = 180
FROM MediaMaster AS mm
WHERE mm.MediaMasterID IN
(SELECT ID FROM PackageList WHERE PackageID = 88063 AND TableID = 318)


----------------------------------------------------------------------------------------


--	This is the query to check departments/media types and counts.

SELECT DISTINCT
mm.LoginID,
u.DisplayName,
mm.DepartmentID,
d.Department,
mr.MediaTypeID,
mt.MediaType,
--mf.FormatID,
--mft.Format,
COUNT(mm.MediaMasterID) AS MediaCount,
COUNT(mr.RenditionID) AS RenditionCount,
COUNT(mr.MediaTypeID) AS TypeCount

FROM MediaMaster AS mm
LEFT OUTER JOIN Departments AS d ON mm.DepartmentID = d.DepartmentID
LEFT OUTER JOIN Users AS u ON mm.LoginID = u.Login
LEFT OUTER JOIN MediaRenditions AS mr ON mm.MediaMasterID = mr.MediaMasterID
LEFT OUTER JOIN MediaFiles AS mf ON mr.RenditionID = mf.RenditionID	
LEFT OUTER JOIN MediaTypes AS mt ON mr.MediaTypeID = mt.MediaTypeID
LEFT OUTER JOIN MediaFormats AS mft ON mf.FormatID = mft.FormatID

GROUP BY
mm.LoginID,
u.DisplayName,
mm.DepartmentID,
d.Department,
mr.MediaTypeID,
mt.MediaType
--,mf.FormatID,
--mft.Format

ORDER BY d.Department, mt.MediaType



SELECT * FROM Departments WHERE MainTableID = 318 ORDER BY Department



--UPDATE MediaMaster
SET DepartmentID = 208 -- SELECT COUNT(*)
FROM MediaMaster AS mm
LEFT OUTER JOIN MediaRenditions AS mr ON mm.MediaMasterID = mr.MediaMasterID
WHERE mm.DepartmentID = 164
AND mr.MediaTypeID = 3


