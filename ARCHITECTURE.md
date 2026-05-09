# Architecture

This document describes the technical architecture of CarsManager.

---

## Technology choices

| Concern | Choice | Rationale |
|---------|--------|-----------|
| Framework | Flutter (stable) | Single codebase for Android + Web |
| State management | Riverpod 2.x + code-gen | Fine-grained reactivity, excellent testability, no `BuildContext` dependency |
| Navigation | GoRouter | URL-based routing, deep linking, shell routes for adaptive nav |
| Data models | Freezed + json_serializable | Immutable value objects with auto-generated `copyWith`, `fromJson`, `toJson`, equality |
| Local storage | JSON file (mobile) / localStorage (web) | Privacy-first, no server dependency |
| Charts | fl_chart | Pure Dart, no native dependencies, good animation support |
| Typography | Google Fonts — Space Grotesk | Modern, humanist, excellent readability |
| Notifications | flutter_local_notifications | OS-level notifications with timezone support |

---

## Repository structure

```
CarsManager/                        ← repo root
├── .github/
│   ├── workflows/
│   │   ├── ci.yml                  ← analyze + test + build (PR/push)
│   │   ├── release.yml             ← build + GitHub Release (tag push)
│   │   └── deploy-web.yml          ← GitHub Pages deploy (after release)
│   ├── ISSUE_TEMPLATE/
│   └── PULL_REQUEST_TEMPLATE.md
├── cars_manager/                   ← Flutter application
│   ├── android/
│   ├── ios/
│   ├── web/
│   ├── lib/                        ← application source code (see below)
│   ├── test/
│   ├── integration_test/
│   ├── assets/
│   │   ├── data/                   ← default seed data (cars.json)
│   │   └── icons/                  ← app logos and feature icons
│   ├── pubspec.yaml
│   ├── analysis_options.yaml
│   ├── flutter_launcher_icons.yaml
│   └── flutter_native_splash.yaml
├── README.md
├── ARCHITECTURE.md                 ← this file
├── CONTRIBUTING.md
├── DESIGN_SYSTEM.md
├── CHANGELOG.md
├── RELEASE.md
├── ROADMAP.md
├── SECURITY.md
├── CODE_OF_CONDUCT.md
├── ENVIRONMENT_SETUP.md
├── package.json                    ← Node.js tooling (commitlint, husky)
├── commitlint.config.js
└── .lintstagedrc.js
```

---

## Application source structure (`cars_manager/lib/`)

```
lib/
├── main.dart                       # Minimal entry point: ProviderScope + runApp
│
├── app/
│   ├── app.dart                    # Root widget (MaterialApp.router, theme, localization)
│   └── router/
│       ├── app_router.dart         # GoRouter: all routes, shell route, redirects
│       └── routes.dart             # Route name constants
│
├── core/
│   ├── constants/
│   │   └── app_constants.dart      # App-wide magic values
│   ├── extensions/
│   │   ├── context_extensions.dart # BuildContext shorthand helpers
│   │   ├── datetime_extensions.dart
│   │   └── string_extensions.dart
│   ├── services/
│   │   ├── notification_service.dart  # OS notifications (singleton)
│   │   └── preferences_service.dart  # SharedPreferences wrapper
│   ├── storage/
│   │   ├── cars_storage.dart          # Conditional export (io vs web)
│   │   ├── cars_storage_io.dart       # File-based storage (Android/iOS)
│   │   └── cars_storage_web.dart      # localStorage (web)
│   └── theme/
│       ├── app_colors.dart            # Color tokens (brand, semantic, chart)
│       ├── app_dimensions.dart        # Spacing, radius, shadow system
│       ├── app_text_styles.dart       # Typography scale (Space Grotesk)
│       └── app_theme.dart             # Material 3 ThemeData (light + dark)
│
├── features/
│   ├── garage/                     # Vehicle management
│   │   ├── data/
│   │   │   ├── models/car.dart         # @freezed Car model
│   │   │   └── repositories/
│   │   │       └── cars_repository.dart
│   │   ├── domain/
│   │   │   └── cars_notifier.dart      # @riverpod AsyncNotifier<List<Car>>
│   │   └── presentation/
│   │       ├── garage_screen.dart
│   │       ├── car_detail_screen.dart
│   │       └── widgets/
│   │
│   ├── fuel/                       # Fuel tracking
│   │   ├── data/models/fuel_entry.dart
│   │   ├── domain/fuel_notifier.dart
│   │   └── presentation/fuel_screen.dart
│   │
│   ├── expenses/                   # Insurance, inspection, tax, repairs, fines
│   │   ├── data/models/            # One @freezed model per expense type
│   │   ├── domain/expenses_notifier.dart
│   │   └── presentation/expenses_screen.dart
│   │
│   ├── analytics/                  # Derived insights (no mutations)
│   │   ├── domain/analytics_provider.dart   # Pure @riverpod providers
│   │   └── presentation/analytics_screen.dart
│   │
│   ├── reminders/                  # Notification management UI
│   │   ├── domain/reminders_notifier.dart
│   │   └── presentation/reminders_screen.dart
│   │
│   └── settings/                   # App preferences
│       ├── domain/settings_notifier.dart
│       └── presentation/settings_screen.dart
│
├── shared/
│   ├── widgets/                    # Reusable design system components
│   │   ├── app_scaffold.dart       # Adaptive nav (bottom bar / rail / sidebar)
│   │   ├── app_button.dart
│   │   ├── app_card.dart
│   │   ├── app_text_field.dart
│   │   ├── app_bottom_sheet.dart
│   │   ├── empty_state.dart
│   │   ├── loading_state.dart
│   │   ├── error_state.dart
│   │   ├── status_pill.dart
│   │   ├── metric_tile.dart
│   │   └── charts/
│   │       ├── donut_chart.dart
│   │       └── stacked_bar_chart.dart
│   └── utils/
│       ├── semantic_status.dart
│       └── due_date_color.dart
│
└── l10n/                           # ARB-based localization (EN, IT)
```

