

USE [TMS]
GO

/****** Object:  View [dbo].[MFAHv_LOAN_FF_Insurance]    Script Date: 7/21/2016 9:41:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[MFAHv_LOAN_FF_Insurance] 
AS

/*

MFAHv_LOAN_FF_Insurance
Custom MFAH View

Created		7/21/2016	Dave Thompson

*/

SELECT
li.ID								AS LoanID,
li.Lendertoselfinsure_140			AS LenderToSelfInsure,
li.Estimatedpremium_141				AS EstimatedPremium,
li.AcceptsMFAHinsurance_142			AS AcceptsMFAHInsurance,
li.Absoluteliabilityrequired_143	AS AbsoluteLiabilityRequired,
li.Terrorismonpremisesrequir_144	AS TerrorismOnPremisesRequired,
li.AcceptsUSGI_145					AS AcceptsUSGI

FROM vgsFF_2_18 AS li -- Loan Insurance

GO




USE [TMS]
GO

/****** Object:  View [dbo].[MFAHv_LOAN_FF_Fees]    Script Date: 7/21/2016 9:41:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[MFAHv_LOAN_FF_Fees] 
AS

/*

MFAHv_LOAN_FF_Fees
Custom MFAH View

Created		7/21/2016	Dave Thompson
						
*/

SELECT
lf.ID								AS LoanID,
lf.Loan_154							AS Loan,
lf.Crating_155						AS Crating,
lf.Mattingframing_156				AS MattingFraming,
lf.Conservation_157					AS Conservation,
lf.Reproduction_158					AS Reproduction,
lf.Complimentarycataloguesre_159	AS CompCatalogues

FROM vgsFF_2_20 AS lf -- Loan Fees

GO






USE [TMS]
GO

/****** Object:  View [dbo].[MFAHv_LOAN_FF_Courier]    Script Date: 7/21/2016 9:41:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[MFAHv_LOAN_FF_Courier] 
AS

/*

MFAHv_LOAN_FF_Courier
Custom MFAH View

Created		7/21/2016	Dave Thompson
						
*/

SELECT
lc.ID								AS LoanID,
lc.Courierrequired_146				AS CourierRequired,
lc.Traveltype_147					AS TravelType,
lc.Travelexpense_148				AS TravelExpense,
lc.Perdiem_149						AS PerDiem,
lc.Numberofdays_150					AS NumberOfDays,
lc.Travelinsurance_151				AS TravelInsurance,
lc.Hotel_152						AS Hotel,
lc.Otherrequirements_153			AS OtherRequirements

FROM vgsFF_2_19 AS lc -- Loan Courier

GO


EXEC('GRANT SELECT ON MFAHv_LOAN_FF_Insurance TO TMSUsers')
GO

EXEC('GRANT SELECT ON MFAHv_LOAN_FF_Fees TO TMSUsers')
GO

EXEC('GRANT SELECT ON MFAHv_LOAN_FF_Courier TO TMSUsers')
GO




USE [TMS]
GO

/****** Object:  View [dbo].[MFAHv_EXH_OBJ_FF_OGNExpenses]    Script Date: 7/28/2016 1:13:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[MFAHv_EXH_OBJ_FF_OGNExpenses] 
AS

/*

MFAHv_EXH_OBJ_FF_OGNExpenses
Custom MFAH View

Created		7/28/2016	Dave Thompson
						
*/

SELECT
ogn.ID								AS ObjectID,
CAST(ogn.ShippingIncoming_175 AS NUMERIC(18,2))			AS ShippingIncoming,
CAST(ogn.ShippingReturn_176 AS NUMERIC(18,2))			AS ShippingReturn,
CAST(ogn.Framing_177 AS NUMERIC(18,2))					AS Framing,
CAST(ogn.Other_178 AS NUMERIC(18,2))					AS Other,
CAST(ogn.PurchasePrice_179 AS NUMERIC(18,2))			AS PurchasePrice,
CAST(ogn.OGNPurchasePrice_180 AS NUMERIC(18,2))			AS OGNPurchasePrice

FROM vgsFF_9_24 AS ogn -- OGN Expenses


GO

EXEC('GRANT SELECT ON MFAHv_EXH_OBJ_FF_OGNExpenses TO TMSUsers')
GO








---------------------------------------------------------------------------------------------------


USE [TMS]
GO

