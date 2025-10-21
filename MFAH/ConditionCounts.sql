



SELECT COUNT(*), 'Condition Records' FROM Conditions
--SELECT COUNT(*), 'Media attached to Condition Records' FROM MediaXrefs WHERE TableID = 95	--Conditions
SELECT COUNT(*), 'TextEntries linked to Condition Records' FROM TextEntries WHERE TableID = 95	--Conditions

SELECT '' 

SELECT COUNT(*), 'Condition Line Items' FROM CondLineItems
SELECT COUNT(*), 'Media linked to Condition Line Items' FROM MediaXrefs WHERE TableID = 97	--CondLineItems
--SELECT COUNT(*) FROM TextEntries WHERE TableID = 97	--CondLineItems



