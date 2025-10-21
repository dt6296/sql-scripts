

--UPDATE SecGrpHierXref SET Viewable = 1, Addable = 0, Editable = 0, Deletable = 0
--(54692 row(s) affected)

--UPDATE DDSecGrpXref SET Editable = 0
--(571330 row(s) affected)


SELECT DISTINCT
ltn.TableID,
ltn.TableLabel,
t.TableName /*,
c.ColumnID,
c.ColumnName,

h.HierarchyID,
lhn.HierarchyLabel,
sghx.Viewable, sghx.Addable, sghx.Editable, sghx.Deletable,
sg.SecurityGroupID,
sg.SecurityGroup,
sgx.Viewable, sgx.Editable
*/

FROM DDLocalTableNames		AS ltn
INNER JOIN DDTables			AS t	ON	ltn.TableID = t.TableID
INNER JOIN DDColumns		AS c	ON	t.TableID = c.PhysTableID
INNER JOIN DDHierarchy		AS h	ON	t.TableID = h.TableID
INNER JOIN SecGrpHierXref	AS sghx	ON	h.HierarchyID = sghx.HierarchyID
INNER JOIN SecurityGroups	AS sg	ON	sghx.SecurityGroupID = sg.SecurityGroupID
INNER JOIN DDSecGrpXref		AS sgx	ON	sg.SecurityGroupID = sgx.SecurityGroupID
									AND	h.HierarchyID = sgx.HierarchyID
INNER JOIN DDLocalHierNames	AS lhn	ON	h.HierarchyID = lhn.HierarchyID

WHERE 
(lhn.LanguageID = 1 OR lhn.LanguageID IS NULL)
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











