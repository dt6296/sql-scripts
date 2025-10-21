

/*
This script copies security settings from a security user template to an actual TMS user.

EXEC CopyTMSUserSecurity @SourceUserID, @TargetUserID
*/


--1)	Run These two SELECT statements.

SELECT 'SourceUserID', * FROM Users WHERE Login = 'zGraphicsPublication'	-- SourceUserID
SELECT 'TargetUserID', * FROM Users WHERE Login = 'sdorris'		-- TargetUserID


--2)	Copy and pase the SourceUserID and TargetUserID into the EXEC statement below.
--3)	Execute the statement below.

/*
EXEC CopyTMSUserSecurity 2654,2744;
*/

--	The scripts below construct the above EXEC statement for a group of TMS users so that we don't have to do the
--	above for each TMS user individually.


SELECT * FROM SecurityGroups WHERE SecurityGroup = 'OA - General' -- SecurityGroupID = 110
SELECT * FROM Users WHERE SecurityGroupID = 110


-- Construct EXEC Statements

SELECT
'EXEC CopyTMSUserSecurity ' + CAST(s.UserID AS NVARCHAR(4)) + ',' + CAST(t.UserID AS NVARCHAR(4)) + ';' 

FROM (SELECT UserID FROM Users WHERE Login = 'zCuratorial') AS s
CROSS JOIN
(SELECT UserID FROM Users WHERE SecurityGroupID = (SELECT SecurityGroupID FROM Users WHERE Login = 'zCuratorial')) AS t
 
 WHERE s.UserID <> t.UserID

 /*

EXEC CopyTMSUserSecurity 2650,800;
EXEC CopyTMSUserSecurity 2650,1091;
EXEC CopyTMSUserSecurity 2650,1092;
EXEC CopyTMSUserSecurity 2650,1122;
EXEC CopyTMSUserSecurity 2650,1123;
EXEC CopyTMSUserSecurity 2650,1125;
EXEC CopyTMSUserSecurity 2650,1130;
EXEC CopyTMSUserSecurity 2650,1132;
EXEC CopyTMSUserSecurity 2650,1133;
EXEC CopyTMSUserSecurity 2650,1135;
EXEC CopyTMSUserSecurity 2650,1138;
EXEC CopyTMSUserSecurity 2650,1139;
EXEC CopyTMSUserSecurity 2650,1141;
EXEC CopyTMSUserSecurity 2650,1142;
EXEC CopyTMSUserSecurity 2650,1151;
EXEC CopyTMSUserSecurity 2650,1223;
EXEC CopyTMSUserSecurity 2650,1269;
EXEC CopyTMSUserSecurity 2650,1302;
EXEC CopyTMSUserSecurity 2650,1303;
EXEC CopyTMSUserSecurity 2650,1344;
EXEC CopyTMSUserSecurity 2650,1353;
EXEC CopyTMSUserSecurity 2650,1371;
EXEC CopyTMSUserSecurity 2650,1430;
EXEC CopyTMSUserSecurity 2650,1460;
EXEC CopyTMSUserSecurity 2650,1464;
EXEC CopyTMSUserSecurity 2650,1493;
EXEC CopyTMSUserSecurity 2650,1513;
EXEC CopyTMSUserSecurity 2650,1516;
EXEC CopyTMSUserSecurity 2650,1535;
EXEC CopyTMSUserSecurity 2650,1549;
EXEC CopyTMSUserSecurity 2650,1557;
EXEC CopyTMSUserSecurity 2650,1575;
EXEC CopyTMSUserSecurity 2650,1587;
EXEC CopyTMSUserSecurity 2650,1593;
EXEC CopyTMSUserSecurity 2650,2605;
EXEC CopyTMSUserSecurity 2650,2662;
EXEC CopyTMSUserSecurity 2650,2670;
EXEC CopyTMSUserSecurity 2650,2681;
EXEC CopyTMSUserSecurity 2650,2684;
EXEC CopyTMSUserSecurity 2650,2704;
EXEC CopyTMSUserSecurity 2650,2733;



*/


-- Update All User Security _______________________________________________________________________________________

SELECT * FROM UserFields WHERE ContextID = 40

SELECT
'EXEC CopyTMSUserSecurity ' + CAST(p.UserID AS NVARCHAR(4)) + ',' + CAST(u.UserID AS NVARCHAR(4)) + '; -- ' + ufxd.FieldValue + ' - ' +
	u.DisplayName + ', ' + ufxt.FieldValue + ' - ' + ufxs.FieldValue,
u.UserID,
u.Login,
u.DisplayName,
ufxs.FieldValue AS SecurityProfile,
p.UserID,
ufxd.FieldValue AS Department

FROM Users AS u
LEFT OUTER JOIN Constituents AS c ON u.ConstituentID = c.ConstituentID
LEFT OUTER JOIN UserFieldXrefs AS ufxs ON c.ConstituentID = ufxs.ID AND ufxs.UserFieldID = 323 -- Security Profile
LEFT OUTER JOIN UserFieldXrefs AS ufxd ON c.ConstituentID = ufxd.ID AND ufxd.UserFieldID = 322 -- Department
LEFT OUTER JOIN UserFieldXrefs AS ufxt ON c.ConstituentID = ufxt.ID AND ufxt.UserFieldID = 325 -- Job Title
INNER JOIN Users AS p ON ufxs.FieldValue = p.Login

WHERE u.IsDisabled = 0
AND ufxs.FieldValue IS NOT NULL

ORDER BY ufxd.FieldValue, u.DisplayName



