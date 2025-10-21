

DROP TABLE #Output
DROP TABLE #FieldList

CREATE TABLE #Output
(ObjectID INT, Field VARCHAR(25), Term VARCHAR(25))

CREATE TABLE #FieldList
(Field VARCHAR(25))

INSERT INTO #FieldList VALUES
('CreditLine'),
('ObjectName'),
('Title'),
('Medium'),
('Signed'),
('Inscribed'),
('Markings'),

('Description'),
('Exhibitions')



DECLARE @InputString varchar(4000)
DECLARE	@ObjectID INT

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
					DECLARE @ObjectField VARCHAR(25)
					DECLARE @Delimiter	VARCHAR(10)
					SET @Delimiter = ' '

					DECLARE field_cursor CURSOR FOR
					SELECT Field FROM #FieldList

					OPEN field_cursor
					FETCH NEXT FROM field_cursor INTO @ObjectField
							
						WHILE @@FETCH_STATUS = 0
						BEGIN

DECLARE @FieldValue VARCHAR(1000) 
SET @InputString = (SELECT dbo.GetInputString(@ObjectID, @ObjectField))

							--SELECT @InputString = dbo.GetInputString (@ObjectID, @ObjectField)
							--DECLARE @SQL			VARCHAR(1000)		
							--SET @InputString = (SELECT CASE WHEN @ObjectField IS NULL THEN 'is null' ELSE dbo.Format_RemovePunctuation (@ObjectField)  END FROM [MFAH-TMS].TMS.dbo.objects WHERE ObjectID = @ObjectID)

							--SELECT @InputString = ('SELECT '+ @ObjectField + ' FROM [MFAH-TMS].TMS.dbo.objects WHERE ObjectID = ' + CAST(@ObjectID as VARCHAR(10)))
							--EXEC (@InputString)
							--CREATE TABLE #InputString (InputString VARCHAR(1000)
							--INSERT #InputString (EXEC (@SQL))

							--SET @InputString = (SELECT InputString FROM #InputString)
							Declare @iSpaces int
							Declare @part varchar(500)
							
--PRINT @SQL  BREAK				 


							--initialize spaces
							Select @iSpaces = charindex(@Delimiter,@InputString,0)  


								While @iSpaces > 0  
								BEGIN  
									Select @part = substring(@InputString,0,charindex(@Delimiter,@InputString,0))
									Insert #Output SELECT @ObjectID, @ObjectField, @part
									Select @InputString = substring(@InputString,charindex(@Delimiter,@InputString,0)+ len(@Delimiter),len(@InputString) - charindex(' ',@InputString,0))
									Select @iSpaces = charindex(@Delimiter,@InputString,0)
								END  

								If len(@InputString) > 0
									Insert Into #Output
									Select @ObjectID, @ObjectField, @part

								
						FETCH NEXT FROM	field_cursor INTO @ObjectField
						END
						CLOSE field_cursor;
						DEALLOCATE field_cursor;

		FETCH NEXT FROM object_cursor INTO @ObjectID
END
				
			
		-- This is executed as long as the previous fetch succeeds.
CLOSE object_cursor;
DEALLOCATE object_cursor;


select * FROM #Output

SELECT  dbo.GetInputString (21564, 'CreditLine')

