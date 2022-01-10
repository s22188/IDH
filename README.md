# IDH

Instrukcja:
1. Uruchomić skrypt create_schema.sql w MSSQL w celu stworzenia tabel i procedur na swoim schemacie. Przy pierwszym uruchomieniu trzeba odkomentować i użyć: use twoja_eska.
2. Jako, że ścieżka do plików jest bezpośrednia należy:
  - w sekcji Connection Managers dla połączeń Flat File zmodyfikować ścieżkę w File name do odpowiedniego pliku w katalogu data
3. Skonfigurować połączenie (Connection Managers) do bazy danych pod swoją s-kę.
4. Uruchomić po kolei wszystkie pakiety z SSIS packages.
5. Zweryfikować w bazie wprowadzone dane (zwrócić uwagę w szczególności na AgeGroup, PreHoliodayPeriod , HolidayPeriod)
