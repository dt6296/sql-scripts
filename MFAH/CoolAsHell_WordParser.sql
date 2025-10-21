IF OBJECT_ID(N'dbo.TestFunction', N'TF') IS NOT NULL
    DROP FUNCTION dbo.TestFunction;
GO
CREATE FUNCTION dbo.TestFunction(@Input VARCHAR(4000))
RETURNS @retCharInfo TABLE 
(
    -- Columns returned by the function
    CharPos INT PRIMARY KEY NOT NULL, 
    Chartr CHAR(1) NULL, 
    Word INT NULL,
	Diacrit INT NULL
)
AS 

BEGIN

DECLARE @InputString VARCHAR(4000)
SET @InputString = 
	(
	SELECT
		CASE WHEN Work_CDWA_OwnersCreditLine IS NULL THEN '' ELSE Work_CDWA_OwnersCreditLine END + ' ' +
		CASE WHEN Work_CDWA_ExhibitionDescription IS NULL THEN '' ELSE Work_CDWA_ExhibitionDescription END + ' ' +
		CASE WHEN Work_VRA_Title1 IS NULL THEN '' ELSE Work_VRA_Title1 END + ' ' +
		CASE WHEN Work_VRA_Title2 IS NULL THEN '' ELSE Work_VRA_Title2 END + ' ' +
		CASE WHEN Work_VRA_Agent1 IS NULL THEN '' ELSE Work_VRA_Agent1 END + ' ' +
		CASE WHEN Work_VRA_Agent2 IS NULL THEN '' ELSE Work_VRA_Agent2 END + ' ' +
		CASE WHEN Work_VRA_Agent3 IS NULL THEN '' ELSE Work_VRA_Agent3 END + ' ' +
		CASE WHEN Work_VRA_Location1 IS NULL THEN '' ELSE Work_VRA_Location1 END + ' ' +
		CASE WHEN Work_VRA_Location2 IS NULL THEN '' ELSE Work_VRA_Location2 END + ' ' +
		CASE WHEN Work_VRA_Location3 IS NULL THEN '' ELSE Work_VRA_Location3 END + ' ' +
		CASE WHEN Work_VRA_Location4 IS NULL THEN '' ELSE Work_VRA_Location4 END + ' ' +
		CASE WHEN Work_VRA_Location5 IS NULL THEN '' ELSE Work_VRA_Location5 END + ' ' +
		CASE WHEN Work_VRA_Location6 IS NULL THEN '' ELSE Work_VRA_Location6 END 
	FROM ImageCatalog 
	WHERE Image_Local_ID =112163--IN (SELECT Image_Local_ID FROM UpdatedRecords)
	)


DECLARE @Index          INT
DECLARE @Char           CHAR(1)
DECLARE @PrevChar       CHAR(1)
DECLARE @WordCount      INT
DECLARE @NextChar		CHAR(1)
DECLARE @HasDiacrit		INT

SET @Index = 1
SET @WordCount = 0

WHILE @Index <= LEN(@InputString)
BEGIN	
    SET @Char     = SUBSTRING(@InputString, @Index, 1)						
    SET @PrevChar = CASE WHEN @Index = 1 THEN ' 'ELSE SUBSTRING(@InputString, @Index - 1, 1) END
	SET @NextChar = CASE WHEN @Index = LEN(@InputString) THEN '' ELSE SUBSTRING(@InputString, @Index + 1, 1) END

	SET @HasDiacrit = CASE WHEN @Char IN (SELECT diacrit from diacrits) THEN 1 ELSE 0 END 

    IF @PrevChar = ' ' AND @Char != ' '
        SET @WordCount = @WordCount + 1		


		-- Return the information to the caller
			--IF @Input IS NOT NULL 
			BEGIN
				INSERT @retCharInfo
				SELECT @Index, @Char, @WordCount, @HasDiacrit;
			END;
			--RETURN;

    SET @Index = @Index + 1

END
RETURN
END 
GO

-------------------------------------------------

