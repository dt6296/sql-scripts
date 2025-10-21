


/*


alter FUNCTION [dbo].[gsCompLocations] (@ObjectID int, @Delim nvarchar(10)) 
RETURNS nvarchar(4000) AS
BEGIN  
	-- Declare the return variable here 
	DECLARE @out NVARCHAR(4000)
	DECLARE @DelimLen INT 
	
	SET @out = ''  
	SET @DelimLen = DATALENGTH(@Delim)
	
	SELECT  @out=@out+@Delim+ComponentNumber+':  '+LocationString+'    '+CHAR(13)+CHAR(10)
	FROM ObjComponents		OC 
	INNER JOIN ObjLocations	OL	ON OC.CurrentObjLocID = OL.ObjLocationID 
	INNER JOIN Locations	L	ON OL.LocationID = L.LocationID 
	WHERE OC.ObjectID = @ObjectID          
	
	IF LEN (@out)>@DelimLen   
	SET @out= SUBSTRING(@out,@DelimLen+1,LEN(@out)-@DelimLen)   
	RETURN @out 
END
GO
GRANT EXEC ON dbo.gsCompLocations TO TMSUsers
GO


*/




SELECT ObjectNumber, dbo.gsCompLocations(ObjectID, '') 
FROM Objects
WHERE ObjectNumber IN ('61.62','2013.478.A-.C')