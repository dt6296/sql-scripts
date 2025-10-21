--NOTE! Please back up your database before running the script.

USE TMS
GO

/*

DECLARE @Name AS NVARCHAR(259),
		@LoginID AS NVARCHAR(32),
		@EnteredDate AS DATETIME;		

SELECT	@Name = 'TEST.DAVE',
		@LoginID = 'dthompson',
		@EnteredDate = Getdate();				

--The script will add a constituent to the below ObjectIDs
	SELECT	O.OBJECTID AS ID
	FROM dbo.[Objects] AS O 
		INNER JOIN dbo.[PackageList] AS PL ON O.OBJECTID = PL.ID AND TABLEID = 108 
		INNER JOIN dbo.[Packages] AS P ON PL.PACKAGEID = P.PACKAGEID 	
	WHERE P.NAME =  @Name
	ORDER BY O.OBJECTID 

DECLARE @DepartmentID AS INT,
		@RoleTypeID AS INT,
		@ConstituentID INT, 
		@NameID INT, 
		@RoleID INT;

--Please use below SELECT Clauses to assign proper valuse to the parameters 
--@DepartmentID:	SELECT * FROM dbo.Departments
--@RoleTypeID:		SELECT * FROM dbo.RoleTypes WHERE RoleType = 'Object Related'
--@RoleID:			SELECT * FROM dbo.Roles WHERE RoleTypeID = 1
--@ConstituentID:   SELECT * FROM dbo.Constituents WHERE ConstituentID = 16060
--@NameID:			SELECT *  FROM dbo.ConAltNames  WHERE ConstituentID = 16060

SELECT	@DepartmentID = -1,		-- In our database DepartmentID = 2 refres to Photography department	-- -1 = unassigned
		@RoleTypeID = 19,		-- In our database RoleTypeID = 1 to [Object Related] roletype			--	19 = Rights Related
		@RoleID  = 450,			-- In our database RoleID  = 1 refers to Artist role					--	450 = Rights Contact, 425 = Rights Holder
		@ConstituentID = 29872, -- The ConstituentID													--	29872 = Me
		@NameID = 32316;		-- The AltNameID assigned to the ConstituentID							--	32316 = David Thompson


SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED


DECLARE @ID INT,
		@ConXrefID INT

DECLARE Restore_CURSOR CURSOR FORWARD_ONLY FAST_FORWARD READ_ONLY FOR 

	SELECT	O.OBJECTID AS ID
	FROM dbo.[Objects] AS O 
		INNER JOIN dbo.[PackageList] AS PL ON O.OBJECTID = PL.ID AND TABLEID = 108 
		INNER JOIN dbo.[Packages] AS P ON PL.PACKAGEID = P.PACKAGEID 	
	WHERE P.NAME =  @Name
	ORDER BY O.OBJECTID 
		
OPEN Restore_CURSOR
FETCH NEXT FROM Restore_CURSOR INTO @ID
WHILE @@FETCH_STATUS = 0
BEGIN
	
	INSERT INTO [dbo].[ConXrefs]
           ([ID]
           ,[RoleID]
           ,[TableID]
           ,[LoginID]
           ,[EnteredDate]
           ,[DisplayOrder]
           ,[Displayed]
           ,[Active]
           ,[RoleTypeID]
           ,[ConXrefSetID]
           ,[IsDefaultDisplayBio])

	SELECT	@ID AS ID, 
			@RoleID as RoleID, 
			126 as TableID,			-- This is hard-coded to the Objects table (108), 126 = RightsRelated
			@LoginID as LoginID, 
			@EnteredDate as EnteredDate,
			2 as DisplayOrder,
			1 as Displayed,
			1 as Active,
			@RoleTypeID as RoleTypeID,
			-1 as ConXrefSetID,
			1 as IsDefaultDisplayBio

	SET @ConXrefID = @@IDENTITY;

	INSERT INTO [dbo].[ConXrefDetails]
           ([ConXrefID]
           ,[RoleTypeID]
           ,[NameID]
           ,[ConstituentID]
           ,[AddressID]
           ,[DateBegin]
           ,[DateEnd]
           ,[Prefix]
           ,[Remarks]
           ,[ConStatement]
           ,[Suffix]
           ,[Amount]
           ,[DisplayDate]
           ,[LoginID]
           ,[EnteredDate]
           ,[DepartmentID]
           ,[UnMasked]
           ,[DisplayBioID])
		SELECT @ConXrefID
			   ,@RoleTypeID as [RoleTypeID]
			   ,@NameID as [NameID]
			   ,@ConstituentID as [ConstituentID]
			   ,NULL as [AddressID]
			   ,0 as [DateBegin]
			   ,0 as [DateEnd]
			   ,NULL as [Prefix]
			   ,NULL as [Remarks]
			   ,NULL as [ConStatement]
			   ,NULL as [Suffix]
			   ,NULL as [Amount]
			   ,NULL as [DisplayDate]
			   ,@LoginID as [LoginID]
			   ,@EnteredDate as [EnteredDate]
			   ,@DepartmentID as [DepartmentID]
			   ,1 as [UnMasked]
			   ,-1 as [DisplayBioID]				-- Mine = 12762
		UNION ALL
		SELECT @ConXrefID
			   ,@RoleTypeID as [RoleTypeID]
			   ,@NameID as [NameID]
			   ,@ConstituentID as [ConstituentID]
			   ,NULL as [AddressID]
			   ,0 as [DateBegin]
			   ,0 as [DateEnd]
			   ,NULL as [Prefix]
			   ,NULL as [Remarks]
			   ,NULL as [ConStatement]
			   ,NULL as [Suffix]
			   ,NULL as [Amount]
			   ,NULL as [DisplayDate]
			   ,@LoginID as [LoginID]
			   ,@EnteredDate as [EnteredDate]
			   ,@DepartmentID as [DepartmentID]
			   ,0 as [UnMasked]
			   ,-1 as [DisplayBioID]				-- Mine = 12762

		--SELECT @ID, @ConXrefID
	FETCH NEXT FROM Restore_CURSOR INTO @ID
END
CLOSE Restore_CURSOR
DEALLOCATE Restore_CURSOR
GO


*/