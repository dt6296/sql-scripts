





SELECT duesid, dueskey
FROM
(
	SELECT duesid, dueskey, RANK() OVER(PARTITION BY duesid ORDER BY duesprocdt) AS RankByDate
	FROM dues_full
	WHERE duesacctno = '40010' 
) AS d
WHERE d.RankByDate = 1