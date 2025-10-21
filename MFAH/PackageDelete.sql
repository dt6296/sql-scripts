



SELECT * FROM Packages WHERE Owner = 'jsawhill'




SELECT * 
FROM Packages
WHERE EnteredDate < GETDATE()-(365*5)
AND Owner NOT IN
(
'mhershon',
'bchan',
'wmichels',
'kwillis',
'awalker',
'mtimko',
'rvogel',
'lrosenblum',
'ccurran',
'jdibley',
'msmith',
'kburrows',
'relliot',
'cstrauss',
'dthompson',
'mflores',
'dwoodall',
'kapplegarth',
'cedwards',
'jobsta',
'lwilhelm',
'ttan',
'kcrain',
'bolivetti',
'mmcgreger',
'spine',
'jmarshall',
'cgervais',
'nabdulghani',
'jbakke',
'jlevy',
'rdyll',
'mstein'
)
ORDER BY EnteredDate DESC















