--SELECT * FROM SecGrpHierXref WHERE HierarchyID = 313108 AND SecurityGroupID = 73




SELECT DISTINCT 
sg.SecurityGroup,
--h.HierarchyID,
ltn.TableLabel /*,
c.ColumnName,
sghx.Viewable,
sghx.Addable,
sghx.Editable,
sghx.Deletable
*/


--UPDATE SecGrpHierXref SET Viewable = 1, Addable = 0, Editable = 0, Deletable = 0
--(58581 row(s) affected)

--UPDATE DDSecGrpXref SET Editable = 0
--(632088 row(s) affected)



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

WHERE 
	(lmn.LanguageID = 1 OR lmn.LanguageID IS NULL)
AND (lhn.LanguageID = 1 OR lhn.LanguageID IS NULL)
AND (ltn.LanguageID = 1 OR ltn.LanguageID IS NULL)

AND sg.SecurityGroupID = 73
--AND c.ColumnName = 'DepartmentID'



AND ltn.TableLabel IN --('Departments')
(
'Accession Methods',
'Account Groups',
'Accounts',
'Address Formats',
'Address Types',
'Annotation Colors',
'Authority Translations',
'Bibliography Formats',
'Certainty Levels',
'Circulation Statuses',
'Classifications',
'Column Thesaurus Xref Types',
'Conservation Activity Attribute Type',
'Conservation Activity Types',
'Constituent Geography Types',
'Constituent Types',
'Conveyance Types',
'Cost Methods',
'Currencies',
'DDLanguages',
'Departments',
'Dim. Secondary Units',
'Dim. Unit Types',
'Dimension Elements',
'Dimension Methods',
'Dimension Types',
'Dimension Units',
'Disposition Methods',
'Email Types',
'Environmental Classifications',
'Environmental Measurements of Components',
'EnvironmentalRequirementTypes',
'Event Geography Types',
'EventTypes',
'Exhibition Statuses',
'Fill Annotation Colors',
'Fiscal Years',
'Flex Fields',
'Incoming Shipping Methods',
'In-House Location',
'Insurance Policies',
'Insurance Types',
'Lending Purposes',
'Level',
'Light Exposure Info',
'Light Sensitivity Levels',
'Loan Purposes',
'Loan Statuses',
'Local Currencies',
'Location Purposes',
'Media Archival Types',
'Media Color Depths',
'Media Formats',
'Media Paths',
'Media Sizes',
'Media Statuses',
'Media Types',
'Media View Types',
'Object Component Statuses',
'Object Component Types',
'Object Geography Types',
'Object Incoming Purposes',
'Object Levels',
'Object Name Types',
'Object Rights Types',
'Object Statuses',
'Object Types',
'Overall Conditions',
'Period',
'Phone Types',
'Project Item Statuses',
'Project Statuses',
'Project Types',
'Related Transitive Records 1',
'Related Transitive Records 2',
'Relationships',
'Role Types',
'Roles',
'Sales Tax',
'Semantic File Types',
'Shape Line Styles',
'ShapeFormats',
'Shapes',
'ShapeTypes',
'Shipment Purposes',
'Shipment Statuses',
'Shipment Types',
'Shipping Methods',
'Site Classifications',
'Site Geography Types',
'Site Statuses',
'Site Types',
'Status Flag',
'Statuses-Active',
'Storage Formats',
'Storage Methods',
'Term Master',
'TermMasterDates',
'Terms',
'Text Statuses',
'Text Types',
'Thesaurus Term Master (Term Search)',
'Thesaurus Terms (Term Search)',
'Thesaurus Xref Types',
'Title Types',
'Transaction Line Item Types',
'Transaction Types',
'Treatment Priorities',
'Valuation Purpose'
)

