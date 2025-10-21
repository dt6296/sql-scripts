

SELECT oi.*,
lox.LoanID,
lox.ObjectID,
o.ObjectNumber,
oi.CurrencyValue,
oi.Value AS OldValue,
--oi.ValuationPurposeID,
--oi.CurrencyID,
--oi.CurrencyRate2,
--oi.IsCurrent,
oi.CurrencyValue * .01547952 AS NewValue

FROM LoanObjXrefs AS lox 
LEFT OUTER JOIN ObjInsurance AS oi ON lox.ObjectID = oi.ObjectID
LEFT OUTER JOIN Objects AS o ON lox.ObjectID = o.ObjectID

WHERE lox.LoanID = 11611

ORDER BY o.SortNumber




--UPDATE ObjInsurance
--SET CurrencyRate2 = 0.01547952
--SET Value = oi.CurrencyValue * CurrencyRate2,
AdjustedValue = oi.CurrencyValue * CurrencyRate2,
RoundedValue = oi.CurrencyValue * CurrencyRate2
FROM LoanObjXrefs AS lox 
LEFT OUTER JOIN ObjInsurance AS oi ON lox.ObjectID = oi.ObjectID
LEFT OUTER JOIN Objects AS o ON lox.ObjectID = o.ObjectID

WHERE lox.LoanID = 11611



