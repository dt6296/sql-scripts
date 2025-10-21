












SELECT * FROM UserFieldGroups

/*

UserFieldGroupID	GroupName
51					Object Rights and Reproduction

*/

SELECT * FROM UserFieldGroupXrefs WHERE UserFieldGroupID = 51

/*

UserFieldGroupXrefID	UserFieldID	UserFieldGroupID
185						273			51
186						274			51
187						275			51
188						276			51

*/

SELECT * FROM UserFieldGroupWF

/*

UserFieldGroupWFID	UserFieldGroupXrefID	DependValueID	DependUserFieldGroupXrefID	CompareOperator	Rank
22					187						983				188							2916			0
23					186						983				188							2916			1
24					185						983				188							2916			2

*/


SELECT * FROM UserFieldValueAuthority

/*

UserFieldValueID	UserFieldID	UserFieldValue
977					273			1
978					273			0
979					274			1
980					274			0
981					275			1
982					275			0
983					276			1
984					276			0

*/


SELECT * FROM UserFields WHERE UserFieldID IN (273,274,276,276)


SELECT * FROM UserFieldXrefs WHERE UserFieldID IN (273,274,276,276)











SELECT * FROM UserFieldGroups

/*

UserFieldGroupID	GroupName
51					Object Rights and Reproduction

*/

SELECT * FROM UserFieldGroupXrefs WHERE UserFieldGroupID = 51

/*

UserFieldGroupXrefID	UserFieldID	UserFieldGroupID
185						273			51
186						274			51
187						275			51
188						276			51

*/

SELECT * FROM UserFieldGroupWF

/*

UserFieldGroupWFID	UserFieldGroupXrefID	DependValueID	DependUserFieldGroupXrefID	CompareOperator	Rank
22					187						983				188							2916			0
23					186						983				188							2916			1
24					185						983				188							2916			2

*/


SELECT * FROM UserFieldValueAuthority

/*

UserFieldValueID	UserFieldID	UserFieldValue
977					273			1
978					273			0
979					274			1
980					274			0
981					275			1
982					275			0
983					276			1
984					276			0

*/


SELECT * FROM UserFields WHERE UserFieldID IN (273,274,276,276)




---------------------------	RUN THESE -------------------------------------------------------------


SELECT * FROM UserFieldXrefs WHERE UserFieldID IN (273,274,276,276)



SELECT ort.ObjectID, o.ObjectNumber
FROM ObjRights AS ort 
INNER JOIN Objects AS o ON ort.ObjectID = o.ObjectID 
WHERE ort.ObjRightsID = 18451







