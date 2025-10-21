-- The ImageSize parameter pulls from the results of this query and defaults to SizeOrder = 3
-- This Dataset is here only to allow changing of the default size of cached image
-- in case the 3rd in size is smaller than 192x192 or if the image quality is poor,
-- or for troubleshooting.

select 
 row_number() over (order by cast(S.value as int)) as SizeOrder
,s.value as Size
from configuration as c
cross apply string_split(c.configValue, ',') as s  
where c.configLabel = N'Media.Cache.Image.Sizes'
