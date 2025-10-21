
















select * from UserFieldTypes
select * from ObjUserFields
where LoginID = 'mtimko'
order by EnteredDate desc



select  uf.*, uft.*
from ObjUserFields uf inner join
UserFieldTypes uft on uf.FieldTypeID = uft.UserFieldTypeID
where uf.LoginID = 'mtimko' and uf.EnteredDate > '2010-05-23'
order by uf.FieldTypeID

select * from UserFieldTypes where UserFieldType like 'ZZ%'

select distinct uf.FieldValue, uft.UserFieldType, uft.UserFieldTypeID
from ObjUserFields uf inner join
UserFieldTypes uft on uf.FieldTypeID = uft.UserFieldTypeID
where uft.UserFieldTypeID = 22 --ZZ Event
order by uf.FieldValue

select distinct uf.FieldValue, uft.UserFieldType, uft.UserFieldTypeID
from ObjUserFields uf inner join
UserFieldTypes uft on uf.FieldTypeID = uft.UserFieldTypeID
where uft.UserFieldTypeID = 20 --ZZ Place depicted
order by uf.FieldValue

select distinct uf.FieldValue, uft.UserFieldType, uft.UserFieldTypeID
from ObjUserFields uf inner join
UserFieldTypes uft on uf.FieldTypeID = uft.UserFieldTypeID
where uft.UserFieldTypeID = 21 --ZZ AAT
order by uf.FieldValue

select distinct uf.FieldValue, uft.UserFieldType, uft.UserFieldTypeID
from ObjUserFields uf inner join
UserFieldTypes uft on uf.FieldTypeID = uft.UserFieldTypeID
where uft.UserFieldTypeID = 25 --ZZ Theme
order by uf.FieldValue

select distinct uf.FieldValue, uft.UserFieldType, uft.UserFieldTypeID
from ObjUserFields uf inner join
UserFieldTypes uft on uf.FieldTypeID = uft.UserFieldTypeID
where uft.UserFieldTypeID = 19 --ZZ Subject
order by uf.FieldValue

select distinct uf.FieldValue, uft.UserFieldType, uft.UserFieldTypeID
from ObjUserFields uf inner join
UserFieldTypes uft on uf.FieldTypeID = uft.UserFieldTypeID
where uft.UserFieldTypeID = 23 --ZZ Personage
order by uf.FieldValue

select distinct uf.FieldValue, uft.UserFieldType, uft.UserFieldTypeID
from ObjUserFields uf inner join
UserFieldTypes uft on uf.FieldTypeID = uft.UserFieldTypeID
where uft.UserFieldTypeID = 24 --ZZ Keyword
order by uf.FieldValue






select * from v_InformationSchemaColumns where TABLE_NAME = 'UserFieldTypes'

select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'UserFieldTypes'

572 = me
922 = merrianne
372	= shemon

0 = sa
35 = DataStandardCataloger

SELECT * FROM Users order by Login
SELECT * FROM UserSecurity where UserID = 372 order by DepartmentID
select * from Departments
select * from SecurityGroups


update UserSecurity
set SecurityGroupID = 0
where UserID = 372