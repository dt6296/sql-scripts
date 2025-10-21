

--Dimitry sent these scripts to troubleshoot and fix the problem
--with that one object that kept returning a data integrity error when 
--navigating to it.

--11/24/2015


Select ObjectID, ObjectNumber from Objects where ObjectNumber = '75.356.25'


Select MX.MediaMasterID,MX.PrimaryDisplay,MX.Rank,M.MediaView, M.PublicCaption, TP.Path ThumbPath, DMR.ThumbFileName, DMR.ThumbBlobSize,  PMR.RenditionNumber PrimaryRenditionNumber,PMR.RenditionID PrimaryRenditionID, PMR.PrimaryFileID PrimaryFileID,  PMF.FormatID PrimaryFormatID,PMFT.Format PrimaryFormat, PMT.IsDigital PrimaryIsDigital, PMFT.ViewerID PrimaryViewerID, PMT.MediaType PrimaryMediaType, DMR.RenditionNumber DisplayRenditionNumber,DMR.RenditionID DisplayRenditionID, DMR.PrimaryFileID DisplayFileID, DMF.FormatID DisplayFormatID, DMFT.Format DisplayFormat, DMT.IsDigital DisplayIsDigital, DMFT.ViewerID DisplayViewerID, DMT.MediaType DisplayMediaType, PMR.PrimaryFileID PrimaryFileID, PMF.FileName PrimaryFileName, PMP.Path PrimaryFilePath, DMR.PrimaryFileID DisplayFileID, DMF.FileName DisplayFileName, DMP.Path DisplayFilePath, M.DepartmentID, D.Department, DMF.IsConfidential DisplayFileIsConfidential, PMF.IsConfidential PrimaryFileIsConfidential, M.PublicAccess
From MediaXrefs MX
Inner Join MediaMaster M On MX.MediaMasterID = M.MediaMasterID
Inner Join Departments D On M.DepartmentID = D.DepartmentID
Inner Join MediaRenditions DMR On M.DisplayRendID = DMR.RenditionID
Inner Join MediaRenditions PMR On M.PrimaryRendID = PMR.RenditionID
Left Join MediaPaths TP On DMR.ThumbPathID = TP.PathID
Inner Join MediaTypes PMT On PMR.MediaTypeID = PMT.MediaTypeID
Inner Join MediaTypes DMT On DMR.MediaTypeID = DMT.MediaTypeID
Left Join MediaFiles DMF On DMR.PrimaryFileID = DMF.FileID
Left Join MediaFiles PMF On PMR.PrimaryFileID = PMF.FileID
Left Join MediaPaths DMP On DMF.PathID = DMP.PathID
Left Join MediaPaths PMP On PMF.PathID = PMP.PathID
Left Join MediaFormats DMFT On DMF.FormatID = DMFT.FormatID
Left Join MediaFormats PMFT On PMF.FormatID = PMFT.FormatID
Where MX.ID = 2499 AND MX.TableID = 108



select fileName, FileID from MediaFiles where FileID = 1188


Update MediaFiles set FileName = 'DisplayFile.jpg' where FileID = 1188

