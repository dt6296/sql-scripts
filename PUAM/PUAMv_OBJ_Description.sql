USE [TMS]
GO

/****** Object:  View [dbo].[ObjectDescription]    Script Date: 8/28/2025 10:38:38 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--create view [dbo].[PUAMv_OBJ_Description] as

--	formerly	                            dbo.ObjectDescription
--	updated		8/28/2025	Dave Thompson	reformatted, renamed
--  note        9/23/2025   Dave Thompson   This returns one record per object with first active displayed 
--                                          object-related constituent where DisplayOrder = 1,
--                                          and displayed title where DisplayOrder = 1

select
 o.ObjectID
,o.SortNumber
,o.ObjectNumber
,ot.Title
,o.ObjectName
,o.Dated
,o.[Medium]
,o.Dimensions
,o.CreditLine
,o.DepartmentID
,o.ClassificationID
,o.ObjectStatusID
,o.[Description]

,can.ConstituentID
,can.AlphaSort
,cxd.Prefix
,can.DisplayName
,cxd.Suffix
,c.DisplayDate      -- should this be cxd>>cdb.DisplayBio, in case it's different for different objects? (like can.DisplayName?)

from Objects as o
left outer join ObjTitles as ot on  o.ObjectID = ot.ObjectID 
                                and ot.Displayed = 1 
                                and ot.DisplayOrder = 1 
                                and ot.IsExhTitle = 0
left outer join (
                    ConXrefs as cx
                    inner join Roles            as r    on  cx.RoleID = r.RoleID
                    inner join ConXrefDetails   as cxd  on  cx.ConXrefID = cxd.ConXrefID 
                                                        and cxd.UnMasked = 1
                    inner join ConAltNames      as can  on  cxd.NameID = can.AltNameID
                    inner join Constituents     as c    on  cxd.ConstituentID = c.ConstituentID
                ) 
                on  o.ObjectID = cx.ID 
                and cx.RoleTypeID = 1 
                and cx.TableID = 108 
                and cx.DisplayOrder = 1 
                and cx.Displayed = 1

GO

