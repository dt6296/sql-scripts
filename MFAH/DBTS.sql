












SELECT * FROM MFAHt_DBTS ORDER BY MFAH_DBTS_DateTime

SELECT MAX(MFAH_DBTS) FROM MFAHt_DBTS


SELECT * FROM Objects WHERE SysTimeStamp > (SELECT MAX(MFAH_DBTS) FROM MFAHt_DBTS)

SELECT * FROM ConXrefDetails WHERE SysTimeStamp > (SELECT MAX(MFAH_DBTS) FROM MFAHt_DBTS)
-- not all tables have the timestamp field in 2010, but they do in 2014, GSRowVersion I think it's called.

