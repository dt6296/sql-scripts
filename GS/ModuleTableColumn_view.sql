

/*


--select * from INFORMATION_SCHEMA.TABLES where TABLE_TYPE = 'BASE TABLE' order by TABLE_NAME

--select * from DDTables order by TableName


select distinct m.ModuleID, m.MainTableID, t.TableName as ModuleName
from DDModules as m
inner join DDTables as t on m.MainTableID = t.PhysTableID


select distinct PhysTableID, TableName, * from DDTables as t order by t.TableName



select distinct t.PhysTableID, t.TableName, c. ColumnID, c.ColumnName, c.PhysTableID, c.[Type], c.[Length], c.Nullable
from DDColumns as c
inner join DDTables as t on c.PhysTableID = t.PhysTableID





FROM SecurityGroups AS sg
LEFT OUTER JOIN SecGrpHierXref AS sghx ON sg.SecurityGroupID = sghx.SecurityGroupID

select 
m.MainTableID, t.TableName,
t.PhysTableID, t.TableName, 
c. ColumnID, c.ColumnName, c.PhysTableID, c.[Type], c.[Length], c.Nullable, c.[Description]

FROM SecurityGroups AS sg
LEFT OUTER JOIN SecGrpHierXref AS sghx ON sg.SecurityGroupID = sghx.SecurityGroupID
LEFT OUTER JOIN DDHierarchy AS h ON sghx.HierarchyID = h.HierarchyID
LEFT OUTER JOIN DDLocalHierNames AS lhn ON h.HierarchyID = lhn.HierarchyID
LEFT OUTER JOIN DDTables AS t ON h.TableID = t.TableID
LEFT OUTER JOIN	DDLocalTableNames AS ltn ON t.TableID = ltn.TableID
LEFT OUTER JOIN DDSecGrpXref AS sgx ON h.HierarchyID = sgx.HierarchyID AND sg.SecurityGroupID = sgx.SecurityGroupID
LEFT OUTER JOIN DDColumns AS c ON sgx.ColumnID = c.ColumnID
LEFT OUTER JOIN DDModules AS m ON t.ModuleType = m.ModuleID
LEFT OUTER JOIN DDLocalModuleNames AS lmn ON m.ModuleID = lmn.ModuleID
LEFT OUTER JOIN DDLocalColumnNames AS lcn ON c.ColumnID = lcn.ColumnID and lcn.LanguageID = 1





select distinct
 m.ModuleID,m.MainTableID
,mt.TableName as ModuleName
,t.PhysTableID,t.TableName,t.IsAuthorityTable
,c. ColumnID,c.ColumnName,c.[Type],c.[Length],c.Nullable,c.DefaultValue,c.[Description]

from DDModules as m
inner join DDTables as mt on m.MainTableID = mt.PhysTableID
inner join DDTables as t on mt.ModuleType = t.ModuleType
inner join DDColumns as c on c.PhysTableID = t.TableID 

where t.TableName = 'TextEntries'



select * from DDTables as t
where t.TableName = 'TextEntries'

select * from DDContexts

select * from DDTables where TableName in ('TextEntries','UserFieldXrefs')


select --x.*,
 x.ContextID
,x.Context
,x.ContextType
,x.[Description]
,x.ModuleID
,m.MainTableID
,mt.TableName
from DDContexts as x
inner join DDModules as m on x.ModuleID = m.ModuleID
inner join DDTables as mt on m.MainTableID = mt.PhysTableID



*/


select distinct
 m.ModuleID, m.*
,mt.TableName as ModuleName
,t.PhysTableID,t.TableName,t.IsAuthorityTable
,c. ColumnID,c.ColumnName,c.[Type],c.[Length],c.Nullable,c.DefaultValue,c.[Description]

from DDColumns as c -- 5554
left outer join DDTables as t on c.PhysTableID = t.PhysTableID -- 5578
left outer join DDModules as m on t.PhysTableID = m.MainTableID
left outer join DDTables as mt on m.MainTableID = mt.TableID 

--left outer join DDTables as mt on t.ModuleType = mt.ModuleType and t.TableID = mt.TableID -- 5787


