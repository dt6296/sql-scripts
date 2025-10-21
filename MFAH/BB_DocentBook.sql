
SELECT * FROM TextTypes WHERE TextTypeID = 38 -- Note
SELECT * FROM TextStatuses WHERE TextStatusID = 23 -- Approved

SELECT * FROM TextEntries 
WHERE TextTypeID = 38 
AND Purpose = 'Docent Book' -- 2109
AND TextStatusID = 23		-- 2109


------------------------------------------------------------



SELECT * FROM MFAHt_BB_DocentBook

SELECT * FROM MFAHt_BB_DocentBook -- 278 
WHERE TextEntry IS NOT NULL		-- 240
AND ObjectID = 21561

SELECT * FROM TextTypes WHERE TableID = 108 ORDER BY TextType ASC
SELECT * FROM TextStatuses



SELECT ObjectID, ObjectNumber FROM MFAHt_BB_DocentBook
WHERE TextEntry IS NOT NULL
GROUP BY ObjectID, ObjectNumber
HAVING COUNT(*) > 1


--DELETE FROM MFAHt_BB_DocentBook

--INSERT INTO TextEntries (TableID,ID,TextTypeID,TextStatusID,Purpose,TextDate,LoginID,EnteredDate,Remarks,TextEntry,LanguageID)

SELECT
--o.ObjectNumber,
108							AS	TableID,		-- 108 = Objects
bb.ObjectID					AS	ID,				-- 
38							AS	TextTypeID,		--  38 = Note
23							AS	TextStatusID,	--  23 = Approved
'Docent Book'				AS	Purpose,
'2020-10-20'				AS	TextDate,
'dthompson'					AS	LoginID,
GETDATE()					AS	EnteredDate,
''							AS	Remarks,
bb.TextEntry				AS	TextEntry,
1							AS	Language

FROM Objects AS o
INNER JOIN MFAHt_BB_DocentBook AS bb ON o.ObjectID = bb.ObjectID

WHERE bb.TextEntry IS NOT NULL



SELECT * FROM DDLanguages WHERE LocalLabel = 'ENGLISH'



-- Forgot to add Language above, ran the UPDATE below, then updated the INSERT above.
--UPDATE TextEntries SET LanguageID = 1
--SELECT * FROM TextEntries
WHERE TextTypeID = 38
AND Purpose = 'Docent Book'
AND LoginID = 'dthompson'
AND EnteredDate > '2020-08-10 10:00:00'




SELECT
te.ID AS ObjectID,
tt.TextType,
ts.TextStatus,
te.Purpose,
te.TextDate,
c.N_DisplayName AS Author,
te.Remarks,
te.TextEntry,
te.TextEntryHTML,
l.LocalLabel AS Language

FROM TextEntries AS te
LEFT OUTER JOIN TextTypes AS tt ON te.TextTypeID = tt.TextTypeID
LEFT OUTER JOIN TextStatuses AS ts ON te.TextStatusID = ts.TextStatusID
LEFT OUTER JOIN Constituents AS c ON te.AuthorConID = c.ConstituentID
LEFT OUTER JOIN DDLanguages AS l ON te.LanguageID = l.LanguageID

WHERE te.TextTypeID = 38 -- Note
AND Purpose = 'Docent Book'
AND ID = @ObjectID




SELECT 
o.ObjectID

FROM Objects AS o
INNER JOIN TextEntries AS te ON o.ObjectID = te.ID AND te.TableID = 108

WHERE te.TextTypeID = 38 -- Note
AND Purpose = 'Docent Book'



SELECT DISTINCT
l.CurRoom

FROM MFAHv_OBJ_Location_ActiveComponent_First AS l

WHERE l.CurSite = 'Bayou Bend'
and l.CurRoom IS NOT NULL