




-- Rights Type list for Marty & Cynthia - 1/12/2018






SELECT
o.ObjectID,
o.ObjectNumber,
ort.ObjRightsTypeID,
orts.ObjRightsType,
REPLACE(REPLACE(REPLACE(ort.ContractNumber,CHAR(10),''),CHAR(09),''),CHAR(13),'') AS ContractNumber,
REPLACE(REPLACE(REPLACE(ort.Copyright,CHAR(10),''),CHAR(09),''),CHAR(13),'') AS Copyright,
REPLACE(REPLACE(REPLACE(ort.Restrictions,CHAR(10),''),CHAR(09),''),CHAR(13),'') AS Restrictions,
REPLACE(REPLACE(REPLACE(ort.CreditLineRepro,CHAR(10),''),CHAR(09),''),CHAR(13),'') AS CreditLineRepro,
ort.AgreementReceivedISO


FROM Objects AS o
LEFT OUTER JOIN ObjRights AS ort ON o.ObjectID = ort.ObjectID
LEFT OUTER JOIN ObjRightsTypes AS orts ON ort.ObjRightsTypeID = orts.ObjRightsTypeID

WHERE
o.ObjectStatusID IN (2,27) 
AND (ort.ObjRightsTypeID = 0 OR ort.ObjRightsTypeID IS NULL)

ORDER BY o.SortNumber








