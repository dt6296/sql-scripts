select
 ReportID
,FormName
,MenuLabel
,ReportName
,[Description]
,[Global]
,FilePath
,[owner]

from Reports

where PlugIn = 0

order by ReportName