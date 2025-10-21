
--  Possibly updating rights-related ConXrefs



SELECT * FROM Roles
--	394	DO NOT USE Copyright Holder
--	415	DO NOT USE Copyright Contact


SELECT * FROM RoleTypes WHERE RoleTypeID = 19
SELECT * FROM Roles WHERE RoleTypeID = 19

--	RoleTypeID = 19
--	RoleTypeID = 425	Rights Holder
--	RoleTypeID = 450	Rights Contact




SELECT * FROM MFAHv_OBJ_Constituent
WHERE cx_RoleID IN (394,415)


SELECT
o_ObjectID AS ObjectID,
o_ObjectNumber AS ObjectNumber,
cx_RoleID AS RoleID,
cx_Role AS Role,
cxd_RoleType AS RoleType,
can_ConstituentID AS ConstituentID,
can_DisplayName AS DisplayName
FROM MFAHv_OBJ_Constituent
WHERE cx_RoleID IN (394,415)



SELECT * FROM MFAHv_OBJ_Constituent
WHERE o_ObjectID = 110421
AND cx_RoleID = 394


SELECT * FROM ConXrefs WHERE RoleID IN (425,450)



SELECT * FROM ConXrefs WHERE ConXrefID = 581002
SELECT * FROM ConXrefDetails WHERE ConXrefID = 581002




--UPDATE ConXrefs
SET RoleTypeID = 19, RoleID = 425, TableID = 126, DisplayOrder = 1
WHERE ConXrefID = 581002

--UPDATE ConXrefDetails
SET RoleTypeID = 19
WHERE ConXrefID = 581002

--This appears to have worked, but you have to be careful!





----------	These are the INSERT statements below --------		SEE StoredProcedure for updated versions




SELECT * FROM Packages WHERE Name = 'WillMichels'




SELECT ort.* FROM ObjRights AS ort WHERE ort.ObjectID IN
(SELECT ID FROM PackageList WHERE PackageID = 85940)







-- Insert ObjRights record if none exists  -------------------------------------------------------

--INSERT INTO ObjRights (ObjectID,ObjRightsTypeID,LoginID,EnteredDate)
SELECT
pl.ID			AS ObjectID,
0				AS ObjRightsTypeID,
'dthompson'		AS LoginID,
GETDATE()		AS EnteredDate

FROM PackageList AS pl
LEFT OUTER JOIN ObjRights AS ort ON pl.ID = ort.ObjectID AND pl.TableID = 108
WHERE ort.ObjectID IS NULL
AND pl.PackageID = 113196



-- Insert Rights-Related ConXref-------------------------------------------------------------------

--INSERT INTO ConXrefs (ID,RoleID,TableID,LoginID,EnteredDate,DisplayOrder,Displayed,Active,RoleTypeID,ConXrefSetID,IsDefaultDisplayBio)
SELECT
ObjRightsID,							--	ObjRightsID
425				AS RoleID,				--	Rights Holder
126				AS TableID,				--	ObjRights
'dthompson'		AS LoginID,
GETDATE()		AS EnteredDate,
1				AS DisplayOrder,
1				AS Displayed,
1				AS Active,
19				AS RoleTypeID,			--	Rights-Related
-1				AS ConXrefSetID,
0				AS IsDefaultDisplayBio
FROM PackageList AS pl
INNER JOIN ObjRights AS ort ON pl.ID = ort.ObjectID
WHERE pl.PackageID = 113196


-- Insert Rights-Related ConXrefDetails (Unmasked = YES)-------------------------------------------

--INSERT INTO ConXrefDetails (ConXrefID,RoleTypeID,NameID,ConstituentID,LoginID,EnteredDate,DateBegin,DateEnd,DepartmentID,Unmasked,DisplayBioID)
SELECT DISTINCT
ConXrefID,
RoleTypeID,							--	Rights Related
cn.DefaultNameID	AS NameID,
10718				AS ConstituentID,
'dthompson'			AS LoginID,
GETDATE()			AS EnteredDate,
0					AS DateBegin,
0					AS DateEnd,
-1					AS DepartmentID,	-- Does the department matter? Is it the object department? Need to research.
1					AS Unmasked,		-- Unmasked = YES/NO 1/0
-1					AS DisplayBioID

