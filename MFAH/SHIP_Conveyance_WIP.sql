




--																		GOTO LINE 150
/*


SELECT
s.ShipmentID,
s.ShipmentNumber,
scx.ComponentID,
scx.Included,
oc.ObjectID,
sch.CrateID,
sch.Position,
c.CrateID,
c.CrateNumber,
ss.StepID,
ss.StepNumber,
ssh.*

FROM Shipments					AS s
LEFT OUTER JOIN ShipCompXrefs	AS scx	ON	s.ShipmentID = scx.ShipmentID
										AND	scx.Included = 1
LEFT OUTER JOIN ObjComponents	AS oc	ON	scx.ComponentID = oc.ComponentID
LEFT OUTER JOIN	ShipCrateHiers	AS sch	ON	oc.ComponentID = sch.ID	
										AND	sch.TableID = 94
										AND s.ShipmentID = sch.ShipmentID
LEFT OUTER JOIN Crates			AS c	ON	sch.CrateID = c.CrateID
LEFT OUTER JOIN ShipmentSteps	AS ss	ON	s.ShipmentID = ss.ShipmentID

LEFT OUTER JOIN ShipStepHiers	AS ssh	ON	(sch.CrateID = ssh.ID AND ssh.TableID = 26)
										AND	(sch.ID = ssh.ID AND ssh.TableID = 94)



WHERE s.ShipmentID = 1613

ORDER BY c.CrateNumber









-- 45 crates

SELECT
s.ShipmentID,
s.ShipmentNumber,
ss.StepID,
ss.StepNumber,
sc.ConveyanceID,
sc.ConveyanceTypeID,
ct.ConveyanceType,
ssh.TableID,
ssh.ID AS CrateID

FROM Shipments					AS s
LEFT OUTER JOIN ShipmentSteps	AS ss	ON	s.ShipmentID = ss.ShipmentID
LEFT OUTER JOIN ShipConveyances	AS sc	ON	ss.StepID = sc.StepID
LEFT OUTER JOIN ConveyanceTypes	AS ct	ON	sc.ConveyanceTypeID = ct.ConveyanceTypeID
LEFT OUTER JOIN ShipStepHiers	AS ssh	ON	sc.ConveyanceID = ssh.ConveyanceID
										AND	sc.StepID = ssh.StepID

WHERE s.ShipmentID = 1613


*/

/*



SELECT
s.ShipmentID,
s.ShipmentNumber,
ss.StepID,
ss.StepNumber

FROM Shipments AS s
LEFT OUTER JOIN ShipmentSteps AS ss ON s.ShipmentID = ss.ShipmentID

WHERE s.ShipmentID = 1613			-- 1 step


SELECT
ss.StepID,
ss.StepNumber,
sc.ConveyanceID,
sc.ConveyanceNumber

FROM ShipmentSteps AS ss
LEFT OUTER JOIN ShipConveyances AS sc ON ss.StepID =  sc.StepID
				
WHERE ss.ShipmentID = 1613			-- 3 conveyances



SELECT
sch.ShipmentID,
sch.TableID,
sch.ID,
sch.CrateID,
sch.RootCrateID,
c.CrateNumber

FROM ShipCrateHiers AS sch
LEFT OUTER JOIN Crates AS c ON sch.RootCrateID = c.CrateID

WHERE sch.ShipmentID = 1613
AND sch.TableID = 26				-- 45 crates





SELECT
scx.ShipmentID,
scx.ComponentID,
oc.ComponentNumber,
oc.ComponentName,
oc.ComponentType,
scx.Included

FROM ShipCompXrefs AS scx
LEFT OUTER JOIN ObjComponents AS oc ON scx.ComponentID = oc.ComponentID

WHERE scx.ShipmentID = 1613
AND scx.Included = 1				-- 255 components




SELECT * FROM ShipCrateHiers AS sch WHERE ShipmentID = 1613




SELECT * FROM ShipCrateHiers AS sch WHERE ShipmentID = 1613 AND TableID = 94 -- 255 Components with their CrateIDs


SELECT * FROM ShipStepHiers AS ssh 
WHERE StepID IN (SELECT StepID FROM ShipmentSteps WHERE ShipmentID = 1613)
AND ConveyanceID IS NOT NULL
ORDER BY StepID, ConveyanceID, ID --45 crates w/ 3 conveyances
*/


--------------------------------------------------------------------------------------	This is it!


SELECT
e.ExhibitionID,
e.ExhTitle,
s.ShipmentID,
s.ShipmentNumber,
s.ActShipDate,
s.EstShipDate,
s.ActArrivalDate,
s.EstArrivalDate,
s.ShipToAddress,
s.ShipFromAddress,
ssh.StepID,
ss.StepNumber,
ssh.TableID,
'Crate' AS TableName,
ssh.ID,
c.CrateID,
c.CrateNumber,
c.CrateHeightCM,
c.CrateHeightInches,
c.CrateWidthCM,
c.CrateWidthInches,
c.CrateDepthCM,
c.CrateDepthInches,
c.CrateWeightKG,
c.CrateWeightLBS,
ssh.ConveyanceID,
sc.ConveyanceNumber,
sc.ConveyanceTypeID,
ct.ConveyanceType,
sch.ID AS ComonentID,
oc.ComponentName,
oc.ComponentNumber,
oct.ObjCompType,
oc.ObjectID,
o.ObjectNumber,
o.SortNumber

