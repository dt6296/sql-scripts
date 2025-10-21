

-- New Virtual Records


SELECT DISTINCT
at.ObjectID,
CHAR(09),
o.ObjectNumber,
CASE WHEN o.EnteredDate > (SELECT MAX(MFAH_DBTS_DateTime) FROM MFAHt_DBTS) THEN 'New Record' ELSE 'Existing Record' END AS IsNew

FROM AuditTrail AS at
INNER JOIN Objects AS o ON at.ObjectID = o.ObjectID

WHERE at.ModuleID = 1	-- Objects
AND at.GSRowVersion > (SELECT MAX(MFAH_DBTS) FROM MFAHt_DBTS)
AND o.IsVirtual = 1


