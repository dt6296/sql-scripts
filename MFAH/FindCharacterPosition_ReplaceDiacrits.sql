
--uses dbo.Format_RemoveAccents from MFAH-SQL2.ImageCatalog_Data



select patindex ('%�%','fi�rst, seco�nd, th�ird') as POS
select patindex ('%�%','fi�rst, seco�nd, th�ird') as POS

select charindex ('�','fi�rst, seco�nd, th�ird',0) as POS
select charindex ('�','fi�rst, seco�nd, th�ird',0) as POS
select charindex ('�','fi�rst, seco�nd, th�ird', charindex ('�','fi�rst, seco�nd, th�ird',0)+1) as POS



		DECLARE @txt VARCHAR(50)
		DECLARE @char CHAR(1)

		SET @txt = 'fi�rst, seco�nd, th�ird'
		SET @CHAR = '�'
		--SET @char = '�'

		SELECT @txt, CHARINDEX (@char, @txt, 0) AS POS, LEN(@txt) - LEN(REPLACE(@txt, @char, '')) AS OCCURS, dbo.Format_RemoveAccents (@txt)
		WHERE 
		(LEN(@txt) - LEN(REPLACE(@txt, @char, '')))/1 > 0

select charindex ('�','fi�rst, seco�nd, th�ird',0) as POS
select charindex ('�','fi�rst, seco�nd, th�ird', charindex ('�','fi�rst, seco�nd, th�ird',0)+1) as POS




		DECLARE @txt VARCHAR(50)
		SET @txt = 'Impressionist'
		SELECT @txt, dbo.Format_RemoveAccents (@txt)
