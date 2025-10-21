
SELECT
o.ObjectID,
o.ObjectNumber,
o.SortNumber,
op.Value

FROM MFAHv_OBJ AS o
LEFT OUTER JOIN MFAHv_OBJ_Value_Purchase AS op ON o.ObjectID = op.ObjectID

WHERE	o.ObjectStatusID IN (2)
AND		o.AccessionMethodID = 1	--	Purchase
AND		CY >= 2012
AND		op.Value >= 50000.00

ORDER BY o.SortNumber



