


--	User-supplied variable declarations
declare @Procedure nvarchar(100);		-- Name of this script (origninally intended as a persistent reference)
declare @ServerSource nvarchar(50);		-- Server on which the view(s) to be checked are located
declare @DatabaseSource nvarchar(50);	-- Database in which the view(s) to be checked are located
declare @TableList nvarchar(100);		-- Either a single view name, or multiple views using % wildcard
declare @FieldToCheck nvarchar(100);	-- Field to be checked for truncation
declare @MaxFieldLength nvarchar(10);	-- Max field lengh of the TMS field to which the field is mapped
declare @TimeOffset int;				-- Adjustment for difference between local and server time (if any)

set @Procedure = N'sp_CheckFieldForTruncation';
set @ServerSource = N'DVMCMSDB04';
set @DatabaseSource = N'DOI_SRC1';
set @TableList = N'vOBJ_FlexFields_group_%'; 
set @FieldToCheck = N'FieldName';
set @MaxFieldLength = N'7';
set @TimeOffset = 0;

-- Get number of views to be checked (based on @TableList above)
declare @iParamDef nvarchar(500);		--
declare @iSQL nvarchar(1000);			-- 
declare @iOUT int;						-- 
declare @i int;							-- Loop iteration

set @iParamDef = N'@iOUT int output';
set @iSQL = N'select @iOUT = count(*) from ' + @ServerSource + '.' + @DatabaseSource + N'.INFORMATION_SCHEMA.VIEWS where TABLE_NAME like ''' + @TableList + N'''';
execute sp_executesql @iSQL,@iParamDef,@iOUT = @i output;

--	Create temp tables
drop table if exists #ViewName;
create table #ViewName (ViewName varchar(100));

drop table if exists #FieldName;
create table #FieldName (ViewName varchar(100),FieldsTruncated int);

drop table if exists #ProcedureStats;
create table #ProcedureStats (StoredProcedure varchar(100), ProcedureStart datetime, ProcedureFinish datetime, Duration varchar(15), NumRowsWithTruncation int, ViewsChecked nvarchar(100), FieldChecked nvarchar(100));

--	Initialize loop
declare @Duration nvarchar(15);			-- Duration of execution time for each view checked
declare @MilliSeconds int				-- Duration unit of measure
declare @t0 datetime;					-- Begin execution time for each view checked
declare @t1 datetime;					-- End execution time for each view checked
declare @RowCount int;					-- Number of views to be checked

set @t0 = dateadd(hour,@TimeOffset,getdate());
set @RowCount = 0;

while @i > 0
begin

	set @t0 = dateadd(hour,@TimeOffset,getdate());

--	BEGIN STUFF TO DO

--	Get the next view name to be checked and assign it to @view	
	drop table if exists #testTable;
	create table #testTable (RowNumber int, TABLE_NAME varchar(100));
	declare @testSQL nvarchar(500);			-- 
	declare @view nvarchar(100);			-- 
	set @testSQL = N'insert into #testTable select row_number()over(order by TABLE_NAME asc) as RowNumber, TABLE_NAME from ' + @ServerSource + N'.' + @DatabaseSource + N'.INFORMATION_SCHEMA.VIEWS where TABLE_NAME like ''' + @TableList + N'''';
	exec sp_executesql @testSQL;
	select @view = (select TABLE_NAME from #testTable where RowNumber = @i);

--	insert view name (@view) and the count of truncated rows into temp table #ViewName
	declare @SQL nvarchar(1000);			-- 
	insert into #ViewName select @view;
	set @SQL = N'insert into #FieldName select distinct ''' + @view + N''', count(*) from  ' + @DatabaseSource + '..' + quotename(@view) + N' where len(' + @FieldToCheck + ') > ' + @MaxFieldLength; 
	exec sp_executesql @SQL;

--	END STUFF TO DO

	set @i = @i - 1;
	set @RowCount = (select FieldsTruncated from #FieldName where ViewName = @view)
	set @t1 = dateadd(hour,@TimeOffset,getdate())
	set @MilliSeconds = datediff(millisecond,@t0,@t1);
	set @Duration = concat(
	--      RIGHT('0' + cast(@MilliSeconds/(1000*60*60*24) as varchar(2)),2), ':',						-- Days
			RIGHT('0' + cast(@MilliSeconds/(1000*60*60) as varchar(2)),2), ':',							-- Hrs
			RIGHT('0' + cast((@MilliSeconds%(1000*60*60))/(1000*60) as varchar(2)),2), ':',				-- Mins
			RIGHT('0' + cast(((@MilliSeconds%(1000*60*60))%(1000*60))/1000 as varchar(2)),2)--, '.',	-- Secs
		   -- ((@MilliSeconds%(1000*60*60))%(1000*60))%1000												-- Milli Secs
	);

	insert into #ProcedureStats select @Procedure,@t0,@t1,@Duration,@RowCount,@view,@FieldToCheck;

end 
--	End loop

print @Duration;
print @RowCount;

--	Get results
select StoredProcedure,ProcedureStart,ProcedureFinish,ViewsChecked,FieldChecked,NumRowsWithTruncation,Duration from #ProcedureStats order by ProcedureFinish desc
go 