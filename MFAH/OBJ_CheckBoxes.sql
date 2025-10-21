




SELECT
COUNT(*)	AS ObjectCount,
Accountability,
CuratorApproved

FROM Objects AS o

GROUP BY
Accountability,
CuratorApproved


SELECT ObjectID FROM Objects AS o WHERE Accountability = 1 OR CuratorApproved = 1



