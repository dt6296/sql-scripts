



/*
SELECT DISTINCT cx_RoleTypeID, cx_RoleType, cx_RoleID, cx_Role
FROM MFAHv_OBJ_Constituent AS ac
WHERE cx_RoleTypeID = 2
AND cx_RoleID IN (11,2,16,45,47,18,233)
ORDER BY cx_Role


cx_RoleTypeID	cx_RoleType	cx_RoleID	cx_Role
2	Acquisition Related	11	Dealer
2	Acquisition Related	2	Donor
2	Acquisition Related	16	Donor (Anonymous)
2	Acquisition Related	45	Donor by Exchange
2	Acquisition Related	47	Intermediary
2	Acquisition Related	18	Seller
2	Acquisition Related	233	Seller (Anonymous)

SELECT * FROM ObjectStatuses

OBJ_Number = REPLACE(REPLACE(REPLACE(OBJ_Number,CHAR(10),''),CHAR(09),''),CHAR(13),'')
*/





SELECT
o.ObjectID,
o.ObjectNumber,
om.DisplayName,
REPLACE(REPLACE(REPLACE(ISNULL(ot.Title,''),CHAR(10),''),CHAR(09),''),CHAR(13),'')			AS Title,
REPLACE(REPLACE(REPLACE(ISNULL(o.CreditLine,''),CHAR(10),''),CHAR(09),''),CHAR(13),'')		AS CreditLine,
REPLACE(REPLACE(REPLACE(ISNULL(o.Provenance,''),CHAR(10),''),CHAR(09),''),CHAR(13),'')		AS Provenance,
ISNULL(CAST(dealer.DealerID AS VARCHAR(10)),'')			AS DealerID,
ISNULL(dealer.DealerName,'')							AS DealerName,
ISNULL(dealer.DealerCity,'')							AS DealerCity,
ISNULL(dealer.DealerState,'')							AS DealerState,
ISNULL(CAST(donor.DonorID AS VARCHAR(10)),'')			AS DonorID,
ISNULL(donor.DonorName,'')								AS DonorName,
ISNULL(donor.DonorCity,'')								AS DonorCity,
ISNULL(donor.DonorState,'')								AS DonorState,
ISNULL(CAST(itm.IntermediaryID AS VARCHAR(10)),'')		AS IntermediaryID,
ISNULL(itm.IntermediaryName,'')							AS IntermediaryName,
ISNULL(itm.IntermediaryCity,'')							AS IntermediaryCity,
ISNULL(itm.IntermediaryState,'')						AS IntermediaryState,
ISNULL(CAST(seller.SellerID AS VARCHAR(10)),'')			AS SellerID,
ISNULL(seller.SellerName,'')							AS SellerName,
ISNULL(seller.SellerCity,'')							AS SellerCity,
ISNULL(seller.SellerState,'')							AS SellerState


FROM Objects AS o
LEFT OUTER JOIN MFAHv_OBJ_Maker_FirstDisplayed AS om ON o.ObjectID = om.ObjectID
LEFT OUTER JOIN MFAHv_OBJ_Title_FirstDisplayed AS ot ON o.ObjectID = ot.ObjectID

LEFT OUTER JOIN
-------------------------------------------------------------------------------Dealer
(
	SELECT DISTINCT
	oc.o_ObjectID			AS ObjectID,
	oc.c_ConstituentID		AS DealerID,
	oc.c_DisplayName		AS DealerName,
	ca.City					AS DealerCity,
	ca.State				AS DealerState

	FROM MFAHv_OBJ_Constituent AS oc
	LEFT OUTER JOIN
	(
		SELECT 
		cas.ConstituentID,
		MAX(cas.ConAddressID) AS ConAddressID
		FROM ConAddress AS cas
		GROUP BY cas.ConstituentID
	) AS caid ON oc.c_ConstituentID = caid.ConstituentID
	LEFT OUTER JOIN ConAddress AS ca ON caid.ConAddressID = ca.ConAddressID

	WHERE oc.cx_RoleID IN (11)	-- Dealer
) AS dealer ON o.ObjectID = dealer.ObjectID


LEFT OUTER JOIN
-------------------------------------------------------------------------------Donor
(
	SELECT DISTINCT
	oc.o_ObjectID			AS ObjectID,
	oc.c_ConstituentID		AS DonorID,
	oc.c_DisplayName		AS DonorName,
	ca.City					AS DonorCity,
	ca.State				AS DonorState

	FROM MFAHv_OBJ_Constituent AS oc
	LEFT OUTER JOIN
	(
		SELECT 
		cas.ConstituentID,
		MAX(cas.ConAddressID) AS ConAddressID
		FROM ConAddress AS cas
		GROUP BY cas.ConstituentID
	) AS caid ON oc.c_ConstituentID = caid.ConstituentID
	LEFT OUTER JOIN ConAddress AS ca ON caid.ConAddressID = ca.ConAddressID

	WHERE oc.cx_RoleID IN (2,16,45)	-- Donor
) AS donor ON o.ObjectID = donor.ObjectID

LEFT OUTER JOIN
-------------------------------------------------------------------------------Intermediary
(
	SELECT DISTINCT
	oc.o_ObjectID			AS ObjectID,
	oc.c_ConstituentID		AS IntermediaryID,
	oc.c_DisplayName		AS IntermediaryName,
	ca.City					AS IntermediaryCity,
	ca.State				AS IntermediaryState

	FROM MFAHv_OBJ_Constituent AS oc
	LEFT OUTER JOIN
	(
		SELECT 
		cas.ConstituentID,
		MAX(cas.ConAddressID) AS ConAddressID
		FROM ConAddress AS cas
		GROUP BY cas.ConstituentID
	) AS caid ON oc.c_ConstituentID = caid.ConstituentID
	LEFT OUTER JOIN ConAddress AS ca ON caid.ConAddressID = ca.ConAddressID

	WHERE oc.cx_RoleID IN (47)	-- Intermediary
) AS itm ON o.ObjectID = itm.ObjectID


LEFT OUTER JOIN 
-------------------------------------------------------------------------------Seller
(
	SELECT DISTINCT
	oc.o_ObjectID			AS ObjectID,
	oc.c_ConstituentID		AS SellerID,
	oc.c_DisplayName		AS SellerName,
	ca.City					AS SellerCity,
	ca.State				AS SellerState

	FROM MFAHv_OBJ_Constituent AS oc
	LEFT OUTER JOIN
	(
		SELECT 
		cas.ConstituentID,
		MAX(cas.ConAddressID) AS ConAddressID
		FROM ConAddress AS cas
		GROUP BY cas.ConstituentID
	) AS caid ON oc.c_ConstituentID = caid.ConstituentID
	LEFT OUTER JOIN ConAddress AS ca ON caid.ConAddressID = ca.ConAddressID

	WHERE oc.cx_RoleID IN (18,233)	-- Seller
) AS seller ON o.ObjectID = seller.ObjectID


WHERE o.DepartmentID = 11	-- Photography
AND ObjectStatusID = 2		-- Accessioned
AND o.Provenance IS NULL


ORDER BY o.SortNumber