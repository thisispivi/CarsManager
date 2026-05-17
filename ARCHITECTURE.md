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
| Charts | fl_chart + custom wrappers | Native Flutter charting with consistent app styling |
| Motion | flutter_animate | Declarative entrance and onboarding animations |
| Localization | Flutter gen-l10n | Built-in ARB workflow for English and Italian |
| Notifications | flutter_local_notifications | Local reminders and due-date notifications |

---

## Repository Structure

```text
CarsManager/
├── .github/
│   └── workflows/               # CI, release, and web deployment
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
├── README.md
├── DESIGN_SYSTEM.md
├── ENVIRONMENT_SETUP.md
├── package.json                 # Commit and verification tooling
├── commitlint.config.js
└── .lintstagedrc.js
```

---

## Application Structure

```text
cars_manager/lib/
├── app/
│   ├── app.dart                 # MaterialApp.router and theme wiring
│   └── router/                  # GoRouter configuration and route names
├── core/
│   ├── responsive/              # ScreenSize breakpoints and helpers
│   ├── services/                # Preferences and notification services
│   ├── storage/                 # Platform-conditional storage adapters
│   └── theme/                   # Tokens, ThemeExtensions, and ThemeData
├── data/
│   ├── car_data.dart            # Legacy single-car data helpers
│   └── cars_data.dart           # App bootstrap persistence helpers
├── design_system/
│   ├── atoms/                   # Small primitives
│   ├── molecules/               # Buttons, fields, pills, metric tiles
│   ├── organisms/               # Scaffold, cards, states, layout surfaces
│   └── charts/                  # Reusable chart primitives
├── features/
│   ├── analytics/
│       ├── data/models/         # Freezed analytics DTOs
│       ├── domain/              # Riverpod providers
│       └── presentation/        # Cross-car analytics screen
│   ├── expenses/domain/         # Generated expense collection providers
│   ├── fuel/domain/             # Generated fuel entry providers
│   ├── garage/domain/           # Generated car and active-car providers
│   ├── home/presentation/       # v2 dashboard
│   ├── onboarding/              # First-run onboarding gate and controller
│   ├── reminders/presentation/  # Legacy reminders screen during migration
│   ├── search/presentation/     # Global command/search overlay
│   ├── settings/domain/         # Generated settings providers
│   └── vehicle_detail/          # Per-car overview/fuel/expenses/timeline
├── l10n/                        # ARB files and generated localizations
├── models/                      # Hand-written app models
├── presentation/
│   ├── common/                  # Legacy shared widgets and utilities
│   ├── pages/                   # Legacy forms and migrated support widgets
│   └── widgets/                 # Cross-page widgets
└── main.dart                    # App bootstrap and CarsManagerState
```

---

## State Management And Routing

The app starts in `main.dart` with `ProviderScope(child: CarsManagerApp())`. `CarsManagerApp` lives in `lib/app/app.dart` and uses `MaterialApp.router`.

## Theme Layer

The visual system is intentionally layered. `AppColors` owns raw brand, surface, semantic, and chart tokens. `AppColorScheme` is a `ThemeExtension` that exposes adaptive v2 color tokens to widgets. `AppTheme` converts those tokens into Material 3 `ThemeData` for light and dark mode, including color scheme, input decorations, navigation, buttons, cards, and app bars.

`CarsManagerApp` passes the resulting themes into `MaterialApp.router`, and screens consume them through `Theme.of(context)` or the extension instead of hardcoded fonts or colors. This keeps logo-aligned brand changes centralized and lets shared widgets inherit the active locale and brightness correctly.

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
/             -> Onboarding gate, then v2 dashboard
/garage       -> v2 garage
/garage/add   -> Car form
/car/:id      -> Vehicle detail overview tab
/car/:id/fuel -> Vehicle detail fuel tab
/car/:id/expenses -> Vehicle detail expenses tab
/car/:id/timeline -> Vehicle detail timeline tab
/fuel         -> Redirect to active vehicle fuel tab
/expenses     -> Redirect to active vehicle expenses tab
/analytics    -> v2 cross-car analytics
/reminders    -> Redirect to dashboard
/settings     -> Full settings page
```

The shell is responsive: mobile uses a three-item bottom navigation bar, tablet uses a rail, and desktop uses a persistent sidebar with logo, active-car switcher, navigation, and theme toggle. Search is available from the shell and through `Ctrl/Cmd + K`.

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

Brand assets live in `cars_manager/assets/icons/`. Platform-facing metadata is configured in:

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

Current coverage includes model business logic, generated analytics serialization, Riverpod provider behavior, and shared widget smoke tests. Future work should add golden coverage for the v2 dashboard, garage, vehicle detail, analytics, and settings screens in light and dark mode.
