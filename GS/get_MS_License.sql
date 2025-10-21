-- This checks for the existence of a Media Studo license that matches the current System.Version.
-- If it returns 1, the zsub_OBJ_Media sub report is availabe to tms_OBJ_List.
-- If it returns 0, the zsub_OBJ_Media sub report is NOT availabe to tms_OBJ_List.

select 1 as MS_License from LocalInfo as li
inner join [Configuration] as c on li.[Version] = c.ConfigValue
where c.ConfigLabel  = 'System.Version'
and li.ProductName = 'MS'