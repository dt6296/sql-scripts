
/*

These notes pertain to my idea to help better manage exhibition checklists, 
and to programmatically determine if an object is on view or not.

The idea behind this logic is that when managing an exhibition checklist:
if an object is not included in a venue, then it is Unapproved for that venue;
if an object is included in a venue, and if "approved" is unchecked, then it is Pending Approval;
if an object is included in a venue, and if "approved" is checked, then it is Approved;

if an object is approved and if "displayed" is checked, then it is "Approved/Displayed";
if an object is pending approval but "displayed" is checked, then the status is "Undetermined" because
	it wouldn't make sense to display an object that isn't approved for a venue.

I wrote it this way so that the display checkboxes don't have to be maintained, it seems like extra work.

The display checkboxes and Display Begin and End Dates have to do with determining if an object is "on view".
However, my idea will work only if all objects on view at the MFAH are recorded in an exhibition-venue record 
with accurate begin/end display dates, and accurate begin/end display dates for exceptions.

My idea is that the "Displayed" checkbox doesn't play into the determination because it would require
manual upkeep of that checkbox for every single object on view in the museum.

Instead, the next thing I would do to determine if an object is on view is to write a script that
1) checks to see if the object is in an on-view location
2) if so, checks to see if the object is in an exhibition MFAH venue that is currently on view using the exh-venue Begin and End Dates
3) then, if the exh-venue-object Display Begin and End Dates are null, assume the display dates are the same as the exh venue Begin and End Dates,
4) if either the exh-venue-object Display Begin or End Date is null, use those dates to determine if the object is currently on-view.

This will allow users to manage individual object change-outs by only recording the exceptions to the exh-venue Display dates
by updating the exh-venue-object display begin and end dates. 

This may seem like a lot of work to get around the task of just manually updating the objects.onview checkbox, but the benefit is that this
approach can help prevent mistakes and oversights when updating that checkbox, and will also begin to create an accurate 
exhibition history for all objects going forward, and will assist with requests from the Director's office about building-specific
on view statistics.

The result of this script should then accurately determine if an object is on view, and can then be used to update the
objects.onview checkbox nightly so that it's published correctly on eMuseum.

So, to write and execute the script now will not return reliable results. 
All the data has to be entered and managed in this way for the script to return reliable results.

***************
One caveat is that I think there's still an issue with multi-component objects, time-based media especially, in which the primary component
is not the one on view, so the object may still appear as "not on view" on eMuseum. One has to determine which component to use
when determining if it is on view or not. I think I started down a path of looking to see if any of the components were on view,
and if so, then the object can be considered on view. I don't remember at the moment how far I got with this.
***************


- Dave Thompson 3/23/2021

*/



SELECT
ExhTitle,
SubTitle,
ExhTitleDisplay,
ExhMnemonic,
ExhDisplayDate,
Section,
Classification,
ObjectNumber,
ObjectSortNumber,
IndemnityNumber,
ArtistMaker,
TitleFirstActiveDisplayed AS Title,
Dated,
DateBegin,
Medium,
Dimensions,
ThumbBlob,
PrimaryLender,
LenderCity,
LenderState,
CurrentValue,
ThirdPartyValuation,
ThirdPartyAppraiser,
LendersObjectNumber,
Venue,
VenueMnemonic,
VenueDisplayOrder,
ExhVenObjXrefID,
ExhVenObjApproved,
ExhVenObjDisplayed,


CASE WHEN ExhVenObjXrefID IS NULL THEN 'Not Approved' ELSE
CASE WHEN ExhVenObjApproved = 0 AND ExhVenObjDisplayed = 0 THEN 'Pending' ELSE
CASE WHEN ExhVenObjApproved = 1 AND ExhVenObjDisplayed = 0 THEN 'Approved' ELSE
CASE WHEN ExhVenObjApproved = 1 AND ExhVenObjDisplayed = 1 THEN 'Approved/Displayed' ELSE
CASE WHEN ExhVenObjApproved = 0 AND ExhVenObjDisplayed = 1 THEN 'Undetermined' ELSE
'Undetermined' END END END END END AS VenueStatus,


CASE WHEN ExhVenObjXrefID IS NULL THEN 'LightCoral' ELSE
CASE WHEN ExhVenObjApproved = 0 AND ExhVenObjDisplayed = 0 THEN 'LemonChiffon' ELSE
CASE WHEN ExhVenObjApproved = 1 AND ExhVenObjDisplayed = 0 THEN 'LightGreen' ELSE
CASE WHEN ExhVenObjApproved = 1 AND ExhVenObjDisplayed = 1 THEN 'LightGreen' ELSE
CASE WHEN ExhVenObjApproved = 0 AND ExhVenObjDisplayed = 1 THEN 'Silver' ELSE
'Silver' END END END END END AS VenueStatusColor,


ExhVenObjRemarks		AS VenueRemarks,
StatusOverview,
InstallLightingClimateRequirements,
Notes

FROM MFAHv_EXH_VENUE_LOAN_Object evlo

--WHERE evlo.ExhibitionID = 951
--AND ObjectNumber = 'EX.2020.P/C.013.1'

INNER JOIN
(
	SELECT
	ID,ReportGUID
	FROM WebReportIDs
UNION
	SELECT 
	ID,ReportGUID
	FROM ReportIDs
) AS r ON evlo.ExhibitionID = r.ID

WHERE r.ReportGUID IN (@TMSReportID)


ORDER BY Section, ObjectSortNumber, VenueDisplayOrder

