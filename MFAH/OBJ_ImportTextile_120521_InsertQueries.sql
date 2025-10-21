
--INSERT QUERIES




SELECT     TOP (100) PERCENT o.ObjectID, o.ObjectNumber
FROM         [MFAH-TMS].TMS.dbo.Objects AS o INNER JOIN
                      [MFAH-TMS].TMS.dbo.ObjPkgList AS opl ON o.ObjectID = opl.ObjectID
WHERE     (opl.ObjectPackageID = 12955)
ORDER BY o.ObjectID

insert into ConsObject (Obj_Num, Obj_NumType, Obj_Name, Obj_Added, Appellation)
(
SELECT  o.ObjectID, 'TMSObjectNumber', o.ObjectNumber, getdate(), o.ObjectNumber
FROM         [MFAH-TMS].TMS.dbo.Objects AS o INNER JOIN
                      [MFAH-TMS].TMS.dbo.ObjPkgList AS opl ON o.ObjectID = opl.ObjectID
WHERE     (opl.ObjectPackageID = 12955)
)


select * from ConsObject
select * from ObjNumbers


update ConsObject
set Obj_NumType = 'TMSObjectID'
where Obj_NumType = 'TMSObjectNumber'

--!!!
select appellation, count(*)
from ConsObject
group by appellation
having count(*) > 1




--TMS Object Number - 269
select o.ObjectID as TMSObjectID, o.ObjectNumber as TMSObjectNumber, 2 as ObjNumTypeID, getdate() as Retrieved
from [MFAH-TMS].TMS.dbo.Objects AS o	
inner join [MFAH-TMS].TMS.dbo.ObjPkgList opl on o.ObjectID = opl.ObjectID
where ObjectPackageID = 12955
order by o.ObjectID


select * from ConsObject where Obj_NumType = 'TMSObjectID'
select * from ObjNumbers
select * from ObjNumType


insert into ObjNumbers (ObjNum, ObjNumTypeID, ObjNumDateAssigned, Obj_ID)
(
select co.Obj_Name, 2, getdate(), co.Obj_ID
from ConsObject as co
where Obj_NumType = 'TMSObjectID'
)






--Object Classification - 269
select o.ObjectID as TMSObjectID, c.Classification, getdate() as Retrieved
from [MFAH-TMS].TMS.dbo.Objects o 
inner join [MFAH-TMS].TMS.dbo.Classifications c on o.ClassificationID = c.ClassificationID
inner join [MFAH-TMS].TMS.dbo.ObjPkgList opl on o.ObjectID = opl.ObjectID
where ObjectPackageID = 12955
order by o.ObjectID


insert into ObjClassification (ObjClassification, Obj_ID)
(
select c.Classification, co.Obj_ID
from [MFAH-TMS].TMS.dbo.Objects o 
inner join [MFAH-TMS].TMS.dbo.Classifications c on o.ClassificationID = c.ClassificationID
inner join [MFAH-TMS].TMS.dbo.ObjPkgList opl on o.ObjectID = opl.ObjectID
inner join ConsObject co on co.Obj_Name = o.ObjectNumber
where ObjectPackageID = 12955
)




--Object Medium - 269
select o.ObjectID as TMSObjectID, o.Medium, getdate() as Retrieved
from [MFAH-TMS].TMS.dbo.Objects o
inner join [MFAH-TMS].TMS.dbo.ObjPkgList opl on o.ObjectID = opl.ObjectID
where ObjectPackageID = 12955
order by o.ObjectID


insert into ObjMedium (ObjMedium, Obj_ID)
(
select o.Medium, co.Obj_ID
from [MFAH-TMS].TMS.dbo.Objects o 
inner join ConsObject co on co.Obj_Name = o.ObjectNumber
inner join [MFAH-TMS].TMS.dbo.ObjPkgList opl on o.ObjectID = opl.ObjectID
where ObjectPackageID = 12955
and o.Medium is not null
)



