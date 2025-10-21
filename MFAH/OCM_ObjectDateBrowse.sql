



-- Object Date Browse


--Using Historical Dates is problematic because not all objects have historical dates entered, and those that do don't indicate what type of date it is.

--so, I'm going to just use object begin and end dates.

/*
SELECT
o.ObjectID,
o.ObjectNumber,
o.Dated,
o.DateBegin,
o.DateEnd,
od.ObjDateID,
od.EventType,
od.DateText,
'DateBegSearch'		AS HistDateSearchType,
od.DateBegSearch	AS HistDateSearch

FROM Objects AS o
LEFT OUTER JOIN ObjDates AS od ON o.ObjectID = od.ObjectID

WHERE o.ObjectStatusID IN (2,27)
--AND o.ObjectNumber = '93.186'

UNION

SELECT
o.ObjectID,
o.ObjectNumber,
o.Dated,
o.DateBegin,
o.DateEnd,
od.ObjDateID,
od.EventType,
od.DateText,
'DateBegSearch'		AS HistDateSearchType,
od.DateEndSearch	AS HistDateSearch

FROM Objects AS o
LEFT OUTER JOIN ObjDates AS od ON o.ObjectID = od.ObjectID

WHERE o.ObjectStatusID IN (2,27)
--AND o.ObjectNumber = '93.186'



SELECT COUNT(*) FROM Objects WHERE DateBegin IS NULL --	= 0
SELECT COUNT(*) FROM Objects WHERE DateEnd IS NULL --	= 0

SELECT * FROM Objects WHERE DateBegin = 0 --	= 0
AND ObjectStatusID IN (2,27)

SELECT * FROM Objects WHERE DateEnd = 0 --	= 0
AND ObjectStatusID IN (2,27)

*/



SELECT
o.ObjectID,
o.ObjectNumber,
o.Dated,
o.DateBegin,
o.DateEnd,
o.DateEnd - o.DateBegin AS DateRange

FROM Objects AS o

WHERE o.ObjectStatusID IN (2,27)







SELECT
o.ObjectID,
o.ObjectNumber,
o.Dated,
'DateBegin'		AS DateType,
o.DateBegin		AS ObjectDate


FROM Objects AS o

WHERE o.ObjectStatusID IN (2,27)


UNION

SELECT
o.ObjectID,
o.ObjectNumber,
o.Dated,
'DateEnd'		AS DateType,
o.DateEnd		AS ObjectDate

FROM Objects AS o

WHERE o.ObjectStatusID IN (2,27)