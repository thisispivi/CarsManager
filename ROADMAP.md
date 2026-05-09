# Roadmap

This document outlines planned features and milestones for CarsManager. Items are grouped by milestone — not by timeline — and subject to change.

---

## v1.1 — Architecture & Polish

**Theme:** Foundation overhaul and premium UI.

- [ ] Migrate state management from Provider to Riverpod 2.x
- [ ] Add GoRouter for URL-based navigation and deep linking
- [ ] Convert all models to Freezed + json_serializable
- [ ] New feature-first folder structure
- [ ] Redesigned color palette (derived from brand logo)
- [ ] Expanded typography scale (Space Grotesk)
- [ ] Adaptive scaffold (bottom nav → rail → sidebar)
- [ ] Redesigned Garage screen with hero car card
- [ ] New Car Detail screen with tab bar
- [ ] Redesigned Expenses screen
- [ ] New Analytics screen
- [ ] Redesigned Settings screen
- [ ] Full component library (`AppButton`, `AppCard`, `EmptyState`, etc.)
- [ ] Dark/light mode toggle — immediate persistence
- [ ] Unit and widget test suite
- [ ] Regenerate app icons from new logo (flutter_launcher_icons)
- [ ] Native splash screen (flutter_native_splash)

---

## v1.2 — Feature Completeness

**Theme:** Everything you need to track your vehicle fully.

- [ ] Mileage tracking on fuel entries and repairs
- [ ] Fuel efficiency (L/100km) computation and chart
- [ ] Recurring expense tracking (annual insurance, road tax auto-scheduling)
- [ ] Export to CSV / share as PDF from Analytics
- [ ] Document storage — attach image/PDF receipts to expense entries
- [ ] Smart notifications — configurable per item type (90/30/7/0 days)
- [ ] Complete notification → deep link integration
- [ ] Multi-car analytics dashboard (aggregate across all vehicles)

---

## v1.3 — Intelligence

**Theme:** Predictions, insights, and smart recommendations.

- [ ] Cost prediction — projected annual cost based on history
- [ ] Yearly cost comparison vs previous year
- [ ] "Most expensive month" insight card
- [ ] Fuel price trend alerts
- [ ] Service interval reminders (km-based, not date-based)
- [ ] Car resale value estimator (based on year, mileage, make)

---

## v2.0 — Cloud Sync

**Theme:** Multi-device support with local-first architecture.

- [ ] `SyncRepository` interface (local-first, conflict-free)
- [ ] Optional cloud backup (no mandatory account)
- [ ] Export / import full data archive
- [ ] Cross-device sync via encrypted JSON payload
- [ ] Web app first-class experience (desktop sidebar, keyboard navigation)

---

## Backlog

Features under consideration, not yet scheduled:

- iOS App Store release
- Widget (home screen) showing next due date
- Car community / tips (opt-in)
- Fuel station map integration
- OBD-II adapter support (diagnostics)
- Offline-first PWA caching

---

## Won't do

- Social features (sharing, leaderboards)
- Advertising or data monetisation
- Mandatory account creation
