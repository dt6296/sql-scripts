

-- Media Path update (2 commodities paths)









SELECT * FROM MediaPaths WHERE Path LIKE '\\mfah.local\Photoservices\Imaging\Portfolio\TIFF%s\012'

SELECT * FROM MediaPaths WHERE Path LIKE '\\mfah.local\sf\data\TMS IMAGES\Exhibitions%'
SELECT * FROM MediaPaths WHERE Path LIKE '\\mfah.local\sf\data\TMS IMAGES\Commodities%'

-- Added PathID to end of Path so I could identify which was which to delete in authority.

SELECT
COUNT(*) AS FileCount, 
mf.PathID,
mp.Path,
mp.PhysicalPath
FROM MediaFiles AS mf
INNER JOIN MediaPaths AS mp ON mf.PathID = mp.PathID
WHERE mf.PathID IN (13,51)
GROUP BY 
mf.PathID,
mp.Path,
mp.PhysicalPath


(No column name)	PathID	Path											PhysicalPath
527					31		\\mfah.local\sf\data\TMS IMAGES\Commodities 31	\\mfah.local\sf\data\TMS IMAGES\Commodities
2614				46		\\mfah.local\sf\data\TMS IMAGES\Commodities 46	\\mfah.local\sf\data\TMS IMAGES\Commodities

----------------------------

--UPDATE MediaFiles
SET PathId = 51
WHERE PathID = 13

--AFTER UPDATE

(No column name)	PathID	Path											PhysicalPath
3141				46		\\mfah.local\sf\data\TMS IMAGES\Commodities 46	\\mfah.local\sf\data\TMS IMAGES\Commodities




-----------------------------------------------	Brian's query

Select 'MediaFiles' As Type, MP.PathID, Path, Count(IsNull(MF.PathID, -1)) As TimesFound
From MediaFiles MF
       left outer join MediaPaths MP On MP.PathID = MF.PathID
WHERE mf.PathID IN (119)

Group By MP.PathID, MP.Path



UNION

Select 'MediaThumbnail' As Type, MP.PathID, Path, Count(IsNull(MR.ThumbPathID, -1)) As TimesFound
From MediaRenditions MR 
       left outer join MediaPaths MP On MR.ThumbPathID = MP.PathID 
WHERE mp.PathID IN (119)
	   
Group By MP.PathID, MP.Path

Order By Type, Path


--Order By Path, TimesFound desc    --<<this is a handy way to look at it too
