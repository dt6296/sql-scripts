
--loop vars
DECLARE @iNextRowId		INT
DECLARE @iCurrentRowId	INT

--field vars
DECLARE	@ObjectID		INT
DECLARE @Term			VARCHAR(50)
DECLARE @Delimiter		VARCHAR(10)
DECLARE @InputString	VARCHAR(500)
SET		@Delimiter		= ' '

-- Initialize row counter
SET @iCurrentRowId = 0


-- start the main processing loop
--WHILE 1=1
	BEGIN
		-- Reset variables
		SET @iNextRowId = NULL     

		-- get the next iRowId
		SELECT   @iNextRowId = MIN(ObjectID)
		FROM     [MFAH-TMS].TMS.dbo.Objects NOLOCK
		WHERE    ObjectID > 0  

     	/*
		-- did we get a valid next row id?
		IF ISNULL(@ObjectID,0) = 0
		BEGIN
			PRINT 'DONE'
			BREAK
		END
		*/

		-- get the next row
		SELECT	@iCurrentRowId = ObjectID
		FROM    [MFAH-TMS].TMS.dbo.Objects NOLOCK
		WHERE   ObjectID = @iNextRowId  
		
		SET @InputString = 
			(
				SELECT 
				CASE WHEN ObjectName IS NULL THEN '' ELSE dbo.Format_RemovePunctuation (ObjectName) END
				FROM [MFAH-TMS].TMS.dbo.objects
				WHERE ObjectID = @iCurrentRowId
			) 

        DECLARE @iSpaces	INT
        DECLARE @part		VARCHAR(500)
 
        --initialize spaces
        SELECT @iSpaces = CHARINDEX(@Delimiter,@InputString,0)
        WHILE @iSpaces > 0

			BEGIN
				SELECT @part = SUBSTRING(@InputString,0,CHARINDEX(@Delimiter,@InputString,0))
				INSERT INTO TermTable(ObjectID, Field, Term)
				SELECT @ObjectID, 'ObjectName', @part
				SELECT @InputString = SUBSTRING(@InputString,CHARINDEX(@Delimiter,@InputString,0)+ LEN(@Delimiter)+1,LEN(@InputString) - CHARINDEX(' ',@InputString,0))
				SELECT @iSpaces = CHARINDEX(@Delimiter,@InputString,0)
			END

			--IF LEN(@InputString) > 0
			--	INSERT INTO TermTable
			--	SELECT @ObjectID, @InputString

RETURN
END


