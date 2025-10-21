SELECT
o.ObjectID,
o.ObjectNumber,
o.SortNumber,
omfd.DisplayName AS Artist,
o.TitleDateDisplay,
otfd.Title,
o.Dated,
o.Medium,
o.Dimensions,
ol.CurLocationString,
o.ThumbBLOB,
o.CreditLine,
dbo.MFAHfx_ConcatAltNums(o.ObjectID) AS AltNums,
ovc.Value,
ovc.ValuationDate,
s.Viewable,
cxs.ForwardDisplay AS Attribution,
cxs.DisplayOrder

FROM MFAHv_OBJ AS o
LEFT OUTER JOIN MFAHv_OBJ_Maker_FirstDisplayed				AS omfd	ON o.ObjectID = omfd.ObjectID
LEFT OUTER JOIN MFAHv_OBJ_Title_FirstDisplayed				AS otfd	ON o.ObjectID = otfd.ObjectID
LEFT OUTER JOIN MFAHv_OBJ_Location_ActiveComponent_First	AS ol	ON o.ObjectID = ol.ObjectID
LEFT OUTER JOIN MFAHv_OBJ_Value_Current						AS ovc	ON o.ObjectID = ovc.ObjectID

LEFT OUTER JOIN ConXrefSets		AS cxs	ON o.ObjectID = cxs.ID aND cxs.TableID = 108

LEFT OUTER JOIN vgsrpUserSecHier_ObjInsurC_RO				AS s	ON o.DepartmentID = s.DepartmentID

--INNER JOIN ReportIDs AS r ON o.ObjectID = r.ID AND r.ReportGUID IN (@TMSReportID)

WHERE s.UserID = 1269
AND o.ObjectID = 110421

AND cxs.Displayed = 1 AND cxs.Active = 1


--SELECT * FROM ConXrefSets WHERE ID = 110421 AND TableID = 108