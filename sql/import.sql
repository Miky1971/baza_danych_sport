-- Import danych do pustej bazy sports (po schema_db_sports.sql). Uruchomienie w psql, połączonym z bazą sports:
--   \i 'C:/Users/Marek/Documents/Firmatic/CSharp/baza_danych_sport/sql/import.sql'
-- \copy czyta pliki po stronie klienta (psql), więc serwer nie potrzebuje dostępu do katalogu Documents.
-- Kolejność wg kluczy obcych. Wszystko w jednej transakcji: błąd w dowolnym kroku = nic nie zostaje zapisane.
\set ON_ERROR_STOP on
BEGIN;

\copy country (id, continent, name, path_flag, part_of, status, note, parent_id, tags, fed_olympic, fed_football, fed_athletic, fed_other, fed_note, ioc_code) FROM 'C:/Users/Marek/Documents/Firmatic/CSharp/baza_danych_sport/import/country.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8')
\copy tag (applies_to, code, short, note) FROM 'C:/Users/Marek/Documents/Firmatic/CSharp/baza_danych_sport/import/tag.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8')
\copy discipline (id, name, fed_world, fed_world_old, fed_world_year, fed_europe, fed_europe_old, fed_europe_year, note) FROM 'C:/Users/Marek/Documents/Firmatic/CSharp/baza_danych_sport/import/discipline.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8')
\copy discipline_event (id, discipline_id, name, category, season, para, tags, olympic_debut, note) FROM 'C:/Users/Marek/Documents/Firmatic/CSharp/baza_danych_sport/import/discipline_event.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8')
\i 'C:/Users/Marek/Documents/Firmatic/CSharp/baza_danych_sport/import/pictograms.sql'
\copy event_series (id, name, short, type, scope, region, athletes, team_format, season) FROM 'C:/Users/Marek/Documents/Firmatic/CSharp/baza_danych_sport/import/event_series.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8')
\copy event (id, series_id, year, number, ident, cancelled, note) FROM 'C:/Users/Marek/Documents/Firmatic/CSharp/baza_danych_sport/import/event.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8')
\copy event_country_role (event_id, country_id, role, cities, note) FROM 'C:/Users/Marek/Documents/Firmatic/CSharp/baza_danych_sport/import/event_country_role.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8')
\copy competition (id, event_id, discipline_event_id, gender, kind, note) FROM 'C:/Users/Marek/Documents/Firmatic/CSharp/baza_danych_sport/import/competition.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8')
\copy result (id, competition_id, country_id, team_suffix, club_or_team, stage, place, status, score, note) FROM 'C:/Users/Marek/Documents/Firmatic/CSharp/baza_danych_sport/import/result.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';', ENCODING 'UTF8')

-- id były podane jawnie, więc licznik IDENTITY trzeba przestawić za największe id (inaczej pierwszy INSERT bez id dostałby id = 1 -> duplikat)
SELECT setval(pg_get_serial_sequence('country', 'id'), max(id)) FROM country;
SELECT setval(pg_get_serial_sequence('discipline', 'id'), max(id)) FROM discipline;
SELECT setval(pg_get_serial_sequence('discipline_event', 'id'), max(id)) FROM discipline_event;
SELECT setval(pg_get_serial_sequence('event_series', 'id'), max(id)) FROM event_series;
SELECT setval(pg_get_serial_sequence('event', 'id'), max(id)) FROM event;
SELECT setval(pg_get_serial_sequence('competition', 'id'), max(id)) FROM competition;
SELECT setval(pg_get_serial_sequence('result', 'id'), max(id)) FROM result;

COMMIT;
