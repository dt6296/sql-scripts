


SELECT ObjectID,
CASE WHEN CurUnitType LIKE '%on view%'
OR CurUnitNumber LIKE '%on view%'
OR CurUnitPosition LIKE '%on view%'
THEN 1 ELSE 0 END AS ObjectOnView
FROM MFAHv_OBJ_Location



SELECT
eox.ObjectID
FROM ExhObjXrefs AS eox
INNER JOIN Exhibitions AS e ON eox.ExhibitionID = e.ExhibitionID



SELECT * FROM MFAHv_EXH_VENUE_OBJ AS evox
WHERE evox.ExhVenObjDisplayed = 1



SELECT evox.* FROM ExhVenObjXrefs AS evox
INNER JOIN ExhVenuesXrefs AS evx ON evox.ExhVenueXrefID = evx.ExhVenueXrefID
INNER JOIN Objects AS o ON evox.ObjectID = o.ObjectID
WHERE evx.ExhibitionID = 836
AND evx.ConstituentID = 0
AND o.ObjectNumber LIKE 'TEST.DAVE.%'

--------------------------------------------------------------------------

SELECT
evox.ExhVenObjXrefID,
evx.ConstituentID AS VenueID,
evx.Mnemonic AS VenueMnemonic,
evx.BeginISODate AS Venue_BeginISODate,
evox.BeginDisplDateISO AS ExhVenObj_BeginDisplayISODate,
evx.EndISODate AS Venue_BeginISODate,
evox.EndDisplDateISO AS ExhVenObj_EndDisplayISODate,
evox.ObjectID,
evox.Approved,
evox.Displayed

FROM ExhVenObjXrefs AS evox
INNER JOIN ExhVenuesXrefs AS evx ON evox.ExhVenueXrefID = evx.ExhVenueXrefID
INNER JOIN Objects AS o ON evox.ObjectID = o.ObjectID
WHERE evx.ExhibitionID = 836
AND evx.ConstituentID = 0
AND o.ObjectNumber LIKE 'TEST.DAVE.%' 


-- Do I really have to do this? Can I just look at "Displayed"?
--UPDATE ExhVenObjXrefs
SET 
BeginDisplDateISO = evx.BeginISODate, 
EndDisplDateISO = evx.EndISODate
--SELECT * 
FROM ExhVenObjXrefs AS evox
INNER JOIN ExhVenuesXrefs AS evx ON evox.ExhVenueXrefID = evx.ExhVenueXrefID
INNER JOIN Objects AS o ON evox.ObjectID = o.ObjectID
WHERE evx.ExhibitionID = 836
AND evx.ConstituentID = 0
AND o.ObjectNumber LIKE 'TEST.DAVE.%' 



-------------------------------------------------------------------------- This is it!
-- This is supposed to indicate OnView if any component is in on view location 
-- AND MFAH venue-object = Displayed
-- AND GETDATE() is between an EXH-VENUE Begin and End dates.
-- The problem for now is that not all exh-venue-objs are marked as Displayed, 
-- or even in an exhibition in the first place.
-- SO, my criteria could be if any component is in an on view location
-- OR...
-- Now I'm lost. My criteria is already if any component is in an on view location
-- THEN mark it as On View. 
-- BUT, 2020.170 is marked as on view because there's a component on view, but it still
-- shows as not on view on eMuseum. WTF???

SELECT evox.ObjectID, o.ObjectNumber, evox.Approved, evox.Displayed,

dbo.MFAHfx_ISOtoDATETIME(evx.BeginISODate),
dbo.MFAHfx_ISOtoDATETIME(evx.EndISODate)+'23:59:59',

CASE WHEN SUM(CASE WHEN ol.CurUnitType LIKE '%on view%'
OR ol.CurUnitNumber LIKE '%on view%'
OR ol.CurUnitPosition LIKE '%on view%'
THEN 1 ELSE 0 END) > 0 
AND evox.Displayed = 1 
AND GETDATE() BETWEEN dbo.MFAHfx_ISOtoDATETIME(evx.BeginISODate) 
	AND dbo.MFAHfx_ISOtoDATETIME(evx.EndISODate)+'23:59:59'
THEN 1 ELSE 0 END AS OnView

FROM MFAHv_OBJ_Location AS ol
INNER JOIN ExhVenObjXrefs AS evox ON ol.ObjectID = evox.ObjectID
INNER JOIN ExhVenuesXrefs AS evx ON evox.ExhVenueXrefID = evx.ExhVenueXrefID
INNER JOIN Objects AS o ON evox.ObjectID = o.ObjectID

WHERE evx.ExhibitionID = 836--1015
AND evx.ConstituentID = 0

GROUP BY 
evox.ObjectID, 
o.ObjectNumber, 
evox.Approved, 
evox.Displayed,
evx.BeginISODate,
evx.EndISODate


