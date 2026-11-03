# Feature Development Guide

Every new capability lives under:

```text
lib/features/[feature_name]/
```

## Folder template

```text
lib/features/[feature_name]/
├── data/
│   ├── datasources/
│   │   ├── [feature]_remote_datasource.dart
│   │   └── [feature]_local_datasource.dart
│   ├── models/
│   │   └── [feature]_model.dart
│   └── repositories/
│       └── [feature]_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── [feature]_entity.dart
│   ├── repositories/
│   │   └── [feature]_repository.dart
│   └── usecases/          # only when business logic needs it
│       └── [action]_[feature]_usecase.dart
└── presentation/
    ├── cubit/
    │   ├── [feature]_cubit.dart
    │   └── [feature]_state.dart
    ├── pages/
    │   └── [feature]_page.dart
    └── widgets/
```

## Step-by-step

1. **Entity** — pure Dart model of the business concept.
2. **Repository interface** — Domain contract (`Future<…>` methods).
3. **Model + DataSource** — map JSON / seed / Firebase into models.
4. **Repository impl** — call data sources, map models → entities, map errors → failures/exceptions.
5. **UseCase** (optional) — add when the action is more than a thin pass-through (e.g. login, checkout). Skip for simple list/get CRUD.
6. **Cubit + State** — emit `Initial` → `Loading` → `Loaded` / `Error`.
7. **Page** — `BlocProvider(create: (_) => sl<FeatureCubit>()..load())` and build UI from state.
8. **DI** — register everything in `lib/core/di/injection_container.dart`.
9. **Route** — add a GoRoute or shell tab when the feature is reachable from navigation.
10. **Tests** — prefer `test/features/[feature_name]/` for Cubit and repository tests.

## Data flow example (auth)

```text
login_page.dart
      ↓
auth_cubit.dart
      ↓
login_usecase.dart
      ↓
auth_repository.dart  (interface)
      ↑
auth_repository_impl.dart
      ↓
auth_local_datasource.dart  (or remote)
      ↓
seed / API / Firebase
```

## Cross-feature rules

- Do not import another feature’s datasources, models, pages, or Cubits.
- If two features need the same entity, extract a shared domain type into `core/` or a dedicated shared module — do not reach into `features/other/data`.
- Shared UI goes in `lib/core/widgets/`.
- Shared theme tokens go in `lib/core/theme/`.

## Checklist before merge

- [ ] Feature folder matches the template
- [ ] Domain has no Flutter / Dio / Firebase imports
- [ ] Cubit handles loading and error states
- [ ] Dependencies registered in GetIt
- [ ] No new packages without a clear reason
- [ ] Docs updated if the architecture changes