/****** Object:  View [dbo].[MFAHv_LOAN_FF_CourierTravel_Inbound]    Script Date: 7/21/2016 9:41:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[MFAHv_LOAN_FF_CourierTravel_Inbound]
AS

/*

MFAHv_LOAN_FF_CourierTravel_Inbound
Custom MFAH View

Created		8/12/2016	Dave Thompson
						
*/

SELECT
'Inbound'									AS CourierType,
lc.ID										AS LoanID,
lc.Traveltype_184							AS TravelType,
CAST(lc.Travelexpense_185 AS NUMERIC(18,2))	AS TravelExpense,
lc.TravelInsurance_201						AS TravelInsurance

FROM vgsFF_2_27 AS lc -- Loan Courier Inbound

GO

EXEC('GRANT SELECT ON MFAHv_LOAN_FF_CourierTravel_Inbound TO TMSUsers')
GO







CREATE VIEW [dbo].[MFAHv_LOAN_FF_CourierTravel_Outbound]
AS

/*

MFAHv_LOAN_FF_CourierTravel_Outbound
Custom MFAH View

Created		8/12/2016	Dave Thompson
						
*/

SELECT
'Outbound'									AS CourierType,
lc.ID										AS LoanID,
lc.Traveltype_186							AS TravelType,
CAST(lc.Travelexpense_196 AS NUMERIC(18,2))	AS TravelExpense,
lc.TravelInsurance_204						AS TravelInsurance

FROM vgsFF_2_28 AS lc -- Loan Courier Outbound

GO

EXEC('GRANT SELECT ON MFAHv_LOAN_FF_CourierTravel_Outbound TO TMSUsers')
GO






CREATE VIEW [dbo].[MFAHv_LOAN_FF_CourierTravel_RoundTrip]
AS

/*

MFAHv_LOAN_FF_CourierTravel_RoundTrip
Custom MFAH View

Created		8/12/2016	Dave Thompson
						
*/

SELECT
'Outbound'									AS CourierType,
lc.ID										AS LoanID,
lc.TravelType_188							AS TravelType,
CAST(lc.TravelExpense_195 AS NUMERIC(18,2))	AS TravelExpense,
lc.TravelInsurance_205						AS TravelInsurance

FROM vgsFF_2_30 AS lc -- Loan Courier RoundTrip

GO

EXEC('GRANT SELECT ON MFAHv_LOAN_FF_CourierTravel_RoundTrip TO TMSUsers')
GO






CREATE VIEW [dbo].[MFAHv_LOAN_FF_CourierTravel_BetweenVenues]
AS

/*

MFAHv_LOAN_FF_CourierTravel_BetweenVenues
Custom MFAH View

Created		8/12/2016	Dave Thompson
						
*/

SELECT
'Outbound'									AS CourierType,
lc.ID										AS LoanID,
lc.TravelType_189							AS TravelType,
CAST(lc.TravelExpense_194 AS NUMERIC(18,2))	AS TravelExpense,
lc.TravelInsurance_199						AS TravelInsurance

FROM vgsFF_2_31 AS lc -- Loan Courier BetweenVenues

GO

EXEC('GRANT SELECT ON MFAHv_LOAN_FF_CourierTravel_BetweenVenues TO TMSUsers')
GO









CREATE VIEW [dbo].[MFAHv_LOAN_FF_CourierTravel_Installation]
AS

/*

MFAHv_LOAN_FF_CourierTravel_Installation
Custom MFAH View

Created		8/12/2016	Dave Thompson
						
*/

SELECT
'Outbound'									AS CourierType,
lc.ID										AS LoanID,
lc.TravelType_190							AS TravelType,
CAST(lc.TravelExpense_193 AS NUMERIC(18,2))	AS TravelExpense,
lc.TravelInsurance_202						AS TravelInsurance

FROM vgsFF_2_32 AS lc -- Loan Courier Installation

GO

EXEC('GRANT SELECT ON MFAHv_LOAN_FF_CourierTravel_Installation TO TMSUsers')
GO










CREATE VIEW [dbo].[MFAHv_LOAN_FF_CourierTravel_Deinstallation]
AS

/*

MFAHv_LOAN_FF_CourierTravel_Deinstallation
Custom MFAH View

Created		8/12/2016	Dave Thompson
						
*/

