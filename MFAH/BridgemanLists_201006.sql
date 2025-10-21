


SELECT * FROM Packages WHERE Name = 'BridgemanList_201006_Active'		--	314820
SELECT * FROM Packages WHERE Name = 'BridgemanList_201006_Withdrawn'	--	314821
SELECT * FROM Packages WHERE Name = 'BridgemanList_201006_Reserved'		--	314822


SELECT b.BALID, b.SuppliersReference, b.[Status], o.ObjectID, o.ObjectNumber
FROM MFAHt_BridgemanList_201006 AS b 
LEFT OUTER JOIN Objects AS o ON b.ObjectNumber = o.ObjectNumber
WHERE b.ObjectNumber IS NOT NULL	-- 11888
--AND b.Status = 'Active'			--	7357
--AND b.Status = 'Reserved'			--  3331
--AND b.Status = 'Withdrawn'		--  1200


--INSERT INTO TMS.dbo.PackageList (PackageID, ID, MainData, OrderPos, LoginID, EnteredDate, Notes, TableID)
SELECT DISTINCT
314822,
o.ObjectID,
o.ObjectNumber,
ROW_NUMBER() OVER (ORDER BY o.SortNumber),
'dthompson',
GETDATE(),
NULL,
108

FROM MFAHt_BridgemanList_201006 AS b 
LEFT OUTER JOIN Objects AS o ON b.ObjectNumber = o.ObjectNumber

WHERE b.ObjectNumber IS NOT NULL	-- 11888
AND o.ObjectID IS NOT NULL			-- 11634
--AND b.Status = 'Active'			--	7173		6812
--AND b.Status = 'Reserved'			--  3270		3123
--AND b.Status = 'Withdrawn'		--  1191		1082

AND b.ObjectNumber NOT IN
(SELECT ObjectNumber FROM MFAHt_BridgemanList_201006 WHERE ObjectNumber IS NOT NULL GROUP BY ObjectNumber HAVING COUNT(*) > 1) -- 303



-- Records not caputured above

--INSERT INTO TMS.dbo.PackageList (PackageID, ID, MainData, OrderPos, LoginID, EnteredDate, Notes, TableID)
SELECT 
314822,
ObjectID,
ObjectNumber,
ROW_NUMBER() OVER (ORDER BY SortNumber) + (SELECT MAX(OrderPos) FROM PackageList WHERE PackageID = 314822),
'dthompson',
GETDATE(),
'has multiple Bridgeman records',
108

--SELECT DISTINCT ObjectID, ObjectNumber, SortNumber, Status 
FROM
(
	SELECT DISTINCT o.ObjectID, o.ObjectNumber, o.SortNumber, Status
	FROM MFAHt_BridgemanList_201006 AS b 
	LEFT OUTER JOIN Objects AS o ON b.ObjectNumber = o.ObjectNumber
	WHERE b.ObjectNumber IS NOT NULL	-- 11888
	AND b.ObjectNumber IN
	(
		SELECT ObjectNumber 
		FROM MFAHt_BridgemanList_201006 
		WHERE ObjectNumber IS NOT NULL 
		GROUP BY ObjectNumber 
		HAVING COUNT(*) > 1
	) -- 303
) AS sq

WHERE ObjectNumber IS NOT NULL
AND ObjectID IS NOT NULL
--AND Status = 'Active'		--232
--AND Status = 'Withdrawn'	-- 77
--AND Status = 'Reserved'	-- 112

ORDER BY SortNumber




SELECT b.* FROM MFAHt_BridgemanList_201006 AS b
LEFT OUTER JOIN Objects AS o ON b.ObjectNumber = o.ObjectNumber
WHERE o.ObjectNumber IS NULL