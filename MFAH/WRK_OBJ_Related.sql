/*

MFAHv_RelatedObject
Custom MFAH View

Author:			Dave Thompson
Created:		4/25/2014

Description:	
--Related object information for subreport

Updated:		4/27/2014
Because the Associations table structures the relationships as ID1 and ID2,
the original version of this query would only pull associated records for ObjectIDs in ID1,
therefore, I couldn't display the parent record for a child record (child record ObjectID is in ID2).
So, I added the UNION query to pull both.

Updated:		4/30/2014
Added
r.RelationshipTypeID,
CASE statement to return RelationshipType,
r.MoveCoLocated

Updated:		5/6/2014
I replaced the reference to MFAHv_OCM_Object with Objects and linked in ObjectLevels and ObjectTypes
because I use this view as the source for a sub report which already references MFAHv_OCM_Object, which made
that report run extremely slowly.

Updated:		6/14/2014	Renamed from MFAHv_RelatedObject

Updated:		6/17/2014	Changed RelPosition to 1 for "primary", 2 for "subordinate".
							In dependent queries, if null, then 0.  I prefer to filter records by
							an integer rather than some text string that I may later change.
Updated:		6/19/2014	Changed RelPosition in second query to
							CASE WHEN r.RelationshipTypeID !=0 THEN 1 ELSE 2 END AS RelPosition
							so that see-also relationship members always appear.
							
							I changed join criteria because I had the object focus linked to the
							target object information.
							
				***********	But then I changed it back, because the point of the query is to
							return infomation about an object's related object(s).
							
							Changed RelPosition in second query again to
							CASE WHEN	(r2.RelationshipTypeID = 0 AND o2.ObjectLevelID = 10) 
							OR			(r2.RelationshipTypeID !=0)
							THEN 1 ELSE 2 END AS RelPosition
							so that accessioned children of collection items appear, even if the entire
							collection is not accessioned.
							For instance, TR:334-2012-TR:552-2012 is a collection under consideration
							for purchase. We only accessioned some of the 181 photos, 2013.423-443, for example.
*/

SELECT
1	AS RelPosition,
r1.RelationshipTypeID,
CASE
	WHEN r1.RelationshipTypeID = 0 THEN 'Parent-Child'
	WHEN r1.RelationshipTypeID = 1 THEN 'See Also'
	WHEN r1.RelationshipTypeID = 2 THEN 'Inseparable Objects'
	ELSE 'Undetermined' END AS RelationshipType,
a1.ID1			AS ObjectID,
a1.ID2			AS RelatedObjectID,
r1.Relation1	AS RelationFocus,
r1.Relation2	AS RelationTarget,
r1.Rel1Prep,
r1.MoveCoLocated,
o1.ObjectNumber,
o1.SortNumber,
o1.ObjectLevelID,
ol1.ObjectLevel,
o1.ObjectTypeID,
ot1.ObjectType,
o1.Title,
o1.IsVirtual,
CASE WHEN o1.IsVirtual = 1 THEN 'Virtual Object' ELSE 'Physical Object' END AS IsVirtualDisplay

FROM			Associations		AS a1	
LEFT OUTER JOIN Relationships		AS r1	ON a1.RelationshipID = r1.RelationshipID
LEFT OUTER JOIN Objects				AS o1	ON a1.ID2 = o1.ObjectID
LEFT OUTER JOIN ObjectLevels		AS ol1	ON o1.ObjectLevelID = ol1.ObjectLevelID
LEFT OUTER JOIN ObjectTypes			AS ot1	ON o1.ObjectTypeID = ot1.ObjectTypeID


WHERE	a1.TableID = 108
--AND		a.ID1 IN (120735,117763,117792,117793,117794,117795,117796,124041)
--AND (a.ID1 IN (121709,121710) OR a.ID2 IN (121709,121710))
--AND a1.ID1 IN (114501,114502) 
--AND a1.ID1 IN (121826,121827)


UNION	-----------------------------------------------------------------------


SELECT
CASE WHEN	(r2.RelationshipTypeID = 0 AND o2.ObjectLevelID = 10) 
OR			(r2.RelationshipTypeID !=0)
THEN 1 ELSE 2 END AS RelPosition,

r2.RelationshipTypeID,
CASE
	WHEN r2.RelationshipTypeID = 0 THEN 'Parent-Child'
	WHEN r2.RelationshipTypeID = 1 THEN 'See Also'
	WHEN r2.RelationshipTypeID = 2 THEN 'Inseparable Objects'
	ELSE 'Undetermined' END AS RelationshipType,
a2.ID2			AS ObjectID,
a2.ID1			AS RelatedObjectID,
r2.Relation2	AS RelationFocus,
r2.Relation1	AS RelationTarget,
r2.Rel2Prep,
r2.MoveCoLocated,
o2.ObjectNumber,
o2.SortNumber,
o2.ObjectLevelID,
ol2.ObjectLevel,
o2.ObjectTypeID,
ot2.ObjectType,
o2.Title,
o2.IsVirtual,
CASE WHEN o2.IsVirtual = 1 THEN 'Virtual Object' ELSE '' END AS IsVirtualDisplay

FROM			Associations		AS a2	
LEFT OUTER JOIN Relationships		AS r2	ON a2.RelationshipID = r2.RelationshipID
LEFT OUTER JOIN Objects				AS o2	ON a2.ID1 = o2.ObjectID
LEFT OUTER JOIN ObjectLevels		AS ol2	ON o2.ObjectLevelID = ol2.ObjectLevelID
LEFT OUTER JOIN ObjectTypes			AS ot2	ON o2.ObjectTypeID = ot2.ObjectTypeID

WHERE	a2.TableID = 108
--AND		a.ID1 IN (120735,117763,117792,117793,117794,117795,117796,124041)
--AND (a.ID1 IN (121709,121710) OR a.ID2 IN (121709,121710))
--AND a2.ID2 IN (114501,114502)
--AND a2.ID2 IN (121826,121827)



GO


