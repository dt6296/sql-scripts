
-- TRIGGER for CROPS


/*
SELECT TABLE_NAME, COLUMN_NAME, ORDINAL_POSITION,
    COLUMNPROPERTY(OBJECT_ID(TABLE_SCHEMA + '.' + TABLE_NAME),
    COLUMN_NAME, 'ColumnID') AS COLUMN_ID
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ImageCatalog';

*/



UPDATE ImageCatalog
SET 
IMG_CropSquare = 0,
IMG_CropVertical = 0,
IMG_CropHorizontal = 0,
IMG_CropPortrait = 0,
IMG_CropLandscape = 0,
Record_Local_Number1 = NULL
WHERE OBJ_ID = 129555




SELECT
IMG_CropSquare,
IMG_CropVertical,
IMG_CropHorizontal,
IMG_CropPortrait,
IMG_CropLandscape,

--Record_Local_Number1,

IMG_CropSquare_Created,
IMG_CropVertical_Created,
IMG_CropHorizontal_Created,
IMG_CropPortrait_Created,
IMG_CropLandscape_Created

FROM ImageCatalog WHERE OBJ_ID = 129555



USE [ImageCatalog_Data]
GO
/****** Object:  Trigger [dbo].[Update_Crop_Created]    Script Date: 8/24/2015 2:40:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER TRIGGER [dbo].[Update_Crop_Created]
ON [dbo].[ImageCatalog]
AFTER INSERT, UPDATE 
AS 
BEGIN
SET NOCOUNT ON;


--	IMG_CropSquare, column 174

	IF UPDATE(IMG_CropSquare)
	BEGIN
		UPDATE ImageCatalog
		SET IMG_CropSquare_Created = GETDATE()
		WHERE ImageCatalog.Image_Local_ID IN (SELECT Image_Local_ID FROM deleted UNION SELECT Image_Local_ID FROM inserted)
		AND IMG_CropSquare = 1

		UPDATE ImageCatalog
		SET IMG_CropSquare_Created = NULL
		WHERE ImageCatalog.Image_Local_ID IN (SELECT Image_Local_ID FROM deleted UNION SELECT Image_Local_ID FROM inserted)
		AND IMG_CropSquare = 0
	END

---------------------------------------------------------------------------------------------------

	IF UPDATE(IMG_CropVertical)
	BEGIN
		UPDATE ImageCatalog
		SET IMG_CropVertical_Created = GETDATE()
		WHERE ImageCatalog.Image_Local_ID IN (SELECT Image_Local_ID FROM deleted UNION SELECT Image_Local_ID FROM inserted)
		AND IMG_CropVertical = 1

		UPDATE ImageCatalog
		SET IMG_CropVertical_Created = NULL
		WHERE ImageCatalog.Image_Local_ID IN (SELECT Image_Local_ID FROM deleted UNION SELECT Image_Local_ID FROM inserted)
		AND IMG_CropVertical = 0
	END

---------------------------------------------------------------------------------------------------

	IF UPDATE(IMG_CropHorizontal)
	BEGIN
		UPDATE ImageCatalog
		SET IMG_CropHorizontal_Created = GETDATE()
		WHERE ImageCatalog.Image_Local_ID IN (SELECT Image_Local_ID FROM deleted UNION SELECT Image_Local_ID FROM inserted)
		AND IMG_CropHorizontal = 1

		UPDATE ImageCatalog
		SET IMG_CropHorizontal_Created = NULL
		WHERE ImageCatalog.Image_Local_ID IN (SELECT Image_Local_ID FROM deleted UNION SELECT Image_Local_ID FROM inserted)
		AND IMG_CropHorizontal = 0
	END

---------------------------------------------------------------------------------------------------

	IF UPDATE(IMG_CropPortrait)
	BEGIN
		UPDATE ImageCatalog
		SET IMG_CropPortrait_Created = GETDATE()
		WHERE ImageCatalog.Image_Local_ID IN (SELECT Image_Local_ID FROM deleted UNION SELECT Image_Local_ID FROM inserted)
		AND IMG_CropPortrait = 1

		UPDATE ImageCatalog
		SET IMG_CropPortrait_Created = NULL
		WHERE ImageCatalog.Image_Local_ID IN (SELECT Image_Local_ID FROM deleted UNION SELECT Image_Local_ID FROM inserted)
		AND IMG_CropPortrait = 0
	END

---------------------------------------------------------------------------------------------------

	IF UPDATE(IMG_CropLandscape)
	BEGIN
		UPDATE ImageCatalog
		SET IMG_CropLandscape_Created = GETDATE()
		WHERE ImageCatalog.Image_Local_ID IN (SELECT Image_Local_ID FROM deleted UNION SELECT Image_Local_ID FROM inserted)
		AND IMG_CropLandscape = 1

		UPDATE ImageCatalog
		SET IMG_CropLandscape_Created = NULL
		WHERE ImageCatalog.Image_Local_ID IN (SELECT Image_Local_ID FROM deleted UNION SELECT Image_Local_ID FROM inserted)
		AND IMG_CropLandscape = 0
	END



END

