



SELECT CultureGroup, COUNT(*) FROM Constituents WHERE CultureGroup IS NOT NULL GROUP BY CultureGroup


SELECT CultureGroup,* FROM Constituents WHERE ConstituentID = 20406


SELECT CultureGroup,* FROM Constituents WHERE ConstituentID = 13114

SELECT CultureGroup,* FROM Constituents WHERE ConstituentID = 1322

SELECT CultureGroup,* FROM Constituents WHERE ConstituentID = 7099

SELECT * FROM Constituents WHERE CultureGroup = ''

--UPDATE Constituents
SET CultureGroup = NULL
WHERE CultureGroup = ''