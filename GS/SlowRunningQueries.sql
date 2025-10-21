
/*

https://www.site24x7.com/learn/optimize-slow-sql-queries-for-large-dataset.html#:~:text=To%20optimize%20queries%20for%20this,and%20improve%20overall%20system%20performance.

*/


select r.session_id, r.status, r.total_elapsed_time, r.cpu_time, r.wait_time, r.command, t.text
from sys.dm_exec_requests as r
cross apply sys.dm_exec_sql_text(r.sql_handle) as t
where status != 'sleeping'