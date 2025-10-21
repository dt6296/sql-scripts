


/*

SELECT * FROM INFORMATION_SCHEMA.TABLES					--	853

SELECT * FROM INFORMATION_SCHEMA.VIEWS					--	502

SELECT * FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE		--	1578

SELECT * FROM INFORMATION_SCHEMA.VIEW_COLUMN_USAGE		--	8204


*/
/*

--This gives me all objects that have child objects.
--So, if a view doesn't have any child views, it won't appear as a parent

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

WITH myCTE
AS
(
	SELECT
	1 AS Level,
	parent.TABLE_NAME
	FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE	AS parent
	
	UNION ALL
	
	SELECT
	rCTE.Level + 1 AS Level,
	child.VIEW_NAME
	FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE	AS child
	INNER JOIN myCTE AS rCTE ON child.TABLE_NAME = rCTE.TABLE_NAME
	WHERE child.TABLE_NAME IS NOT NULL
)

SELECT DISTINCT 
myCTE.*,
TableUsage.*,
ti.*
FROM myCTE

INNER JOIN

(
	SELECT DISTINCT 
	TABLE_NAME AS Parent,
	VIEW_NAME AS Child
	FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE
)
AS TableUsage	ON TableUsage.Parent = myCTE.TABLE_NAME

INNER JOIN [TMS].[sys].[all_objects] AS ti ON TableUsage.Parent = ti.name

--ORDER BY TableUsage.Child



Level				= from myCTE		Level in Hierarchy
TABLE_NAME			= from myCTE
	
Parent				= from TableUsage
Child				= from TableUsage

name				= from ti (all_objects)
object_id			= from ti (all_objects)
principal_id		= from ti (all_objects)
schema_id			= from ti (all_objects)
parent_object_id	= from ti (all_objects)
type				= from ti (all_objects)
type_desc			= from ti (all_objects)
create_date			= from ti (all_objects)
modify_date			= from ti (all_objects)
is_ms_shipped		= from ti (all_objects)
is_published		= from ti (all_objects)
is_schema_published	= from ti (all_objects)





SELECT * FROM INFORMATION_SCHEMA.TABLES	--857
SELECT * FROM INFORMATION_SCHEMA.VIEWS	--506	contains view definition

--	351 TABLES
--	506 VIEWS


SELECT
t.*,
v.*

FROM INFORMATION_SCHEMA.TABLES	AS t
LEFT OUTER JOIN INFORMATION_SCHEMA.VIEWS	AS v	ON t.TABLE_NAME = v.TABLE_NAME



SELECT * FROM sys.all_objects

SELECT DISTINCT
COUNT(*)	AS TypeCount,
type,
type_desc
FROM sys.all_objects
GROUP BY type, type_desc
 

SELECT * 
FROM sys.all_objects
WHERE type IN ('FN','U','V','P','TF','TR') AND is_ms_shipped = 0		--1147
ORDER BY type, name


--YES  FN,U,V,P,TF,TR




SELECT * FROM sys.objects
WHERE type IN ('FN','U','V','P','TF','TR') AND is_ms_shipped = 0		--1147
ORDER BY type, name



  
--  This doesn't work because parent-child is 1:1, it isn't meant for what I'm trying to do.  
  
  
SELECT 
p.object_id		AS p_object_id, 
p.name			AS p_name, 
p.type			AS p_type, 
p.type_desc		AS p_type_desc,

c.object_id		AS c_object_id, 
c.name			AS c_name, 
c.type			AS c_type, 
c.type_desc		AS c_type_desc,
c.parent_object_id

FROM sys.objects AS p
LEFT OUTER JOIN sys.objects AS c ON c.parent_object_id = p.object_id

WHERE p.type IN ('FN','U','V','P','TF','TR') AND p.is_ms_shipped = 0		--1147
AND c.type IN ('FN','U','V','P','TF','TR') AND c.is_ms_shipped = 0


*/




-----------------------------------------------------------------------------------



SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

----------------------------------------------------------------------------------------------------

WITH myCTE
AS
(	SELECT
	1 AS Level,
	parent.TABLE_NAME
	FROM INFORMATION_SCHEMA.TABLES	AS parent				--857 USING TABLES, 1147 IN VIEW_TABLE_USAGE	VIEWS are included in TABLE_NAME if they are referenced by another VIEW
	
	UNION ALL
	
	SELECT
	rCTE.Level + 1 AS Level,
	child.VIEW_NAME
	FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE	AS child
	INNER JOIN myCTE AS rCTE ON child.TABLE_NAME = rCTE.TABLE_NAME
	--WHERE child.TABLE_NAME IS NOT NULL
)

----------------------------------------------------------------------------------------------------

SELECT DISTINCT

myCTE.TABLE_NAME,
myCTE.Level,


TableUsage.Parent,
ParentInfo.p_type,
ParentInfo.p_type_desc,
ParentInfo.p_create_date,
ParentInfo.p_modify_date,

TableUsage.Child,
ti.type			AS c_type,
ti.type_desc	AS c_type_desc

----------------------------------------------------------------------------------------------------	myCTE

FROM myCTE

----------------------------------------------------------------------------------------------------	TableUsage

LEFT OUTER JOIN
(	SELECT DISTINCT 
	TABLE_NAME AS Parent,
	VIEW_NAME AS Child
	FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE  
)	AS TableUsage	ON TableUsage.Parent = myCTE.TABLE_NAME

----------------------------------------------------------------------------------------------------	ti

LEFT OUTER JOIN
sys.all_objects AS ti ON TableUsage.Child = ti.name

----------------------------------------------------------------------------------------------------	ParenInfo

LEFT OUTER JOIN
(	SELECT
	name	AS p_name,
	type	AS p_type,
	type_desc	AS p_type_desc,
	create_date	AS p_create_date,
	modify_date	AS p_modify_date
	FROM sys.objects
	WHERE type IN ('FN','U','V','P','TF','TR') AND is_ms_shipped = 0		--1147
)	AS ParentInfo ON myCTE.TABLE_NAME = ParentInfo.p_name 

----------------------------------------------------------------------------------------------------

--WHERE Parent LIKE '%DCT%' OR Child LIKE '%DCT%'   --	If an object has no children, it doesn't appear.

ORDER BY p_type, Parent





SELECT DISTINCT			--857
t.TABLE_NAME,
t.TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES AS t
ORDER BY t.TABLE_NAME



SELECT DISTINCT
--tu.TABLE_NAME		--301
tu.VIEW_NAME
FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE AS tu
ORDER BY tu.VIEW_NAME		--492



SELECT DISTINCT
t.TABLE_NAME,
t.TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES AS t 
INNER JOIN INFORMATION_SCHEMA.VIEW_TABLE_USAGE AS tu ON t.TABLE_NAME = tu.TABLE_NAME		--288