---

## State management

### Pattern: Riverpod 2.x with code generation

All state lives in `@riverpod`-annotated classes. There is no global singleton state.

**Provider types used:**

| Type | Used for |
|------|---------|
| `@riverpod AsyncNotifier` | Async data with loading/error states (cars, fuel entries) |
| `@riverpod Notifier` | Synchronous state (active car ID, settings) |
| `@riverpod` function | Derived/computed state — no mutations (analytics, due date summaries) |

**Data flow:**

```
UI (ref.watch) ← Notifier ← Repository ← Storage
                                ↑
                     UI mutation (ref.read(...).mutate())
```

**Active car pattern:** `ActiveCarNotifier` holds the currently selected car ID. Feature notifiers (`FuelNotifier`, `ExpensesNotifier`) watch it via `ref.watch(activeCarNotifierProvider)` to scope their data automatically.

---

## Navigation

GoRouter manages all navigation. The app uses a `ShellRoute` to wrap all main tabs inside `AppScaffold` (adaptive nav bar/rail/sidebar).

### Route map

```
/                  → redirect to /garage
/garage            → GarageScreen
/garage/add        → CarFormScreen (add mode)
/garage/:carId     → CarDetailScreen
/garage/:carId/edit → CarFormScreen (edit mode)
/fuel              → FuelScreen
/expenses          → ExpensesScreen
/analytics         → AnalyticsScreen
/reminders         → RemindersScreen
/settings          → SettingsScreen
```

---

## Data persistence

### Storage layer

The storage implementation is platform-conditional via a Dart conditional export:

```dart
// cars_storage.dart
export 'cars_storage_io.dart'
    if (dart.library.html) 'cars_storage_web.dart';
```

| Platform | Implementation | Location |
|----------|---------------|---------|
| Android / iOS | JSON file | `{app_documents}/cars.json` |
| Web | localStorage | Key: `carsmanager.data` |

On first launch, if no saved data exists, the app seeds from `assets/data/cars.json`.

### Data format

A single `CarsDataSnapshot` JSON object wraps all cars and their nested entries. Each `Car` contains all related lists inline. This avoids relational complexity while keeping the data model simple for a single-user app.

---

## Adaptive layout

`AppScaffold` uses `LayoutBuilder` to select the appropriate navigation pattern:

| Width | Navigation |
|-------|-----------|
| < 600 dp | `NavigationBar` (bottom) |
| 600–1199 dp | `NavigationRail` (left, compact) |
| ≥ 1200 dp | `NavigationDrawer` (left, persistent, with logo) |

---

## Code generation

Two code-gen systems run via `build_runner`:

| Tool | Generates | Output |
|------|-----------|--------|
| `freezed` | `copyWith`, `==`, `toString`, `_$*` classes | `*.freezed.dart` |
| `json_serializable` | `fromJson` / `toJson` | `*.g.dart` |
| `riverpod_generator` | Provider boilerplate from `@riverpod` | `*.g.dart` |

Run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Generated files are **committed** to the repository so CI doesn't need to run `build_runner` before `flutter analyze`.

---

## Testing strategy

| Layer | Type | Location | Tool |
|-------|------|----------|------|
| Models | Unit | `test/unit/models/` | `flutter_test` |
| Repositories | Unit | `test/unit/repositories/` | Mock storage via `mocktail` |
| Notifiers | Unit | `test/unit/domain/` | `ProviderContainer` |
| Widgets | Widget | `test/widget/` | `WidgetTester` |
| Screens | Smoke | `test/widget/screens/` | `WidgetTester` |
| Flows | Integration | `integration_test/` | `flutter_test` + `integration_test` |

Coverage target: **> 60%** for `lib/` (excluding generated files and `l10n/`).
