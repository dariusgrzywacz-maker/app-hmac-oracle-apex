# APP_HMAC

Pakiet PL/SQL dla Oracle APEX, który zabezpiecza integralność identyfikatorów i
parametrów przekazywanych z przeglądarki do operacji aplikacyjnych. Podpis HMAC
pozwala wykryć zmianę danych, ale nie zastępuje autoryzacji użytkownika ani
kontroli uprawnień do rekordu.

## Funkcje

- podpisywanie i weryfikacja identyfikatorów oraz parametrów przez HMAC-SHA256;
- powiązanie podpisu z kontekstem aplikacji i sesji APEX;
- konfiguracja dozwolonych akcji i trybu ważności `SESSION` albo `TTL`;
- rotacja kluczy i audyt operacji administracyjnych.

## Struktura repozytorium

```text
.
├── .gitignore
├── LICENSE
├── README.md
├── docs/
│   └── INSTALLATION.md
└── sql/
    ├── install/
    │   └── APP_HMAC_INSTALL.sql
    └── uninstall/
        └── APP_HMAC_UNINSTALL.sql
```

## Wymagania

- Oracle APEX dostępny w docelowej bazie;
- pakiety `DBMS_CRYPTO` i `UTL_I18N`;
- uprawnienia do tworzenia tabel, pakietów, triggerów i — jeśli używany —
  zadań `DBMS_SCHEDULER`.

Uprawnienia wymagane do kompilacji i uruchomienia instalatora muszą być nadane
bezpośrednio schematowi instalacyjnemu, zgodnie z polityką Oracle Database.

## Instalacja

Połącz się z docelowym schematem w SQLcl lub SQL*Plus i uruchom:

```sql
@sql/install/APP_HMAC_INSTALL.sql
```

Instalator tworzy obiekty w bieżącym schemacie, generuje pierwszy klucz i
dodaje testową akcję `APP_HMAC_INSTALL_TEST`. Szczegółowa lista kroków,
weryfikacja instalacji i test w kontekście APEX znajdują się w
[instrukcji instalacji](docs/INSTALLATION.md).

## Bezpieczeństwo

- Nie przekazuj aplikacji bezpośredniego dostępu do `APP_HMAC_KEYS` ani
  `APP_HMAC_ADMIN_LOG`.
- Nadaj aplikacji wyłącznie wymagane `EXECUTE` do `APP_HMAC`; dostęp do
  `APP_HMAC_ADMIN` ogranicz do administratorów lub kontrolowanego joba.
- Weryfikuj podpis bezpośrednio przed operacją DML i niezależnie sprawdzaj
  uprawnienia użytkownika do wykonania tej operacji.
- Podpis nie szyfruje identyfikatora i nie zapewnia ochrony przed ponownym
  użyciem poprawnego żądania.
- Podpisy `APP_HMAC_V4` nie są kompatybilne z wcześniejszym formatem V3.

## Usuwanie

Skrypt [deinstalacyjny](sql/uninstall/APP_HMAC_UNINSTALL.sql) usuwa obiekty
pakietu i dane konfiguracyjne. Uruchamiaj go wyłącznie po świadomej decyzji
administracyjnej i po wykonaniu kopii wymaganych danych.

## Licencja

Projekt jest udostępniony na licencji [MIT](LICENSE).

*Created with ❤️ for the Oracle APEX community.*
