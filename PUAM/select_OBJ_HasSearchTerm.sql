



DECLARE @SearchTerm NVARCHAR(50)

SET @SearchTerm = 'Aaron' + '%' + 'Mendelsohn'

SELECT
 o.ObjectID
,o.ObjectNumber
,o.ObjectName
,o.Title
,o.[Medium]
,o.Signed
,o.Inscribed
,o.Markings
,o.CreditLine
,o.Chat
,o.[Description]
,o.Exhibitions
,o.Provenance
,o.PubReferences
,o.Notes
,o.CuratorialRemarks
,o.RelatedWorks
,o.Portfolio
,o.CatRais
,o.HistAttributions
,o.Bibliography
,o.PaperSupport

FROM [Objects] AS o

WHERE
 o.ObjectName LIKE '%' + @SearchTerm + '%'
OR o.Title LIKE '%' + @SearchTerm + '%'
OR o.[Medium] LIKE '%' + @SearchTerm + '%'
OR o.Signed LIKE '%' + @SearchTerm + '%'
OR o.Inscribed LIKE '%' + @SearchTerm + '%'
OR o.Markings LIKE '%' + @SearchTerm + '%'
OR o.CreditLine LIKE '%' + @SearchTerm + '%'
OR o.Chat LIKE '%' + @SearchTerm + '%'
OR o.[Description] LIKE '%' + @SearchTerm + '%'
OR o.Exhibitions LIKE '%' + @SearchTerm + '%'
OR o.Provenance LIKE '%' + @SearchTerm + '%'
OR o.PubReferences LIKE '%' + @SearchTerm + '%'
OR o.Notes LIKE '%' + @SearchTerm + '%'
OR o.CuratorialRemarks LIKE '%' + @SearchTerm + '%'
OR o.RelatedWorks LIKE '%' + @SearchTerm + '%'
OR o.Portfolio LIKE '%' + @SearchTerm + '%'
OR o.CatRais LIKE '%' + @SearchTerm + '%'
OR o.HistAttributions LIKE '%' + @SearchTerm + '%'
OR o.Bibliography LIKE '%' + @SearchTerm + '%'
OR o.PaperSupport LIKE '%' + @SearchTerm + '%'

