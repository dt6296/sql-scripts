-- Latino / Latin American objects / artists






SELECT * FROM Departments WHERE MainTableID = 108



SELECT DISTINCT ArtistMaker, count(*)
FROM MFAHv_OBJ AS o
WHERE o.ObjectStatusID = 2
AND DepartmentID = 116	-- 866, 216
--AND CY >= 2001			--	843, 201
GROUP by ArtistMaker






--SELECT DISTINCT CultureGroup FROM Constituents WHERE Nationality = 'American'

SELECT DISTINCT sq.Department, COUNT(*) AS Works FROM
(
SELECT COUNT(o.ObjectID) AS Occurences, oc.Culture, c.c_Nationality, c.c_ConstituentID, d.Department
FROM MFAHv_OBJ AS o 
INNER JOIN ObjContext AS oc ON o.ObjectID = oc.ObjectID
INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID
LEFT OUTER JOIN MFAHv_OBJ_Constituent AS c ON o.ObjectID = c.o_ObjectID
WHERE o.ObjectStatusID = 2
AND o.CY >= 2001
AND c.c_Nationality LIKE '%American%'
AND
(
	   oc.Culture LIKE '%Costa Rican%'
	OR oc.Culture LIKE '%Salvador%'
	OR oc.Culture LIKE '%Guatemal%'
	OR oc.Culture LIKE '%Hondur%'
	OR oc.Culture LIKE '%Mexican%'
	OR oc.Culture LIKE '%Nicaraug%'
	OR oc.Culture LIKE '%Panama%'
	OR oc.Culture LIKE '%Argentin%'
	OR oc.Culture LIKE '%Bolivian%'
	OR oc.Culture LIKE '%Brazilian%'
	OR oc.Culture LIKE '%Chilean%'
	OR oc.Culture LIKE '%Columbian%'
	OR oc.Culture LIKE '%Ecuador%'
	OR oc.Culture LIKE '%Guian%'
	OR oc.Culture LIKE '%Guyana%'
	OR oc.Culture LIKE '%Paragua%'
	OR oc.Culture LIKE '%Peruvian%'
	OR oc.Culture LIKE '%Surinam%'
	OR oc.Culture LIKE '%Urugua%'
	OR oc.Culture LIKE '%Venezuelan%'
	OR oc.Culture LIKE '%Cuban%'
	OR oc.Culture LIKE '%Dominican%'
	OR oc.Culture LIKE '%Haitian%'
	OR oc.Culture LIKE '%Martin%'
	OR oc.Culture LIKE '%Puerto Rican%'
	OR oc.Culture LIKE '%Barthel%'
	OR oc.Culture LIKE '%Saint Martin%'
)
GROUP BY oc.Culture, c.c_Nationality, c.c_ConstituentID, d.Department
) AS sq
GROUP BY sq.Department


