
-----THIS  IS  IT!

SELECT
oi.ObjInsuranceID,
oi.ObjectID,

----Value as stated in "native" or foreign currency------------------------------------------------

oi.CurrencyValue,		--Stated Value: Object value converted to foreign currency
oi.CurrencyID,			--Currency: Internal identifier relating Object Value to Currencies
c.Currency,
oi.ValueISODate,		--Stated Date: Date of insurance valuation

-----Exchange Rate and Value as stated in USD------------------------------------------------------

oi.CurrencyRate2,		--Exhchange Rate: Currency conversion rate for currency value
oi.CurrencyRateISODate,	--The date associated with the Exchange Rate.
oi.ValuationPurposeID,	--Internal identifier relating Object Insurance to Valuation Purpose table
vp.ValuationPurpose,
oi.Value,				--Local Value: Numerical field for insurance value

-----Inflation Rate and Inflation-Adjusted Value in USD--------------------------------------------

oi.RiskFactor,			--Inflation Rate: The Inflation Rate applied to the value to compensate for inflation for a period of time (such as a loan)
oi.AdjustedValue		--Value after INFLATION RATE is applied


FROM ObjInsurance AS oi
LEFT OUTER JOIN ValuationPurposes AS vp ON oi.ValuationPurposeID = vp.ValuationPurposeID
LEFT OUTER JOIN Currencies AS c ON oi.CurrencyID = c.CurrencyID
INNER JOIN
(
	SELECT ObjectID, ObjInsuranceID, RANK() OVER(PARTITION BY ObjectID ORDER BY ValueISODate DESC) AS RankByDate
	FROM ObjInsurance
	WHERE ValuationPurposeID = 7
)	AS lv ON oi.ObjInsuranceID = lv.ObjInsuranceID AND lv.RankByDate = 1

WHERE oi.ObjectID IN (11407,119538)



---------------------------------------------------------------------------------------------------

/*

SELECT
ObjectID,
ObjInsuranceID,
v

FROM 
(
	SELECT TOP 100 PERCENT 
	ObjectID,
	ObjInsuranceID, 
	MAX(ValueISODate) AS v
	FROM ObjInsurance 
	WHERE ValuationPurposeID = 7 
	GROUP BY ObjectID, ObjInsuranceID
)	AS subq

WHERE ObjectID IN (11407,119538)



SELECT * FROM ObjInsurance 
	WHERE ValuationPurposeID = 7 and ValueISODate IS NULL		-- Only 131 records


-------This is GOOD---------------------------------------------------------------------------------

SELECT
ObjectID, ObjInsuranceID
FROM
(
	SELECT ObjectID, ObjInsuranceID, RANK() OVER(PARTITION BY ObjectID ORDER BY ValueISODate DESC) AS RankByDate
	FROM ObjInsurance
	WHERE ValuationPurposeID = 7
) AS lv
WHERE lv.RankByDate = 1
AND ObjectID IN (11407,119538)










SELECT duesid, dueskey
FROM
(
	SELECT duesid, dueskey, RANK() OVER(PARTITION BY duesid ORDER BY duesprocdt) AS RankByDate
	FROM dues_full
	WHERE duesacctno = '40010' 
) AS d
WHERE d.RankByDate = 1



*/