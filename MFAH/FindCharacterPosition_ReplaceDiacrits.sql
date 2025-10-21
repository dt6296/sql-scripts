
--uses dbo.Format_RemoveAccents from MFAH-SQL2.ImageCatalog_Data



select patindex ('%ž%','fiãrst, secožnd, thãird') as POS
select patindex ('%ã%','fiãrst, secožnd, thãird') as POS

select charindex ('ž','fiãrst, secožnd, thãird',0) as POS
select charindex ('ã','fiãrst, secožnd, thãird',0) as POS
select charindex ('ã','fiãrst, secožnd, thãird', charindex ('ã','fiãrst, secožnd, thãird',0)+1) as POS



		DECLARE @txt VARCHAR(50)
		DECLARE @char CHAR(1)

		SET @txt = 'fiãrst, secožnd, thãird'
		SET @CHAR = 'ã'
		--SET @char = 'ž'

		SELECT @txt, CHARINDEX (@char, @txt, 0) AS POS, LEN(@txt) - LEN(REPLACE(@txt, @char, '')) AS OCCURS, dbo.Format_RemoveAccents (@txt)
		WHERE 
		(LEN(@txt) - LEN(REPLACE(@txt, @char, '')))/1 > 0

select charindex ('ã','fiãrst, secožnd, thãird',0) as POS
select charindex ('ã','fiãrst, secožnd, thãird', charindex ('ã','fiãrst, secožnd, thãird',0)+1) as POS




		DECLARE @txt VARCHAR(50)
		SET @txt = 'Impressionist'
		SELECT @txt, dbo.Format_RemoveAccents (@txt)
