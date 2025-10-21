

SELECT * FROM MediaFormats
SELECT * FROM MediaTypes
SELECT TOP 25 * FROM MFAHt_DBTS ORDER BY MFAH_DBTS_DateTime DESC
SELECT TOP 1 * FROM MFAHt_DBTS GROUP BY MFAH_DBTS_DateTime ORDER BY MFAH_DBTS_DateTime DESC




SELECT
mp.[Path], mf.FileName, mf.LoginID, mf.EnteredDate

FROM MediaFiles AS mf
INNER JOIN MediaPaths AS mp ON mf.PathID = mp.PathID
INNER JOIN MediaFormats AS mft ON mf.FormatID = mft.FormatID

WHERE mf.EnteredDate > (SELECT TOP 1 MFAH_DBTS_DateTime FROM MFAHt_DBTS ORDER BY MFAH_DBTS_DateTime DESC)

AND mft.MediaTypeID = 4 -- Document



EXEC [dbo].[MFAHsp_NewDocuments]


