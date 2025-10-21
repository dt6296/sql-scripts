










SELECT
c.ConditionID,
c.ID,
c.ExaminerID,
c.Examiner2ID,
c.LoginID,
c.EnteredDate,
c.SurveyTypeID,
st.SurveyType,
c.OverallConditionID,
oc.OverallCondition,
c.SurveyISODate,
c.ReportISODate,
cli.CondLineItemID,
cli.BriefDescription,
cli.Statement,
cli.Proposal,
cli.Treatment,
cli.ActionRequired,
cli.ActionTaken,
cli.AttributeTypeID,
sat.AttributeType

FROM Conditions AS c
LEFT OUTER JOIN CondLineItems AS cli ON c.ConditionID = cli.ConditionID
LEFT OUTER JOIN SurveyTypes AS st ON c.SurveyTypeID = st.SurveyTypeID
LEFT OUTER JOIN OverallConditions AS oc ON c.OverallConditionID = oc.OverallConditionID
LEFT OUTER JOIN SurveyAttrTypes AS sat ON cli.AttributeTypeID = sat.AttributeTypeID

WHERE c.EnteredDate > '2016-07-01'
AND sat.AttributeTypeID = 15














