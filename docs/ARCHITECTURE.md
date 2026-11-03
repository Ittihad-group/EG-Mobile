# EG-Mobile Architecture

EG-Mobile follows **Clean Architecture** with **feature-based** folders and **MVVM + Cubit** for presentation state.

## Goals

- Independent, testable features
- Clear dependency direction
- Shared infrastructure in `core/`
- Easy extension when connecting EG-System APIs

## High-level structure

```text
lib/
├── core/           # Shared config, DI, network, storage, theme, utils, widgets
├── features/       # One folder per feature (auth, dashboard, products, …)
├── app.dart        # MaterialApp + global BlocProviders + router
└── main.dart       # Binding + GetIt init + runApp
```

## Dependency rule

```text
Presentation → Domain ← Data
      ↓           ↑
     Cubit     UseCases / Repository interfaces
                  ↑
            Repository implementations
                  ↑
         Data sources (local / remote)
```

- **Domain** must not import Flutter, Dio, Firebase, SharedPreferences, or GetIt.
- **Data** implements Domain repository contracts.
- **Presentation** talks to Domain via UseCases (meaningful business actions) or repository interfaces (simple reads).
- Features must not depend on another feature’s **data** or **presentation** internals. Shared types belong in `core/` or a carefully shared domain contract.

## Layers

### Domain

- Entities
- Repository interfaces
- UseCases (when they encode real business rules)
- No UI, no IO frameworks

### Data

- Remote / local data sources
- Models / DTOs + mapping to entities
- Repository implementations
- Seed data is temporary local IO until the API is live

### Presentation

- Pages and feature widgets
- Cubit + immutable State (Equatable)
- Loading / success / error handling
- No business rules beyond UI orchestration

## State management

- **Cubit** is the ViewModel (MVVM).
- Do **not** use Provider / ChangeNotifier for feature state.
- Register Cubits in GetIt; provide them with `BlocProvider` at the page or app root.
- Global app state: `AuthCubit`, `LocaleCubit`.

## Dependency injection

All wiring lives in:

```text
lib/core/di/injection_container.dart
```

Register:

- Core services (`DioClient`, storage, `NetworkInfo`, `AppConfig`)
- Data sources
- Repositories
- UseCases
- Cubits (`registerFactory` for page-scoped Cubits)

Never construct repositories or data sources inside widgets.

## Networking & storage

| Concern | Approach |
|---------|----------|
| REST | Dio via `DioClient` |
| Endpoints | `ApiEndpoints` |
| Connectivity | `NetworkInfo` abstraction |
| Preferences | `LocalStorage` (SharedPreferences) |
| Tokens / secrets | `SecureStorage` |
| Structured local DB | Hive / Sqflite when needed |

## Routing

`go_router` in `lib/core/router/app_router.dart` with auth redirects:

- Unauthenticated → `/login`
- Authenticated → `/`

## Current data mode

The app ships with **local seed data** aligned with EG-System. Feature local datasources read from `lib/core/data/seed_data.dart`. Remote datasources (e.g. `AuthRemoteDataSource`) are stubbed and ready to swap in when the API is available.
