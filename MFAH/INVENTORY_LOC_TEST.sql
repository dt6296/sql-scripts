	WHERE		i.department	IN	(SELECT item FROM dbo.siriusfn_SplitMultiValue(@Department,	','))
		AND		(i.department + i.category)		IN	(SELECT item FROM dbo.siriusfn_SplitMultiValue(@Category,	','))
		AND		i.vendor_1		IN	(SELECT item FROM dbo.siriusfn_SplitMultiValue(@Vendor,	','))
		AND		ISNULL(t.NetSale,0) != CASE WHEN @IncludeZeroSold = 'false' THEN 0 ELSE 999999999 END
		AND		ii.locatn_id IN (SELECT item FROM dbo.siriusfn_SplitMultiValue(@Location,	','))
		AND		ii.date_time BETWEEN @TransStart AND @TransEnd + ' 23:59:59.997'





SELECT

l.LocationString,
o.ObjectID,
o.SortNumber

FROM Locations AS l
INNER JOIN MFAHv_OBJ_Location AS ol ON l.LocationID = ol.CurLocationID
INNER JOIN ObjComponents AS oc ON ol.ComponentID = oc.ComponentID
INNER JOIN Objects AS o ON oc.ObjectID = o.ObjectID

WHERE l.Site IN (SELECT item FROM dbo.MFAHfx_SplitMultiValue('LAW BUILDING',','))
AND (l.Site + l.Room) IN (SELECT item FROM dbo.MFAHfx_SplitMultiValue('LAW BUILDING209M JONES GALLERIES,LAW BUILDING210M JONES GALLERIES',','))

ORDER BY l.LocationString


