



/*

SELECT * FROM Reports

SELECT * FROM DDTables WHERE TableID = 147

SELECT * FROM DDTables WHERE TableName LIKE '%Report%'

SELECT * FROM UserXrefs WHERE TableID = 147

SELECT * FROM Users ORDER BY DisplayName
*/


--This doesn't do what I thought it would.
/*
SELECT
ux.*,
u.DisplayName--,
--r.MenuLabel,
--r.ReportName,
--r.FilePath,
--r.IsLoaded

FROM UserXrefs			AS ux
LEFT OUTER JOIN Users	AS u	ON ux.UserID = u.UserID
--LEFT OUTER JOIN Reports	AS r	ON ux.ID = r.ReportID	--AND ux.TableID = 147

--WHERE ux.TableID = 147
--AND 
WHERE 
ux.ID = 4570
--ux.UserID = 1026	--Phyllis Hastings
*/



---------------------------------------------------------------------------------------------------




--This returns an individual's personal reports.


SELECT * FROM Reports 
--WHERE ReportID = 3605
WHERE Owner = 'dthompson'
--AND Global = 0				--Personal Reports (Global = 1 = Public Reports)
ORDER BY ReportName


SELECT * FROM Reports 
--WHERE ReportID = 3605
WHERE Owner = 'kpashko'
AND Global = 0				--Personal Reports (Global = 1 = Public Reports)
ORDER BY ReportName


SELECT * FROM Reports 
--WHERE ReportID = 3605
WHERE Owner = 'phastings'
AND Global = 0				--Personal Reports (Global = 1 = Public Reports)
ORDER BY ReportName



SELECT ReportName, COUNT(ReportName) AS CountReportName FROM Reports
GROUP BY ReportName
HAVING COUNT(ReportName) > 1

SELECT * FROM Reports WHERE ReportName = 'OBJ_BasicInfoWorksheet.rpt'
---------------------------------------------------------------------------------------------------


--	I couldn't add OBJ_Thumbnail and number.rpt to Kim's personal reports because it has no Reports records that make it public, 
--	so I could never see it in the reports maintenance menu unless logged in as Phyllis (or someone who "owns" the report).
--	The problem was that I was looking for the Menu Label, but these can differ by user.
--	When I added the report to Kim's personal reports, I was able to just point to the File Name, and it appeared just fine.
--	2/19/2014



--	A problem with the querys below is the path/file name problem (my OCM report, for instance).
SELECT *
FROM Reports
WHERE ReportName IN
(
	SELECT ReportName FROM Reports
	GROUP BY ReportName
	HAVING COUNT(ReportName) > 1	--reports that appear multiple times int he Reports table
)
ORDER BY ReportName



SELECT *
FROM Reports
WHERE ReportName IN
(
	SELECT ReportName FROM Reports
	GROUP BY ReportName
	HAVING SUM(Global) > 0			-- reports with at least one public instance
)
ORDER BY ReportName


SELECT *
FROM Reports
WHERE ReportName IN
(
	SELECT ReportName FROM Reports
	GROUP BY ReportName
	HAVING SUM(Global) = 0			-- reports with at least one public instance
)
ORDER BY ReportName
--	Phyllis' "thumbnail and number" report appears here.


---------------------------------------------------------------------------------------------------




SELECT * FROM Reports 
--WHERE ReportID = 3605
WHERE MenuLabel LIKE 'file labels'
ORDER BY ReportName



SELECT * FROM Reports 
--WHERE ReportID = 3605
WHERE MenuLabel LIKE '%OCM%'
ORDER BY ReportName

