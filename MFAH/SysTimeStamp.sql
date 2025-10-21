SELECT * FROM DDTables WHERE PhysTableID = 88


SELECT * FROM sys.objects WHERE object_id = 1813581499

SELECT * FROM sys.objects WHERE name = 'LoginRecords'

SELECT * FROM sys.objects WHERE object_id = 1797581442

SELECT * FROM LoginRecords
WHERE ComputerID = 'MFAHL-14200'

SELECT DISTINCT ComputerID FROM LoginRecords ORDER BY ComputerID


SELECT CONVERT(DATETIME,(CONVERT(BIGINT,SysTimeStamp))), * FROM LoginRecords
WHERE ComputerID = 'MFAH-TMS'


SELECT CONVERT(DATETIME,(CONVERT(BIGINT,SysTimeStamp)),126), * FROM LoginRecords
WHERE ComputerID = 'MFAH-TMS'


SELECT CONVERT(DATETIME,SysTimeStamp,126), * FROM LoginRecords
WHERE ComputerID = 'MFAH-TMS'


SELECT CONVERT(INT,SysTimeStamp), * FROM LoginRecords
WHERE ComputerID = 'MFAHL-14200'

---------------------------------------------------------------------------------------------------
DECLARE @t TABLE (myKey int);
UPDATE MyTest
SET myValue = 2
    OUTPUT inserted.myKey INTO @t(myKey) 
WHERE myKey = 1 
    AND RV = myValue;
IF (SELECT COUNT(*) FROM @t) = 0
    BEGIN
        RAISERROR ('error changing row with myKey = %d'
            ,16 -- Severity.
            ,1 -- State 
            ,1) -- myKey that was changed 
    END;
---------------------------------------------------------------------------------------------------


SELECT * FROM Objects WHERE ObjectID = 110421
--SysTimeStamp = 0x0000000001D19EAA


DECLARE @t TABLE (ObjectID INT);
	UPDATE Objects
	SET ObjectCount = 2
		OUTPUT inserted.ObjectID INTO @t(myKey)
	WHERE ObjectID = 110421
	AND SysTimeStamp = ObjectCount;
IF (SELECT COUNT(*) FROM @t) = 0
	BEGIN
		RAISERROR('error changing row with ObjectID = %d'
		,16	--severity
		,1	--state
		,1)	-- ObjectID that was changed
	END;
---------------------------------------------------------------------------------------------------		


CREATE TABLE MyTest (myKey int PRIMARY KEY
    ,myValue int, RV rowversion, OLDRV CHAR(18));
GO 
INSERT INTO MyTest (myKey, myValue) VALUES (1, 0);
GO 
INSERT INTO MyTest (myKey, myValue) VALUES (2, 0);
GO


SELECT *,CAST(RV AS INT) FROM MyTest


DECLARE @t TABLE (myKey int);
UPDATE MyTest
SET OLDRV = CAST(RV AS INT)
    OUTPUT inserted.myKey INTO @t(myKey) 
WHERE myKey = 1 ;
    --AND RV = 0x0000000001D5E9B9;
IF (SELECT COUNT(*) FROM @t) = 0
    BEGIN
        RAISERROR ('error changing row with myKey = %d'
            ,16 -- Severity.
            ,1 -- State 
            ,1) -- myKey that was changed 
    END;


DROP TABLE MyTest





