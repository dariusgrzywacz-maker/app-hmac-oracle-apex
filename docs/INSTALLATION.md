# APP_HMAC V4 - paczka wdrozeniowa

## Pliki
- `../sql/install/APP_HMAC_INSTALL.sql` - pełna instalacja w aktualnie połączonym schemacie.
- `../sql/uninstall/APP_HMAC_UNINSTALL.sql` - usunięcie obiektów, tylko do kontrolowanego rollbacku.

## Uruchomienie
1. Połącz się z docelowym schematem lub ustaw `ALTER SESSION SET CURRENT_SCHEMA = ...`.
2. Zapewnij bezpośrednie uprawnienie wykonania `DBMS_CRYPTO` oraz dostęp kompilacyjny do pakietów APEX.
3. Z katalogu głównego repozytorium uruchom `@sql/install/APP_HMAC_INSTALL.sql` w SQLcl albo SQL*Plus.
4. Sprawdz `USER_ERRORS`, `USER_OBJECTS` i rekordy w `APP_HMAC_ADMIN_LOG`.
5. Usuń akcje `APP_HMAC_INSTALL_TEST` po testach.
6. Nadaj aplikacji tylko `EXECUTE ON APP_HMAC`; `APP_HMAC_ADMIN` ogranicz do administratora lub joba.

## Decyzje projektowe
- Brak kwalifikatora schematu zapewnia przenosność.
- Format payloadu ma wersje `APP_HMAC_V4`; podpisy V3 nie sa kompatybilne.
- Log jest autonomiczny, aby zachować informacje o błędzie nawet po rollbacku operacji administracyjnej.
- Log nie przechowuje `SECRET_VALUE`.
- `SESSION` nadal zależy od aktywnej sesji APEX oraz dostepności klucza weryfikacyjnego.
- Maksymalny TTL wynosi 86400 sekund, a domyślny grace period 25 godzin.

## Test minimalny w APEX
```plsql
l_signature := app_hmac.sign_id('APP_HMAC_INSTALL_TEST', '123');
if not app_hmac.verify_id('APP_HMAC_INSTALL_TEST', '123', l_signature) then
    raise_application_error(-20000, 'Test HMAC nie powiodł się.');
end if;
```

Test `SIGN` wymaga kontekstu sesji Oracle APEX. Nie należy traktować testu uruchomionego poza APEX jako testu integracyjnego.