DECLARE @InputString VARCHAR(4000)
select * from dbo.TestFunction(@InputString)

-------------------------------------------------

select Record_Local_StrippedDiacriticals from ImageCatalog 	WHERE Image_Local_ID IN (SELECT Image_Local_ID FROM UpdatedRecords)

-------------------------------------------------

DECLARE @Stripped VARCHAR(200) 
DECLARE @InputString VARCHAR(200)

SELECT @Stripped																--= COALESCE(@Stripped, '') + Chartr
FROM dbo.TestFunction(@InputString)
WHERE Word IN (SELECT DISTINCT Word FROM dbo.TestFunction(@InputString) )		--WHERE Diacrit = 1)  
PRINT @Stripped


DECLARE @InputString VARCHAR(200)
SELECT DISTINCT Word, COALESCE(Chartr,'')
FROM dbo.TestFunction(@InputString)


-------------------------------------------------

UPDATE ImageCatalog
SET Record_Local_StrippedDiacriticals = @Stripped
WHERE Image_Local_ID =112163


DECLARE @myString varchar(500)
DECLARE @deliminator varchar(10)
SET @deliminator = ' '
SET @myString = 'The goose drank wine, the monkey chewed tobacco on the street car line.'
SELECT *
FROM dbo.SplitString (@myString, @deliminator)



Select * From SplitString('Hello John Smith','')

DECLARE @myString varchar(500)
DECLARE @deliminator varchar(10)
SET @myString = 'The goose drank wine, the monkey chewed tobacco on the street car line.'
SET @deliminator = ''

    Select @myString = substring(@mystring,charindex(@deliminator,@myString,0)+ len(@deliminator),len(@myString) - charindex(' ',@myString,0))
PRINT @myString


---------------------------------------------------------
DECLARE @InputString VARCHAR(4000)
select * from dbo.TestFunction(@InputString)

DECLARE @InputString VARCHAR(4000)
SELECT distinct part FROM dbo.SplitString (@InputString) where part != ' '


----------------------------------------------------------------------------------

, = 044
. = 046
/ = 047

------------------------------------
ALTER FUNCTION SplitString 
(
    -- Add the parameters for the function here
    @InputString varchar(4000)
)
RETURNS 
@ReturnTable TABLE 
(
    -- Add the column definitions for the TABLE variable here
    [id] [int] IDENTITY(1,1) NOT NULL,
    [part] [varchar](500) NULL
)
AS
BEGIN



DECLARE @Delimiter VARCHAR(10)
SET @Delimiter = ' '
SET @InputString = 
	(
	SELECT
		CASE WHEN Work_CDWA_OwnersCreditLine IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(Work_CDWA_OwnersCreditLine) END + ' ' +
		CASE WHEN Work_CDWA_ExhibitionDescription IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(Work_CDWA_ExhibitionDescription) END + ' ' +
		CASE WHEN Work_VRA_Title1 IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(Work_VRA_Title1) END + ' ' +
		CASE WHEN Work_VRA_Title2 IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(Work_VRA_Title2) END + ' ' +
		CASE WHEN Work_VRA_Agent1 IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(Work_VRA_Agent1) END + ' ' +
		CASE WHEN Work_VRA_Agent2 IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(Work_VRA_Agent2) END + ' ' +
		CASE WHEN Work_VRA_Agent3 IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(Work_VRA_Agent3) END + ' ' +
		CASE WHEN Work_VRA_Location1 IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(Work_VRA_Location1) END + ' ' +
		CASE WHEN Work_VRA_Location2 IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(Work_VRA_Location2) END + ' ' +
		CASE WHEN Work_VRA_Location3 IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(Work_VRA_Location3) END + ' ' +
		CASE WHEN Work_VRA_Location4 IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(Work_VRA_Location4) END + ' ' +
		CASE WHEN Work_VRA_Location5 IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(Work_VRA_Location5) END + ' ' +
		CASE WHEN Work_VRA_Location6 IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(Work_VRA_Location6) END 
	FROM ImageCatalog 
	WHERE Image_Local_ID =112163--IN (SELECT Image_Local_ID FROM UpdatedRecords)
	)

        Declare @iSpaces int
        Declare @part varchar(500)
 
        --initialize spaces
        Select @iSpaces = charindex(@Delimiter,@InputString,0)
        While @iSpaces > 0

        Begin
            Select @part = substring(@InputString,0,charindex(@Delimiter,@InputString,0))

            Insert Into @ReturnTable(part)
            Select @part

    Select @InputString = substring(@InputString,charindex(@Delimiter,@InputString,0)+ len(@Delimiter)+1,len(@InputString) - charindex(' ',@InputString,0))


            Select @iSpaces = charindex(@Delimiter,@InputString,0)
        end

        If len(@InputString) > 0
            Insert Into @ReturnTable
            Select @InputString

    RETURN 
