

--SELECT * FROM Departments WHERE MainTableID = 108


SELECT
DisplayName AS ConstituentName,
AlphaSort,

SUM(CurrentValue) AS CurrentValue,

--ISNULL(SUM(NotAssigned),0) AS NotAssigned,
ISNULL(SUM(EuropeMediterranean),0) AS EuropeMediterranean,
ISNULL(SUM(DecArtsCraftDesign),0) AS DecArtsCraftDesign,
ISNULL(SUM(BayouBend),0) AS BayouBend,
ISNULL(SUM(ModernContemporary),0) AS ModernContemporary,
--ISNULL(SUM(Antiquities),0) AS Antiquities,
ISNULL(SUM(PrintsDrawings),0) AS PrintsDrawings,
ISNULL(SUM(AmericanArt),0) AS AmericanArt,
ISNULL(SUM(Photography),0) AS Photography,
--ISNULL(SUM(HirschLibrary),0) AS HirschLibrary,
ISNULL(SUM(AsianArt),0) AS AsianArt,
--ISNULL(SUM(AfricanArt),0) AS AfricanArt,
--ISNULL(SUM(ArtOfTheAmericas),0) AS ArtOfTheAmericas,
--ISNULL(SUM(OceanicArt),0) AS OceanicArt,
--ISNULL(SUM(LearningInterpretation),0) AS LearningInterpretation,
ISNULL(SUM(Rienzi),0) AS Rienzi,
ISNULL(SUM(EuropeanBeck),0) AS EuropeanBeck,
--ISNULL(SUM(Archives),0) AS Archives,
--ISNULL(SUM(BuildingGrounds),0) AS BuildingGrounds,
--ISNULL(SUM(PowellLibrary),0) AS PowellLibrary,
--ISNULL(SUM(BayouBendMemorialRoom),0) AS BayouBendMemorialRoom,
--ISNULL(SUM(Director),0) AS Director,
--ISNULL(SUM(Membership),0) AS Membership,
--ISNULL(SUM(Development),0) AS Development,
--ISNULL(SUM(Conservation),0) AS Conservation,
--ISNULL(SUM(BlafferFoundation),0) AS BlafferFoundation,
--ISNULL(SUM(FinanceAdministration),0) AS FinanceAdministration,
ISNULL(SUM(FilmVideo),0) AS FilmVideo,
--ISNULL(SUM(Registration),0) AS Registration,
--ISNULL(SUM(AfricanArtGlassell),0) AS AfricanArtGlassell,
--ISNULL(SUM(AsianArtGlassell),0) AS AsianArtGlassell,
--ISNULL(SUM(AoAGlassell),0) AS AoAGlassell,
--ISNULL(SUM(GlassellSchool),0) AS GlassellSchool,
ISNULL(SUM(LatinAmerican),0) AS LatinAmerican,
--ISNULL(SUM(Exhibitons),0) AS Exhibitons,
--ISNULL(SUM(Crates),0) AS Crates,
--ISNULL(SUM(DoraMaar),0) AS DoraMaar,
ISNULL(SUM(IslamicArt),0) AS IslamicArt,
--ISNULL(SUM(ImageLibrary),0) AS ImageLibrary,
--ISNULL(SUM(BayouBendGardens),0) AS BayouBendGardens,
--ISNULL(SUM(Frames),0) AS Frames,
--ISNULL(SUM(Training),0) AS Training,
--ISNULL(SUM(Accessories),0) AS Accessories,
--ISNULL(SUM(ExhibitionPlanning),0) AS ExhibitionPlanning,
--ISNULL(SUM(Equipment),0) AS Equipment,
--ISNULL(SUM(NON-MFAH),0) AS NON-MFAH,

SUM(Donated) AS Donated,
SUM(Funded) AS Funded,
SUM(CountOfObjects) AS TotalObjects,

CASE WHEN SUM(CountOfObjects)>= 20 THEN 1 ELSE 0 END	AS 'At Least 20',
CASE WHEN SUM(CountOfObjects)>= 12 THEN 1 ELSE 0 END	AS 'At Least 12',
CASE WHEN SUM(CountOfObjects)>= 10 THEN 1 ELSE 0 END	AS 'At Least 10',
CASE WHEN SUM(CountOfObjects)< 10 THEN 1 ELSE 0 END	AS 'Fewer Than 10'

