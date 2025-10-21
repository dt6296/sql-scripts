









SELECT
o.ObjectID,
o.ObjectNumber,
oi.*

FROM Objects AS o
INNER JOIN ObjInsurance AS oi ON o.ObjectID = oi.ObjectID

WHERE o.ObjectNumber LIKE '2016.135.%'
AND o.ObjectID NOT IN (132029,132030)



SELECT

o.ObjectID,
o.ObjectNumber,
oi.Value,
oi.ValuationPurposeID,
oi.CurrencyID,
oi.CurrencyRate2,
oi.CurrencyValue,
oi.ValueISODate,
oi.AdjustedValue,
oi.IsCurrent,
oi.RoundedValue,
oi.LocalCurrencyID,
oi.LoginID,
oi.EnteredDate

FROM Objects AS o
INNER JOIN ObjInsurance AS oi ON o.ObjectID = oi.ObjectID

WHERE o.ObjectNumber LIKE '2016.135.%'



SELECT * FROM ValuationPurposes











INSERT INTO ObjInsurance 
(
ObjectID,
Value,
ValuationPurposeID,
CurrencyID,
CurrencyRate2,
CurrencyValue,
ValueISODate,
AdjustedValue,
IsCurrent,
RoundedValue,
LocalCurrencyID,
LoginID,
EnteredDate,
ValueNotes
)

SELECT
o.ObjectID,
--o.ObjectNumber,
500,
7,
1,
1,
500,
'2016-03-23',
500,
1,
500,
1,
'dthompson',
GETDATE(),
'$15,000.00 for a portfolio of 31 photographs'

FROM Objects AS o
LEFT OUTER JOIN ObjInsurance AS oi ON o.ObjectID = oi.ObjectID

WHERE o.ObjectNumber LIKE '2016.135.%'
AND o.ObjectID NOT IN (132029,132030)