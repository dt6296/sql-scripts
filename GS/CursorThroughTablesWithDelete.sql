DECLARE @sqlCommand VARCHAR(3000);
DECLARE @tableList TABLE(Value NVARCHAR(128));
DECLARE @TableName VARCHAR(128);
DECLARE @RecordCount INT;

-- get a cursor with a list of table names and their record counts
DECLARE MyCursor CURSOR FAST_FORWARD
FOR SELECT t.name TableName,
           i.rows Records
    FROM sysobjects t,
         sysindexes i
    WHERE 
          t.xtype = 'U'              -- only User tables
          AND i.id = t.id          
          AND i.indid IN(0, 1)       -- 0=Heap, 1=Clustered Index
          --AND i.rows < 10            -- Filter by number of records in the table
          AND t.name LIKE 'obj%';  -- Filter tables by name. You could also provide a list:
                                     -- AND t.name IN ('MyTable1', 'MyTable2', 'MyTable3');
                                     -- or a list of tables to exclude:
                                     -- AND t.name NOT IN ('MySpecialTable', ... );

OPEN MyCursor;

FETCH NEXT FROM MyCursor INTO @TableName, @RecordCount;

-- for each table name in the cursor, delete all records from that table:
WHILE @@FETCH_STATUS = 0
    BEGIN
        --SET @sqlCommand = 'DELETE FROM ' + @TableName;
		SET @sqlCommand = 'SELECT * FROM ' + @TableNAme;
        EXEC (@sqlCommand);
        FETCH NEXT FROM MyCursor INTO @TableName, @RecordCount;
    END;

CLOSE MyCursor;
DEALLOCATE MyCursor;