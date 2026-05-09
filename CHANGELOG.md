# Changelog

All notable changes to CarsManager are documented here.

Format: [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
Versioning: [Semantic Versioning](https://semver.org/).

---

## [Unreleased]

### Added
- Comprehensive CI/CD pipeline with Flutter build jobs for Android and Web
- Tag-triggered automated GitHub Releases with APK artifacts
- GitHub Pages deployment workflow for web builds
- Pull request template and issue templates (bug report, feature request)
- Conventional commit enforcement via `commitlint` and Husky `commit-msg` hook
- `flutter_launcher_icons` and `flutter_native_splash` configuration
- Full documentation suite: CONTRIBUTING, ARCHITECTURE, DESIGN_SYSTEM, RELEASE, ROADMAP, SECURITY, CODE_OF_CONDUCT, ENVIRONMENT_SETUP
- Strict `analysis_options.yaml` with 15+ lint rules

### Changed
- Package identifier updated from `com.example.cars_manager` to `io.carsmanager.app`
- App label changed from "Cars Manager" to "CarsManager" across all platforms
- Web manifest: brand colours (`#1A56FF` primary, `#0F1114` background), correct product description
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
