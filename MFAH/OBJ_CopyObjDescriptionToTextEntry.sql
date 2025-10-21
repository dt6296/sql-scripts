/*
SELECT TOP 1000 [TextTypeID]
      ,[TableID]
      ,[TextType]
      ,[LoginID]
      ,[EnteredDate]
  FROM [TMS].[dbo].[TextTypes]
*/  
--SELECT TOP 100 * FROM TextEntries WHERE TextTypeID = 102

SELECT
108,							--TableID
ObjectID,
102,							--TextTypeID
21,								--TextStatusID
'Data Standardization 2013',	--Purpose (can be null)
GETDATE(),						--TextDate
								--LoginID
								--EnteredDate
								--AuthorConID
								--Remarks (NEXT)
'On 8/20/2013 Dave Thompson COPIED this text from the Object Description field to this text entry record at the request of the Website Committee. (Discussed and approved by Mari Carmen Ramirez, Shemon Bar-Tal, and Merrianne Timko.)  No data was deleted or altered in the Object Description field.',
[Description],					--TextEntryHTML
[Description]					--TextEntry

FROM [Objects]
WHERE [Description] IS NOT NULL

--INSERT STATEMENT
/*
INSERT INTO TextEntries 
(TableID, ID, TextTypeID, TextStatusID, Purpose, TextDate, LoginID, Remarks, TextEntryHTML, TextEntry)

	SELECT
	108, ObjectID, 102, 21, 'Data Standardization 2013', '8/20/2013', 'dthompson',
	'On 8/20/2013 Dave Thompson COPIED this text from the Object Description field to this text entry record at the request of the Website Committee. (Discussed and approved by Mari Carmen Ramirez, Shemon Bar-Tal, and Merrianne Timko.)  No data was deleted or altered in the Object Description field.',
	[Description], [Description]

FROM [Objects]
WHERE [Description] IS NOT NULL 
*/




