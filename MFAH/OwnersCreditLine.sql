

SELECT

CAST(CASE WHEN o.ObjectStatusID = 2 
	THEN 'The Museum of Fine Arts, Houston, '
	+ CAST(o.CreditLine AS NVARCHAR(MAX)) 
	ELSE ISNULL(o.CreditLine,'^') 
	END AS NVARCHAR(MAX)) AS OBJ_OwnersCreditLine,

CASE WHEN (o.CreditLine LIKE 'Museum%' OR o.CreditLine LIKE 'Gift%') 
THEN LOWER(SUBSTRING(o.CreditLine, 1, 1))
+ RIGHT(CAST(o.CreditLine AS NVARCHAR(MAX)),(LEN(CAST(o.CreditLine AS NVARCHAR(MAX)))-1))
ELSE ISNULL(o.CreditLine,'^') END AS OCLTEST

FROM Objects AS o

WHERE o.ObjectID IN (110421,123456)





GO

SELECT

CAST(CASE WHEN o.ObjectStatusID = 2 
	THEN 'The Museum of Fine Arts, Houston, '
	+ CASE WHEN (o.CreditLine LIKE 'Museum%' OR o.CreditLine LIKE 'Gift%') 
THEN LOWER(SUBSTRING(o.CreditLine, 1, 1))
+ RIGHT(CAST(o.CreditLine AS NVARCHAR(MAX)),(LEN(CAST(o.CreditLine AS NVARCHAR(MAX)))-1))
ELSE ISNULL(o.CreditLine,'^') END END
	 AS NVARCHAR(MAX)) AS OBJ_OwnersCreditLine,

CASE WHEN (o.CreditLine LIKE 'Museum%' OR o.CreditLine LIKE 'Gift%') 
THEN LOWER(SUBSTRING(o.CreditLine, 1, 1))
+ RIGHT(CAST(o.CreditLine AS NVARCHAR(MAX)),(LEN(CAST(o.CreditLine AS NVARCHAR(MAX)))-1))
ELSE ISNULL(o.CreditLine,'^') END AS OCLTEST

FROM Objects AS o

WHERE o.ObjectID IN (110421,123456)





SELECT

CAST('The Museum of Fine Arts, Houston, ' AS NVARCHAR(MAX)) +

--CASE WHEN (o.CreditLine LIKE 'Museum%' OR o.CreditLine LIKE 'Gift%') THEN 
LOWER(SUBSTRING(o.CreditLine, 1, 1))
+ RIGHT(CAST(o.CreditLine AS NVARCHAR(MAX)),(LEN(CAST(o.CreditLine AS NVARCHAR(MAX)))-1))
--ELSE ISNULL(o.CreditLine,'^') END AS OCLTEST

FROM Objects AS o

WHERE o.ObjectID IN (110421,123456)





SELECT

CAST(CASE WHEN o.ObjectStatusID = 2 THEN
CAST('The Museum of Fine Arts, Houston, ' AS NVARCHAR(MAX)) +
--CASE WHEN (o.CreditLine LIKE 'Museum%' OR o.CreditLine LIKE 'Gift%') THEN 
LOWER(SUBSTRING(o.CreditLine, 1, 1)) + RIGHT(CAST(o.CreditLine AS NVARCHAR(MAX)),(LEN(CAST(o.CreditLine AS NVARCHAR(MAX)))-1))
ELSE ISNULL(o.CreditLine,'^')END AS NVARCHAR(MAX)) AS OBJ_OwnersCreditLine

FROM Objects AS o

WHERE o.ObjectID IN (110421,123456,69114,1309,60088,73130,66794)



SELECT

CAST(CASE WHEN o.ObjectStatusID = 2 THEN
CAST('The Museum of Fine Arts, Houston, ' AS NVARCHAR(MAX)) +
REPLACE(CAST(o.CreditLine AS NVARCHAR(MAX)),'Gift of','gift of')
ELSE ISNULL(o.CreditLine,'^')END AS NVARCHAR(MAX)) AS OBJ_OwnersCreditLine

FROM Objects AS o

WHERE o.ObjectID IN (110421,123456,69114,1309,60088,73130,66794)



----  THIS ONE!

SELECT
o.ObjectID,
CAST(CASE WHEN o.ObjectStatusID = 2 THEN
CAST('The Museum of Fine Arts, Houston, ' AS NVARCHAR(MAX)) +
REPLACE(
REPLACE(CAST(o.CreditLine AS NVARCHAR(MAX)),'Gift of','gift of'),'Museum purchase','museum purchase')
ELSE ISNULL(o.CreditLine,'^')END AS NVARCHAR(MAX)) AS OBJ_OwnersCreditLine

FROM Objects AS o

WHERE o.ObjectID IN (110421,123456,69114,1309,60088,73130,66794, 73130)








SELECT

CAST(CASE WHEN o.ObjectStatusID = 2 THEN
CAST('The Museum of Fine Arts, Houston, ' AS NVARCHAR(MAX)) +
CASE WHEN dbo.MFAHfx_OBJ_CreditLineCap(o.ObjectID) = 0 THEN
LOWER(SUBSTRING(o.CreditLine, 1, 1)) + RIGHT(CAST(o.CreditLine AS NVARCHAR(MAX)),(LEN(CAST(o.CreditLine AS NVARCHAR(MAX)))-1))
ELSE ISNULL(o.CreditLine,'^')END END AS NVARCHAR(MAX)) AS OBJ_OwnersCreditLine

FROM Objects AS o

WHERE o.ObjectID IN (110421,123456,69114,1309,60088,73130)

