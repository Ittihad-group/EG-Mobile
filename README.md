# EG-Mobile

Flutter companion app for the plant ERP (**EG-System**)  
**المصرية الألمانية لتصنيع منتجات WPC & PVC** — جمصة، الدقهلية.

## Architecture

Clean Architecture + feature-based modules + MVVM with Cubit.

See:

- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)
- [docs/FEATURE_DEVELOPMENT.md](docs/FEATURE_DEVELOPMENT.md)
- [docs/CODING_STANDARDS.md](docs/CODING_STANDARDS.md)

## Related repos

| Repo | Role |
|------|------|
| [EG-System](https://github.com/Ittihad-group/EG-System) | Web ERP |
| [EG-Website](https://github.com/Ittihad-group/EG-Website) | Public website |
| **EG-Mobile** | Internal mobile ERP app |

## Features

- Auth (demo local login)
- Dashboard KPIs
- Products
- Inventory
- Sales orders
- Production / work orders
- Customers & dealers
- Finance snapshot
- Settings (company + language)

Arabic (RTL) / English.

## Demo login

```
admin@egerman-upvc.com / admin123
sales@egerman-upvc.com / sales123
```

## Run

```bash
flutter pub get
flutter run
```

Copy `.env.example` when wiring real API environments.

## Stack

- Flutter + Cubit (`flutter_bloc`)
- GetIt DI
- Dio networking
- SharedPreferences + Flutter Secure Storage
- go_router

Prototype data is local seed aligned with EG-System; remote datasources are ready to connect later.
