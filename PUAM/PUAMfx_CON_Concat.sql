



create function [dbo].[PUAMfx_CON_Concat](@ObjectID int)
returns nvarchar(1500)
as

begin

declare @ArtistMakers nvarchar(1500)

select @ArtistMakers =
    string_agg(dbo.puamFormatConCaption (cx.ConXrefID),', ') within group (order by cx.DisplayOrder asc)
    from ConXrefs as cx
    where cx.TableID = 108
    and cx.RoleTypeID = 1
    and cx.Displayed = 1
    and cx.ID = @ObjectID

return @ArtistMakers

end 

GO

/*


select o.ObjectNumber, dbo.PUAMfx_CON_Concat(22814) from Objects as o where o.ObjectID = 22814
select o.ObjectNumber, dbo.PUAMfx_CON_Concat(39794) from Objects as o where o.ObjectID = 39794
select o.ObjectNumber, dbo.PUAMfx_CON_Concat(19605) from Objects as o where o.ObjectID = 19605
select o.ObjectNumber, dbo.PUAMfx_CON_Concat(81231) from Objects as o where o.ObjectID = 81231
select o.ObjectNumber, dbo.PUAMfx_CON_Concat(30368) from Objects as o where o.ObjectID = 30368



select
cx.ID
from ConXrefs as cx
where cx.TableID = 108
and cx.RoleTypeID = 1
and cx.Displayed = 1
group by cx.ID
having count(*) > 2

*/

