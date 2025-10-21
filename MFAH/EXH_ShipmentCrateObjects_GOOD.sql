

alter VIEW [dbo].[MFAHv_ObjectDeinstallTags]
AS

/*

[MFAHv_ObjectDeinstallTags]
Custom MFAH View

Author:		Dave Thompson
Created:	5/10/2014

Description:	
This is purpose-built and very rough...


*/

--SELECT * FROM Roles WHERE RoleID = 427

--SELECT * FROM Shipments WHERE ShipmentID = 1112

SELECT
e.ExhibitionID,
e.ExhTitle,
l.LoanNumber,
l.PrimaryConXrefID,

lox.ObjectID,
lox.LoanObjStatus,
o.ObjectNumber,
oc.ComponentID,
o.Title,

cxd.ConXrefDetailID,
cxd.RoleTypeID,
cxd.NameID,
cxd.ConstituentID,
can.DisplayName,


sox.Remarks,

s.ShipmentID,
s.ShipmentNumber,
s.ShipmentTypeID,
st.ShipmentType,
s.ShipmentPurposeID,
sp.ShipmentPurpose,
s.ShipmentStatusID,
ss.ShipmentStatus,
s.EstShipDate,
s.ActShipDate,
s.ShipFromGeo,
s.ShipToGeo,
s.ShipFromComment,
s.ShipToComment,

sch.CrateHierID,
sch.CrateID,
sch.TableID,
sch.ID,
sch.Position,
sch.Instructions,

c.CrateNumber,

oi.ThumbBlob,

cs.DisplayName AS IsTSA


FROM			Exhibitions			AS e
LEFT OUTER JOIN	ExhLoanXrefs		AS elx	ON	e.ExhibitionID = elx.ExhibitionID
LEFT OUTER JOIN Loans				AS l	ON	elx.LoanID = l.LoanID
LEFT OUTER JOIN	LoanObjXrefs		AS lox	ON	elx.LoanID = lox.LoanID
LEFT OUTER JOIN	Objects				AS o	ON	lox.ObjectID = o.ObjectID
LEFT OUTER JOIN MFAHv_ObjectImage	AS oi	ON	o.ObjectID = oi.ObjectID

LEFT OUTER JOIN ConXrefDetails		AS cxd	ON	l.PrimaryConXrefID = cxd.ConXrefID
											AND	cxd.UnMasked = 1
LEFT OUTER JOIN	ConAltNames			AS can	ON	cxd.NameID = can.AltNameID

LEFT OUTER JOIN ObjComponents		AS oc	ON	o.ObjectID = oc.ObjectID
LEFT OUTER JOIN	ShipCompXrefs		AS scx	ON	oc.ComponentID = scx.ComponentID
LEFT OUTER JOIN	Shipments			AS s	ON	scx.ShipmentID = s.ShipmentID

LEFT OUTER JOIN	ShipObjXrefs		AS sox	ON	s.ShipmentID = sox.Shipmentid
											AND	o.ObjectID = sox.ObjectID

LEFT OUTER JOIN ShipmentTypes		AS st	ON	s.ShipmentTypeID = st.ShipmentTypeID
LEFT OUTER JOIN	ShipmentPurposes	AS sp	ON	s.ShipmentPurposeID = sp.ShipmentPurposeID
LEFT OUTER JOIN	ShipmentStatuses	AS ss	ON	s.ShipmentStatusID = ss.ShipmentStatusID

LEFT OUTER JOIN	ShipCrateHiers		AS sch	ON	scx.ShipmentID = sch.ShipmentID
											AND	oc.ComponentID = sch.ID
											AND	sch.TableID = 94
LEFT OUTER JOIN Crates				AS c	ON	sch.CrateID = c.CrateID


LEFT OUTER JOIN	ConXrefs			AS cx	ON	s.ShipmentID = cx.ID
											AND	cx.TableID = 345
											AND cx.RoleID = 468
LEFT OUTER JOIN	ConXrefDetails		AS cxds	ON	cx.ConXrefID = cxds.ConXrefID
											AND	cxds.UnMasked = 1
LEFT OUTER JOIN Constituents		AS cs	ON	cxds.ConstituentID = cs.ConstituentID
	

WHERE e.ExhibitionID = 621
AND s.ShipmentTypeID = 2

/*


LEFT OUTER JOIN	ShipCrateHiers		AS sch	ON	s.ShipmentID = sch.ShipmentID
											AND	sch.TableID = 94
LEFT OUTER JOIN Crates				AS c	ON	sch.CrateID = c.CrateID
LEFT OUTER JOIN	ShipCompXrefs		AS scx	ON	sch.ShipmentID = scx.ShipmentID
											AND	sch.ID	= scx.ComponentID
											AND	sch.TableID	= 94
LEFT OUTER JOIN	ObjComponents		AS oc	ON	scx.ComponentID = oc.ComponentID
LEFT OUTER JOIN Objects				AS o	ON	oc.ObjectID = o.ObjectID
LEFT OUTER JOIN MFAHv_ObjectImage	AS oi	ON	o.ObjectID = oi.ObjectID

*/

--WHERE s.ShipmentID = 1112

--SELECT * FROM DDTables WHERE TableID IN (26,94)  --26 = Crates, 94 = ObjComponents
--SELECT * FROM RoleTypes


/*

SELECT
ObjectNumber,
CrateNumber,
DisplayName,
Remarks,
ShipToComment,
Position,
EstShipDate,
Instructions

FROM	MFAHv_ObjectDeinstallTags

ORDER BY 
ShipToComment,
ObjectNumber

*/