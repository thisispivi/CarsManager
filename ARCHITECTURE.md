# Architecture

This document describes the current CarsManager architecture.

---

## Technology Choices

| Concern | Choice | Rationale |
|---------|--------|-----------|
| Framework | Flutter stable | One codebase for Android, web, and desktop targets |
| State management | Flutter Riverpod 2.x | App state is provided through `ProviderScope` and generated `@riverpod` feature providers |
| Navigation | GoRouter | Deep-linkable tab routes and web URL support |
| Local storage | JSON file / web localStorage | Privacy-first persistence without a backend |
| Code generation | Freezed + json_serializable | Immutable generated DTOs for new models |
| Charts | fl_chart | Native Flutter charting with no web-only dependency |
| Localization | Flutter gen-l10n | Built-in ARB workflow for English and Italian |
| Notifications | flutter_local_notifications | Local reminders and due-date notifications |

---

## Repository Structure

```text
CarsManager/
├── .github/
│   ├── workflows/               # CI, release, and web deployment
│   ├── ISSUE_TEMPLATE/
│   └── PULL_REQUEST_TEMPLATE.md
├── .husky/                      # Git hooks
├── cars_manager/                # Flutter application
│   ├── android/
│   ├── ios/
│   ├── linux/
│   ├── macos/
│   ├── web/
│   ├── windows/
│   ├── assets/
│   ├── lib/
│   ├── test/
│   ├── analysis_options.yaml
│   ├── flutter_launcher_icons.yaml
│   └── flutter_native_splash.yaml
├── logos/                       # Source brand assets
├── README.md
├── DESIGN_SYSTEM.md
├── ENVIRONMENT_SETUP.md
├── RELEASE.md
├── ROADMAP.md
├── SECURITY.md
├── package.json                 # Commit and verification tooling
├── commitlint.config.js
└── .lintstagedrc.js
```

---

## Application Structure

```text
cars_manager/lib/
├── core/
│   ├── services/                # Preferences and notification services
│   ├── storage/                 # Platform-conditional storage adapters
│   └── theme/                   # Color, spacing, typography, and ThemeData
├── data/
│   ├── car_data.dart            # Legacy single-car data helpers
│   └── cars_data.dart           # App bootstrap persistence helpers
├── features/
│   ├── analytics/
│       ├── data/models/         # Freezed analytics DTOs
│       ├── domain/              # Riverpod providers
│       └── presentation/        # Analytics screen
│   ├── expenses/domain/         # Generated expense collection providers
│   ├── fuel/domain/             # Generated fuel entry providers
│   ├── garage/domain/           # Generated car and active-car providers
│   ├── reminders/presentation/  # Reminder list screen
│   └── settings/domain/         # Generated settings providers
├── l10n/                        # ARB files and generated localizations
├── models/                      # Hand-written app models
├── presentation/
│   ├── common/                  # Shared widgets, extensions, and utilities
│   ├── pages/                   # Home, car form, fuel, payments
│   └── widgets/                 # Cross-page widgets
└── main.dart                    # App bootstrap and CarsManagerState
```

---

## State Management And Routing

The app starts in `main.dart` with `ProviderScope(child: CarsManagerApp())`. `CarsManagerApp` lives in `lib/app/app.dart` and uses `MaterialApp.router`.

`CarsManagerState` in `lib/app/state/cars_manager_state.dart` is currently the central app state object. It is exposed through `carsManagerStateProvider`, a Riverpod `ChangeNotifierProvider`, while the older screens continue to read it through a compatibility scope during migration. It owns:

- the vehicle list and active vehicle ID
- locale, theme, unit, currency, and notification settings
- mutations for cars, fuel entries, inspections, insurance, taxes, repairs, and fines

New feature code should prefer generated Riverpod providers directly. Existing screens are being migrated away from the compatibility API incrementally.

```text
Widget event -> CarsManagerState mutation -> saveCarData -> storage adapter
             -> notifyListeners -> widgets rebuild
```

GoRouter routes:

```text
/             -> /garage
/garage       -> Garage screen
/garage/add   -> Car form
/fuel         -> Fuel screen
/expenses     -> Expenses screen
/analytics    -> Analytics screen
/reminders    -> Reminders screen
/settings     -> Settings screen
```

---

## Persistence

The app persists a single snapshot containing all vehicles, nested entries, active vehicle ID, and preferences.

| Platform | Implementation | Notes |
|----------|----------------|-------|
| Android/iOS/desktop | `cars_storage_io.dart` | JSON file under the app documents directory |
| Web | `cars_storage_web.dart` | Browser `localStorage` |

On first launch, data is seeded from `assets/data/cars.json`.

---

## Localization

Source strings live in:

- `cars_manager/lib/l10n/app_en.arb`
- `cars_manager/lib/l10n/app_it.arb`

Generated Dart localization files are committed because the app imports them directly and CI analyzes the repository without a separate generation step.

Regenerate after editing ARB files:

```bash
cd cars_manager
flutter gen-l10n
```

---

## Branding

Brand assets live in `logos/` and `cars_manager/assets/icons/`. Platform-facing metadata is configured in:

- Android: `android/app/build.gradle.kts`, `AndroidManifest.xml`
- Web: `web/index.html`, `web/manifest.json`
- iOS/macOS: Xcode project settings and plist files
- Linux/Windows: CMake and runner metadata
- Generated icons/splash: `flutter_launcher_icons.yaml`, `flutter_native_splash.yaml`

---

## Testing Strategy

Current checks are intentionally lightweight:

| Check | Command |
|-------|---------|
| Format | `npm run format:check` |
| Analyze | `npm run analyze` |
| Tests | `npm test` |
| Full local verification | `npm run verify` |

Current generated-code coverage includes the Freezed/json_serializable `ActiveCarAnalytics` model. Future work should broaden unit coverage around model serialization and widget coverage for the main vehicle, fuel, and payment flows.
