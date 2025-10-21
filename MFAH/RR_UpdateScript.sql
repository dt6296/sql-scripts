


--ALTER PROCEDURE [dbo].[MFAHsp_OBJ_RightsPanel_UpdateFromPackage]


/*
MFAH Custom Stored Procedure
MFAHsp_OBJ_RightsPanel_UpdateFromPackage

Created			8/21/2015	Dave Thompson
							Used to update/insert ObjRightsType and Status Flags for
							objects in a parameterized object package ID.

							Packages provided by Photography and Imaging Services department.

Updated			12/08/2015	Added script to update Restrictions field

*/


@PackageID			INT,
@ObjRightsTypeID	INT,			-- 1 = Copyright Protected					 2 = Public Domain
@FlagID				INT,			-- 1 = See Rights / Repro. Restrictions		24 = Public Domain
@CreditLineRepro	NVARCHAR(MAX),
@Restrictions		NVARCHAR(MAX)


AS
BEGIN

SET NOCOUNT ON;



-- Make sure Package is Global so you can see and execute it in TMS -------------------------------


UPDATE Packages SET Global = 1 WHERE PackageID = @PackageID



-- Update existing ObjRights records, set RightsType = @ObjRightsTypeID  ------------------------

UPDATE ObjRights
SET ObjRightsTypeID = @ObjRightsTypeID
FROM			Objects			AS o
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID
WHERE	o.ObjectID IN (SELECT ID FROM PackageList WHERE PackageID = @PackageID AND TableID = 108)
AND ocr.ObjRightsTypeID IN (0,1) --0 = (not entered), 1 = Copyright Protected, 2 = Public Domain



-- Insert new ObjRights records, type = @ObjRightsTypeID ---------------------------------------

INSERT INTO ObjRights (ObjectID, ObjRightsTypeID, LoginID, EnteredDate)
SELECT 
o.ObjectID,
@ObjRightsTypeID,
'dthompson',
GETDATE()
FROM			Objects			AS o
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID
WHERE	o.ObjectID IN (SELECT ID FROM PackageList WHERE PackageID = @PackageID AND TableID = 108)
AND (ObjRightsTypeID IS NULL)



-- Update R&R panel Credit Line -------------------------------------------------------------------

UPDATE ObjRights
SET CreditLineRepro = @CreditLineRepro
FROM ObjRights
WHERE ObjectID IN (SELECT ID FROM PackageList WHERE PackageID = @PackageID AND TableID = 108)



-- Update R&R panel Restrictions -------------------------------------------------------------------

UPDATE ObjRights
SET Restrictions = @Restrictions
FROM ObjRights
WHERE ObjectID IN (SELECT ID FROM PackageList WHERE PackageID = @PackageID AND TableID = 108)



-- Delete existing Status Flags of same type ------------------------------------------------------

DELETE FROM StatusFlags WHERE ObjectID IN
(
	SELECT sf.ObjectID
	FROM StatusFlags AS sf
	INNER JOIN PackageList AS pl ON sf.ObjectID = pl.ID AND pl.TableID = 1080
	WHERE PackageID = @PackageID
	GROUP BY sf.ObjectID
)
AND FlagID = @FlagID



-- Insert Status Flag -----------------------------------------------------------------------------

INSERT INTO StatusFlags (ObjectID, FlagID, OnOff, LoginID, EnteredDate)
SELECT DISTINCT o.ObjectID, @FlagID, 1, 'dthompson', GETDATE()
FROM			Objects			AS o
LEFT OUTER JOIN ObjRights		AS ocr	ON o.ObjectID = ocr.ObjectID
LEFT OUTER JOIN StatusFlags		AS sf	ON o.ObjectID = sf.ObjectID
LEFT OUTER JOIN FlagLabels		AS fl	ON sf.FlagID = fl.FlagID
WHERE	o.ObjectID IN (SELECT ID FROM PackageList WHERE PackageID = @PackageID AND TableID = 108)
AND ObjRightsTypeID = @ObjRightsTypeID AND (sf.FlagID <> @FlagID OR sf.FlagID IS NULL)






END




GO


