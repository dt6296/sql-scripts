

-- Conservation Data Cleanup - Project Field


SELECT
oc.ConditionID,
c.Classification,
d.Department,
COUNT(*) AS Occurrences,
st.SurveyType,
os.ObjectStatus,
o.ObjectNumber,
ISNULL(oc.Project,'') AS Project

FROM Conditions AS oc
INNER JOIN SurveyTypes AS st ON oc.SurveyTypeID = st.SurveyTypeID
INNER JOIN Objects AS o ON oc.ID = o.ObjectID AND oc.TableID = 108
INNER JOIN Classifications AS c ON o.ClassificationID = c.ClassificationID
INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID
INNER JOIN ObjectStatuses AS os ON o.ObjectStatusID = os.ObjectStatusID

GROUP BY
st.SurveyType,
o.ObjectNumber,
c.Classification,
os.ObjectStatus,
d.Department,
oc.Project,
oc.ConditionID

ORDER BY
c.Classification,
d.Department,
os.ObjectStatus,
oc.Project,
st.SurveyType