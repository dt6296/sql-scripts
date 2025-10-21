
TRUNCATE test_TMS_Terms

DECLARE @Len INT, @Start INT, @end INT, @Cursor INT,@length INT, @string VARCHAR(1000), @ObjectID INT, @Counter INT, @ObjectField VARCHAR(25)
SET @Counter	= 1
DECLARE object_cursor CURSOR FOR
	SELECT ObjectID
	FROM [MFAH-TMS].TMS.dbo.Objects 
	WHERE ObjectID > 0
	ORDER BY ObjectID
	OPEN object_cursor	
		FETCH NEXT FROM object_cursor INTO @ObjectID
		WHILE @@FETCH_STATUS = 0
			BEGIN
				WHILE @Counter < 10
					BEGIN
						IF @Counter = 1 SET @string	= (SELECT CASE WHEN CreditLine	IS NULL THEN 'null' ELSE CreditLine  END FROM [MFAH-TMS].TMS.dbo.objects WHERE ObjectID = @ObjectID)
						IF @Counter = 2 SET @string	= (SELECT CASE WHEN ObjectName	IS NULL THEN 'null' ELSE ObjectName  END FROM [MFAH-TMS].TMS.dbo.objects WHERE ObjectID = @ObjectID)
						IF @Counter = 3 SET @string	= (SELECT CASE WHEN Title		IS NULL THEN 'null' ELSE Title		 END FROM [MFAH-TMS].TMS.dbo.objects WHERE ObjectID = @ObjectID)
						IF @Counter = 4 SET @string	= (SELECT CASE WHEN Medium		IS NULL THEN 'null' ELSE Medium		 END FROM [MFAH-TMS].TMS.dbo.objects WHERE ObjectID = @ObjectID)
						IF @Counter = 5 SET @string	= (SELECT CASE WHEN Signed		IS NULL THEN 'null' ELSE Signed		 END FROM [MFAH-TMS].TMS.dbo.objects WHERE ObjectID = @ObjectID)
						IF @Counter = 6 SET @string	= (SELECT CASE WHEN Inscribed	IS NULL THEN 'null' ELSE Inscribed	 END FROM [MFAH-TMS].TMS.dbo.objects WHERE ObjectID = @ObjectID)
						IF @Counter = 7 SET @string	= (SELECT CASE WHEN Markings	IS NULL THEN 'null' ELSE Markings	 END FROM [MFAH-TMS].TMS.dbo.objects WHERE ObjectID = @ObjectID)
						IF @Counter = 8 SET @string	= (SELECT CASE WHEN Description	IS NULL THEN 'null' ELSE Description END FROM [MFAH-TMS].TMS.dbo.objects WHERE ObjectID = @ObjectID)
						IF @Counter = 9 SET @string	= (SELECT CASE WHEN Exhibitions	IS NULL THEN 'null' ELSE Exhibitions END FROM [MFAH-TMS].TMS.dbo.objects WHERE ObjectID = @ObjectID)
						IF @Counter = 1 SET @ObjectField	= 'CreditLine' 		
						IF @Counter = 2 SET @ObjectField	= 'ObjectName' 
						IF @Counter = 3 SET @ObjectField	= 'Title'
						IF @Counter = 4 SET @ObjectField	= 'Medium' 
						IF @Counter = 5 SET @ObjectField	= 'Signed' 
						IF @Counter = 6 SET @ObjectField	= 'Inscribed' 
						IF @Counter = 7 SET @ObjectField	= 'Markings' 
						IF @Counter = 8 SET @ObjectField	= 'Description' 
						IF @Counter = 9 SET @ObjectField	= 'Exhibitions' 

						SELECT @Cursor=1, @len=LEN(@string)
						WHILE @cursor<@len
							BEGIN
								SELECT @start=PATINDEX('%[^A-Za-z0-9][A-Za-z0-9]%',' '+SUBSTRING (@string,@cursor,500))-1
								SELECT @length=PATINDEX('%[^A-Z''a-z0-9-]%',SUBSTRING (@string,@cursor+@start+1,500)+' ')   
								INSERT test_TMS_Terms SELECT  @ObjectID, @ObjectField, SUBSTRING(@string,@cursor+@start,@length), @Counter
								SELECT @Cursor=@Cursor+@Start+@length+1
							END
						SET @Counter = @Counter + 1
				END				
			FETCH NEXT FROM object_cursor INTO @ObjectID
			SET @Counter = 1
		END	
	CLOSE object_cursor;
DEALLOCATE object_cursor;

GO





