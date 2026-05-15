# Changelog

All notable changes to CarsManager are documented here.

Format: [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
Versioning: [Semantic Versioning](https://semver.org/).

---

## [Unreleased]

### Added
- CarsManager v2 dashboard with active-car hero, quick actions, upcoming deadlines, recent activity, and monthly summary.
- Vehicle detail route with Overview, Fuel, Expenses, and Timeline tabs.
- Cross-car analytics dashboard with insight cards, category ranking, cost overview, car comparison, and monthly trend table.
- Global search overlay for cars, fuel entries, and expenses with `Ctrl/Cmd + K`.
- First-run onboarding flow using the new brand direction.
- Responsive app shell: mobile bottom navigation, tablet rail, and desktop sidebar with active-car switching.
- Full settings route with theme, language, units, currency, reminders, export, and reset controls.
- `ThemeExtension`-based v2 color scheme and blue-to-green design tokens.
- `flutter_animate` for onboarding and motion polish.
- Comprehensive CI/CD pipeline with Flutter build jobs for Android and Web
- Tag-triggered automated GitHub Releases with APK artifacts
- GitHub Pages deployment workflow for web builds
- Pull request template and issue templates (bug report, feature request)
- Conventional commit enforcement via `commitlint` and Husky `commit-msg` hook
- `flutter_launcher_icons` and `flutter_native_splash` configuration
- Full documentation suite: CONTRIBUTING, ARCHITECTURE, DESIGN_SYSTEM, RELEASE, ROADMAP, SECURITY, CODE_OF_CONDUCT, ENVIRONMENT_SETUP
- Strict `analysis_options.yaml` with 15+ lint rules

### Changed
- Version bumped to `2.0.0+1`.
- Graphical overhaul: updated the brand palette from purple-indigo to blue-green, added logo-aligned gradient tokens, refreshed navigation, themed forms/buttons/cards, and redesigned garage vehicle cards.
- Home now launches into the v2 dashboard after onboarding instead of the garage management view.
- Global Fuel, Expenses, and Reminders tabs now redirect into dashboard or per-vehicle detail contexts.
- Replaced hardcoded navigation, analytics, reminders, and settings strings with localization keys.
- Removed screen-level `GoogleFonts.spaceGrotesk()` calls so typography flows through the app theme.
- Hardened image handling for mobile file picking and corrupt base64 data.
- Package identifier updated from `com.example.cars_manager` to `io.carsmanager.app`
- App label changed from "Cars Manager" to "CarsManager" across all platforms
- Web manifest: brand colours (`#004B9F` primary, `#0F1114` background), correct product description
- Web `index.html`: proper title, description, theme-color, and `lang="en"` attribute
- iOS `Info.plist`: display name and bundle name updated to "CarsManager"
- `pubspec.yaml`: professional product description

---

## [1.0.0] — 2025-05-01

### Added
- Initial release
- Multi-vehicle garage (add, edit, delete cars with photo and metadata)
- Fuel consumption tracking with charts (cost, avg price, volume by year)
- Payment/expense tracking: insurance, inspection (MOT), road tax, repairs, traffic fines
- Due date reminders with OS notifications (configurable intervals)
- In-app notification centre
- Yearly expense analytics with donut and stacked bar charts
- Dark and light theme support
- English and Italian localization
- Provider-based state management
- JSON local storage (file on mobile, localStorage on web)
- Pre-commit hooks: `dart format`, `dart analyze`, `flutter test`
- GitHub Actions CI: dart analyze + dart test

[Unreleased]: https://github.com/apirasp/CarsManager/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/apirasp/CarsManager/releases/tag/v1.0.0
