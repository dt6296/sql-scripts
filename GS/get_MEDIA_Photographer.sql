select
 mm.MediaMasterID
,mr.RenditionID
,string_agg(cp.DisplayName,'; ') as Photographer

from			MediaMaster					as mm	
left outer join	MediaRenditions				as mr	on	mm.MediaMasterID = mr.MediaMasterID
left outer join ConXrefs					as cx	on	mr.RenditionID = cx.ID 
													and cx.TableID = 322 -- Media Renditions
													--and cx.RoleID = 373  -- Photographer		-- This is hardcoded, see below.
left outer join Roles						as r	on cx.RoleID = r.RoleID and r.[Role] = 'Photographer'
left outer join ConXrefDetails				as cxd	on	cx.ConXrefID = cxd.ConXrefID 
													and cxd.Unmasked = 1
left outer join Constituents				as cp	on	cxd.ConstituentID = cp.ConstituentID

group by
 mm.MediaMasterID
,mr.RenditionID

