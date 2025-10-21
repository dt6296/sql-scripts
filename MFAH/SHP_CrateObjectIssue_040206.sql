

--Crystal SQL

 SELECT "Shipments"."ShipmentID", "Objects"."ObjectNumber", "Makers"."DisplayName", "Makers"."DisplayOrder", "ObjTitles"."Title", "Objects"."Dated", "ShipCompRootCrateXrefs"."CrateNumber", "ShipCompRootCrateXrefs"."CrateHeightCM", "ShipCompRootCrateXrefs"."CrateWidthCM", "ShipCompRootCrateXrefs"."CrateDepthCM", "ObjTitles"."DisplayOrder", "Objects"."ObjectID", "Objects"."SortNumber", "Exhibitions"."ExhTitle", "Objects"."Medium", "Objects"."Dimensions"
 FROM   {oj ((((("TMS"."dbo"."Shipments" "Shipments" LEFT OUTER JOIN "TMS"."dbo"."ShipExhXrefs" "ShipExhXrefs" ON "Shipments"."ShipmentID"="ShipExhXrefs"."ShipmentID") LEFT OUTER JOIN "TMS"."dbo"."ShipCompRootCrateXrefs" "ShipCompRootCrateXrefs" ON "Shipments"."ShipmentID"="ShipCompRootCrateXrefs"."ShipmentID") LEFT OUTER JOIN "TMS"."dbo"."Exhibitions" "Exhibitions" ON "ShipExhXrefs"."ExhibitionID"="Exhibitions"."ExhibitionID") LEFT OUTER JOIN "TMS"."dbo"."Objects" "Objects" ON "ShipCompRootCrateXrefs"."ObjectID"="Objects"."ObjectID") LEFT OUTER JOIN "TMS"."dbo"."Makers" "Makers" ON "Objects"."ObjectID"="Makers"."ObjectID") LEFT OUTER JOIN "TMS"."dbo"."ObjTitles" "ObjTitles" ON "Objects"."ObjectID"="ObjTitles"."ObjectID"}
 WHERE  ("Makers"."DisplayOrder"=1 OR "Makers"."DisplayOrder" IS  NULL ) AND "ObjTitles"."DisplayOrder"=1 AND "Shipments"."ShipmentID"=1010
 ORDER BY "Shipments"."ShipmentID", "ShipCompRootCrateXrefs"."CrateNumber", "Objects"."SortNumber", "Objects"."ObjectNumber"




-- altered Piece of "ShipCompRootCrateXrefs"


SELECT 

SCX.ShipmentID, 
CR.CrateNumber, 
OC.ObjectID, 
o.ObjectNumber,
m.Maker,
m.DisplayOrder,
ot.Title,
ot.DisplayOrder

FROM ShipCompXrefs SCX INNER JOIN ObjComponents OC ON SCX.ComponentID = OC.ComponentID
INNER JOIN ShipCrateHiers SCH ON SCX.ShipmentID = SCH.ShipmentID AND SCX.ComponentID = SCH.ID AND SCH.TableID = 94
INNER JOIN Crates CR ON SCH.RootCrateID = CR.CrateID
INNER JOIN CrateTypes CT ON CR.TypeID = CT.TypeID
INNER JOIN Objects AS o ON OC.ObjectID = o.ObjectID
LEFT OUTER JOIN Makers AS m ON o.ObjectID = m.ObjectID
LEFT OUTER JOIN ObjTitles AS ot ON o.ObjectID = ot.ObjectID

WHERE OC.ObjectID NOT IN
 (SELECT LOX.ObjectID 
  FROM LoanObjXrefs LOX INNER JOIN ShipLoanXrefs SLX ON LOX.LoanID = SLX.LoanID
  WHERE SLX.ShipmentID = SCX.ShipmentID)
  AND SCX.ShipmentID = 1010
AND SCX.ShipmentID = 1010