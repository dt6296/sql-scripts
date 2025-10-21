

--------------------------------------------------------------------------Distinct Object Count by Department

SELECT
s.Stage,
s.Dept,
s.Department,
s.CuratorApproved,
s.DataStandardsApproved,
COUNT(s.ID) AS ObjectCount

FROM

(

	SELECT
	'Stage I'	AS Stage,
	'Asian Art'	AS Dept,
	d.Department,
	o.CuratorApproved,
	o.Accountability AS DataStandardsApproved,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID
	INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

	WHERE p.PackageID = 15484

	UNION

	SELECT
	'Stage I'	AS Stage,
	'Asian Art'	AS Dept,
	d.Department,
	o.CuratorApproved,
	o.Accountability AS DataStandardsApproved,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID
	INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID
	
	WHERE p.PackageID = 16615

	UNION

	SELECT
	'Stage I'	AS Stage,
	'Asian Art'	AS Dept,
	d.Department,
	o.CuratorApproved,
	o.Accountability AS DataStandardsApproved,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID
	INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

	WHERE p.PackageID = 16249

	UNION

	SELECT
	'Stage I'	AS Stage,
	'Asian Art'	AS Dept,
	d.Department,
	o.CuratorApproved,
	o.Accountability AS DataStandardsApproved,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID
	INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

	WHERE p.PackageID = 16533

	UNION

	SELECT
	'Stage I'	AS Stage,
	'Asian Art'	AS Dept,
	d.Department,
	o.CuratorApproved,
	o.Accountability AS DataStandardsApproved,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID
	INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

	WHERE p.PackageID = 16580

	UNION

	SELECT
	'Stage I'	AS Stage,
	'Asian Art'	AS Dept,
	d.Department,
	o.CuratorApproved,
	o.Accountability AS DataStandardsApproved,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID
	INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

	WHERE p.PackageID = 15484
	
	UNION

	SELECT
	'Stage I'	AS Stage,
	'Bayou Bend'	AS Dept,
	d.Department,
	o.CuratorApproved,
	o.Accountability AS DataStandardsApproved,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID
	INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

	WHERE p.PackageID = 14402
	
	UNION

	SELECT
	'Stage I'	AS Stage,
	'Blaffer'	AS Dept,
	d.Department,
	o.CuratorApproved,
	o.Accountability AS DataStandardsApproved,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID
	INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

	WHERE p.PackageID = 12200

	UNION

	SELECT
	'Stage I'	AS Stage,
	'Blaffer'	AS Dept,
	d.Department,
	o.CuratorApproved,
	o.Accountability AS DataStandardsApproved,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID
	INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

	WHERE p.PackageID = 14594


	UNION

	SELECT
	'Stage I'	AS Stage,
	'Latin American'	AS Dept,
	d.Department,
	o.CuratorApproved,
	o.Accountability AS DataStandardsApproved,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID
	INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

	WHERE p.PackageID = 14616


	UNION

	SELECT
	'Stage I'	AS Stage,
	'Latin American'	AS Dept,
	d.Department,
	o.CuratorApproved,
	o.Accountability AS DataStandardsApproved,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID
	INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

	WHERE p.PackageID = 14617

	UNION

	SELECT
	'Stage I'	AS Stage,
	'Latin American'	AS Dept,
	d.Department,
	o.CuratorApproved,
	o.Accountability AS DataStandardsApproved,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID
	INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

	WHERE p.PackageID = 14618
	

	UNION

	SELECT
	'Stage I'	AS Stage,
	'Photography'	AS Dept,
	d.Department,
	o.CuratorApproved,
	o.Accountability AS DataStandardsApproved,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID
	INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

	WHERE p.PackageID = 14543


	UNION

	SELECT
	'Stage I'	AS Stage,
	'Rienzi'	AS Dept,
	d.Department,
	o.CuratorApproved,
	o.Accountability AS DataStandardsApproved,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID
	INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

	WHERE p.PackageID = 14614

	UNION

	SELECT
	'Stage I'	AS Stage,
	'Antiquities'	AS Dept,
	d.Department,
	o.CuratorApproved,
	o.Accountability AS DataStandardsApproved,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID
	INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

	WHERE p.PackageID = 14613

	UNION

	SELECT
	'Stage II'	AS Stage,
	'Decorative Arts'	AS Dept,
	d.Department,
	o.CuratorApproved,
	o.Accountability AS DataStandardsApproved,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID
	INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

	WHERE p.PackageID = 15064

	UNION

	SELECT
	'Stage II'	AS Stage,
	'American Art'	AS Dept,
	d.Department,
	o.CuratorApproved,
	o.Accountability AS DataStandardsApproved,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID
	INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

	WHERE p.PackageID = 15065

	UNION

	SELECT
	'Stage II'	AS Stage,
	'Art of the Americas'	AS Dept,
	d.Department,
	o.CuratorApproved,
	o.Accountability AS DataStandardsApproved,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID
	INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

	WHERE p.PackageID = 15071

	UNION

	SELECT
	'Stage II'	AS Stage,
	'European Art'	AS Dept,
	d.Department,
	o.CuratorApproved,
	o.Accountability AS DataStandardsApproved,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID
	INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

	WHERE p.PackageID = 14793

	UNION

	SELECT
	'Stage II'	AS Stage,
	'European Art'	AS Dept,
	d.Department,
	o.CuratorApproved,
	o.Accountability AS DataStandardsApproved,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID
	INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

	WHERE p.PackageID = 14795

	UNION

	SELECT
	'Stage II'	AS Stage,
	'Prints and Drawings'	AS Dept,
	d.Department,
	o.CuratorApproved,
	o.Accountability AS DataStandardsApproved,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID
	INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

	WHERE p.PackageID = 14559

	UNION

	SELECT
	'Stage II'	AS Stage,
	'Photography'	AS Dept,
	d.Department,
	o.CuratorApproved,
	o.Accountability AS DataStandardsApproved,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID
	INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

	WHERE p.PackageID = 14572

	UNION

	SELECT
	'Stage II'	AS Stage,
	'Photography'	AS Dept,
	d.Department,
	o.CuratorApproved,
	o.Accountability AS DataStandardsApproved,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID
	INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

	WHERE p.PackageID = 15022

	UNION

	SELECT
	'Stage II'	AS Stage,
	'European Art'	AS Dept,
	d.Department,
	o.CuratorApproved,
	o.Accountability AS DataStandardsApproved,
	pl.ID

	FROM [Packages] AS p
	INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
	INNER JOIN Objects AS o ON pl.ID = o.ObjectID
	INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

	WHERE p.PackageID = 16986


	
) AS s

GROUP BY 
s.Dept,
s.Department,
s.Stage,
s.CuratorApproved,
s.DataStandardsApproved





