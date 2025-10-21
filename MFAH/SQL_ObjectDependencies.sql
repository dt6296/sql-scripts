
--TMS_Tables.csv
SELECT
  TABLE_NAME	ObjectName
, TABLE_TYPE	ObjectType
FROM INFORMATION_SCHEMA.TABLES	
ORDER BY TABLE_NAME




--TMS_Parent
SELECT DISTINCT
  t.TABLE_NAME		AS Parent
FROM INFORMATION_SCHEMA.TABLES AS t
LEFT OUTER JOIN INFORMATION_SCHEMA.VIEW_TABLE_USAGE AS tu ON t.TABLE_NAME = tu.TABLE_NAME
WHERE CASE WHEN tu.VIEW_NAME IS NOT NULL THEN 1 ELSE 0 END = 1
ORDER BY t.TABLE_NAME


--TMS_Associations
SELECT DISTINCT
  t.TABLE_NAME		AS Parent
, tu.VIEW_NAME		AS Child
, CASE WHEN tu.VIEW_NAME IS NOT NULL THEN 1 ELSE 0 END AS IsParent

FROM INFORMATION_SCHEMA.TABLES AS t
LEFT OUTER JOIN INFORMATION_SCHEMA.VIEW_TABLE_USAGE AS tu ON t.TABLE_NAME = tu.TABLE_NAME

--WHERE CASE WHEN tu.VIEW_NAME IS NOT NULL THEN 1 ELSE 0 END = 1

ORDER BY t.TABLE_NAME






--SELECT * FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE		--	1578



--All Objects by Type

SELECT
o.name,
o.type_desc AS type
FROM sys.all_objects AS o
WHERE type IN ('FN','U','V','P','TF','TR') AND is_ms_shipped = 0		--1147
ORDER BY type, name





--returns all objects, and parents of Triggers
SELECT
o.object_id,
o.name,
o.type_desc AS type,
so.id,
so.parent_obj,
po.object_id,
po.name,
po.type_desc
FROM sys.all_objects AS o
LEFT OUTER JOIN sys.sysobjects AS so ON o.object_id = so.id
LEFT OUTER JOIN sys.all_objects AS po ON so.parent_obj = po.object_id
WHERE o.type IN ('FN','U','V','P','TF','TR') AND o.is_ms_shipped = 0		--1147
ORDER BY o.type, o.name




-- NO connection
SELECT
o.object_id,
o.name,
o.type_desc AS type,
so.object_id,
so.name
FROM sys.all_objects AS o
LEFT OUTER JOIN sys.system_objects AS so ON o.object_id = so.principal_id
WHERE o.type IN ('FN','U','V','P','TF','TR') AND o.is_ms_shipped = 0		--1147
ORDER BY o.type, o.name


-- Transact-SQL Statement to list all objects and their dependencies (SQL Server 2008). 
SELECT SCH.name + '.' + OBJ.name AS ObjectName 
      ,OBJ.type_desc AS ObjectType 
      ,COL.name AS ColumnName 
      ,DEP.referenced_database_name AS ReferencedDatabase 
      ,REFSCH.name + '.' + REFOBJ.name AS ReferencedObjectName 
      ,REFOBJ.type_desc AS ReferencedObjectType 
      ,REFCOL.name AS ReferencedColumnName       
      ,DEP.referencing_class_desc AS ReferenceClass 
      ,DEP.is_schema_bound_reference AS IsSchemaBound 
FROM sys.sql_expression_dependencies AS DEP 
     INNER JOIN 
     sys.objects AS OBJ 
         ON DEP.referencing_id = OBJ.object_id 
     INNER JOIN 
     sys.schemas AS SCH 
         ON OBJ.schema_id = SCH.schema_id 
     LEFT JOIN sys.columns AS COL 
         ON DEP.referencing_id = COL.object_id 
            AND DEP.referencing_minor_id = COL.column_id 
     INNER JOIN sys.objects AS REFOBJ 
         ON DEP.referenced_id = REFOBJ.object_id 
     INNER JOIN sys.schemas AS REFSCH 
         ON REFOBJ.schema_id = REFSCH.schema_id 
     LEFT JOIN sys.columns AS REFCOL 
         ON DEP.referenced_class IN (0, 1) 
            AND DEP.referenced_minor_id = REFCOL.column_id 
            AND DEP.referenced_id = REFCOL.object_id 
