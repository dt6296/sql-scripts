





SELECT ObjectID, ObjectNumber, CreditLine
FROM Objects
WHERE ObjectStatusID IN (2,27)
AND CreditLine LIKE '%, ' + CHAR(71) + 'ift%'
COLLATE Latin1_General_CS_AI




SELECT ObjectID, ObjectNumber, CreditLine
FROM Objects
WHERE ObjectStatusID IN (2,27)
AND CreditLine LIKE '%, ' + CHAR(77) + 'useum%'
COLLATE Latin1_General_CS_AI