FROM

(
	SELECT
	DisplayName,
	can_AlphaSort AS AlphaSort,
	SUM(Donated) AS Donated,
	SUM(Funded) AS Funded,
	CurrentValue,
	CountOfObjects,

--	[0]		AS	NotAssigned,	
	[1]		AS	EuropeMediterranean,
	[2]		AS	DecArtsCraftDesign,
	[3]		AS	BayouBend,
	[5]		AS	ModernContemporary,
--	[6]		AS	Antiquities,
	[9]		AS	PrintsDrawings,
	[10]		AS	AmericanArt,
	[11]		AS	Photography,
--	[12]		AS	HirschLibrary,
	[14]		AS	AsianArt,
--	[15]		AS	AfricanArt,
--	[16]		AS	ArtOfTheAmericas,
--	[17]		AS	OceanicArt,
--	[18]		AS	LearningInterpretation,
	[20]		AS	Rienzi,
	[22]		AS	EuropeanBeck,
--	[27]		AS	Archives,
--	[31]		AS	BuildingGrounds,	
--	[34]		AS	PowellLibrary,
--	[37]		AS	BayouBendMemorialRoom,
--	[39]		AS	Director,
--	[41]		AS	Membership,	
--	[42]		AS	Development,	
--	[67]		AS	Conservation,	
--	[68]		AS	BlafferFoundation,
--	[74]		AS	FinanceAdministration,	
	[102]	AS	FilmVideo,
--	[104]	AS	Registration,
--	[111]	AS	AfricanArtGlassell,
--	[112]	AS	AsianArtGlassell,
--	[113]	AS	AoAGlassell,
--	[114]	AS	GlassellSchool,
	[116]	AS	LatinAmerican,
--	[117]	AS	Exhibitons,
--	[119]	AS	Crates,
--	[120]	AS	DoraMaar,
	[121]	AS	IslamicArt
--	[122]	AS	ImageLibrary,
--	[123]	AS	BayouBendGardens,
--	[124]	AS	Frames,
--	[125]	AS	Training,
--	[126]	AS	Accessories,
--	[127]	AS	ExhibitionPlanning,
--	[166]	AS	Equipment,
--	[264]	AS	NON-MFAH

	FROM
	(
		SELECT 
		oc.DisplayName,
		oc.cx_RoleID,
		ISNULL(SUM(CASE	WHEN oc.cx_RoleID IN (2,16) THEN 1 ELSE 0 END),0) AS Donated,
		ISNULL(SUM(CASE	WHEN oc.cx_RoleID IN (14,24) THEN 1 ELSE 0 END),0) AS Funded,
		oc.can_AlphaSort,
		o.DepartmentID,
		ISNULL(COUNT(oc.o_ObjectID),0)	AS CountOfObjects,
		ISNULL(COUNT(oc.o_ObjectID),0)	AS ObjectCount,
		ISNULL(SUM(ov.Value),0)				AS CurrentValue

		FROM MFAHv_OBJ_Constituent										AS oc
		LEFT OUTER JOIN MFAHv_OBJ										AS o			ON oc.o_ObjectID = o.ObjectID
		LEFT OUTER JOIN MFAHv_OBJ_Maker_FirstDisplayed	AS omfd	ON oc.o_ObjectID = omfd.ObjectID
		LEFT OUTER JOIN MFAHv_OBJ_Value_Current				AS ov		ON o.ObjectID = ov.ObjectID

		WHERE o_ObjectID IN
		(
			SELECT o_ObjectID FROM MFAHv_OBJ_Constituent
			WHERE cx_RoleTypeID = 2			-- Acquisition Related
			AND cx_RoleID IN (2,16,14,24)		-- Donor, Donor(Anonymous), Funder, Funder(Anonymous)
		)
		AND o.DateBegin >= 1900
		AND o.ObjectStatusID = 2					-- Accessioned Object
		AND o.DepartmentID NOT IN (0,6,12,15,16,17,18,27,31,34,37,39,41,42,67,68,74,104,111,112,113,114,117,119,120,122,123,124,125,126,127,166,264)
		AND cx_RoleTypeID = 2						-- Acquisition Related
		AND cx_RoleID IN (2,16,14,24)			-- Donor, Donor(Anonymous), Funder, Funder(Anonymous)
		--AND oc.DisplayName = 'Alvin S. Romansky'

		GROUP BY
		oc.DisplayName,
		oc.can_AlphaSort,
		oc.cx_RoleID,
		o.DepartmentID
	) AS p

	PIVOT

	(
		SUM(ObjectCount)
		FOR DepartmentID IN
		(
--			[0],			-- NotAssigned
			[1],			-- EuropeMediterranean
			[2],			-- DecArtsCraftDesign
			[3],			-- BayouBend
			[5],			-- ModernContemporary
--			[6],			-- Antiquities
			[9],			-- PrintsDrawings
			[10],			-- AmericanArt
			[11],			-- Photography
--			[12],			-- HirschLibrary
			[14],			-- AsianArt
--			[15],			-- AfricanArt
--			[16],			-- ArtOfTheAmericas
--			[17],			-- OceanicArt
			[18],			-- LearningInterpretation
			[20],			-- Rienzi
			[22],			-- EuropeanBeck
			[27],			-- Archives
--			[31],			-- BuildingGrounds,
			[34],			-- PowellLibrary
			[37],			-- BayouBendMemorialRoom
			[39],			-- Director
--			[41],			-- Membership
--			[42],			-- Development
--			[67],			-- Conservation
			[68],			-- BlafferFoundation
--			[74],			-- FinanceAdminstration
			[102],		-- FilmVideo
--			[104],		-- Registration
--			[111],		-- AfricanArtGlassell
--			[112],		-- AsianArtGlassell
--			[113],		-- AoAGlassell
			[114],		-- GlassellSchool
			[116],		-- LatinAmerican
			[117],		-- Exhibitons
--			[119],		-- Crates
			[120],		-- DoraMaar
			[121],		-- IslamicArt
--			[122],		-- ImageLibrary
			[123]		-- BayouBendGardens
--			[124],		-- Frames
--			[125],		-- Training
--			[126],		-- Accessories
--			[127],		-- ExhibitionPlanning
--			[166],		-- Equipment
--			[264],		-- NON-MFAH
		)
	) AS pvt

GROUP BY DisplayName, can_AlphaSort, Donated, Funded, CurrentValue, CountOfObjects,
--			[0],			-- NotAssigned
			[1],			-- EuropeMediterranean
			[2],			-- DecArtsCraftDesign
			[3],			-- BayouBend
			[5],			-- ModernContemporary
--			[6],			-- Antiquities
			[9],			-- PrintsDrawings
			[10],			-- AmericanArt
			[11],			-- Photography
--			[12],			-- HirschLibrary
			[14],			-- AsianArt
--			[15],			-- AfricanArt
--			[16],			-- ArtOfTheAmericas
--			[17],			-- OceanicArt
			[18],			-- LearningInterpretation
			[20],			-- Rienzi
			[22],			-- EuropeanBeck
			[27],			-- Archives
--			[31],			-- BuildingGrounds,
			[34],			-- PowellLibrary
			[37],			-- BayouBendMemorialRoom
			[39],			-- Director
--			[41],			-- Membership
--			[42],			-- Development
--			[67],			-- Conservation
			[68],			-- BlafferFoundation
--			[74],			-- FinanceAdminstration
			[102],		-- FilmVideo
--			[104],		-- Registration
--			[111],		-- AfricanArtGlassell
--			[112],		-- AsianArtGlassell
--			[113],		-- AoAGlassell
			[114],		-- GlassellSchool
			[116],		-- LatinAmerican
			[117],		-- Exhibitons
--			[119],		-- Crates
			[120],		-- DoraMaar
			[121],		-- IslamicArt
--			[122],		-- ImageLibrary
			[123]		-- BayouBendGardens
--			[124],		-- Frames
--			[125],		-- Training
--			[126],		-- Accessories
--			[127],		-- ExhibitionPlanning
--			[166],		-- Equipment
--			[264],		-- NON-MFAH
) AS sq

GROUP BY DisplayName, AlphaSort

ORDER BY CurrentValue DESC, AlphaSort ASC




--SELECT * FROM Roles WHERE RoleTypeID = 2

--SELECT * FROM Departments WHERE MainTableID = 108