FROM ShipStepHiers					AS ssh	
LEFT OUTER JOIN ShipConveyances		AS sc	ON	ssh.ConveyanceID = sc.ConveyanceID
LEFT OUTER JOIN ConveyanceTypes		AS ct	ON	sc.ConveyanceTypeID = ct.ConveyanceTypeID
LEFT OUTER JOIN ShipmentSteps		AS ss	ON	sc.StepID = ss.StepID
LEFT OUTER JOIN MFAHv_SHIP			AS s	ON	ss.ShipmentID = s.ShipmentID
LEFT OUTER JOIN MFAHv_CRATE			AS c	ON	ssh.ID = c.CrateID AND ssh.TableID = 26
LEFT OUTER JOIN ShipCrateHiers		AS sch	ON	ssh.ID = sch.CrateID AND ssh.TableID = 26 AND sch.ShipmentID = 1613
LEFT OUTER JOIN ObjComponents		AS oc	ON	sch.ID = oc.ComponentID AND sch.TableID = 94 
LEFT OUTER JOIN ObjCompTypes		AS oct	ON	oc.ComponentType = oct.ObjCompTypeID
LEFT OUTER JOIN Objects				AS o	ON	oc.ObjectID = o.ObjectID
LEFT OUTER JOIN ShipLoanXrefs		AS slx	ON	s.ShipmentID = slx.ShipmentID
LEFT OUTER JOIN ExhLoanXrefs		AS elx	ON	slx.LoanID = elx.LoanID
LEFT OUTER JOIN Exhibitions			AS e	ON	elx.ExhibitionID = e.ExhibitionID
											
WHERE ssh.ConveyanceID IS NOT NULL
AND ssh.StepID IN (SELECT StepID FROM ShipmentSteps WHERE ShipmentID = 1613)
--AND sch.CrateHierID IS NOT NULL

ORDER BY ssh.StepID, ssh.ConveyanceID, ssh.ID




--SELECT * FROM ConXrefs WHERE ID = 1613
--SELECT * FROM DDTAbles WHERE TableID = 372





SELECT DISTINCT
e.ExhibitionID,
e.ExhTitle,
s.ShipmentID,
s.ShipmentNumber,
s.ActShipDate,
s.EstShipDate,
s.ActArrivalDate,
s.EstArrivalDate,
s.ShipToAddress,
s.ShipFromAddress,
ssh.StepID,
ss.StepNumber,
ssh.TableID,
'Crate' AS TableName,
ssh.ID,
c.CrateID,
c.CrateNumber,
c.CrateHeightCM,
c.CrateHeightInches,
c.CrateWidthCM,
c.CrateWidthInches,
c.CrateDepthCM,
c.CrateDepthInches,
c.CrateWeightKG,
c.CrateWeightLBS,
ssh.ConveyanceID,
sc.ConveyanceNumber,
sc.ConveyanceTypeID,
ct.ConveyanceType,
sch.ID AS ComonentID,
oc.ComponentName,
oc.ComponentNumber,
oct.ObjCompType,
oc.ObjectID,
o.ObjectNumber,
o.SortNumber

FROM ShipStepHiers					AS ssh	
LEFT OUTER JOIN ShipConveyances		AS sc	ON	ssh.ConveyanceID = sc.ConveyanceID
LEFT OUTER JOIN ConveyanceTypes		AS ct	ON	sc.ConveyanceTypeID = ct.ConveyanceTypeID
LEFT OUTER JOIN ShipmentSteps		AS ss	ON	sc.StepID = ss.StepID
LEFT OUTER JOIN MFAHv_SHIP			AS s	ON	ss.ShipmentID = s.ShipmentID
LEFT OUTER JOIN MFAHv_CRATE			AS c	ON	ssh.ID = c.CrateID AND ssh.TableID = 26
LEFT OUTER JOIN ShipCrateHiers		AS sch	ON	ssh.ID = sch.CrateID AND ssh.TableID = 26 AND sch.ShipmentID = 1615
LEFT OUTER JOIN ObjComponents		AS oc	ON	sch.ID = oc.ComponentID AND sch.TableID = 94 
LEFT OUTER JOIN ObjCompTypes		AS oct	ON	oc.ComponentType = oct.ObjCompTypeID
LEFT OUTER JOIN Objects				AS o	ON	oc.ObjectID = o.ObjectID
LEFT OUTER JOIN ShipLoanXrefs		AS slx	ON	s.ShipmentID = slx.ShipmentID
LEFT OUTER JOIN ExhLoanXrefs		AS elx	ON	slx.LoanID = elx.LoanID
LEFT OUTER JOIN Exhibitions			AS e	ON	elx.ExhibitionID = e.ExhibitionID
											
WHERE ssh.ConveyanceID IS NOT NULL
AND ssh.StepID IN (SELECT StepID FROM ShipmentSteps WHERE ShipmentID = 1615)
--AND sch.CrateHierID IS NOT NULL

ORDER BY oc.ComponentNumber, ssh.StepID, ssh.ConveyanceID, ssh.ID


