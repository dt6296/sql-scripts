-- Created 2/16/2017

--SELECT * FROM Packages WHERE Name LIKE '%Heartfield%'


--SELECT COUNT(*) FROM PackageList WHERE PackageID = 316257 -- 116


DECLARE
@PackageID			INT,
@ObjRightsTypeID	INT,
@FlagID				INT,
@CreditLineRepro	NVARCHAR(MAX),
@Restrictions		NVARCHAR(MAX),
@CopyrightNotice	NVARCHAR(MAX),
@RoleID				INT,
@ConstituentID		INT,
@DataInputDate		VARCHAR(19),
@DataEntryBy		VARCHAR(32),
@AgreementSigned	NVARCHAR(19)

SET	@PackageID			=	316257
--SET	@ObjRightsTypeID	=	1				-- 1 = Copyright Protected					 2 = Public Domain
--SET	@FlagID				=	1				-- 1 = See Rights / Repro. Restrictions		24 = Public Domain
SET	@CreditLineRepro	=	'© The Heartfield Community of Heirs / Artist Rights Society (ARS), New York / VG Bild-Kunst, Bonn'	-- "© Label"
SET	@Restrictions		=	'No cropping or superimposing. Must use ARS credit whenever published. Need copyright clearance for commercial usage.'
--SET	@CopyrightNotice	=	''				-- "Copyright Notice"
--SET	@RoleID				=	450				-- 425 = Rights Holder		450 = Rights Contact
--SET	@ConstituentID		=	21391
SET	@DataInputDate		=	'2020-10-22'	-- in 'YYYY-MM-DD' format
SET	@DataEntryBy		=	'Batch Update'	-- usually 'Batch Update'
--SET @AgreementSigned	=	'2017-06-18'	-- in 'YYYY-MM-DD' format


--EXEC MFAHsp_OBJ_RnR_Update_RightsTypeStatusFlag	@PackageID,@ObjRightsTypeID,@FlagID

--EXEC MFAHsp_OBJ_RnR_Update_CreditLineRepro		@PackageID,@CreditLineRepro

--EXEC MFAHsp_OBJ_RnR_Update_Restrictions			@PackageID,@Restrictions

--EXEC MFAHsp_OBJ_RnR_Update_CopyrightNotice		@PackageID,@CopyrightNotice

--EXEC MFAHsp_OBJ_RnR_Insert_ConXrefs				@PackageID,@RoleID,@ConstituentID,@DataInputDate,@DataEntryBy -- Check the results carefully (3/9/2018)!

--EXEC MFAHsp_OBJ_RnR_Update_AgreementSigned		@PackageID,@AgreementSigned



--UPDATE ObjRights SET AgreementReceivedISO = '2020-08-07', ContractNumber = 'Batch Update'
--SELECT ort.ObjectID, ort.AgreementReceivedISO, ort.ContractNumber
--FROM ObjRights AS ort
--INNER JOIN PackageList AS pl ON ort.ObjectID = pl.ID AND pl.PackageID = 304434


--UPDATE ObjRights SET AgreementReceivedISO = '2020-10-22', ContractNumber = 'Batch Update'
--WHERE ObjectID IN
--(SELECT ID FROM PackageList WHERE PackageID = 316257 AND TableID = 108)


