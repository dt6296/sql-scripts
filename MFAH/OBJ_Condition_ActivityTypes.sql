










SELECT 
c.SurveyTypeID,
st.SurveyType,
c.ID,
o.ObjectNumber,
cl.Classification,
COUNT(*) AS Records

FROM Conditions AS c 
INNER JOIN SurveyTypes AS st ON c.SurveyTypeID = st.SurveyTypeID
INNER JOIN Objects AS o ON c.ID = o.ObjectID
INNER JOIN Classifications AS cl ON o.ClassificationID = cl.ClassificationID

--WHERE c.ID = 110421

GROUP BY 
c.SurveyTypeID,
st.SurveyType,
c.ID,
o.ObjectNumber, o.SortNumber,
cl.Classification

ORDER BY
st.SurveyType,
cl.Classification,
o.SortNumber






