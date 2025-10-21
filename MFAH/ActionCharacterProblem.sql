


select * from  ImageCatalog where
				(LEN(Record_Local_JobNumber) - LEN(REPLACE(Record_Local_JobNumber, CHAR(10), '')))/1 > 0




SELECT * FROM Objects WHERE ObjectNumber = '24.1'


SELECT * FROM Objects 
WHERE
(
	(LEN(Dated)-LEN(REPLACE(Dated,CHAR(10),'')))/1>0
	OR
	(LEN(Title)-LEN(REPLACE(Title,CHAR(10),'')))/1>0
	OR
	(LEN(Medium)-LEN(REPLACE(Medium,CHAR(10),'')))/1>0
--	OR
--	(LEN(Dimensions)-LEN(REPLACE(Dimensions,CHAR(10),'')))/1>0
	OR
	(LEN(Signed)-LEN(REPLACE(Signed,CHAR(10),'')))/1>0
	OR
	(LEN(Inscribed)-LEN(REPLACE(Inscribed,CHAR(10),'')))/1>0
	OR
	(LEN(Markings)-LEN(REPLACE(Markings,CHAR(10),'')))/1>0
	OR
	(LEN(CreditLine)-LEN(REPLACE(CreditLine,CHAR(10),'')))/1>0
)
AND ObjectNumber = '24.1'


--UPDATE Objects
SET Dimensions = REPLACE(REPLACE(REPLACE(Dimensions,CHAR(10),''),CHAR(09),''),CHAR(13),'')
WHERE ObjectNumber = '24.1'