where t.PhysTableID in
(
-- select distinct ',', PhysTableID, '--', TableName from DDTables

-- 	1	--	AccessionMethods
--,	2	--	AccountBalances
--,	3	--	AccountGroups
--,	4	--	Accounts
--,	5	--	AuditTrail
--,	7	--	CHINFieldMapping
--,	8	--	CHINImport
--,	10	--	Classifications
	11	--	ConAddress
,	12	--	ConAltNames
--,	16	--	ConDateEvents
,	17	--	ConDates
,	18	--	ConEMail
--,	19	--	Configuration
--,	20	--	ConGeoCodes
,	21	--	ConGeography
,	22	--	ConPhones
,	23	--	Constituents
--,	25	--	ConTypes
,	26	--	Crates
--,	28	--	Currencies
--,	29	--	DelObjAccession
--,	30	--	DelObjComponents
--,	31	--	DelObjContext
--,	32	--	DelObjConXrefs
--,	33	--	DelObjects
--,	34	--	DelObjGeography
--,	36	--	DelObjIncoming
--,	37	--	DelObjPrep
--,	38	--	DelObjTitles
--,	39	--	Departments
--,	40	--	DimensionTypes
--,	41	--	Entities
--,	43	--	ErrorLog
,	47	--	Exhibitions
,	48	--	ExhLoanXrefs
,	49	--	ExhObjXrefs
,	50	--	ExhVenObjXrefs
,	51	--	ExhVenuesXrefs
--,	52	--	FiscalYears
--,	53	--	FlagLabels
--,	54	--	FunctionKeys
--,	56	--	GeoCodes
--,	57	--	GroupTypes
--,	77	--	LineItemTypes
,	79	--	LoanObjXrefs
--,	80	--	LoanPurposes
,	81	--	Loans
,	82	--	LocApprovers
,	83	--	Locations
,	84	--	LocHandlers
,	85	--	LocPurposes
--,	88	--	LoginRecords
,	89	--	ObjAccession
,	94	--	ObjComponents
,	97	--	CondLineItems
,	98	--	ObjConservation
,	99	--	ObjContext
,	101	--	ObjDates
,	102	--	ObjDeaccession
,	103	--	ObjDeaccessionUse
--,	105	--	ObjectGroups
--,	106	--	ObjectLevels
,	107	--	Packages
,	108	--	Objects
--,	109	--	ObjectStatuses
--,	110	--	ObjectTypes
,	111	--	ObjGeography
,	114	--	ObjIncoming
--,	115	--	ObjIncPurposes
,	116	--	ObjInsurance
,	119	--	ObjLocations
,	122	--	PackageList
--,	124	--	ObjPrep
,	126	--	ObjRights
--,	127	--	ObjRightsTypes
,	134	--	ObjTitles
,	136	--	UserFieldXrefs
--,	141	--	QuickMoves
,	143	--	ReferenceMaster
--,	144	--	RefFormats
,	145	--	RefXRefs
--,	147	--	Reports
--,	149	--	Roles
--,	150	--	RoleTypes
--,	151	--	SalesTax
--,	152	--	SecurityGroups
--,	153	--	ShippingMethods
,	154	--	StatusFlags
--,	155	--	StorageFormats
--,	156	--	StorageMethods
--,	159	--	TermSearch
--,	161	--	TitleTypes
--,	164	--	TMSGroups
--,	165	--	SecurityGroupXref
--,	167	--	Transactions
--,	168	--	TransactionTypes
--,	169	--	TransCodes
--,	170	--	TransDistributions
--,	171	--	TransLineItems
--,	173	--	TransStatus
--,	174	--	UserAuthorityTypes
--,	175	--	UserAuthValues
--,	176	--	UserFields
--,	177	--	UserFieldValueAuthority
--,	178	--	UserSecurity
--,	186	--	ValuationPurposes
,	187	--	HistEvents
,	189	--	Sites
,	194	--	SiteGeography
,	196	--	CostDetails
--,	197	--	CostMethods
--,	198	--	HistGeoCodes
,	199	--	HistGeography
,	201	--	EventXrefs
--,	203	--	ObjCompStatuses
--,	205	--	ObjCompTypes
,	206	--	ObjectNames
--,	207	--	ObjectNameTypes
,	210	--	RefDates
,	215	--	SiteDates
,	218	--	SiteObjXrefs
--,	220	--	SiteStatuses
--,	276	--	DispositionMethods
--,	287	--	TermMaster
--,	288	--	Terms
,	294	--	ExhDates
--,	300	--	Queries
--,	301	--	QueryDetails
--,	302	--	QuerySorts
--,	303	--	QueryThesTerms
--,	304	--	AddressTypes
,	305	--	Associations
--,	306	--	Relationships
--,	309	--	StopWords
--,	310	--	AccountGroupTypes
--,	311	--	AccountTypes
,	317	--	AltNums
,	318	--	MediaMaster
--,	319	--	MediaExtensions
,	320	--	MediaFiles
,	321	--	MediaPaths
,	322	--	MediaRenditions
--,	323	--	MediaTypes
,	324	--	MediaXrefs
--,	325	--	Users
--,	326	--	TempTables
,	327	--	ConXrefs
,	330	--	TextEntries
--,	331	--	TextTypes
--,	332	--	TextStatuses
--,	333	--	Circulation
--,	334	--	MediaColorDepths
--,	335	--	MediaFormats
--,	336	--	MediaSizes
--,	337	--	MediaStatuses
,	338	--	DateEntries
--,	340	--	CirculationStatuses
,	341	--	ThesXrefs
--,	342	--	ThesXrefTypes
--,	344	--	LendingPurposes
,	345	--	Shipments
--,	347	--	ConveyanceTypes
,	348	--	ShipCompXrefs
,	350	--	ShipConveyances
,	352	--	ShipLoanXrefs
--,	353	--	ShipmentPurposes
--,	354	--	ShipmentStatuses
,	355	--	ShipmentSteps
--,	356	--	ShipmentTypes
,	357	--	ShipObjXrefs
,	359	--	ShipExhXrefs
--,	360	--	DDQueryGroups
--,	362	--	ThesaurusBases
--,	367	--	ShipCrateHiers
--,	368	--	ShipStepHiers
--,	374	--	MediaArchTypes
--,	375	--	SurveyTypes
--,	376	--	OverallConditions
--,	377	--	SurveyAttrTypes
--,	378	--	DDColumns
--,	379	--	DDConditions
--,	380	--	DDControls
--,	381	--	DDControlTypes
--,	382	--	DDDatabases
--,	383	--	DDForms
--,	384	--	DDHierarchy
--,	385	--	DDJoins
--,	386	--	DDLanguages
--,	387	--	DDLiterals
--,	388	--	DDLocalColumnNames
--,	389	--	DDLocalControls
--,	390	--	DDLocalHierNames
--,	391	--	DDLocalModuleNames
--,	392	--	DDLocalQGNames
--,	393	--	DDLocalTableNames
--,	394	--	DDModules
--,	395	--	DDQGColXrefs
--,	396	--	DDSecGrpXref
--,	397	--	DDTables
--,	408	--	SecGrpHierXref
--,	409	--	SecurityClasses
--,	424	--	DimensionElements
--,	425	--	DimensionMethods
--,	426	--	DimUnitTypes
--,	427	--	DimensionUnits
--,	428	--	DimElemTypeXrefs
,	429	--	DimItemElemXrefs
--,	430	--	Dimensions
--,	432	--	DDTriggers
--,	433	--	AssocParents
--,	434	--	DDColValues
--,	435	--	DDProjects
,	438	--	ExhVenLocXrefs
,	439	--	Associations
--,	440	--	DDLanguages
--,	442	--	Sources
--,	443	--	TermClasses
--,	444	--	TermMasterGeo
--,	445	--	TermSourceXrefs
--,	446	--	TermTypes
--,	447	--	TMTypeXrefDates
--,	448	--	TMTypeXrefs
--,	457	--	UDPanes
--,	461	--	InsurancePolicies
--,	462	--	InsuranceTypes
--,	463	--	InsurObjXrefs
--,	465	--	AddressFormats
,	466	--	Countries
--,	467	--	UDCtlTypePropXrefs
--,	470	--	UDCtls
--,	471	--	UDCtlTypes
--,	472	--	UDForms
--,	473	--	UDLocalCtlTypNames
--,	474	--	UDLocalFormNames
--,	475	--	UDLocalPropEnums
--,	476	--	UDLocalPropNames
--,	477	--	UDLocalPropValues
--,	478	--	UDProperties
--,	479	--	UDPropertyTypes
--,	480	--	UDPropValues
--,	481	--	DefaultSorts
--,	482	--	AltCharsetCodes
--,	484	--	BCLabelPatterns
--,	485	--	BCLabels
--,	486	--	BCReportHistory
--,	487	--	BCReports
--,	488	--	PluginMessages
--,	489	--	ZLocalResultFields
--,	490	--	ZLocalUseAttribs
--,	491	--	ZResultFields
--,	492	--	ObjPrefixes
--,	494	--	SiteGeoCodes
--,	495	--	TreatmentPriorities
--,	497	--	ListViewColumns
--,	498	--	ListViews
--,	499	--	ListViewLocalNames
--,	505	--	SiteTypes
--,	506	--	SiteClassifications
--,	507	--	DDStopWords
--,	508	--	DataViewQueries
--,	509	--	DataViews
--,	510	--	DataViewLocalNames
--,	511	--	Conditions
--,	517	--	RecordLocks
--,	519	--	CrateProjects
--,	520	--	LocalInfo
--,	521	--	CrateTypes
--,	522	--	AuthorityValues
--,	606	--	CurrentLogin
--,	607	--	DataViewContexts
--,	608	--	DataViewXSLFiles
--,	609	--	DataViewXSLText
--,	614	--	TermMasterDates
--,	615	--	TermMasterLevel
--,	617	--	Connectors
--,	618	--	TableBasedConfigSettings
--,	619	--	ColThesXrefTypes
,	620	--	ColThesXrefs
--,	622	--	UserModuleDefaults
--,	626	--	SecGroupXrefs
--,	627	--	UserXrefs
,	628	--	ConXrefSets
,	629	--	ShipmentGroups
--,	630	--	GroupDetails
,	631	--	AccessionLot
,	632	--	RegistrationSets
--,	638	--	DDColVTableXrefs
,	641	--	ConXrefDetails
--,	643	--	DDContexts
--,	644	--	UserFieldGroupWF
--,	645	--	UserFieldGroupXrefs
--,	646	--	UserFieldGroups
--,	647	--	UserAnonymityRights
--,	648	--	ActionProperties
--,	649	--	ActionPropertyValues
--,	650	--	Actions
--,	651	--	ActionXrefs
--,	652	--	InjectionPoints
--,	653	--	InjectionPointTypes
--,	664	--	LoanStatuses
--,	665	--	InsuranceResponsibilities
--,	666	--	IndemnityResponsibilities
,	667	--	ObjInsIndemResp
,	685	--	ExhObjLoanObjXrefs
--,	686	--	ReportGroups
--,	687	--	ReportGroupXrefs
--,	688	--	DDLOCALES
--,	690	--	DDLocalContextNames
--,	693	--	AlertNotifications
--,	695	--	DEExportConditions
--,	696	--	DEProcessors
--,	697	--	DEProcessorXrefs
--,	698	--	DEPropertyValues
--,	699	--	DERelationships
--,	700	--	DEScenarios
--,	701	--	DEScenarioXrefs
--,	702	--	DEUnitFields
--,	703	--	DEUnits
--,	704	--	DEUsedNameSpaces
--,	705	--	DEValueMappings
--,	706	--	DEValueMappingScenarios
--,	723	--	AuthorityTranslations
--,	727	--	FolderTypes
,	728	--	PackageFolders
,	729	--	ConDisplayBios
,	730	--	ClassificationXRefs
,	731	--	ExhibitionTitles
,	733	--	PackageFolderXrefs
--,	734	--	FileContent
--,	738	--	ActiveSessions
--,	739	--	BCReportActions
--,	740	--	BCReportTypes
--,	741	--	BCRepTypeActionXrefs
--,	742	--	BCUnits
--,	746	--	PluginErrorLog
--,	748	--	WACRControls
--,	749	--	WACRForms
--,	750	--	SemanticFileTypes
--,	752	--	FileProperties
,	753	--	EventSearchDates
--,	754	--	RecurrencePatterns
--,	756	--	EventTypes
--,	757	--	Edge
--,	758	--	AssociatedPackages
--,	763	--	UIViews
--,	764	--	DDModelTypeAvailProperties
--,	765	--	DDWidgetTypeAvailProperties
--,	766	--	DDModelTypes
--,	767	--	DDModelTypeWidgetTypeXrefs
--,	768	--	DDWidgetModels
--,	769	--	DDWidgetModelColumns
--,	770	--	ModelCompositions
--,	771	--	ModelCompoPropertyValues
--,	772	--	UIViewCompositions
--,	773	--	WidgetCompoPropertyValues
--,	774	--	ContextXrefs
--,	775	--	DDWidgetTypes
--,	777	--	DDPreferenceScopeFields
--,	778	--	DDPreferenceScopes
--,	779	--	DDPreferenceTypes
--,	780	--	ScopeValues
--,	781	--	UserPreferences
--,	782	--	DDWidgetModelPropValues
--,	783	--	ResolutionLogs
--,	784	--	IndexCache
--,	785	--	FTSOptions
--,	787	--	TermMasterThes
--,	788	--	ClassificationNotations
,	789	--	ThesAssociations
,	790	--	Projects
--,	791	--	ConservationEntities
,	792	--	ConservationReports
--,	793	--	DepartmentMapping
--,	794	--	EnvironmentalClassifications
--,	795	--	EnvironmentalRequirements
,	796	--	EnvironmentalReqXrefs
--,	798	--	LightSensitivityLevels
,	799	--	ProjectDates
,	800	--	ProjectItems
--,	801	--	ProjectItemStatuses
,	802	--	ProjectRelated
,	803	--	ConservationReportRelated
--,	804	--	ProjectStatuses
--,	805	--	ProjectTypes
--,	806	--	Tasks
--,	807	--	TaskXrefs
,	808	--	ConservationReportXrefs
--,	809	--	EnvironmentalReqTypes
--,	825	--	FTSQueries
--,	826	--	UserQueries
--,	830	--	DDContextImportedWidgetModels
--,	831	--	UserFieldDepartmentMapping
,	834	--	EnvironmentalReqExt
--,	835	--	DDProducts
--,	836	--	DDProductModuleXrefs
--,	837	--	DDNavigationConfig
,	839	--	PlaceCoordinates
,	840	--	CoordinateDirections
--,	841	--	ProductFTSQueryXrefs
--,	843	--	PhoneTypes
--,	844	--	EMailTypes
--,	845	--	DDContextWidModels
--,	849	--	AnnotationSnapshots
--,	850	--	AnnotationKeys
--,	851	--	ShapeLineStyles
--,	852	--	AnnotationColors
--,	853	--	Annotations
--,	854	--	LayerTextEntryXrefs
--,	855	--	Layers
--,	856	--	FormatMapping
--,	857	--	ShapeFormats
--,	858	--	ShapeTypes
--,	859	--	Shapes
--,	861	--	DDTableMapping
--,	862	--	ConservationReportTEF
--,	863	--	ProjectTEF
--,	864	--	MediaMasterTEF
--,	865	--	SiteTEF
--,	866	--	ReferenceMasterTEF
--,	867	--	ConservationEntityTEF
--,	868	--	Context_1
--,	869	--	Context_2
--,	870	--	Context_3
--,	871	--	Context_4
--,	872	--	Context_5
--,	873	--	Context_6
--,	874	--	Context_7
--,	875	--	Context_8
--,	876	--	Context_9
--,	877	--	Context_29
--,	878	--	Context_34
--,	879	--	Context_36
--,	880	--	Context_37
--,	881	--	Context_40
--,	882	--	Context_42
--,	883	--	Context_58
--,	884	--	Context_59
--,	885	--	Context_66
--,	886	--	Context_95
--,	887	--	FileDownloadHistory
,	888	--	ProjectSteps
--,	889	--	FileHistory
--,	890	--	WebReportMapping
--,	891	--	EnvironmentalMeasurements
,	892	--	EnvMeasureComponentXrefs
--,	893	--	ExhibitionStatuses
--,	894	--	ExhibitionObjStatuses
--,	895	--	LoanObjStatuses
--,	896	--	DDBatchConfigurations
--,	897	--	BatchProcesses
--,	898	--	BatchProcessItems
--,	901	--	DDGSIdentifiers
--,	902	--	GSIdentifierLinks
--,	903	--	ExceptionLogs
--,	904	--	FTSTaskLogs
--,	905	--	FTSTaskStatistics
--,	906	--	MediaProcessFailures
--,	907	--	TermSourceLanguages
--,	908	--	WebReportIDS
--,	909	--	ReportIDS
--,	910	--	ObjectTEF
--,	912	--	Context_146
--,	914	--	MediaViewTypes
--,	915	--	UserProductXrefs
--,	916	--	UserSessions
--,	918	--	Context_148
--,	920	--	Context_149
--,	922	--	Context_150
--,	923	--	ConstituentsTEF
--,	924	--	ExhibitionsTEF
--,	925	--	ExhObjXrefsTEF
--,	926	--	LoanObjXrefsTEF
--,	927	--	LoansTEF
--,	928	--	HistEventsTEF
--,	930	--	CertaintyLevels
--,	931	--	DownloadTemplates
--,	935	--	Context_192
--,	937	--	Context_193
--,	939	--	Context_194
--,	941	--	Context_195
--,	943	--	Context_196
--,	945	--	Context_197
--,	947	--	Context_198
--,	948	--	SiteNameTypes
--,	949	--	SiteNames
--,	950	--	ApplicationTasks
--,	951	--	TaskItems
--,	952	--	RecursionHistory
--,	953	--	RecursionExceptions
--,	954	--	AltNumDescriptions
--,	955	--	ScopeFieldValues
--,	956	--	UserPrefScopeFldValueXrefs
--,	958	--	Context_228
--,	969	--	FSFolderCache
--,	970	--	FSFileCache
--,	971	--	FSCacheMediaXrefs
--,	972	--	ServicesTimeOff
--,	977	--	Context_290
--,	988	--	DDHelpContexts
--,	989	--	DDLocalHelpContexts
--,	991	--	Context_313
--,	998	--	EdgeCN
--,	1001	--	Context_319
,	1002	--	ObjLocationHistory
--,	1003	--	MoveTransactions
--,	1004	--	CrateLocationHiers
--,	1006	--	DDApiProfiles
--,	1007	--	DDApiProfileModuleXrefs
--,	1008	--	TermMasterThesTEF
--,	1009	--	ConfigurationDependencies
--,	1010	--	AdvAuditTrail
--,	1011	--	AuthorityAuditTrail
--,	1012	--	AuditTrailProcessLog
--,	1013	--	AuditTrailProcesses
--,	1014	--	AdvAuditTrailConfiguration
--,	1015	--	AdvAuditTrailAuthConfig
--,	1016	--	UserTransactions
--,	1020	--	DDLicensedFeatures
--,	1021	--	DDFeatureProductXrefs
--,	1022	--	MediaImporterProfiles
--,	1023	--	MediaImporterProfileUserXrefs
--,	1024	--	MediaImporterProfileFormatXrefs
--,	1025	--	MediaImporterFields
--,	1026	--	MediaImporterProfileFieldXrefs
--,	1027	--	MediaImporterWorkingFolders
--,	5000	--	UFGroup_2
--,	5001	--	UFGroup_3
--,	5002	--	UFGroup_4
)


/*


select 
 x.ContextID
,x.ModuleID
,x.TableID
,x.Context
,x.ContextType
,x.[Description]
,x.[HierarchyID]
,t.TableName 
,h.TableID
,ht.TableName as Hierarchy
-- select * 

from DDContexts as x
inner join DDTables as t on x.TableID = t.TableID
inner join DDHierarchy as h on x.[HierarchyID] = h.[HierarchyID]
inner join DDTables as ht on h.TableID = ht.TableID

where ModuleID = 1

order by x.TableID

*/