SELECT
'Outbound'									AS CourierType,
lc.ID										AS LoanID,
lc.TravelType_191							AS TravelType,
CAST(lc.TravelExpense_192 AS NUMERIC(18,2))	AS TravelExpense,
lc.TravelInsurance_200						AS TravelInsurance

FROM vgsFF_2_33 AS lc -- Loan Courier Deinstallation

GO

EXEC('GRANT SELECT ON MFAHv_LOAN_FF_CourierTravel_Deinstallation TO TMSUsers')
GO










CREATE VIEW [dbo].[MFAHv_LOAN_FF_CourierTravel_None]
AS

/*

MFAHv_LOAN_FF_CourierTravel_None
Custom MFAH View

Created		8/12/2016	Dave Thompson
						
*/

SELECT
'Outbound'									AS CourierType,
lc.ID										AS LoanID,
lc.TravelType_197							AS TravelType,
CAST(lc.TravelExpense_198 AS NUMERIC(18,2))	AS TravelExpense,
lc.TravelInsurance_203						AS TravelInsurance

FROM vgsFF_2_34 AS lc -- Loan Courier None

GO

EXEC('GRANT SELECT ON MFAHv_LOAN_FF_CourierTravel_None TO TMSUsers')
GO







USE [TMS]
GO

/****** Object:  View [dbo].[MFAHv_LOAN_FF_CourierExpenses]    Script Date: 7/21/2016 9:41:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[MFAHv_LOAN_FF_CourierExpenses] 
AS

/*

MFAHv_LOAN_FF_CourierExpenses
Custom MFAH View

Created		8/12/2016	Dave Thompson
						
*/

SELECT

ID												AS LoanID,
CAST(PerDiem_207 AS NUMERIC(18,2))				AS PerDiem,
CAST(GroundTransportation_211 AS NUMERIC(18,2))	AS GroundTransportation,
CAST(Hotel_206 AS NUMERIC(18,2))				AS Hotel,
CAST(NumberofNights_208 AS NUMERIC(18,2))		AS NumberOfNights,
OtherRequirements_209							AS OtherRequirements,
CAST(OtherExpenses_210 AS NUMERIC(18,2))		AS OtherExpenses

FROM vgsFF_2_36 AS lc -- Loan Courier Expenses

GO


EXEC('GRANT SELECT ON MFAHv_LOAN_FF_CourierExpenses TO TMSUsers')
GO









/****** Object:  View [dbo].[MFAHv_LOAN_OBJ_FF_Fees]    Script Date: 7/21/2016 9:41:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[MFAHv_LOAN_OBJ_FF_Fees] AS

/*

MFAHv_LOAN_OBJ_FF_Fees
Custom MFAH View

Created		8/12/2016	Dave Thompson
						
*/

SELECT

lo.LoanID,
lof.ID											AS LoanObjectID,
CAST(Loan_212 AS NUMERIC(18,2))					AS Loan,
CAST(Crating_213 AS NUMERIC(18,2))				AS Crating,
CAST(MattingandFraming_214 AS NUMERIC(18,2))	AS MatFrame,
CAST(Conservation_215 AS NUMERIC(18,2))			AS Conservation,
CAST(Reproduction_216 AS NUMERIC(18,2))			AS Reproduction

FROM vgsFF_29_37 AS lof -- Loan Object Fees
INNER JOIN MFAHv_LOAN_OBJ AS lo ON lof.ID = lo.LoanObjXrefID

GO


EXEC('GRANT SELECT ON MFAHv_LOAN_OBJ_FF_Fees TO TMSUsers')
GO







/****** Object:  View [dbo].[MFAHv_LOAN_OBJ_FF_Fees_SUM]    Script Date: 7/21/2016 9:41:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[MFAHv_LOAN_OBJ_FF_Fees_SUM] AS

/*

MFAHv_LOAN_OBJ_FF_Fees_SUM
Custom MFAH View

Created		8/12/2016	Dave Thompson
						
*/

SELECT

f.LoanID,
SUM(Loan)			AS Loan,
SUM(Crating)		AS Crating,
SUM(MatFrame)		AS MatFrame,
SUM(Conservation)	AS Conservation,
SUM(Reproduction)	AS Reproduction

FROM MFAHv_LOAN_OBJ_FF_Fees AS f

GROUP BY f.LoanID

GO


EXEC('GRANT SELECT ON MFAHv_LOAN_OBJ_FF_Fees_SUM TO TMSUsers')
GO
