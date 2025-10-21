select 
 logo.ConfigValue  + 'ReportLogo.jpg' as logo
from configuration as c
cross apply configuration as logo
where c.configLabel = N'Media.Cache.Image.Sizes'
and logo.ConfigLabel = N'System.Reports.InstitutionLogoPath'