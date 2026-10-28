-- Kontrola po imporcie: liczba wierszy w każdej tabeli

SELECT 'country' AS "Tabela", COUNT(*) AS "Ile" FROM country 
UNION ALL
SELECT 'competition', COUNT(*) FROM competition
UNION ALL
SELECT 'discipline', COUNT(*) FROM discipline
UNION ALL
SELECT 'discipline_event', COUNT(*) FROM discipline_event
UNION ALL
SELECT 'event', COUNT(*) FROM event
UNION ALL
SELECT 'event_country_role', COUNT(*) FROM event_country_role
UNION ALL
SELECT 'event_series', COUNT(*) FROM event_series
UNION ALL
SELECT 'result', COUNT(*) FROM result
ORDER BY "Ile" DESC
;