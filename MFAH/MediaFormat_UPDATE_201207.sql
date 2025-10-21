
/*

		DON'T RUN THIS YET!

		JPG and TIF were created by the Media Loader
		-12/15/2020


*/


SELECT * FROM MediaTypes
SELECT * FROM MediaFormats WHERE MediaTypeID = 1

FormatID 20 >> 2
FormatID 23 >> 1


SELECT * FROM MediaFiles WHERE FormatID = 20 -- JPG,  14937
SELECT * FROM MediaFiles WHERE FormatID = 23 -- TIF,   7155

SELECT * FROM MediaFiles WHERE FormatID = 2 -- JPEG, 141342
SELECT * FROM MediaFiles WHERE FormatID = 1 -- TIFF,  56291


--UPDATE MediaFiles SET FormatID = 2 WHERE FormatID = 20
--UPDATE MediaFiles SET FormatID = 1 WHERE FormatID = 23