


--server:  milltest\SQL2005
--database:  MFAH_Custom
--table:  EventPerson



----------------------------------------------------------------------------------------------------------
WITH CTE ( EventName, Person_List, PersonName, length )
          AS ( SELECT EventName, CAST( '' AS VARCHAR(8000) ), CAST( '' AS VARCHAR(8000) ), 0
                 FROM EventPerson
                GROUP BY EventName
                UNION ALL
               SELECT p.EventName, CAST( Person_List +
                      CASE WHEN length = 0 THEN '' ELSE ', ' END + p.PersonName AS VARCHAR(8000) ),
                      CAST( p.PersonName AS VARCHAR(8000)), length + 1
                 FROM CTE c
                INNER JOIN EventPerson p
                   ON c.EventName = p.EventName
                WHERE p.PersonName > c.PersonName )
SELECT EventName, Person_List
      FROM ( SELECT EventName, Person_List,
                    RANK() OVER ( PARTITION BY EventName ORDER BY length DESC )
               FROM CTE ) D ( EventName, Person_List, rank )
     WHERE rank = 1 ;