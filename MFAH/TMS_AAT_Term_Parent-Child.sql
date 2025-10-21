



SELECT 
st.ParentTerm, t.term, t.TermMasterID, tx.*
FROM ThesXrefs AS tx
LEFT OUTER JOIN TMSThesaurus.dbo.Terms AS t ON tx.TermID = t.TermID
LEFT OUTER JOIN
(
	SELECT
	tp.TermID		AS ParentTermID,
	tp.TermMasterID	AS ParentTermMasterID,
	tp.TermTypeID	AS ParentTermTypeID,
	tp.Term			AS ParentTerm,
	tc.TermID		AS ChildTermID,
	tc.TermMasterID	AS ChildTermMasterID,
	tc.TermTypeID	AS ChildTermTypeID,
	tc.Term			AS ChildTerm
	FROM TMSThesaurus.dbo.Terms AS tp
	LEFT OUTER JOIN TMSThesaurus.dbo.TermMaster AS tmp ON tp.TermMasterID = tmp.TermMasterID
	LEFT OUTER JOIN TMSThesaurus.dbo.TermMaster AS tmc ON tmp.CN = LEFT(tmc.CN, CASE WHEN LEN(tmc.CN)<4 THEN LEN(tmc.CN) ELSE LEN(tmc.CN)-4 END)
	LEFT OUTER JOIN TMSThesaurus.dbo.Terms AS tc ON tmc.TermMasterID = tc.TermMasterID
	--WHERE tp.LoginID = 'dthompson' 
	--AND tp.EnteredDate >= '2013-08-01 00:00'
) AS st	ON t.TermID = st.ChildTermID
WHERE
TableID = 187



SELECT
tp.TermID		AS ParentTermID,
tp.TermMasterID	AS ParentTermMasterID,
tp.TermTypeID	AS ParentTermTypeID,
tp.Term			AS ParentTerm,
tc.TermID		AS ChildTermID,
tc.TermMasterID	AS ChildTermMasterID,
tc.TermTypeID	AS ChildTermTypeID,
tc.Term			AS ChildTerm
FROM TMSThesaurus.dbo.Terms AS tp
LEFT OUTER JOIN TMSThesaurus.dbo.TermMaster AS tmp ON tp.TermMasterID = tmp.TermMasterID
LEFT OUTER JOIN TMSThesaurus.dbo.TermMaster AS tmc ON tmp.CN = LEFT(tmc.CN, CASE WHEN LEN(tmc.CN)<4 THEN LEN(tmc.CN) ELSE LEN(tmc.CN)-4 END)
LEFT OUTER JOIN TMSThesaurus.dbo.Terms AS tc ON tmc.TermMasterID = tc.TermMasterID
WHERE tp.LoginID = 'dthompson' 
AND tp.EnteredDate >= '2013-08-01 00:00'



SELECT
tp.TermID		AS ParentTermID,
tp.TermMasterID	AS ParentTermMasterID,
tp.TermTypeID	AS ParentTermTypeID,
tp.Term			AS ParentTerm,
tc.TermID		AS ChildTermID,
tc.TermMasterID	AS ChildTermMasterID,
tc.TermTypeID	AS ChildTermTypeID,
tc.Term			AS ChildTerm
FROM TMSThesaurus.dbo.Terms AS tp
LEFT OUTER JOIN TMSThesaurus.dbo.TermMaster AS tmp ON tp.TermMasterID = tmp.TermMasterID
LEFT OUTER JOIN TMSThesaurus.dbo.TermMaster AS tmc ON tmp.CN = LEFT(tmc.CN, CASE WHEN LEN(tmc.CN)<4 THEN LEN(tmc.CN) ELSE LEN(tmc.CN)-4 END)
LEFT OUTER JOIN TMSThesaurus.dbo.Terms AS tc ON tmc.TermMasterID = tc.TermMasterID
WHERE tp.LoginID = 'dthompson' 
AND tp.EnteredDate >= '2013-08-01 00:00'





SELECT * FROM DDTables ORDER BY TableName