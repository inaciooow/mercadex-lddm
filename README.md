# Mercadex

## Run Mobile With Mock Data

```bash
cd mobile
flutter pub get
flutter run --dart-define=USE_MOCK_DATA=true
```

`USE_MOCK_DATA=true` is the default, so `flutter run` also uses mocked data.

## Development Admin Login

The database seed creates this development-only account:

```text
Email: admin@mercadex.local
Password: admin
```
# To-DO

- splash screen
- change colors