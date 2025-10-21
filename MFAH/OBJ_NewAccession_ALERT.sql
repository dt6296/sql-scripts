





SELECT TOP 100 
o.ObjectNumber,
o.SortNumber,
at.*

FROM AuditTrail AS at
INNER JOIN Objects AS o ON at.ObjectID = o.ObjectID

WHERE at.ColumnName = 'ObjectStatus'
AND at.NewValue IN ('Accessioned object','Blaffer Foundation Accession')
--AND GSRowVersion > (SELECT MAX(MFAH_DBTS) FROM MFAHt_DBTS)

ORDER BY at.EnteredDate DESC


----------	Need to add obj-related constituents.