--Object Culture - 204
select o.ObjectID as TMSObjectID, oc.Culture, getdate() as Retrieved
from [MFAH-TMS].TMS.dbo.Objects o
inner join [MFAH-TMS].TMS.dbo.ObjContext oc on o.ObjectID = oc.ObjectID
inner join [MFAH-TMS].TMS.dbo.ObjPkgList opl on o.ObjectID = opl.ObjectID
where ObjectPackageID = 12955
and oc.Culture is not null
order by o.ObjectID


insert into ObjCulture (ObjCulture, Obj_ID)
(
select oc.Culture, co.Obj_ID
from [MFAH-TMS].TMS.dbo.Objects o 
inner join ConsObject co on co.Obj_Name = o.ObjectNumber
inner join [MFAH-TMS].TMS.dbo.ObjContext oc on o.ObjectID = oc.ObjectID
inner join [MFAH-TMS].TMS.dbo.ObjPkgList opl on o.ObjectID = opl.ObjectID
where ObjectPackageID = 12955
and oc.Culture is not null
)



--Object Date - 269
select o.ObjectID as TMSObjectID, o.Dated, getdate() as Retrieved
from [MFAH-TMS].TMS.dbo.Objects o
inner join [MFAH-TMS].TMS.dbo.ObjPkgList opl on o.ObjectID = opl.ObjectID
where ObjectPackageID = 12955
order by o.ObjectID



insert into ObjDated (ObjDated, Obj_ID)
(
select o.Dated, co.Obj_ID
from [MFAH-TMS].TMS.dbo.Objects o 
inner join ConsObject co on co.Obj_Name = o.ObjectNumber
inner join [MFAH-TMS].TMS.dbo.ObjPkgList opl on o.ObjectID = opl.ObjectID
where ObjectPackageID = 12955
and o.Dated is not null
)



--Object Title - 269
select o.ObjectID as TMSObjectID, ot.Title, getdate() as Retrieved
from [MFAH-TMS].TMS.dbo.Objects o
inner join [MFAH-TMS].TMS.dbo.ObjTitles ot on o.ObjectID = ot.ObjectID
inner join [MFAH-TMS].TMS.dbo.ObjPkgList opl on o.ObjectID = opl.ObjectID
where ot.DisplayOrder = 1
and ObjectPackageID = 12955



insert into ObjTitle (ObjTitle, Obj_ID)
(
select ot.Title, co.Obj_ID
from [MFAH-TMS].TMS.dbo.Objects o 
inner join ConsObject co on co.Obj_Name = o.ObjectNumber
inner join [MFAH-TMS].TMS.dbo.ObjTitles ot on o.ObjectID = ot.ObjectID
inner join [MFAH-TMS].TMS.dbo.ObjPkgList opl on o.ObjectID = opl.ObjectID
where ObjectPackageID = 12955
and o.Dated is not null
)


--Object Actor - 267
select o.ObjectID as TMSObjectID, r.RoleID, r.Role, rt.RoleTypeID, rt.RoleType, c.ConstituentID, c.DisplayName, getdate() as Retrieved
from [MFAH-TMS].TMS.dbo.RoleTypes rt 
inner join [MFAH-TMS].TMS.dbo.Roles r on rt.RoleTypeID = r.RoleTypeID 
inner join [MFAH-TMS].TMS.dbo.ObjConXrefs ocx on r.RoleID = ocx.RoleID 
inner join [MFAH-TMS].TMS.dbo.Constituents c on ocx.ConstituentID = c.ConstituentID 
inner join [MFAH-TMS].TMS.dbo.Objects o on ocx.ObjectID = o.ObjectID
inner join [MFAH-TMS].TMS.dbo.ObjPkgList opl on o.ObjectID = opl.ObjectID
where rt.RoleTypeID = 1
and ObjectPackageID = 12955


select * from Actors