END
GO





		DECLARE @txt VARCHAR(50)
		SET @txt = 'Impressionist, are:? boring/\'
		SELECT @txt, dbo.Format_RemovePunctuation (@txt)

-------------------------------------------------------------------------
CREATE FUNCTION TMS_SplitString 
(
    -- Add the parameters for the function here
    @InputString varchar(4000)
)
RETURNS 
@ReturnTable TABLE 
(
    -- Add the column definitions for the TABLE variable here
    [ObjectID] [int] IDENTITY(1,1) NOT NULL,
    [term] [varchar](500) NULL
)
AS
BEGIN

DECLARE @Delimiter VARCHAR(10)
SET @Delimiter = ' '
SET @InputString = 
	(
		SELECT
		CASE WHEN o.ObjectName IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(o.ObjectName) END + ' ' +
		CASE WHEN o.Title IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(o.Title) END + ' ' +
		CASE WHEN o.Medium IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(o.Medium) END + ' ' +
		CASE WHEN o.Signed IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(o.Signed) END + ' ' +
		CASE WHEN o.Inscribed IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(o.Inscribed) END + ' ' +
		CASE WHEN o.Markings IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(o.Markings) END + ' ' +
		CASE WHEN o.CreditLine IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(o.CreditLine) END + ' ' +
		CASE WHEN o.Description IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(o.Description) END + ' ' +
		CASE WHEN o.Exhibitions IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(o.Exhibitions) END
		FROM [MFAH-TMS].TMS.dbo.objects AS o
		WHERE o.ObjectID = 44238
	)

        Declare @iSpaces int
        Declare @part varchar(500)
 
        --initialize spaces
        Select @iSpaces = charindex(@Delimiter,@InputString,0)
        While @iSpaces > 0

        Begin
            Select @part = substring(@InputString,0,charindex(@Delimiter,@InputString,0))

            Insert Into @ReturnTable(term)
            Select @part

    Select @InputString = substring(@InputString,charindex(@Delimiter,@InputString,0)+ len(@Delimiter)+1,len(@InputString) - charindex(' ',@InputString,0))


            Select @iSpaces = charindex(@Delimiter,@InputString,0)
        end

        If len(@InputString) > 0
            Insert Into @ReturnTable
            Select @InputString

    RETURN 
END
GO







SELECT
	o.ObjectID,
	CASE WHEN o.ObjectName IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(o.ObjectName) END AS ObjectName,
	CASE WHEN o.Title IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(o.Title) END AS Title,
	CASE WHEN o.Medium IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(o.Medium) END AS Medium,
	CASE WHEN o.Signed IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(o.Signed) END AS Signed,
	CASE WHEN o.Inscribed IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(o.Inscribed) END AS Inscribed,
	CASE WHEN o.Markings IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(o.Markings) END AS Markings,
	CASE WHEN o.CreditLine IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(o.CreditLine) END AS CreditLine,
	CASE WHEN o.Description IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(o.Description) END AS Description,
	CASE WHEN o.Exhibitions IS NULL THEN '' ELSE dbo.Format_RemovePunctuation(o.Exhibitions) END Exhibitions
	FROM [MFAH-TMS].TMS.dbo.objects AS o