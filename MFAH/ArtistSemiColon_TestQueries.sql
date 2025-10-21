





SELECT dbo.MFAHfx_ConcatMakers_PrepPrefix_ActiveDisplayed(50289,'; ')

SELECT dbo.MFAHfx_ConcatMakers_PrepPrefix_ActiveDisplayed(102253,'; ')


SELECT dbo.MFAHfx_ConcatMakers_PrepPrefix_ActiveDisplayed(110421,'')

SELECT RIGHT(dbo.MFAHfx_ConcatMakers_PrepPrefix_ActiveDisplayed(110421,''),1)

SELECT LEN(dbo.MFAHfx_ConcatMakers_PrepPrefix_ActiveDisplayed(110421,''))-1

SELECT LEFT(dbo.MFAHfx_ConcatMakers_PrepPrefix_ActiveDisplayed(110421,''),LEN(dbo.MFAHfx_ConcatMakers_PrepPrefix_ActiveDisplayed(110421,''))-1)

SELECT CASE WHEN RIGHT(dbo.MFAHfx_ConcatMakers_PrepPrefix_ActiveDisplayed(105299,''),1) = ';'
THEN LEFT(dbo.MFAHfx_ConcatMakers_PrepPrefix_ActiveDisplayed(105299,''),LEN(dbo.MFAHfx_ConcatMakers_PrepPrefix_ActiveDisplayed(105299,''))-1)
ELSE dbo.MFAHfx_ConcatMakers_PrepPrefix_ActiveDisplayed(105299,'') END



SELECT DATALENGTH('; ') --= 2
SELECT DATALENGTH('; ' + CHAR(13) + CHAR(10)) --= 4



SELECT SUBSTRING('; DT',3,2)



SELECT OBJ_Artist FROM MFAHv_ICP_ObjectExport WHERE OBJ_ID = 105299

SELECT * FROM MFAHt_ICP_ObjectExport WHERE OBJ_ID = 105299