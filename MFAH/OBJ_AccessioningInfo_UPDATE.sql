--	UPDATE OBJ_Accession Info


-- Create a package and find the PackageID

SELECT * FROM Packages WHERE Name = 'Wegman Videos'

SELECT * FROM PackageList WHERE PackageID = 325497

325497


--	Populate the Package with the records to be updated.

--INSERT INTO TMS.dbo.PackageList (PackageID, ID, MainData, OrderPos, LoginID, EnteredDate, Notes, TableID)

SELECT DISTINCT
325497										AS PackageID,
so.ObjectID									AS ID,
so.ObjectNumber								AS MainData,
ROW_NUMBER() OVER (ORDER BY so.SortNumber)	AS OrderPos,
'dthompson'									AS LoginID,
GETDATE()									AS EnteredDate,
NULL										AS Notes,
108											AS TableID

FROM
(
	SELECT DISTINCT
	o.ObjectID,
	o.ObjectNumber,
	o.SortNumber
	
	FROM Objects AS o
	
	WHERE o.ObjectID IN
	(
		146771,
		146772,
		146773,
		146774,
		146521,
		142297,
		142298,
		142299,
		142300,
		142301,
		142302,
		142303,
		142304,
		142305,
		142306,
		142307,
		142308,
		142309,
		142310,
		142311,
		142312,
		142313,
		146765,
		146766,
		146767,
		146768,
		146769,
		146759,
		146758,
		147834,
		147857,
		146522,
		146752,
		146754,
		148718,
		148719,
		148720,
		146523,
		146761,
		146760,
		146775,
		148703,
		147831,
		147832,
		147833,
		147847,
		147848,
		147849,
		147850,
		147851,
		147852,
		147853,
		147854,
		147855,
		147856,
		146524,
		146776,
		146777,
		147836,
		146778,
		146525,
		146757,
		147859,
		146779,
		146780,
		146781,
		146783,
		146784,
		147839,
		147842,
		146526,
		146763,
		146762,
		146785,
		146786,
		146901,
		146902,
		146904,
		146905,
		146906,
		147845,
		147843,
		147835,
		147844,
		147846,
		146907,
		146909,
		146910,
		146911,
		146953,
		146954,
		146980,
		146955,
		146956,
		146957,
		146958,
		146959,
		146960,
		146961,
		146962,
		146963,
		146964,
		146965,
		146966,
		146967,
		146968,
		146969,
		146970,
		146971,
		146972,
		146973,
		146974,
		146975,
		146976,
		146977,
		146978,
		148009,
		148010,
		148011,
		148012,
		148013,
		148014,
		148015,
		148016,
		148017,
		148018,
		146981,
		148019,
		148020,
		148021,
		148022,
		146997,
		148023,
		148024,
		148025,
		148026,
		148027,
		148028,
		148029,
		148030,
		148031,
		148032,
		148033,
		148034,
		148035,
		148036,
		148037,
		148038,
		146527,
		147361,
		147362,
		147363,
		147369,
		147370,
		147371,
		147372,
		147373,
		147374,
		147375,
		147376,
		147377,
		147378,
		147379,
		147380,
		147381,
		147382,
		147383,
		147384,
		147385,
		147386,
		147387,
		147417,
		147418,
		147419,
		147420,
		147421,
		146979,
		148306,
		148307,
		148308,
		148309,
		148310,
		148311,
		148312,
		148313,
		148314,
		148316,
		148317,
		148319,
		148320,
		148705,
		148706,
		148321,
		148322,
		148323,
		148325,
		148326,
		148327,
		148328,
		148329,
		148330,
		148331,
		148332,
		148334,
		148335,
		148339,
		148342,
		148343,
		148344,
		148707,
		148708,
		146916,
		146916,
		146952,
		146528,
		146529,
		146530,
		146531,
		146532,
		148346,
		146998,
		146533,
		146999,
		147209,
		147278,
		147279,
		147280,
		147281,
		147282,
		147283,
		147284,
		147285,
		147286,
		147287,
		147288,
		148347,
		147289,
		147293,
		147294,
		146770,
		147773,
		147736,
		147737,
		147738,
		147739,
		147740,
		147741,
		147742,
		147743,
		147744,
		147745,
		147746,
		147747,
		147748,
		147749,
		147750,
		147751,
		147752,
		147753,
		147754,
		147755,
		147756,
		147757,
		147758,
		147759,
		147760,
		147761,
		147762,
		147763,
		147764,
		147765,
		147766,
		147767,
		147768,
		147769,
		147770,
		147771,
		148348,
		148709,
		148710,
		148711,
		148712,
		148349,
		148713
	)
	--ORDER BY o.SortNumber	
) AS so




--	Find the data to be updated using the package list

SELECT 
oa.ObjectID,
oa.ApprovalISODate1,	--	Subcommittee Approval Date
oa.ApprovalISODate2,	--	Collections Committee Approval Date
oa.DeedOfGiftSentISO,
oa.DeedOfGiftReceivedISO,
oa.AccessionISODate,
oa.CurrPercentOwnership,
oa.AccessionMethodID

FROM ObjAccession AS oa 
INNER JOIN PackageList AS pl	ON oa.ObjectID = pl.ID 
								AND pl.TableID = 108
								AND pl.PackageID = 325497
WHERE pl.PackageID = 325497

SELECT
o.ObjectID,
o.ObjectStatusID, os.ObjectStatus,
o.CreditLine

FROM Objects AS o
INNER JOIN PackageList AS pl	ON o.ObjectID = pl.ID 
								AND pl.TableID = 108
								AND pl.PackageID = 325497
INNER JOIN ObjectStatuses AS os ON o.ObjectStatusID = os.ObjectStatusID
WHERE pl.PackageID = 325497

SELECT * FROM AccessionMethods


--	Update statements

--UPDATE ObjAccession  
SET 
ApprovalISODate1		= '2019-10-10',	--	Subcommittee Approval Date
ApprovalISODate2		= '2019-10-14',	--	Collections Committee Approval Date
AccessionISODate		= '2019-10-14',
DeedOfGiftSentISO		= '2019-09-13',
DeedOfGiftReceivedISO	= '2019-10-07'
--CurrPercentOwnership = 100.0,
--AccessionMethodID = 1
--select * 
FROM ObjAccession AS oa 
INNER JOIN PackageList AS pl	ON oa.ObjectID = pl.ID 
								AND pl.TableID = 108
								AND pl.PackageID = 325497

WHERE pl.PackageID = 325497
AND pl.ID <> 144659


--UPDATE Objects
SET
ObjectStatusID = 2,
CreditLine = 'Barbara Levine and Paige Ramey Collection, museum purchase funded by the Caroline Wiess Law Accessions Endowment Fund'

FROM Objects AS o
INNER JOIN PackageList AS pl	ON o.ObjectID = pl.ID 
								AND pl.TableID = 108
								AND pl.PackageID = 325497
INNER JOIN ObjectStatuses AS os ON o.ObjectStatusID = os.ObjectStatusID

WHERE pl.PackageID = 325497




