/*

mfahv_ObjConSummary

Object-Constituent Summary
Custom MFAH View

Author:			Dave Thompson
Last Updated:	5/29/13

Description:	Pulls Object-Constituent Xrefs based on TMS View ObjConXrefs,
				and counts the number of instances of each Constituent-Role-Department-ObjectStatus.

*/

--ALTER VIEW mfahv_ObjConSummary AS

SELECT DISTINCT
ct.ConstituentType,
c.ConstituentID,
c.Active,
COUNT(ocx.ConXrefID) AS Instances,
c.DisplayName,
c.NameTitle,
c.FirstName,
c.MiddleName,
c.LastName,
c.Suffix,
c.salutation,
c.Institution,
c.CultureGroup,
c.Nationality,
c.BeginDate,
c.EndDate,
c.Code

FROM ObjConXrefs AS ocx
LEFT OUTER JOIN Constituents AS c ON ocx.ConstituentID = c.ConstituentID
LEFT OUTER JOIN ConTypes AS ct ON c.ConstituentTypeID = ct.ConstituentTypeID
LEFT OUTER JOIN [Objects] AS o ON ocx.ObjectID = o.ObjectID
LEFT OUTER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID
LEFT OUTER JOIN ObjectStatuses AS os ON o.ObjectStatusID = os.ObjectStatusID


GROUP BY
ct.ConstituentType,
c.ConstituentID,
c.Active,
c.DisplayName,
c.NameTitle,
c.FirstName,
c.LastName,
c.MiddleName,
c.Suffix,
c.salutation,
c.Institution,
c.CultureGroup,
c.Nationality,
c.BeginDate,
c.EndDate,
c.Code

--GO

