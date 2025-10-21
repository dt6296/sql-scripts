

DROP TABLE #Output

CREATE TABLE #Output
(ObjectID INT, Field VARCHAR(25), Term VARCHAR(25))

DECLARE @InputString	VARCHAR(4000)
DECLARE	@ObjectID		INT
DECLARE @Counter		INT
DECLARE @ObjectField	VARCHAR(25)
DECLARE @Delimiter		VARCHAR(10)

SET @Counter	= 0
SET @Delimiter	= ' '

DECLARE object_cursor CURSOR FOR
SELECT TOP 10 ObjectID
FROM [MFAH-TMS].TMS.dbo.Objects 
WHERE ObjectID = 21564
ORDER BY ObjectID
					
OPEN object_cursor

		-- Perform the first fetch and store the values in variables.
		-- Note: The variables are in the same order as the columns
		-- in the SELECT statement.
		FETCH NEXT FROM object_cursor INTO @ObjectID

			-- Check @@FETCH_STATUS to see if there are any more rows to fetch.
			WHILE @@FETCH_STATUS = 0
			BEGIN  --BEGIN PROCESSING
			
					----DECLARE field_cursor CURSOR FOR
					----SELECT Field FROM #FieldList
					----OPEN field_cursor
					----FETCH NEXT FROM field_cursor INTO @ObjectField
					----	WHILE @@FETCH_STATUS = 0
					----	BEGIN
					----	SET @InputString = (SELECT @FetchedValue FROM [MFAH-TMS].TMS.dbo.objects WHERE ObjectID = @ObjectID)
					--		--DECLARE @FieldValue VARCHAR(1000) 
					--		--SELECT @InputString = (SELECT dbo.GetInputString(@ObjectID, @ObjectField))
					--		--SELECT @InputString = dbo.GetInputString (@ObjectID, @ObjectField)
					--		--DECLARE @SQL			VARCHAR(1000)		
					--		--SET @InputString = (SELECT CASE WHEN @ObjectField IS NULL THEN 'is null' ELSE dbo.Format_RemovePunctuation (@ObjectField)  END FROM [MFAH-TMS].TMS.dbo.objects WHERE ObjectID = @ObjectID)
					--		--SELECT @InputString = ('SELECT '+ @ObjectField + ' FROM [MFAH-TMS].TMS.dbo.objects WHERE ObjectID = ' + CAST(@ObjectID as VARCHAR(10)))
					--		--EXEC (@InputString)
					--		--CREATE TABLE #InputString (InputString VARCHAR(1000)
					--		--INSERT #InputString (EXEC (@SQL))
					--		--SET @InputString = (SELECT InputString FROM #InputString)
					
					SET @Counter = @Counter + 1	
										
					IF @Counter = 1 SET @InputString = (SELECT CreditLine	FROM [MFAH-TMS].TMS.dbo.objects WHERE ObjectID = @ObjectID); SET @ObjectField = 'CreditLine' 
					IF @Counter = 2 SET @InputString = (SELECT ObjectName	FROM [MFAH-TMS].TMS.dbo.objects WHERE ObjectID = @ObjectID); SET @ObjectField = 'ObjectName' 
					IF @Counter = 3 SET @InputString = (SELECT Title		FROM [MFAH-TMS].TMS.dbo.objects WHERE ObjectID = @ObjectID); SET @ObjectField = 'Title'
					IF @Counter = 4 SET @InputString = (SELECT Medium		FROM [MFAH-TMS].TMS.dbo.objects WHERE ObjectID = @ObjectID); SET @ObjectField = 'Medium' 
					IF @Counter = 5 SET @InputString = (SELECT Signed		FROM [MFAH-TMS].TMS.dbo.objects WHERE ObjectID = @ObjectID); SET @ObjectField = 'Signed' 
					IF @Counter = 6 SET @InputString = (SELECT Inscribed	FROM [MFAH-TMS].TMS.dbo.objects WHERE ObjectID = @ObjectID); SET @ObjectField = 'Inscribed' 
					IF @Counter = 7 SET @InputString = (SELECT Markings		FROM [MFAH-TMS].TMS.dbo.objects WHERE ObjectID = @ObjectID); SET @ObjectField = 'Markings' 
					IF @Counter = 8 SET @InputString = (SELECT Description	FROM [MFAH-TMS].TMS.dbo.objects WHERE ObjectID = @ObjectID); SET @ObjectField = 'Description' 
					IF @Counter = 9 SET @InputString = (SELECT Exhibitions	FROM [MFAH-TMS].TMS.dbo.objects WHERE ObjectID = @ObjectID); SET @ObjectField = 'Exhibitions' 
				
					DECLARE @iSpaces	INT
					DECLARE @part		VARCHAR(500)
							
					--Initialize Spaces
					SELECT @iSpaces = CHARINDEX(@Delimiter,@InputString,0)  

					WHILE @iSpaces > 0  
					BEGIN  
						SELECT @part =			SUBSTRING(@InputString,0,CHARINDEX(@Delimiter,@InputString,0))
						INSERT #Output			SELECT @ObjectID, @ObjectField, @part
						SELECT @InputString =	SUBSTRING(@InputString,CHARINDEX(@Delimiter,@InputString,0)+ LEN(@Delimiter)+1,LEN(@InputString) - CHARINDEX(' ',@InputString,0))
						SELECT @iSpaces =		CHARINDEX(@Delimiter,@InputString,0)
					END  

					IF LEN(@InputString) > 0 INSERT INTO #Output SELECT @ObjectID, @ObjectField, @part
RETURN
								
				--FETCH NEXT FROM	field_cursor INTO @ObjectField
				--END
				--CLOSE field_cursor;
				--DEALLOCATE field_cursor;
				
		-- This is executed as long as the previous fetch succeeds.
		FETCH NEXT FROM object_cursor INTO @ObjectID
END
				
			

CLOSE object_cursor;
DEALLOCATE object_cursor;


--select * FROM #Output


