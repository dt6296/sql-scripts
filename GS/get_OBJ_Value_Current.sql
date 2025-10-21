select
 ov.ObjInsuranceID
,ov.ObjectID
,ov.IsCurrent
,ov.DisplayIsCurrent
,ov.CurrencyValue
,ov.CurrencyID
,ov.Currency
,ov.CurrencyRate2
,ov.ValuationPurposeID
,ov.ValuationPurpose
,ov.Value
,ov.ValueNotes
,ov.ValueISODate

from 
(
		select
		oi.ObjInsuranceID,
		oi.ObjectID,
		oi.IsCurrent,
		case when oi.IsCurrent = '' then '' else 'Current' end as DisplayIsCurrent,

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
		oi.[Value],				--Local Value: Numerical field for insurance value
		
		oi.ValueNotes,

		-----Inflation Rate and Inflation-Adjusted Value in USD--------------------------------------------

		oi.RiskFactor,			--Inflation Rate: The Inflation Rate applied to the value to compensate for inflation for a period of time (such as a loan)
		oi.AdjustedValue		--Value after INFLATION RATE is applied


		from ObjInsurance as oi
		LEFT OUTER JOIN ValuationPurposes as vp on oi.ValuationPurposeID = vp.ValuationPurposeID
		LEFT OUTER JOIN Currencies as c on oi.CurrencyID = c.CurrencyID
)as ov

where ov.IsCurrent = 1