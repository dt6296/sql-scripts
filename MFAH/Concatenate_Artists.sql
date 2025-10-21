

ALTER FUNCTION [dbo].[MFAHfx_ConcatMakers] (@ObjectID INT, @Delim NVARCHAR(10)) 
RETURNS NVARCHAR(4000) AS
BEGIN  
	-- Declare the return variable here 
	DECLARE @out NVARCHAR(4000)
	DECLARE @DelimLen INT 
	
	SET @out = ''  
	SET @DelimLen = DATALENGTH(@Delim)
	
	SELECT @out = @out + @Delim + 
	c.cx_Role + ':  ' +
	c.DisplayNameCultureDate + '     ' + CHAR(13) + CHAR(10)
	
	FROM MFAHv_OBJ_Constituent AS c
	WHERE c.o_ObjectID = @ObjectID  
	AND c.cx_RoleTypeID = 1
	ORDER BY c.cx_DisplayOrder     
	
	IF LEN (@out)>@DelimLen   
	SET @out= SUBSTRING(@out,@DelimLen+1,LEN(@out)-@DelimLen)   
	RETURN @out 
END
GO




SELECT DISTINCT TOP 25
dbo.MFAHfx_ConcatMakers(c.o_ObjectID,''), c.o_ObjectID
FROM MFAHv_OBJ_Constituent AS c
WHERE c.o_ObjectID IN (7,882,110421)





SELECT DATALENGTH('')

	DECLARE @Delim NVARCHAR(10)
	SET @Delim = ''

	DECLARE @out NVARCHAR(4000)
	DECLARE @DelimLen INT 
	SET @out = ''  
	SET @DelimLen = DATALENGTH(@Delim)
	
	SELECT @out = @out + @Delim + 
	c.cx_Role + ':  ' +
	c.can_DisplayArtistMaker + '     ' + CHAR(13) + CHAR(10)
	
	FROM MFAHv_OBJ_Constituent AS c
	WHERE c.o_ObjectID = 110421
	ORDER BY c.cx_DisplayOrder
	
	print @out
	




