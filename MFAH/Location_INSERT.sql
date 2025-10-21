/*
Hi David, 
 
Ok, as a workaround you can probably use a script to create a new location address for Internal (external will have slightly different values in insert)
 
It is a multi step insert and You will need to have ConstituentID and AddressID for it. 
 
1. update Constituents set InternalStatus = 1 where ConstituentID = yourcodnid  
- in your case this is probably not necessary  because your constituent already have that in. 
 
2.  UPDATE ConAddress SET ShortName = N'MyAddressShortName' Where ConAddressID = yourConaddressID
-you will need to key in ConaddressID you want to import. 
 
3. INSERT INTO Locations (AddressID, Active, PublicAccess, UnitHeightCM, UnitWidthCM, UnitDepthCM, SecurityCode, [External], LoginID)
 VALUES (yourConaddressID, 1, 0, 0, 0, 0, 0, 0, N'MyLogin')
 
Same thing here. Specify your addressid and login
 
 4. UPDATE ConAddress SET IsLocation = 1 WHERE ConAddressID = yourConaddressID
 
This should also be set for used address. 
Once done you should see it to appear in location hierarchy after which you can add site etc. 
 
I would definitely try it on a test version of TMS. If you need to create one I can help and get you the license for it. 
Doing manual insert is often tricky and even though I think I got all the parts you can never be too cautious. 
 
Please let me know if you have any questions. 
Cheerio!
Dimitry 
*/

SELECT * FROM ConAddress WHERE ConstituentID = 0


--	UPDATE Constituents SET InternalStatus = 1 WHERE ConstituentID = 0

--	UPDATE ConAddress SET ShortName = N'13 HARWIN WAREHOUSE' WHERE ConAddressID = 15176
--	UPDATE ConAddress SET ShortName = N'15 CONSERVATION CENTER' WHERE ConAddressID = 17637

--	INSERT INTO Locations
	(AddressID,
	Active,
	PublicAccess,
	UnitHeightCM,
	UnitWidthCM,
	UnitDepthCM,
	SecurityCode,
	[External],
	LoginID)
	VALUES
	(17637,1,0,0,0,0,0,0,N'dthompson')
	
--	UPDATE  ConAddress SET IsLocation = 1 WHERE ConAddressID = 17637
	
