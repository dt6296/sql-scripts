
/*

REQUEST


From: Seyb, Ingrid 
Sent: Thursday, May 17, 2012 11:40 AM
To: Thompson, Dave; Ganatra, Saurin
Subject: RE: ACD textile survey

Ideally, by Tuesday.  Is that possible?  I created a project called Textiles and a survey called Bayou Bend Textiles at Rosine.  Can they be added to those as well?
Thanks
Ingrid

------------------------------

From: Thompson, Dave 
Sent: Thursday, May 17, 2012 11:21 AM
To: Seyb, Ingrid; Ganatra, Saurin
Subject: RE: ACD textile survey

Hi Ingrid,

Yep, we can add a group of objects to ACD using an object package.    How soon do you need them in ACD?

------------------------------

From: Seyb, Ingrid 
Sent: Thursday, May 17, 2012 11:19 AM
To: Ganatra, Saurin; Thompson, Dave
Subject: ACD textile survey

Hi guys,
I’m planning a survey of the Bayou Bend textiles stored at Rosine.  Is there as yet any way to add a group of objects to ACD en mass?  If so, the object package is “ibs-BB Rosine textiles”.  Any suggestions before I start designing the survey?
Thanks
Ingrid

*/


-------------------------------------------------------------------------------------------------------------
--I think Ingrid is using [MILLTEST\SQL2005].ACD_Test
-------------------------------------------------------------------------------------------------------------



--TMS Object Number - 269
select o.ObjectID as TMSObjectID, o.ObjectNumber as TMSObjectNumber, 2 as ObjNumTypeID, getdate() as Retrieved
from Objects o	
inner join ObjPkgList opl on o.ObjectID = opl.ObjectID
where ObjectPackageID = 12955
order by o.ObjectID

--Object Classification - 269
select o.ObjectID as TMSObjectID, c.Classification, getdate() as Retrieved
from Objects o 
inner join Classifications c on o.ClassificationID = c.ClassificationID
inner join ObjPkgList opl on o.ObjectID = opl.ObjectID
where ObjectPackageID = 12955
order by o.ObjectID

--Object Medium - 269
select o.ObjectID as TMSObjectID, o.Medium, getdate() as Retrieved
from Objects o
inner join ObjPkgList opl on o.ObjectID = opl.ObjectID
where ObjectPackageID = 12955
order by o.ObjectID

--Object Culture - 204
select o.ObjectID as TMSObjectID, oc.Culture, getdate() as Retrieved
from Objects o
inner join ObjContext oc on o.ObjectID = oc.ObjectID
inner join ObjPkgList opl on o.ObjectID = opl.ObjectID
where ObjectPackageID = 12955
and oc.Culture is not null
order by o.ObjectID

--Object Date - 269
select o.ObjectID as TMSObjectID, o.Dated, getdate() as Retrieved
from Objects o
inner join ObjPkgList opl on o.ObjectID = opl.ObjectID
where ObjectPackageID = 12955
order by o.ObjectID

--Object Title - 269
select o.ObjectID as TMSObjectID, ot.Title, getdate() as Retrieved
from Objects o
inner join ObjTitles ot on o.ObjectID = ot.ObjectID
inner join ObjPkgList opl on o.ObjectID = opl.ObjectID
where ot.DisplayOrder = 1
and ObjectPackageID = 12955
order by o.ObjectID

--Object Actor - 267
select o.ObjectID as TMSObjectID, r.RoleID, r.Role, rt.RoleTypeID, rt.RoleType, c.ConstituentID, c.DisplayName, getdate() as Retrieved
from RoleTypes rt 
inner join Roles r on rt.RoleTypeID = r.RoleTypeID 
inner join ObjConXrefs ocx on r.RoleID = ocx.RoleID 
inner join Constituents c on ocx.ConstituentID = c.ConstituentID 
inner join Objects o on ocx.ObjectID = o.ObjectID
inner join ObjPkgList opl on o.ObjectID = opl.ObjectID
where rt.RoleTypeID = 1
and ObjectPackageID = 12955
order by o.ObjectID, r.RoleID


--I'll provide the images later today (5/18/12)
--Object Thumbnail - 189
select o.ObjectID as TMSObjectID, mx.MediaMasterID, mx.PrimaryDisplay, mr.RenditionNumber, mp.Path, mr.ThumbFileName, getdate() as Retrieved
from MediaXrefs mx
inner join MediaRenditions mr on mx.MediaMasterID = mr.MediaMasterID
inner join MediaPaths mp on mr.ThumbPathID = mp.PathID
inner join Objects o on mx.ID = o.ObjectID
inner join ObjPkgList opl on o.ObjectID = opl.ObjectID
where mx.TableID = 108 
and mx.PrimaryDisplay = 1
and ObjectPackageID = 12955
order by o.ObjectID





