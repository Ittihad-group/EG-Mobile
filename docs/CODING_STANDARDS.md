# Coding Standards

## Naming

| Kind | Convention | Example |
|------|------------|---------|
| Classes | `PascalCase` | `AuthCubit`, `UserEntity` |
| Variables / methods | `camelCase` | `isArabic`, `getProducts` |
| Files | `snake_case.dart` | `auth_cubit.dart` |
| Cubits | `feature_cubit.dart` | `products_cubit.dart` |
| States | `feature_state.dart` | `products_state.dart` |
| Models | `feature_model.dart` | `product_model.dart` |
| Entities | `feature_entity.dart` | `product_entity.dart` |
| Repositories | `feature_repository.dart` | `auth_repository.dart` |
| UseCases | `action_feature_usecase.dart` | `login_usecase.dart` |

## State management

- Use **Cubit** only (no Provider / ChangeNotifier for features).
- States are **immutable** and extend `Equatable` when comparison matters.
- Always emit a loading state before async work when the UI should show progress.
- Keep Cubits focused on presentation orchestration; put business rules in Domain.

Example state shape:

```dart
abstract class FeatureState extends Equatable {
  const FeatureState();
  @override
  List<Object?> get props => [];
}

class FeatureInitial extends FeatureState { const FeatureInitial(); }
class FeatureLoading extends FeatureState { const FeatureLoading(); }
class FeatureLoaded extends FeatureState { /* data */ }
class FeatureError extends FeatureState { /* message */ }
```

## Architecture habits

- Prefer constructor injection; resolve via GetIt at composition roots (`main`, page `BlocProvider`).
- Map data models → domain entities at the repository boundary.
- Catch IO exceptions in Data; surface user-safe messages in Presentation.
- Do not create UseCases for trivial pass-through CRUD.
- Do not introduce libraries without a documented technical need.

## UI

- Reuse `lib/core/widgets/` for shared components (`StatCard`, `StatusChip`).
- Use theme tokens from `AppColors` / `AppTheme` instead of scattering raw brand colors.
- Keep feature-specific widgets under `presentation/widgets/`.
- Prefer bilingual helpers via `Formatters.t` / `Formatters.money` driven by `LocaleCubit`.

## Error types

- `lib/core/errors/exceptions.dart` — thrown at the data-source boundary.
- `lib/core/errors/failures.dart` — domain/presentation-facing failure values when mapping is useful.

## Formatting & analysis

- Follow `analysis_options.yaml` (`flutter_lints`).
- Run `dart format` on touched files.
- Prefer explicit types on public APIs; omit obvious local types when clarity is unchanged.