--------------------------------------------------------------


SELECT evx.ExhibitionID, evx.ConstituentID, evox.ObjectID, o.ObjectNumber, evox.Approved, evox.Displayed,
dbo.MFAHfx_ISOtoDATETIME(evx.BeginISODate),
dbo.MFAHfx_ISOtoDATETIME(evx.EndISODate)+'23:59:59',

CASE WHEN SUM(CASE WHEN ol.CurUnitType LIKE '%on view%'
OR ol.CurUnitNumber LIKE '%on view%'
OR ol.CurUnitPosition LIKE '%on view%'
THEN 1 ELSE 0 END) > 0 
AND evox.Displayed = 1 
AND GETDATE() BETWEEN dbo.MFAHfx_ISOtoDATETIME(evx.BeginISODate) AND
dbo.MFAHfx_ISOtoDATETIME(evx.EndISODate)+'23:59:59'
THEN 1 ELSE 0 END AS OnView

FROM MFAHv_OBJ_Location AS ol
INNER JOIN ExhVenObjXrefs AS evox ON ol.ObjectID = evox.ObjectID
INNER JOIN ExhVenuesXrefs AS evx ON evox.ExhVenueXrefID = evx.ExhVenueXrefID
INNER JOIN Objects AS o ON evox.ObjectID = o.ObjectID

WHERE evx.ConstituentID = 0
--AND evx.ExhibitionID = 836--1015
AND o.ObjectNumber LIKE '2018.7'

GROUP BY 
evx.ExhibitionID, evx.ConstituentID, evox.ObjectID, 
o.ObjectNumber, 
evox.Approved, 
evox.Displayed,
evx.BeginISODate,
evx.EndISODate


-- This checks for objects with a component in an on-view location
SELECT DISTINCT evox.ObjectID
FROM MFAHv_OBJ_Location AS ol
INNER JOIN ExhVenObjXrefs AS evox ON ol.ObjectID = evox.ObjectID
INNER JOIN Objects AS o ON evox.ObjectID = o.ObjectID
WHERE ol.CurUnitType LIKE '%on view%'
OR ol.CurUnitNumber LIKE '%on view%'
OR ol.CurUnitPosition LIKE '%on view%'

UNION

-- This checks for objects Displayed in a current MFAH Exhibition-Venue record
SELECT DISTINCT evox.ObjectID
FROM ExhVenObjXrefs AS evox
INNER JOIN ExhVenuesXrefs AS evx ON evox.ExhVenueXrefID = evx.ExhVenueXrefID
WHERE evx.ConstituentID = 0
AND GETDATE() BETWEEN dbo.MFAHfx_ISOtoDATETIME(evx.BeginISODate) AND
dbo.MFAHfx_ISOtoDATETIME(evx.EndISODate)+'23:59:59'
AND evox.Displayed = 1





SELECT ObjectNumber FROM Objects WHERE ObjectID = 17521
SELECT ExhTitle FROM Exhibitions WHERE ExhibitionID IN (837,874,1015)



-- TBM works aren't being moved according to procedure
-- Groups of objects (2016.208.1-.3), if only virtual is web approved and not located,
-- but child records are located in an on-view location, 
-- maybe then mark the virtual as on-view?
-- But which location to use, in case physical objects are in different locations?
-- Maybe in this case, hard-code "view related objects for location" or similar?
-- This would mean publishing related objects.
-- This would require virtual and child physical objects to be web approved.






-- eMuseum issue	------------------------------------------------------

SELECT COUNT(DISTINCT o.ObjectID) FROM MFAHv_OBJ_Location AS ol --WHERE ol.AccessionNumber LIKE 'TEST.DAVE.%'
INNER JOIN Objects AS o ON ol.ObjectID = o.ObjectID
WHERE (ol.CurUnitType LIKE '%on view%'
OR ol.CurUnitNumber LIKE '%on view%'
OR ol.CurUnitPosition LIKE '%on view%')	--	8969
AND o.ObjectStatusID IN (2,27)			--	7399
AND o.PublicAccess = 1					--	5360

-- 5360 on eMuseum, in website search, and in DB search.
-- Also matches nightly on view update job (8969).
-- SO, the eMuseum DB has the correct objects marked on view, but they aren't 
-- displaying correctly on the eMuseum website (2020.170).
-- 2020.170 appears in the results when searching for objects on view, 
-- but the record detail says it's not on view.

/*

I think the idea was to mark objects as "on view" if they're in an "on view" location
AND if they're in an MFAH Exhibition-Venue, and marked as "Displayed" in the ExhVenObjXref.
I was originally going to use the display Begin and End dates, but I think this is unnecessary
and would require lots of backend updates and manual work to maintain the dates.
Just using Displayed would be much easier.

*/

