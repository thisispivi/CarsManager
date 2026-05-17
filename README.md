<div align="center">
  <img src="cars_manager/assets/icons/CarsManagerLogo.png" alt="Cars Manager" height="96" />
  <h1>Cars Manager</h1>
  <p><strong>Your vehicle intelligence platform.</strong></p>
  <p>Every cost. Every service. Total clarity.</p>

  [![CI](https://github.com/apirasp/CarsManager/actions/workflows/ci.yml/badge.svg)](https://github.com/apirasp/CarsManager/actions/workflows/ci.yml)
  [![Release](https://img.shields.io/github/v/release/apirasp/CarsManager?include_prereleases&label=release)](https://github.com/apirasp/CarsManager/releases)
  [![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
  [![Flutter](https://img.shields.io/badge/Flutter-stable-02569B?logo=flutter)](https://flutter.dev)
  [![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-brightgreen)](https://github.com/apirasp/CarsManager)
</div>

---

## Overview

Cars Manager is a privacy-first vehicle management app built with Flutter. It keeps vehicle health, fuel history, expenses, reminders, and analytics in one local-first workspace.

The v2 experience reframes the app from a simple car utility into a personal vehicle intelligence platform: a glanceable dashboard, image-led garage, per-vehicle detail pages, cross-car analytics, search, onboarding, and responsive layouts for mobile, tablet, web, and desktop.

---

## Features

| Category | Details |
|----------|---------|
| Dashboard | Active vehicle hero, upcoming deadlines, recent activity, quick actions, monthly summary |
| Garage | Responsive car list/grid with active vehicle state, imagery, status pills, edit/delete actions |
| Vehicle Detail | Overview, Fuel, Expenses, and Timeline tabs per car |
| Fuel | Period filters, spend/liter metrics, visible calculation flow, entry history |
| Expenses | Insurance, inspection, tax, repair, and fine tracking with category filters |
| Analytics | Localized insights, per-car filter chips, cost overview, category ranking, car comparison, monthly trend table, CSV export |
| Search | Global search for cars, fuel entries, and expenses with keyboard access |
| Reminders | Local due-date notifications for insurance, inspection, and tax, with Android exact-alarm fallback |
| Settings | Full settings page for theme, language, units, currency, notification preferences, export, and reset |
| Onboarding | First-run product introduction stored with SharedPreferences |
| Platform | Mobile bottom navigation, tablet rail, desktop sidebar, web URLs, light and dark themes |

---

## Design

Cars Manager v2 uses a warm, data-friendly identity:

- Coral accent surfaces for primary emphasis and analytics hero moments
- Warm cream backgrounds in light mode and warm charcoal surfaces in dark mode
- Semantic category colors for fuel, insurance, inspection, tax, repairs, and fines
- Typography: Space Grotesk across UI and data-heavy surfaces

The interface favors soft cards, restrained shadows, compact insight blocks, accessible semantic colors, and platform-specific navigation rather than a mobile layout stretched onto desktop.

See [DESIGN_SYSTEM.md](DESIGN_SYSTEM.md) for tokens and component rules.

---

## Tech Stack

| Layer | Technology |
|-------|------------|
| Framework | Flutter stable |
| Language | Dart 3.x |
| State management | Flutter Riverpod 2.x with generated `@riverpod` providers |
| Navigation | GoRouter with URL-backed routes |
| Models | Freezed and json_serializable |
| Storage | Local JSON file on native platforms, `localStorage` on web |
| Charts | fl_chart plus custom lightweight chart components |
| Motion | flutter_animate and Material motion primitives |
| Typography | Google Fonts / Space Grotesk |
| Notifications | flutter_local_notifications |
| Sharing | share_plus CSV export |
| Tooling | GitHub Actions, Husky, lint-staged, commitlint |

---

## Quick Start

```bash
git clone https://github.com/apirasp/CarsManager.git
cd CarsManager
npm install

cd cars_manager
flutter pub get
flutter run
```

For web:

```bash
cd cars_manager
flutter run -d chrome
```

Useful checks:

```bash
cd cars_manager
flutter analyze
flutter test
```

See [ENVIRONMENT_SETUP.md](ENVIRONMENT_SETUP.md) for full setup and troubleshooting.

---

## Architecture

```text
cars_manager/lib/
├── app/                  # App root and GoRouter configuration
├── core/                 # Theme tokens, responsive helpers, services, storage
├── design_system/        # Atoms, molecules, organisms, and chart wrappers
├── features/             # Home, garage, vehicle detail, analytics, search, settings, onboarding
├── l10n/                 # ARB files and generated localizations
├── models/               # Vehicle, fuel, payment, and domain models
├── presentation/         # Legacy pages/widgets still used during migration
└── main.dart             # Bootstrap and ProviderScope
```

The current migration keeps stable legacy form widgets where they are still useful, while routing and primary navigation now favor the v2 feature screens.

See [ARCHITECTURE.md](ARCHITECTURE.md) for deeper implementation notes.

---

## Project Docs

- [Architecture](ARCHITECTURE.md)
- [Design System](DESIGN_SYSTEM.md)
- [Environment Setup](ENVIRONMENT_SETUP.md)
- [Release Process](RELEASE.md)
- [Roadmap](ROADMAP.md)
- [Security](SECURITY.md)

---

## License

[MIT](LICENSE) - Copyright (c) 2025 Andrea Piras