FROM ConXrefs AS cx
INNER JOIN ObjRights AS ort ON cx.ID = ort.ObjRightsID AND cx.TableID = 126
INNER JOIN PackageList AS pl ON ort.ObjectID = pl.ID
CROSS JOIN (SELECT DefaultNameID FROM Constituents WHERE ConstituentID = 10718) AS cn 

WHERE pl.PackageID = 113196
AND cx.EnteredDate > (SELECT TOP 1 MFAH_DBTS_DateTime FROM MFAHt_DBTS ORDER BY MFAH_DBTS_DateTime DESC)







SELECT * FROM ConXrefs WHERE LoginID = 'dthompson' AND EnteredDate > (SELECT TOP 1 MFAH_DBTS_DateTime FROM MFAHt_DBTS ORDER BY MFAH_DBTS_DateTime DESC)


SELECT * FROM ConXrefDetails WHERE LoginID = 'dthompson' AND EnteredDate > (SELECT TOP 1 MFAH_DBTS_DateTime FROM MFAHt_DBTS ORDER BY MFAH_DBTS_DateTime DESC)

--UPDATE ConXrefDetails
SET DepartmentID = -1
WHERE LoginID = 'dthompson' AND EnteredDate > (SELECT TOP 1 MFAH_DBTS_DateTime FROM MFAHt_DBTS ORDER BY MFAH_DBTS_DateTime DESC)


SELECT * FROM Departments

SELECT TOP 1000 * FROM ConXrefDetails ORDER BY EnteredDate DESC



/*

2007.1733 now has two rights holder constituents

*/






--DELETE FROM ConXrefDetails WHERE EnteredDate > '2017-02-01 00:00'
--DELETE FROM ConXrefs WHERE EnteredDate > '2017-02-01 00:00'


SELECT
cx.ConXrefID,
cx.ID,
cx.RoleID,
cx.TableID,
cxd.ConXrefID,
cxd.RoleTypeID,
cxd.NameID,
cxd.ConstituentID,
c.DisplayName,
cxd.DepartmentID,
cxd.Unmasked,
cxd.DisplayBioID,
ort.ObjRightsID,
ort.ObjectID,
ort.ObjRightsTypeID,
ort.ContractNumber,
ort.Copyright,
ort.Restrictions,
ort.CreditLineRepro,
ort.AgreementReceivedISO


FROM ConXrefs AS cx
INNER JOIN ConXrefDetails AS cxd ON cx.ConXrefID = cxd.ConXrefID
INNER JOIN ObjRights AS ort ON cx.ID = ort.ObjRightsID AND cx.TableID = 126
INNER JOIN Constituents AS c ON cxd.ConstituentID = c.ConstituentID

WHERE ort.ObjectID = 110421



--	TMS creates an ObjRights record when Object record is created.
SELECT
*
FROM ObjRights
WHERE ObjectID IN
(
	SELECT
	o.ObjectID--,o.ObjectNumber
	FROM Objects AS o
	WHERE o.ObjectNumber LIKE 'TEST.DAVE.%'
)



SELECT
o.ObjectID,o.ObjectNumber
FROM Objects AS o
LEFT OUTER JOIN ObjRights AS ort ON o.ObjectID = ort.ObjectID
--WHERE ort.ObjectID IS NULL	-- 0 records
GROUP BY o.ObjectID,o.ObjectNumber
HAVING COUNT(ort.ObjRightsID) > 1



SELECT COUNT(*) FROM Objects
SELECT COUNT(*) FROM ObjRights




SELECT TOP 10 * FROM MFAHt_DBTS ORDER BY MFAH_DBTS_DateTime DESC