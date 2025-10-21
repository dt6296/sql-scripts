





--SELECT * FROM Shipments WHERE ShipmentID = 1112

SELECT
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

sex.ShipExhXrefID,
sex.ExhibitionID,

e.ExhTitle,

sch.CrateHierID,
sch.CrateID,
sch.TableID,
sch.ID,
sch.Instructions,

c.CrateNumber,

scx.ShipCompXrefID,
scx.ComponentID,
scx.Included,
scx.Remarks,
scx.ShipStatus,

o.ObjectNumber,
o.Title,

oi.ThumbBlob

FROM			Shipments			AS s
LEFT OUTER JOIN ShipmentTypes		AS st	ON	s.ShipmentTypeID = st.ShipmentTypeID
LEFT OUTER JOIN	ShipmentPurposes	AS sp	ON	s.ShipmentPurposeID = sp.ShipmentPurposeID
LEFT OUTER JOIN	ShipmentStatuses	AS ss	ON	s.ShipmentStatusID = ss.ShipmentStatusID
LEFT OUTER JOIN	ShipExhXrefs		AS sex	ON	s.ShipmentID = sex.ShipmentID
LEFT OUTER JOIN	Exhibitions			AS e	ON	sex.ExhibitionID = e.ExhibitionID
LEFT OUTER JOIN	ShipCrateHiers		AS sch	ON	s.ShipmentID = sch.ShipmentID
											AND	sch.TableID = 94
LEFT OUTER JOIN Crates				AS c	ON	sch.CrateID = c.CrateID
LEFT OUTER JOIN	ShipCompXrefs		AS scx	ON	sch.ShipmentID = scx.ShipmentID
											AND	sch.ID	= scx.ComponentID
											AND	sch.TableID	= 94
LEFT OUTER JOIN	ObjComponents		AS oc	ON	scx.ComponentID = oc.ComponentID
LEFT OUTER JOIN Objects				AS o	ON	oc.ObjectID = o.ObjectID
LEFT OUTER JOIN MFAHv_ObjectImage	AS oi	ON	o.ObjectID = oi.ObjectID


WHERE s.ShipmentID = 1112

--SELECT * FROM DDTables WHERE TableID IN (26,94)  --26 = Crates, 94 = ObjComponents