ORDER BY ObjectName 
        ,ReferencedObjectName 
        ,REFCOL.column_id 




--same as above, but reordered and renamed for Gephi
-- Transact-SQL Statement to list all objects and their dependencies (SQL Server 2008). 


SELECT 

--Source
--	   DEP.referenced_database_name AS ReferencedDatabase 
      
      REFSCH.name + '.' + REFOBJ.name AS Source
      ,REFOBJ.type_desc AS SourceType 
      ,REFCOL.name AS SourceColumn       
      
--Target
      ,SCH.name + '.' + OBJ.name AS Target
      ,OBJ.type_desc AS TargetType 
      ,COL.name AS TargetColumn
      
      
      ,DEP.referencing_class_desc AS ReferenceClass 
      ,DEP.is_schema_bound_reference AS IsSchemaBound 
FROM sys.sql_expression_dependencies AS DEP 
     INNER JOIN 
     sys.objects AS OBJ 
         ON DEP.referencing_id = OBJ.object_id 
     INNER JOIN 
     sys.schemas AS SCH 
         ON OBJ.schema_id = SCH.schema_id 
     LEFT JOIN sys.columns AS COL 
         ON DEP.referencing_id = COL.object_id 
            AND DEP.referencing_minor_id = COL.column_id 
     INNER JOIN sys.objects AS REFOBJ 
         ON DEP.referenced_id = REFOBJ.object_id 
     INNER JOIN sys.schemas AS REFSCH 
         ON REFOBJ.schema_id = REFSCH.schema_id 
     LEFT JOIN sys.columns AS REFCOL 
         ON DEP.referenced_class IN (0, 1) 
            AND DEP.referenced_minor_id = REFCOL.column_id 
            AND DEP.referenced_id = REFCOL.object_id 
ORDER BY Target 
        ,Source 
        ,REFCOL.column_id 




--same as above, but customized more.

-- USE THIS FOR GEPHI!

SELECT 

--Source
--	   DEP.referenced_database_name AS ReferencedDatabase 
      
      REFOBJ.object_id AS SourceID
      ,REFOBJ.type_desc AS SourceType 
      ,REFOBJ.name AS Source

--Target
	  ,OBJ.object_id AS TargetID
	  ,OBJ.type_desc AS TargetType 
	  ,OBJ.name AS Target

FROM sys.sql_expression_dependencies AS DEP 
     INNER JOIN 
     sys.objects AS OBJ 
         ON DEP.referencing_id = OBJ.object_id 
     INNER JOIN 
     sys.schemas AS SCH 
         ON OBJ.schema_id = SCH.schema_id 
     LEFT JOIN sys.columns AS COL 
         ON DEP.referencing_id = COL.object_id 
            AND DEP.referencing_minor_id = COL.column_id 
     INNER JOIN sys.objects AS REFOBJ 
         ON DEP.referenced_id = REFOBJ.object_id 
     INNER JOIN sys.schemas AS REFSCH 
         ON REFOBJ.schema_id = REFSCH.schema_id 
     LEFT JOIN sys.columns AS REFCOL 
         ON DEP.referenced_class IN (0, 1) 
            AND DEP.referenced_minor_id = REFCOL.column_id 
            AND DEP.referenced_id = REFCOL.object_id 

WHERE OBJ.name LIKE 'MFAHv%'

ORDER BY Target 
        ,Source 




----------------
--Node Table

SELECT 

--Node
n.object_id	AS	Id,
n.type		AS	TypeCode,
n.type_desc	AS	Type, 
n.name		AS	Label

FROM	sys.objects	AS	n

WHERE n.type NOT IN ('D','PK','IT','SQ','S','UQ')	--1183 OBJECTS

ORDER BY
n.type_desc,
n.name


----------------
--Edge Table

SELECT 

--Source
s.object_id	AS Source,

--Target
t.object_id	AS Target

FROM		sys.sql_expression_dependencies	AS	DEP
INNER JOIN	sys.objects						AS	t	ON	DEP.referencing_id	= t.object_id
INNER JOIN	sys.objects						AS	s	ON	DEP.referenced_id	= s.object_id

WHERE	t.type NOT IN ('D','PK','IT','SQ','S','UQ')
AND		s.type NOT IN ('D','PK','IT','SQ','S','UQ')

ORDER BY
Source,
Target
