USE [TMS]
GO
/****** Object:  View [dbo].[PUAMv_OBJ_Value]    Script Date: 3/25/2021 12:37:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--alter view [dbo].[PUAMv_OBJ_Value] as

/*

Created		Dave Thompson		10/9/2025

*/

select
 oi.ObjInsuranceID
,oi.ObjectID
,oi.IsCurrent
,case when oi.IsCurrent = '' then '' else 'Current' end as DisplayIsCurrent

----Value as stated in "native" or foreign currency------------------------------------------------

,oi.CurrencyValue as StatedValue	--Stated Value: Object value converted to foreign currency
,oi.CurrencyID						--Currency: Internal identifier relating Object Value to Currencies
,c.Currency
,oi.ValueISODate		--Stated Date: Date of insurance valuation
,dbo.PUAMfx_ISOtoDATE(oi.ValueISODate) AS ValuationDate
,c.Currency
 + ' ' 
 +	case when oi.CurrencyValue is null or oi.ValueISODate is null 
	then isnull(cast(format(oi.CurrencyValue,'N0') as nvarchar(25)),'') + isnull(cast(dbo.PUAMfx_ISOtoDATE(oi.ValueISODate) as varchar(10)),'')
	else isnull(cast(format(oi.CurrencyValue,'N0') as nvarchar(25)) + ' as of ' + cast(dbo.PUAMfx_ISOtoDATE(oi.ValueISODate) as varchar(10)),'')
	end 
 as StatedValueDate_Display


-----Exchange Rate and Value as stated in USD------------------------------------------------------

,oi.CurrencyRate2					--Exhchange Rate: Currency conversion rate for currency value
,oi.CurrencyRateISODate				--The date associated with the Exchange Rate.
,oi.ValuationPurposeID				--Internal identifier relating Object Insurance to Valuation Purpose table
,vp.ValuationPurpose
,oi.[Value]							--Local Value: Numerical field for insurance value
		
,oi.ValueNotes

-----Inflation Rate and Inflation-Adjusted Value in USD--------------------------------------------

,oi.RiskFactor						--Inflation Rate: The Inflation Rate applied to the value to compensate for inflation for a period of time (such as a loan)
,oi.AdjustedValue					--Value after INFLATION RATE is applied


from ObjInsurance as oi
left outer join ValuationPurposes as vp on oi.ValuationPurposeID = vp.ValuationPurposeID
left outer join Currencies as c on oi.CurrencyID = c.CurrencyID

GO









