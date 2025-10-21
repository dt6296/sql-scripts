
/* Change database to SQL authentication */
 
-- step 1: Update Config Login & password fields to have values so db is now set for SQL authentication
update Configuration
set Configvalue = 'tmsadmin'
where ConfigLabel = 'system.login'
update Configuration
set Configvalue = ']^ABQQ' -- this is 'tms' encrypted
where ConfigLabel = 'system.password'
-- step 2: log into DB Config and add 'tmsadmin' user with password = tms
-- step 3: Generate license request logged in as 'tmsadmin'; register
 
/* Change database back to Windows NT authentication */
 
update Configuration
set ConfigValue = ''
where ConfigLabel = 'system.login'
update Configuration
set ConfigValue = ''
where ConfigLabel = 'system.password'
 
--delete any sql authenticated user account, added for testing, running under sql authentication
delete from Users
where DisplayName = 'tmsadmin'