/*

EXEC CopyTMSUserSecurity 2653,1108; -- Administration - Hoffheiser, Marlene, Executive Assistant/Projects Coordinator, Office of the Chief Operating Officer - zFullView
EXEC CopyTMSUserSecurity 2653,1104; -- Administration - Holmes, Willard, Chief Operating Officer - zFullView
EXEC CopyTMSUserSecurity 2653,1376; -- Administration - Ramirez, Carlotta, Museum Counsel - zFullView
EXEC CopyTMSUserSecurity 2653,1599; -- Administration - van Ekert, Aleksandra, Attorney Volunteer - zFullView
EXEC CopyTMSUserSecurity 2657,2623; -- Audio-Visual Services - Otis, Kirston, Audio-Visual Technician - zPublicView
EXEC CopyTMSUserSecurity 2657,557; -- Bayou Bend Collection and Gardens - Canup, Sue, Administrative Assistant, Facilities, Security and Gardens, Bayou Bend - zPublicView
EXEC CopyTMSUserSecurity 2648,1594; -- Bayou Bend Collection and Gardens - Coe, Leslie, Volunteer - zCataloguing
EXEC CopyTMSUserSecurity 2653,756; -- Bayou Bend Collection and Gardens - Fulda, Caryn, Assistant to the Director - zFullView
EXEC CopyTMSUserSecurity 2657,1596; -- Bayou Bend Collection and Gardens - Goicoechea, Mary Ann, Volunteer - zPublicView
EXEC CopyTMSUserSecurity 2657,1162; -- Bayou Bend Collection and Gardens - Hammond, Jennifer, Head of Education, Bayou Bend - zPublicView
EXEC CopyTMSUserSecurity 2657,2666; -- Bayou Bend Collection and Gardens - Hodges, Kristin, Programs Coordinator, Bayou Bend - zPublicView
EXEC CopyTMSUserSecurity 2657,1498; -- Bayou Bend Collection and Gardens - Masterson, Caitlin, Jameson Fellow - zPublicView
EXEC CopyTMSUserSecurity 2657,508; -- Bayou Bend Collection and Gardens - Milillo, Joey, Programs Manager, Bayou Bend - zPublicView
EXEC CopyTMSUserSecurity 2657,1499; -- Bayou Bend Collection and Gardens - Patterson, Meghan, Jameson Fellow - zPublicView
EXEC CopyTMSUserSecurity 2657,1456; -- Bayou Bend Collection and Gardens - Peele, Merritt, Docent Programs Manager, Bayou Bend - zPublicView
EXEC CopyTMSUserSecurity 2657,1384; -- Bayou Bend Collection and Gardens - Regelski, Christina, Education Department Intern - zPublicView
EXEC CopyTMSUserSecurity 2657,1595; -- Bayou Bend Collection and Gardens - Schatz, Susan, Volunteer - zPublicView
EXEC CopyTMSUserSecurity 2657,2628; -- Bayou Bend Collection and Gardens - Springer, Allison, Jameson Fellow - zPublicView
EXEC CopyTMSUserSecurity 2657,2643; -- Bayou Bend Collection and Gardens - Stivison, Emily, Research Fellow - zPublicView
EXEC CopyTMSUserSecurity 2657,1589; -- Bayou Bend Collection and Gardens - Walsh, Linda (BB volunteer 2017-2018), Volunteer - zPublicView
EXEC CopyTMSUserSecurity 2657,2629; -- Bayou Bend Collection and Gardens - Zhou, Eponine, Jameson Fellow - zPublicView
EXEC CopyTMSUserSecurity 2649,1212; -- Conservation - Bomford, David, Audrey Jones Beck Curator of European Art and Chairman, Department of Conservation - zConservation
EXEC CopyTMSUserSecurity 2649,1211; -- Conservation - Bomford, Zahira, Senior Conservator of Paintings - zConservation
EXEC CopyTMSUserSecurity 2649,1512; -- Conservation - Boyd, Trevor, Associate Conservator, Decorative Arts - zConservation
EXEC CopyTMSUserSecurity 2649,1565; -- Conservation - Burgess, Morgan, Intern - zConservation
EXEC CopyTMSUserSecurity 2649,2673; -- Conservation - Craven, James, Conservation Imaging Specialist - zConservation
EXEC CopyTMSUserSecurity 2649,1355; -- Conservation - Curran, Claire, Intern - zConservation
EXEC CopyTMSUserSecurity 2655,1046; -- Conservation - Estrada, Daniel, Senior Framing Technician - zHandling
EXEC CopyTMSUserSecurity 2649,1372; -- Conservation - Galvan, Jorge, Intern - zConservation
EXEC CopyTMSUserSecurity 2649,1089; -- Conservation - Gardner, Melissa, Associate Conservator of Paintings - zConservation
EXEC CopyTMSUserSecurity 2649,1080; -- Conservation - Gillies, Jane, Senior Conservator of Objects and Sculpture - zConservation
EXEC CopyTMSUserSecurity 2649,2680; -- Conservation - Knutas, Per, Head of Conservation - zConservation
EXEC CopyTMSUserSecurity 2649,1085; -- Conservation - Koseki, Toshi, Carol Crow Senior Conservator of Photographs - zConservation
EXEC CopyTMSUserSecurity 2649,1088; -- Conservation - Leal, Maite, Paintings Conservator - zConservation
EXEC CopyTMSUserSecurity 2649,2639; -- Conservation - McFarlin, Katherine, Pre-Program Intern - zConservation
EXEC CopyTMSUserSecurity 2655,1427; -- Conservation - Miller, Seth, On-Call Framing Technician - zHandling
EXEC CopyTMSUserSecurity 2649,1083; -- Conservation - Pine, Steve, Senior Conservator of Decorative Arts - zConservation
EXEC CopyTMSUserSecurity 2649,1078; -- Conservation - Reyes Garcia, Ivan, Assistant Conservator, Historic Frames - zConservation
EXEC CopyTMSUserSecurity 2649,1258; -- Conservation - Rogge, Corina, Andrew W. Mellon Research Scientist - zConservation
EXEC CopyTMSUserSecurity 2649,1077; -- Conservation - Samples, Bert, Senior Conservation Technician, Conservation - zConservation
EXEC CopyTMSUserSecurity 2649,1079; -- Conservation - Seyb, Ingrid, Associate Conservator, Objects and Sculpture - zConservation
EXEC CopyTMSUserSecurity 2649,1084; -- Conservation - Tan, Tina, Conservator, Works on Paper - zConservation
EXEC CopyTMSUserSecurity 2649,2640; -- Conservation - Vargas, Briana, Assistant to the Chairman, Department of Conservation - zConservation
EXEC CopyTMSUserSecurity 2649,1081; -- Conservation - Willis, Karen, Conservation Coordinator - zConservation
EXEC CopyTMSUserSecurity 2650,1430; -- Curatorial - Alejo, Adrian, Administrative Assistant, Photography - zCuratorial
EXEC CopyTMSUserSecurity 2650,1130; -- Curatorial - Aurisch, Helga, Curator, European Art - zCuratorial
EXEC CopyTMSUserSecurity 2648,2612; -- Curatorial - Ayers, Kendall (2018 intern), Intern - zCataloguing
EXEC CopyTMSUserSecurity 2650,1575; -- Curatorial - Bailey, Bradley, Ting Tsung and Wei Fong Chao Curator of Asian Art - zCuratorial
EXEC CopyTMSUserSecurity 2648,2617; -- Curatorial - Bench, Nathaniel (2018 intern), Intern - zCataloguing
EXEC CopyTMSUserSecurity 2650,1371; -- Curatorial - Brooks, Bradley, Curator, Bayou Bend Collection - zCuratorial
EXEC CopyTMSUserSecurity 2648,1254; -- Curatorial - Calvert, Craig, Volunteer - zCataloguing
EXEC CopyTMSUserSecurity 2648,1227; -- Curatorial - Carroll, Frank, Volunteer - zCataloguing
EXEC CopyTMSUserSecurity 2648,1368; -- Curatorial - Champion, Carmen, Intern - zCataloguing
EXEC CopyTMSUserSecurity 2650,1344; -- Curatorial - Chan, Beatrice, Curatorial Assistant, Asian Art - zCuratorial
EXEC CopyTMSUserSecurity 2648,2645; -- Curatorial - Chaouch, Maureen (volunteer, end 4/30/19), Research Volunteer - zCataloguing
EXEC CopyTMSUserSecurity 2650,1133; -- Curatorial - Clifton, James, Curator, Renaissance and Baroque Painting - zCuratorial
EXEC CopyTMSUserSecurity 2650,1303; -- Curatorial - Corstens, Josine, Curatorial Assistant - zCuratorial
EXEC CopyTMSUserSecurity 2648,2621; -- Curatorial - Cox, Diane (2018 intern/volunteer), Volunteer - zCataloguing
EXEC CopyTMSUserSecurity 2650,1099; -- Curatorial - Dacus, Chelsea, Assistant Curator, The Glassell Collections, Africa, Oceania, and the Americas - zCuratorial
EXEC CopyTMSUserSecurity 2648,2613; -- Curatorial - Dalton, Morgan (curatorial volunteer 2018), Volunteer - zCataloguing
EXEC CopyTMSUserSecurity 2650,1493; -- Curatorial - Daniel, Malcolm, Gus and Lyndall Wortham Curator, Department of Photography - zCuratorial
EXEC CopyTMSUserSecurity 2657,2675; -- Curatorial - Decker, Arden, Associate Director, ICAA - zPublicView
EXEC CopyTMSUserSecurity 2655,1044; -- Curatorial - Di Stefano, August, Framing Technician - zHandling
EXEC CopyTMSUserSecurity 2650,1140; -- Curatorial - Dibley, Jason, Collection Manager, Prints, Drawings, and Photographs - zCuratorial
EXEC CopyTMSUserSecurity 2648,1370; -- Curatorial - Doolin, Ann Marie, Volunteer - zCataloguing
EXEC CopyTMSUserSecurity 2648,2606; -- Curatorial - Dunn, William (2018 intern), Volunteer - zCataloguing
EXEC CopyTMSUserSecurity 2650,1137; -- Curatorial - Dyll, Remi, Curatorial and Programs Liaison, Bayou Bend - zCuratorial
EXEC CopyTMSUserSecurity 2650,1125; -- Curatorial - Edwards, Clifford, Administrative Assistant, American Paintings & Sculpture, and Prints & Drawings - zCuratorial
EXEC CopyTMSUserSecurity 2650,1557; -- Curatorial - Fletcher, Kanitra, Assistant Curator, Modern and Contemporary Art - zCuratorial
EXEC CopyTMSUserSecurity 2648,2619; -- Curatorial - Fredrickson, Emma (2018 intern), Intern - zCataloguing
EXEC CopyTMSUserSecurity 2650,1353; -- Curatorial - Froom, Aimée, Curator, Arts of the Islamic World - zCuratorial
EXEC CopyTMSUserSecurity 2650,1138; -- Curatorial - Gomez, Ray, Assistant for Community Outreach and Administration, Film and Video - zCuratorial
EXEC CopyTMSUserSecurity 2648,1448; -- Curatorial - Gonzales, Deborah, Curatorial Volunteer - zCataloguing
EXEC CopyTMSUserSecurity 2648,1435; -- Curatorial - Graveline, Laura, Camfield Fellow - zCataloguing
EXEC CopyTMSUserSecurity 2650,1091; -- Curatorial - Greene, Allison, Isabel Brown Wilson Curator, Department of Modern and Contemporary Art - zCuratorial
EXEC CopyTMSUserSecurity 2650,1092; -- Curatorial - Gutierrez, April, Curatorial Administrator - zCuratorial
EXEC CopyTMSUserSecurity 2648,1582; -- Curatorial - Harper, McKenna, Volunteer - zCataloguing
EXEC CopyTMSUserSecurity 2648,2678; -- Curatorial - Hawk, Maggie, Volunteer - zCataloguing
EXEC CopyTMSUserSecurity 2650,2670; -- Curatorial - Horne, Sarah, Curatorial Assistant, Decorative Arts, Craft and Design - zCuratorial
EXEC CopyTMSUserSecurity 2648,1420; -- Curatorial - Jacobs, Jamie, Volunteer Intern - zCataloguing
EXEC CopyTMSUserSecurity 2648,2604; -- Curatorial - Kayser, Cathie (2018 volunteer), Volunteer, Prints & Drawings - zCataloguing
EXEC CopyTMSUserSecurity 2650,2662; -- Curatorial - Koontz, Rex, Consulting Curator - zCuratorial
EXEC CopyTMSUserSecurity 2650,1549; -- Curatorial - Kubala, Taylor (ICAA/Dec Arts 2017,18 intern), Curatorial Fellow - zCuratorial
EXEC CopyTMSUserSecurity 2650,1445; -- Curatorial - Lamberti, Selina, Senior Cataloguer, Photography Collection - zCuratorial
EXEC CopyTMSUserSecurity 2650,2681; -- Curatorial - Lett, Amanda, Curatorial Assistant, American Painting and Sculpture - zCuratorial
EXEC CopyTMSUserSecurity 2657,2608; -- Curatorial - Linander, Cierra (L&I and Curatorial volunteer 2018), Intern - zPublicView
EXEC CopyTMSUserSecurity 2650,1135; -- Curatorial - Luntz, Marian, Curator, Film and Video - zCuratorial
EXEC CopyTMSUserSecurity 2657,1197; -- Curatorial - McGreger, Maria, Imaging and Web Content Specialist - zPublicView
EXEC CopyTMSUserSecurity 2657,1524; -- Curatorial - Ming, Guanpei, Administrative Volunteer - zPublicView
EXEC CopyTMSUserSecurity 2650,1587; -- Curatorial - Minton, Laura (2018 intern), Curatorial Assistant, Prints and Drawings - zCuratorial
EXEC CopyTMSUserSecurity 2650,1139; -- Curatorial - Mohl, Rachel, Assistant Curator, Latin American and Latino Art - zCuratorial
EXEC CopyTMSUserSecurity 2648,1360; -- Curatorial - Nakata, Nozomi, Volunteer - zCataloguing
EXEC CopyTMSUserSecurity 2648,2674; -- Curatorial - Packer, Michelle, Intern - zCataloguing
EXEC CopyTMSUserSecurity 2650,1464; -- Curatorial - Poster, Amy, Independent Curator and Art Consultant - zCuratorial
EXEC CopyTMSUserSecurity 2648,1443; -- Curatorial - Qian, Wenyi (Blaffer Volunteer), Intern, Sarah Campbell Blaffer Foundation - zCataloguing
EXEC CopyTMSUserSecurity 2650,1142; -- Curatorial - Ramirez, Mari Carmen, The Wortham Curator of Latin American Art and Director, International Center for the Arts of the Americas - zCuratorial
EXEC CopyTMSUserSecurity 2650,2605; -- Curatorial - Rayl, Marijana, Curatorial Assistant, Photography - zCuratorial
EXEC CopyTMSUserSecurity 2650,1460; -- Curatorial - Rendall, Madison, Administrative Assistant - zCuratorial
EXEC CopyTMSUserSecurity 2648,2622; -- Curatorial - Roppolo, Mary Margaret (2018 intern), Intern - zCataloguing
EXEC CopyTMSUserSecurity 2648,1563; -- Curatorial - Sawyer, Samantha, Volunteer - zCataloguing
EXEC CopyTMSUserSecurity 2648,2642; -- Curatorial - Schmudke, Agnesa, Volunteer - zCataloguing
EXEC CopyTMSUserSecurity 2648,2620; -- Curatorial - Schumann, Katherine (2018 intern), Intern - zCataloguing
EXEC CopyTMSUserSecurity 2650,1593; -- Curatorial - Sesana Grajales, Veronica, Curatorial Assistant, Latin American and Latino Art - zCuratorial
EXEC CopyTMSUserSecurity 2648,2627; -- Curatorial - Shan, Dan, Camfield Fellow - zCataloguing
EXEC CopyTMSUserSecurity 2657,1522; -- Curatorial - Shen, Katherine, Administrative Volunteer - zPublicView
EXEC CopyTMSUserSecurity 2648,2624; -- Curatorial - Simor, Eszter (2018 fellow), Film Fellow - zCataloguing
EXEC CopyTMSUserSecurity 2648,1426; -- Curatorial - Spadafora, Claire, Camfield Fellow - zCataloguing
EXEC CopyTMSUserSecurity 2650,1535; -- Curatorial - Squires, Margaret (Maggie) (volunteer 2018), Curatorial Assistant, Art of the Islamic Worlds - zCuratorial
EXEC CopyTMSUserSecurity 2650,1141; -- Curatorial - Stephenson, Tracy, Film Coordinator & Assistant Programmer - zCuratorial
EXEC CopyTMSUserSecurity 2650,1132; -- Curatorial - Strauss, Cindi, Sara and Bill Morgan Curator of Decorative Arts, Craft, and Design - zCuratorial
EXEC CopyTMSUserSecurity 2648,1604; -- Curatorial - Sung, Tracy (2018 intern), Intern - zCataloguing
EXEC CopyTMSUserSecurity 2648,1418; -- Curatorial - Sweeney, Kyle, Fellow - zCataloguing
EXEC CopyTMSUserSecurity 2650,1513; -- Curatorial - Timte, Julie, Administrative Assistant - zCuratorial
EXEC CopyTMSUserSecurity 2648,1416; -- Curatorial - Van Wingerden, Carolyn, Curatorial Fellow - zCataloguing
EXEC CopyTMSUserSecurity 2648,1097; -- Curatorial - Van Zoest, Bonnie, Latin American Art and ICAA Project Administrator - zCataloguing
EXEC CopyTMSUserSecurity 2650,1516; -- Curatorial - Volpe, Lisa, Associate Curator, Photography - zCuratorial
EXEC CopyTMSUserSecurity 2650,1251; -- Curatorial - Walker, Anna, Assistant Curator, Decorative Arts, Craft, and Design - zCuratorial
EXEC CopyTMSUserSecurity 2650,1151; -- Curatorial - Weber, Kaylin, Jeanie Kilroy Wilson Curator of American Painting and Sculpture - zCuratorial
EXEC CopyTMSUserSecurity 2657,793; -- Curatorial - Willour, Clint, (not assigned) - zPublicView
EXEC CopyTMSUserSecurity 2650,1122; -- Curatorial - Woodall, Dena, Associate Curator, Prints & Drawings - zCuratorial
EXEC CopyTMSUserSecurity 2648,1602; -- Curatorial - Xiaolei, Xie (volunteer 2018, Asian Art), Volunteer - zCataloguing
EXEC CopyTMSUserSecurity 2648,2671; -- Curatorial - Yeager, Holly, Volunteer Intern - zCataloguing
EXEC CopyTMSUserSecurity 2648,2665; -- Curatorial - Young, Joyce, Volunteer - zCataloguing
EXEC CopyTMSUserSecurity 2648,1367; -- Curatorial - Zavistovski, Katia, Mellon Director's Initiative Fellow - zCataloguing
EXEC CopyTMSUserSecurity 2648,2633; -- Curatorial - Ziebell, Zelda, Camfield Fellow - zCataloguing
EXEC CopyTMSUserSecurity 2651,1166; -- Design - Cochrane, Bill, Exhibition Designer - zDesign
EXEC CopyTMSUserSecurity 2651,1358; -- Design - Eby, Jack, Chief Exhibition Designer - zDesign
EXEC CopyTMSUserSecurity 2653,1525; -- Development - Blaschke, Christin, Development Associate, Curatorial Affairs - zFullView
EXEC CopyTMSUserSecurity 2653,2625; -- Development - Brown, Kathleen, Development Associate, Special Gifts and Corporate Relations - zFullView
EXEC CopyTMSUserSecurity 2653,1600; -- Development - Fersen, Elizabeth (temp 2018), Development Special Events Coordinator - zFullView
EXEC CopyTMSUserSecurity 2653,2661; -- Development - Flack, Kristen, Senior Development Officer - zFullView
EXEC CopyTMSUserSecurity 2653,1530; -- Development - Gallagher, Megan, Development Special Events Associate - zFullView
EXEC CopyTMSUserSecurity 2653,2626; -- Development - Gordon, Cecily, Development Associate, Curatorial Affairs - zFullView
EXEC CopyTMSUserSecurity 2653,787; -- Development - Greiner, Valerie, Senior Developemtn Officer, Special Gifts - zFullView
EXEC CopyTMSUserSecurity 2653,1189; -- Development - Largent, Tammy, Deputy Cheif Development Officer, Operations - zFullView
EXEC CopyTMSUserSecurity 2653,2638; -- Development - Netherton, Kathryn, Development Special Events Senior Coordinator - zFullView
EXEC CopyTMSUserSecurity 2653,1598; -- Development - Pelini, Kathryn, Development Special Events Senior Coordinator - zFullView
EXEC CopyTMSUserSecurity 2653,1187; -- Development - Powell, Lisa, Senior Development Officer, Grants and Development Communications - zFullView
EXEC CopyTMSUserSecurity 2653,1424; -- Development - Sepulveda, Lucas, Development Writer - zFullView
EXEC CopyTMSUserSecurity 2653,1183; -- Development - Shellenbergar, Dorie, Development Officer, Grants and Development Communications - zFullView
EXEC CopyTMSUserSecurity 2653,1259; -- Development - Skelton, Samantha, Foundation and Government Grants Writer - zFullView
EXEC CopyTMSUserSecurity 2653,1569; -- Development - Thrash, Meghan, Development Officer, Corporate Relations - zFullView
EXEC CopyTMSUserSecurity 2653,1373; -- Development - Verduzco, Michelle, Grants and Development Communications Coordinator - zFullView
EXEC CopyTMSUserSecurity 2652,1497; -- Exhibitions - Gonzalez, Briana, Administrative Assistant - zExhibitions
EXEC CopyTMSUserSecurity 2652,1527; -- Exhibitions - Guerrero, Marcelina, Exhibitions Coordinator - zExhibitions
EXEC CopyTMSUserSecurity 2650,1210; -- Exhibitions - Roldan, Deborah, Assistant Director, Exhibitions - zCuratorial
EXEC CopyTMSUserSecurity 2653,1270; -- Financial Operations - Anyah, Eric, Chief Financial Officer - zFullView
EXEC CopyTMSUserSecurity 2653,1109; -- Financial Operations - Schutza, Maggie, Executive Assistant, Investment and Finance - zFullView
EXEC CopyTMSUserSecurity 2653,1440; -- Financial Operations - Smith, Bradford, Senior Investment Analyst - zFullView
EXEC CopyTMSUserSecurity 2657,1562; -- Hirsch Library and Archives - Bogan, Katie, Library Assistant, Stack Management and Administration - zPublicView
EXEC CopyTMSUserSecurity 2657,1075; -- Hirsch Library and Archives - Culbertson, Margaret, Kitty King Powell Librarian - zPublicView
EXEC CopyTMSUserSecurity 2658,1333; -- Hirsch Library and Archives - Evans, Jon, Chief of Library & Archives - zRegistration
EXEC CopyTMSUserSecurity 2657,1262; -- Hirsch Library and Archives - Fromm, Terry, Volunteer - zPublicView
EXEC CopyTMSUserSecurity 2657,1332; -- Hirsch Library and Archives - Gesell, Sarah, Assistant Archivist - zPublicView
EXEC CopyTMSUserSecurity 2657,1324; -- Hirsch Library and Archives - Johnson, Michelle, Project Manager, William J. Hill Artisans & Artists Archive, Bayou Bend - zPublicView
EXEC CopyTMSUserSecurity 2657,1120; -- Hirsch Library and Archives - Lueders, Helen, Library Assistant, Bayou Bend - zPublicView
EXEC CopyTMSUserSecurity 2657,1588; -- Hirsch Library and Archives - Madden, Carolann, Project Assistant - zPublicView
EXEC CopyTMSUserSecurity 2657,2630; -- Hirsch Library and Archives - Meyer, Stratton (temp admin 2018), Temporary Archives Assistant - zPublicView
EXEC CopyTMSUserSecurity 2657,1560; -- Hirsch Library and Archives - O'Quinn, Shannon, Library Assistant - zPublicView
EXEC CopyTMSUserSecurity 2657,1209; -- Hirsch Library and Archives - Park, Sunyoung, Catalog Librarian - zPublicView
EXEC CopyTMSUserSecurity 2657,1064; -- Hirsch Library and Archives - Pelanne, Joel, Assistant Technical Services Librarian - zPublicView
EXEC CopyTMSUserSecurity 2657,1444; -- Hirsch Library and Archives - Rahuba, Leslie, Project Associate, William J. Hill Texas Artisans & Artists Archive, Bayou Bend - zPublicView
EXEC CopyTMSUserSecurity 2657,1072; -- Hirsch Library and Archives - Sandberg, Diane, Cataloging Assistant - zPublicView
EXEC CopyTMSUserSecurity 2657,2676; -- Hirsch Library and Archives - Stanhope, Sarah, Managing Catalog Librarian - zPublicView
EXEC CopyTMSUserSecurity 2657,1265; -- Hirsch Library and Archives - Stewart, Whitney, Jameson Fellow - zPublicView
EXEC CopyTMSUserSecurity 2657,1441; -- Hirsch Library and Archives - Teich, Jamie, Library Assistant, Acquisitions - zPublicView
EXEC CopyTMSUserSecurity 2657,1289; -- Hirsch Library and Archives - Valdez, Jason, Library Assistant, Serials and Reference - zPublicView
EXEC CopyTMSUserSecurity 2657,1066; -- Hirsch Library and Archives - Wexler, Lynn, Reference Librarian - zPublicView
EXEC CopyTMSUserSecurity 2657,2631; -- Hirsch Library and Archives - Wise, Marie, Managing Archivist - zPublicView
EXEC CopyTMSUserSecurity 2657,2647; -- Human Resources and Volunteers - Thomas, Alexandria, Volunteer Services and Organization Engagement Manager - zPublicView
EXEC CopyTMSUserSecurity 2657,2646; -- Information Technology - Abanto, Greg, Network Security Manager - zPublicView
EXEC CopyTMSUserSecurity 2657,1005; -- Information Technology - Aremband, Jill, Senior Information Technology Administrator - zPublicView
EXEC CopyTMSUserSecurity 2657,1257; -- Information Technology - Diaz, Albert, Support Center Technician - zPublicView
EXEC CopyTMSUserSecurity 2653,1601; -- Information Technology - Haines, Zachary, Chief Technology Officer - zFullView
EXEC CopyTMSUserSecurity 2657,1030; -- Information Technology - Howell, Tom, Senior Infrastructure and Technical Services Manager - zPublicView
EXEC CopyTMSUserSecurity 2657,1016; -- Information Technology - Knickerbocker, David, Senior Support Center Technician - zPublicView
EXEC CopyTMSUserSecurity 2657,1031; -- Information Technology - Luu, Tim, Network Operations Administrator - zPublicView
EXEC CopyTMSUserSecurity 2657,669; -- Information Technology - McClure, Tausheli, Network Communications Specialist - zPublicView
EXEC CopyTMSUserSecurity 2657,729; -- Information Technology - Parks, Phil, Project Manager - zPublicView
EXEC CopyTMSUserSecurity 2657,373; -- Information Technology - Pierce, Christina, Purchasing and Inventory Manager - zPublicView
EXEC CopyTMSUserSecurity 2657,561; -- Information Technology - Stone, Edith, IT Software Trainer - zPublicView
EXEC CopyTMSUserSecurity 2657,1573; -- Learning and Interpretation - Barrios, Maria del Carmen, Post-Graduate Interpretive Fellow - zPublicView
EXEC CopyTMSUserSecurity 2657,1153; -- Learning and Interpretation - Beradino, Jennifer, Senior Manager, Object-based Learning - zPublicView
EXEC CopyTMSUserSecurity 2657,1409; -- Learning and Interpretation - Blanton, Anthony, Volunteer - zPublicView
EXEC CopyTMSUserSecurity 2657,1533; -- Learning and Interpretation - Braziel, Rebecca, Teaching Artist - zPublicView
EXEC CopyTMSUserSecurity 2657,1510; -- Learning and Interpretation - Ceniceros, Tracey (intern 2018), Learning & Interpretation Fellow - zPublicView
EXEC CopyTMSUserSecurity 2657,2637; -- Learning and Interpretation - Dodge, Linda, Speakers Bureau Volunteer - zPublicView
EXEC CopyTMSUserSecurity 2657,1555; -- Learning and Interpretation - East, Linda, Lectures and Concerts Assistant - zPublicView
EXEC CopyTMSUserSecurity 2657,1523; -- Learning and Interpretation - Forbes, Mary (FY 19 volunteer), Volunteer - zPublicView
EXEC CopyTMSUserSecurity 2657,1521; -- Learning and Interpretation - Gipson, Imaria, Volunteer - zPublicView
EXEC CopyTMSUserSecurity 2657,1378; -- Learning and Interpretation - Goeser, Caroline, W. T. and Louise J. Moran Chair of the Department of Learning and Interpretation - zPublicView
EXEC CopyTMSUserSecurity 2657,1362; -- Learning and Interpretation - Gonzalez, Denise, Intergenerational Learning Specialist - zPublicView
EXEC CopyTMSUserSecurity 2657,1438; -- Learning and Interpretation - Greve, Lauren, Object Based Learning Fellow - zPublicView
EXEC CopyTMSUserSecurity 2657,2634; -- Learning and Interpretation - Khim, Courtney, Mellon Undergraduate Curatorial Fellow - zPublicView
EXEC CopyTMSUserSecurity 2655,1472; -- Learning and Interpretation - Kreuzmann, Stephanie, Participatory Programs Specialist - zHandling
EXEC CopyTMSUserSecurity 2657,1374; -- Learning and Interpretation - Lee, Jhih-yin, Volunteer - zPublicView
EXEC CopyTMSUserSecurity 2657,1322; -- Learning and Interpretation - Magill, Kelley, University Programs Specialist - zPublicView
EXEC CopyTMSUserSecurity 2657,1508; -- Learning and Interpretation - McSwain, Hayley, Studio and Gallery Programs Assistant - zPublicView
EXEC CopyTMSUserSecurity 2657,1170; -- Learning and Interpretation - Mims, Margaret, Senior Manager, Lectures and Concerts, Senior Advisor to the Docents - zPublicView
EXEC CopyTMSUserSecurity 2657,1515; -- Learning and Interpretation - Rivera, Mayra, Object-based Learning Assistant - zPublicView
EXEC CopyTMSUserSecurity 2657,1296; -- Learning and Interpretation - Roath Garcia, Elizabeth, Studio and Gallery Programs Manager - zPublicView
EXEC CopyTMSUserSecurity 2657,2635; -- Learning and Interpretation - Sastry, Avani, Mellon Undergraduate Curatorial Fellow - zPublicView
EXEC CopyTMSUserSecurity 2657,1509; -- Learning and Interpretation - Shannon, Chelsea, Gallery Interpretation Specialist - zPublicView
EXEC CopyTMSUserSecurity 2657,2641; -- Learning and Interpretation - Srikureja, Karuna, Samuel H. Kress Interpretive Fellow - zPublicView
EXEC CopyTMSUserSecurity 2657,1175; -- Marketing and Communications - Haus, Mary, Head of Marketing and Communications - zPublicView
EXEC CopyTMSUserSecurity 2657,1176; -- Marketing and Communications - Laskosky, Kelly, Senior Editor, Marketing and Communications - zPublicView
EXEC CopyTMSUserSecurity 2657,2682; -- Marketing and Communications - Rhodes, Elizabeth, Interactive Marketing Associate - zPublicView
EXEC CopyTMSUserSecurity 2657,597; -- Membership and Guest Services - Benitez, Rebecca, Guest Services Assistant Manager - zPublicView
EXEC CopyTMSUserSecurity 2653,1095; -- Museum Management - Campbell, Bonnie, Director, Bayou Bend Collection and Gardens - zFullView
EXEC CopyTMSUserSecurity 2653,1103; -- Museum Management - Scheuer, Winifred, Executive Administrator and Liaison for External Relations - zFullView
EXEC CopyTMSUserSecurity 2653,1442; -- Museum Management - Strauss, Gwen, Director, Brown Foundation Fellows Program, Dora Maar - zFullView
EXEC CopyTMSUserSecurity 2653,1107; -- Museum Management - Tinterow, Gary, Director - zFullView
EXEC CopyTMSUserSecurity 2655,1048; -- Perparations - Beasley, Ken, Senior Preparator - zHandling
EXEC CopyTMSUserSecurity 2655,1049; -- Perparations - Benson, Dale, Chief Preparator - zHandling
EXEC CopyTMSUserSecurity 2655,1051; -- Perparations - Cowart, Joseph, Associate Preparator - zHandling
EXEC CopyTMSUserSecurity 2655,1052; -- Perparations - Crowder, Michael, Associate Preparator - zHandling
EXEC CopyTMSUserSecurity 2655,1280; -- Perparations - Escoto, Juan, Preparator - zHandling
EXEC CopyTMSUserSecurity 2655,1053; -- Perparations - Gannon, Curtis, Associate Preparator, Collections - zHandling
EXEC CopyTMSUserSecurity 2655,1054; -- Perparations - Hinson, Richard, Senior Preparator, Collections - zHandling
EXEC CopyTMSUserSecurity 2655,1055; -- Perparations - Huron, Christopher, Associate Preparator - zHandling
EXEC CopyTMSUserSecurity 2655,2610; -- Perparations - Johnson, Jeremy, Preparator - zHandling
EXEC CopyTMSUserSecurity 2655,1056; -- Perparations - Kennaugh, Michael, Senior Preparator/Administrator - zHandling
EXEC CopyTMSUserSecurity 2655,1490; -- Perparations - Kimberly, Robert, Associate Preparator - zHandling
EXEC CopyTMSUserSecurity 2655,1100; -- Perparations - Storrs, Jason, Associate Preparator - zHandling
EXEC CopyTMSUserSecurity 2655,1060; -- Perparations - Trahan, Frances, Mountmaker - zHandling
EXEC CopyTMSUserSecurity 2656,1042; -- Photographic and Imaging Services - DuBrock, Tom, Senior Collection Photographer - zImagingServices
EXEC CopyTMSUserSecurity 2656,1043; -- Photographic and Imaging Services - Michels, Will, Collection Photographer - zImagingServices
EXEC CopyTMSUserSecurity 2656,1379; -- Photographic and Imaging Services - O'Dell, Cynthia, Image Projects & Rights Coordinator - zImagingServices
EXEC CopyTMSUserSecurity 2657,1529; -- Photographic and Imaging Services - Perez, Ray (PISD Volunteer 2019), Volunteer - zPublicView
EXEC CopyTMSUserSecurity 2656,1381; -- Photographic and Imaging Services - Rodriguez, Shelby, Imaging Services Associate - zImagingServices
EXEC CopyTMSUserSecurity 2656,1038; -- Photographic and Imaging Services - Sanchez, Albert, Digital Imaging Specialist - zImagingServices
EXEC CopyTMSUserSecurity 2657,1564; -- Photographic and Imaging Services - Serna, Karina (PISD volunteer), Volunteer - zPublicView
EXEC CopyTMSUserSecurity 2656,1033; -- Photographic and Imaging Services - Stein, Marty, Photographic and Imaging Services Manager - zImagingServices
EXEC CopyTMSUserSecurity 2657,1406; -- Publications and Graphics - Brand, Heather, Head of Publications - zPublicView
EXEC CopyTMSUserSecurity 2654,1275; -- Publications and Graphics - Dugan, Michelle, Associate Editor - zGraphicsPublication
EXEC CopyTMSUserSecurity 2654,1202; -- Publications and Graphics - Finley-Smiley, Phenon, Manager of Graphics - zGraphicsPublication
EXEC CopyTMSUserSecurity 2654,218; -- Publications and Graphics - Manca, Christine, Senior Editor - zGraphicsPublication
EXEC CopyTMSUserSecurity 2654,1182; -- Publications and Graphics - Schultz, Kem, Editorial Assistant - zGraphicsPublication
EXEC CopyTMSUserSecurity 2654,2660; -- Publications and Graphics - Smith, Megan, Senior Editor - zGraphicsPublication
EXEC CopyTMSUserSecurity 2648,1068; -- Registration - Angulo, Liz, Volunteer - zCataloguing
EXEC CopyTMSUserSecurity 2658,1018; -- Registration - Bakke, Julie, Chief Registrar - zRegistration
EXEC CopyTMSUserSecurity 2658,1572; -- Registration - Cameron, Emma, Assistant Registrar, Collections - zRegistration
EXEC CopyTMSUserSecurity 2657,1214; -- Registration - Carmona, Minerva, Administrative Assistant, Registrar - zPublicView
EXEC CopyTMSUserSecurity 2658,1019; -- Registration - Crain, Kathleen, Exhibitions Registrar - zRegistration
EXEC CopyTMSUserSecurity 2658,1025; -- Registration - Levy, Jennifer, Senior Assistant Registrar, Outgoing Loans - zRegistration
EXEC CopyTMSUserSecurity 2658,1538; -- Registration - Link, Emily, Assistant Registrar, Exhibitions - zRegistration
EXEC CopyTMSUserSecurity 2658,1020; -- Registration - Obsta, John, Associate Registrar, Exhibitions - zRegistration
EXEC CopyTMSUserSecurity 2658,1286; -- Registration - Pashko, Kim, Collections Registrar - zRegistration
EXEC CopyTMSUserSecurity 2648,1069; -- Registration - Rath, Kay (Registrar Volunteer), Volunteer - zCataloguing
EXEC CopyTMSUserSecurity 2658,1331; -- Registration - Rice, Kacie, Assistant Registrar, Incoming Loans - zRegistration
EXEC CopyTMSUserSecurity 2658,1511; -- Registration - Schaeffer, Flora, Assistant Registrar, Incoming Loans - zRegistration
EXEC CopyTMSUserSecurity 2658,2632; -- Registration - Vidal, Monica, Sr. Assistant Registrar, Exhibitions - zRegistration
EXEC CopyTMSUserSecurity 2658,1024; -- Registration - Wilhelm, Linda, Associate Registrar, Collections - zRegistration
EXEC CopyTMSUserSecurity 2648,1281; -- Registration - Williams, Ann, Volunteer - zCataloguing
EXEC CopyTMSUserSecurity 2657,2644; -- Retail Operations - Card, Charlott, Merchandising Manager, Books - zPublicView
EXEC CopyTMSUserSecurity 2657,1400; -- Retail Operations - Goins, Christine, General Manager of Retail - zPublicView
EXEC CopyTMSUserSecurity 2650,1302; -- Rienzi and the Masterson Collection - Flores, Misty, Curatorial Assistant, Rienzi - zCuratorial
EXEC CopyTMSUserSecurity 2650,1123; -- Rienzi and the Masterson Collection - Gervais, Christine, Director, Rienzi and Curator, Decorative Arts - zCuratorial
EXEC CopyTMSUserSecurity 2657,1471; -- Rienzi and the Masterson Collection - Hernandez, Ryan, Learning and Interpretation Coordinator, Rienzi - zPublicView
EXEC CopyTMSUserSecurity 2657,1223; -- Rienzi and the Masterson Collection - Marshall, Janet, Administrative Assistant, Rienzi - zPublicView
EXEC CopyTMSUserSecurity 2657,1261; -- Rienzi and the Masterson Collection - Niemeyer, Stephanie, Manager of Learning and Interpretation, Rienzi - zPublicView
EXEC CopyTMSUserSecurity 2657,1327; -- Rienzi and the Masterson Collection - Pignuolo, Kristen, Rienzi Education Intern - zPublicView
EXEC CopyTMSUserSecurity 2657,690; -- The Glassell School of Art - Cronin, Jenny, Associate Director - zPublicView
EXEC CopyTMSUserSecurity 2657,2607; -- The Glassell School of Art - Gershon, Peter, Core Residency Program Coordinator - zPublicView
EXEC CopyTMSUserSecurity 2657,210; -- The Glassell School of Art - Leclere, Mary, Associate Director, Core Residency Program - zPublicView
EXEC CopyTMSUserSecurity 2657,2683; -- The Glassell School of Art - Lina, Leonardo, Core Fellow - zPublicView
EXEC CopyTMSUserSecurity 2657,514; -- The Glassell School of Art - Manns, Suzanne, Instructor - zPublicView


*/