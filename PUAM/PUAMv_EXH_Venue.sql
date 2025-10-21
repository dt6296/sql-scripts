USE [TMS]
GO
/****** Object:  View [dbo].[PUAMv_EXH_VENUE]    Script Date: 3/25/2021 12:37:55 PM ******/
SET ANSI_NULLS on
GO
SET QUOTED_IDENTIFIER on
GO

--alter view [dbo].[PUAMv_EXH_VENUE] as

/*

Created		10/10/2025	Dave Thompson						

*/

select distinct
 evx.ExhVenueXrefID							as ID
,evx.ExhibitionID
,evx.ConstituentID
,evx.ConstituentID							as VenueID
,c.DisplayName
,c.DisplayName								as Venue
,c.AlphaSort								as VenueAlphaSort
,evx.Remarks
,evx.Contact
,evx.ExhVenueXrefID
,evx.BeginISODate							as VenueBeginISODate
,dbo.PUAMfx_ISOtoDATE(evx.BeginISODate)		as VenueBeginDate
,evx.EndISODate								as VenueEndISODate
,dbo.PUAMfx_ISOtoDATE(evx.EndISODate)		as VenueEndDate
,dbo.PUAMfx_ISOtoDATE_Range(evx.BeginISODate,evx.EndISODate) as VenueDateRange
,isnull(concat_ws(' (',c.DisplayName, dbo.PUAMfx_ISOtoDATE_Range(evx.BeginISODate,evx.EndISODate)),'') + ')' as VenueAndDates

,isnull(concat_ws(
					' ('
					,c.DisplayName, 
					isnull(ca.City,'') + 
					case when ca.[State] is null then '' else ', ' + ca.[State] end + 
					' ' + 
					dbo.PUAMfx_ISOtoDATE_Range(evx.BeginISODate,evx.EndISODate)
				  ),''
		) +
 ')' as VenueCityStateDates

,evx.Approved
,evx.IsForeign
,evx.Mnemonic
,evx.DisplayOrder
,ca.City
,ca.[State]
,cty.Country
,ca.[Rank]

from Exhibitions as e
inner join ExhVenuesXrefs as evx on e.ExhibitionID = evx.ExhibitionID
left outer join Constituents as c on evx.ConstituentID = c.ConstituentID
left outer join ConXrefs as cx on evx.VenueConXrefID = cx.ConXrefID
left outer join ConXrefDetails as cxd on cx.ConXrefID = cxd.ConXrefID
left outer join ConAddress as ca on cxd.AddressID = ca.ConAddressID
left outer join Countries as cty on ca.CountryID = cty.CountryID

--WHERE e.ExhibitionID = 894
GO