insert into Actors (Actor_Name)
(
select distinct c.DisplayName
from [MFAH-TMS].TMS.dbo.RoleTypes rt 
inner join [MFAH-TMS].TMS.dbo.Roles r on rt.RoleTypeID = r.RoleTypeID 
inner join [MFAH-TMS].TMS.dbo.ObjConXrefs ocx on r.RoleID = ocx.RoleID 
inner join [MFAH-TMS].TMS.dbo.Constituents c on ocx.ConstituentID = c.ConstituentID 
inner join [MFAH-TMS].TMS.dbo.Objects o on ocx.ObjectID = o.ObjectID
inner join [MFAH-TMS].TMS.dbo.ObjPkgList opl on o.ObjectID = opl.ObjectID
inner join ConsObject co on co.Obj_Name = o.ObjectNumber
where rt.RoleTypeID = 1
and ObjectPackageID = 12955
)


select * from ActorObjRole
select * from ActorRoles	--16 = Artist


select o.ObjectID as TMSObjectID, r.RoleID, r.Role, rt.RoleTypeID, rt.RoleType, c.ConstituentID, c.DisplayName, getdate() as Retrieved
from [MFAH-TMS].TMS.dbo.RoleTypes rt 
inner join [MFAH-TMS].TMS.dbo.Roles r on rt.RoleTypeID = r.RoleTypeID 
inner join [MFAH-TMS].TMS.dbo.ObjConXrefs ocx on r.RoleID = ocx.RoleID 
inner join [MFAH-TMS].TMS.dbo.Constituents c on ocx.ConstituentID = c.ConstituentID 
inner join [MFAH-TMS].TMS.dbo.Objects o on ocx.ObjectID = o.ObjectID
inner join [MFAH-TMS].TMS.dbo.ObjPkgList opl on o.ObjectID = opl.ObjectID
where rt.RoleTypeID = 1
and ObjectPackageID = 12955





select * from consobject


insert into ActorObjRole (Actor_ID, Obj_ID, ActorRoleID, DateAssociated)
(
select Actor_ID, Obj_ID, 1, getdate()
from [MFAH-TMS].TMS.dbo.RoleTypes rt 
inner join [MFAH-TMS].TMS.dbo.Roles r on rt.RoleTypeID = r.RoleTypeID 
inner join [MFAH-TMS].TMS.dbo.ObjConXrefs ocx on r.RoleID = ocx.RoleID 
inner join [MFAH-TMS].TMS.dbo.Constituents c on ocx.ConstituentID = c.ConstituentID 
inner join [MFAH-TMS].TMS.dbo.Objects o on ocx.ObjectID = o.ObjectID
inner join [MFAH-TMS].TMS.dbo.ObjPkgList opl on o.ObjectID = opl.ObjectID
inner join ConsObject co on co.Obj_Num = ocx.ObjectID
inner join Actors a on c.DisplayName = a.Actor_Name
where rt.RoleTypeID = 1
and ObjectPackageID = 12955
and co.Obj_NumType = 'TMSObjectID'
)


update ActorObjRole
set ActorRoleID = 16
where DateAssociated >= '2012-05-21'




select * from DimensionType --11
select * from DimUnits --6


insert into ObjDimensions (ObjDimDateRec, Obj_ID, DimID, UnitID, DimValue, Comments)
(
select getdate(), co.Obj_ID, 11, 6, 'From TMS', o.Dimensions
from [MFAH-TMS].TMS.dbo.Objects o
inner join [MFAH-TMS].TMS.dbo.ObjPkgList opl on o.ObjectID = opl.ObjectID
inner join ConsObject co on co.Obj_Name = o.ObjectNumber
and ObjectPackageID = 12955
and o.Dimensions is not null
)







--These thumb inserts don't work, the records insert, but the image doesn't appear.  I think they're handled somehow in the application tier.
--Plus, some of the thumbs are BMPs and they have to be GIFs or JPGs

