/*
This script copies security settings from a user security template to an actual TMS user.

You will need to open SQL Server Management Studio (SSMS) to execute this script.

Connect to server MFAH-TMS-SQL, database TMS, and open a New Query window.

The format of the statement used to assign security is as follows:
EXEC CopyTMSUserSecurity @SourceUserID, @TargetUserID

*/
--1)	Run These two SELECT statements.

SELECT 'SourceUserID', * FROM Users WHERE Login = 'zFullView'		-- SourceUserID
SELECT 'TargetUserID', * FROM Users WHERE Login = 'kbentley' 	-- TargetUserID

--2)	Copy and paste the SourceUserID (FROM) and TargetUserID (TO) into the EXEC statement below.
--3)	Execute the EXEC statement below.
/*
	EXEC CopyTMSUserSecurity 2653,2782;
*/


 