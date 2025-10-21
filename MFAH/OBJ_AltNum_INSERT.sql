

-- OBJ_AltNum_INSERT






SELECT * FROM Packages WHERE Name = 'EX.2018.RR.ALL'	-- PackageID = 137881








SELECT an.ID,an.TableID,an.AltNum,an.Description,an.LoginID,an.EnteredDate,an.Remarks


--INSERT INTO AltNums (ID,TableID,AltNum,Description,LoginID,EnteredDate,Remarks)
SELECT
pl.ID,
108,
'IA-2016-325084-1',
'OFAC license number',
'dthompson',
GETDATE(),
'Inserted via SQL on 4/10/17 by Dave Thompson, per Julie Bakke'

FROM AltNums AS an
RIGHT OUTER JOIN PackageList AS pl ON an.ID = pl.ID AND an.TableID = 108 aND pl.TableID = 108

WHERE pl.PackageID = 137881





SELECT * FROM PackageList WHERE ID = 130897 AND TableID = 108
AND PackageID IN (123824,123855)



SELECT
an.*
--DELETE
FROM AltNums AS an
WHERE Description = 'Indemnity Checklist Number'
AND LoginID = 'dthompson'



--INSERT INTO AltNums (ID,TableID,AltNum,Description,LoginID,EnteredDate,Remarks)
SELECT
an.ObjectID,
108,
an.Number,
'Indemnity Checklist Number',
'dthompson',
GETDATE(),
'Peacock in the Desert: The Royal Arts of Jodhpur, India'

FROM MFAHt_AltNums AS an