--Object Thumbnail - 189
select distinct o.ObjectID as TMSObjectID, mx.MediaMasterID, mx.PrimaryDisplay, mr.RenditionNumber, mp.Path, 
'"' + mr.ThumbFileName + '",', getdate() as Retrieved
from [MFAH-TMS].TMS.dbo.MediaXrefs mx
inner join [MFAH-TMS].TMS.dbo.MediaRenditions mr on mx.MediaMasterID = mr.MediaMasterID
inner join [MFAH-TMS].TMS.dbo.MediaPaths mp on mr.ThumbPathID = mp.PathID
inner join [MFAH-TMS].TMS.dbo.Objects o on mx.ID = o.ObjectID
inner join [MFAH-TMS].TMS.dbo.ObjPkgList opl on o.ObjectID = opl.ObjectID
where mx.TableID = 108 
and mx.PrimaryDisplay = 1
and ObjectPackageID = 12955
order by o.ObjectID




--Object Thumbnail - 189
select distinct '"' + mr.ThumbFileName + '",'
from [MFAH-TMS].TMS.dbo.MediaXrefs mx
inner join [MFAH-TMS].TMS.dbo.MediaRenditions mr on mx.MediaMasterID = mr.MediaMasterID
inner join [MFAH-TMS].TMS.dbo.MediaPaths mp on mr.ThumbPathID = mp.PathID
inner join [MFAH-TMS].TMS.dbo.Objects o on mx.ID = o.ObjectID
inner join [MFAH-TMS].TMS.dbo.ObjPkgList opl on o.ObjectID = opl.ObjectID
where mx.TableID = 108 
and mx.PrimaryDisplay = 1
and ObjectPackageID = 12955





select * from ConsObject where Obj_Num = '44006'
select * from ObjImages where Obj_ID = 536
delete from ObjImages where ObjImg_ID = 27



declare @path varchar(50)
set @path = '/ACDTest/UserImages/Object/'

--Object Thumbnail - 189

insert into ObjImages (ObjImgRef, Obj_ID, ObjImgNotes)
(
select distinct @path + mr.ThumbFileName, co.Obj_ID, 'TMS Thumbnail'
from [MFAH-TMS].TMS.dbo.MediaXrefs mx
inner join [MFAH-TMS].TMS.dbo.MediaRenditions mr on mx.MediaMasterID = mr.MediaMasterID
inner join [MFAH-TMS].TMS.dbo.MediaPaths mp on mr.ThumbPathID = mp.PathID
inner join [MFAH-TMS].TMS.dbo.Objects o on mx.ID = o.ObjectID
inner join [MFAH-TMS].TMS.dbo.ObjPkgList opl on o.ObjectID = opl.ObjectID
inner join ConsObject co on co.Obj_Name = o.ObjectNumber
where mx.TableID = 108 
and mx.PrimaryDisplay = 1 and o.ObjectID = 44006
)

and ObjectPackageID = 12955



declare @path varchar(50)
set @path = '/ACDTest/UserImages/Object/'

--Object Thumbnail - 189

insert into ObjDocs (Obj_ID, ObjDoc_Ref, ObjImg_Notes)
(
select distinct co.Obj_ID, @path + mr.ThumbFileName, 'TMS Thumbnail'
from [MFAH-TMS].TMS.dbo.MediaXrefs mx
inner join [MFAH-TMS].TMS.dbo.MediaRenditions mr on mx.MediaMasterID = mr.MediaMasterID
inner join [MFAH-TMS].TMS.dbo.MediaPaths mp on mr.ThumbPathID = mp.PathID
inner join [MFAH-TMS].TMS.dbo.Objects o on mx.ID = o.ObjectID
inner join [MFAH-TMS].TMS.dbo.ObjPkgList opl on o.ObjectID = opl.ObjectID
inner join ConsObject co on co.Obj_Name = o.ObjectNumber
where mx.TableID = 108 
and mx.PrimaryDisplay = 1 and o.ObjectID = 44006
)



select * from ML_ObjType

