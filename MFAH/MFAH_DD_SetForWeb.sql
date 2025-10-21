

/*
SELECT ColumnID, ColumnName, ForWebsite, WebDisplay, WebIndex
FROM mfaht_TMS_DataDictionary_Local
WHERE TableID = 108
AND ColumnID IN
(1223,1224,1233,1234,1236,1237,1238,1239,1240,1243,1246,1248,1251,1281,1282)

UPDATE mfaht_TMS_DataDictionary_Local
SET ForWebsite = 1
WHERE TableID = 108
AND ColumnID IN
(1231,1235)

SELECT * FROM mfaht_TMS_DataDictionary_Local
WHERE ModuleID = 1
ORDER BY TableName

UPDATE mfaht_TMS_DataDictionary_Local
SET ForWebsite = 1
WHERE TableID = 134
AND ColumnID IN
(1575)



SELECT ColumnID, ColumnName, ForWebsite, WebDisplay, WebIndex
FROM mfaht_TMS_DataDictionary_Local
WHERE TableID = 108
AND ColumnID IN
(1223,1224,1233,1234,1236,1237,1238,1239,1240,1243,1246,1248,1251,1281,1282)

UPDATE mfaht_TMS_DataDictionary_Local
SET WebDisplay = 1
WHERE TableID = 108
AND ColumnID IN
(1223,1224,1236,1237,1238,1239,1240,1243,1246,1248,1251)

*/


SELECT ModuleID, Module, TableID, TableName, ColumnID, ColumnName, ForWebsite, WebDisplay, WebIndex
FROM mfaht_TMS_DataDictionary_Local
WHERE ModuleID = 1
AND TableID = 108

UPDATE mfaht_TMS_DataDictionary_Local
SET WebIndex = 1
WHERE ColumnID IN
(
1259,1260,1261
)



SELECT ModuleID, Module, TableID, TableName, ColumnID, ColumnName, ForWebsite, WebDisplay, WebIndex
FROM mfaht_TMS_DataDictionary_Local
WHERE ForWebsite = 1
AND TableID = 23

mfaht_TMS_DataDictionary_Local