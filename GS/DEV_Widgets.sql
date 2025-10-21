
select 
 p.DDProductID
,p.[Name] as Product
,p.[Version]
,v.[Name] as DEV_Name
,v.SystemCode
,v.LoginID
,v.Active
,vc.UIViewID
,vc.Position
,wt.WidgetType
,mt.ModelType
,h.TableID
,t.TableName
,c.ColumnName

from DDProducts							as p
left outer join UIViews					as v	on p.DDProductID = v.ProductID
left outer join UIViewCompositions		as vc	on v.UIViewID = vc.UIViewID
left outer join ModelCompositions		as mc	on vc.ModelCompositionID = mc.ModelCompositionID
left outer join DDWidgetTypes			as wt	on vc.WidgetTypeID = wt.DDWidgetTypeID
left outer join DDWidgetModels			as wm	on mc.DDWidgetModelID = wm.DDWidgetModelID
left outer join DDModelTypes			as mt	on wm.ModelTypeID = mt.DDModelTypeID
left outer join DDWidgetModelColumns	as wmc	on wm.DDWidgetModelID = wmc.DDWidgetModelColumnID
left outer join DDHierarchy				as h	on wmc.[HierarchyID] = h.[HierarchyID]
left outer join DDColumns				as c	on wmc.ColumnID = c.ColumnID
left outer join DDTables				as t	on h.TableID = t.TableID
--left outer join DDContextWidModels		as cwm	on wm.DDWidgetModelID = cwm.DDContextWidModelID
--left outer join DDContexts				as x	on cwm.ContextID = x.ContextID

--where v.[Name] like '%NAGPRA%Object%'

order by p.[Name], v.[Name], v.SystemCode, vc.Position

-- select * from UIViews as u left outer join DDLiterals as l on u.LiteralNumber = l.LiteralNumber and l.LanguageID = 1


-- select * from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'ContextID'





