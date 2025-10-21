

ALTER FUNCTION [dbo].[MFAHfx_ConcatTitles] (@ObjectID INT, @Delim NVARCHAR(10)) 
RETURNS NVARCHAR(4000) AS
BEGIN  
	-- Declare the return variable here 
	DECLARE @out NVARCHAR(4000)
	DECLARE @DelimLen INT 
	
	SET @out = ''  
	SET @DelimLen = DATALENGTH(@Delim)
	
	SELECT @out = @out + @Delim + 
	CAST(t.DisplayOrder AS VARCHAR(1)) + '  ' + 
	CASE WHEN t.Displayed = 1 THEN 'Displayed' ELSE 'Not Displayed' END + ' | ' +
	CASE WHEN t.Active = 1 THEN 'Active' ELSE 'Inactive' END + ' | ' + 
	t.TitleType + ':  ' + 
	t.Title + '     ' + CHAR(13) + CHAR(10)
	
	FROM MFAHv_OBJ_Title AS t
	WHERE t.ObjectID = @ObjectID   
	ORDER BY t.DisplayOrder      
	
	IF LEN (@out)>@DelimLen   
	SET @out= SUBSTRING(@out,@DelimLen+1,LEN(@out)-@DelimLen)   
	RETURN @out 
END
GO




SELECT DISTINCT TOP 25
dbo.MFAHfx_ConcatTitles(t.ObjectID,''), ObjectID
FROM MFAHv_OBJ_Title AS t
WHERE t.ObjectID IN (7,882)





SELECT DATALENGTH('')

	DECLARE @Delim NVARCHAR(10)
	SET @Delim = ''

	DECLARE @out NVARCHAR(4000)
	DECLARE @DelimLen INT 
	SET @out = ''  
	SET @DelimLen = DATALENGTH(@Delim)
	
	SELECT @out = @out + @Delim + 
	CAST(t.DisplayOrder AS VARCHAR(1)) + '  ' + 
	CASE WHEN t.Displayed = 1 THEN 'Displayed' ELSE 'Not Displayed' END + ' | ' +
	CASE WHEN t.Active = 1 THEN 'Active' ELSE 'Inactive' END + ' | ' + 
	TitleType + ':  ' + 
	Title + '     ' + CHAR(13) + CHAR(10)
	
	FROM MFAHv_OBJ_Title AS t
	WHERE t.ObjectID = 7
	ORDER BY t.DisplayOrder
	
	print @out
	




