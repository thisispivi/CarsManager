# Design System

CarsManager v2 is minimal, data-forward, responsive, and calm. It should feel like a premium personal finance product for vehicles: fast to scan, easy to act on, and consistent across mobile, web, and desktop.

---

## Brand Identity

**Positioning:** Your vehicle intelligence platform.

**Tagline:** Every cost. Every service. Total clarity.

**Brand feeling:** confident, calm, intelligent, premium, trustworthy.

**Do use:**
- Blue-to-green brand moments derived from the new logo
- Soft surfaces, generous spacing, and clear data hierarchy
- Semantic green/amber/red vehicle health states
- Compact, glanceable insights before detailed data
- Platform-specific navigation patterns

**Do not use:**
- Purple-indigo brand surfaces from v1
- Racing, chrome, gauge-heavy, or skeuomorphic automotive motifs
- Decorative gradients that do not communicate brand or state
- Dense long-scroll screens where filters or tabs would clarify intent

---

## Color Tokens

### Brand

| Token | Light | Dark | Usage |
|-------|-------|------|-------|
| `brandPrimary` | `#0062CC` | `#4A9EFF` | Primary actions, active navigation, links |
| `brandSecondary` | `#4AAD3A` | `#63C83E` | Healthy states and positive trends |
| `brandGradientStart` | `#004B9F` | `#004B9F` | Logo gradient start |
| `brandGradientEnd` | `#63C83E` | `#63C83E` | Logo gradient end |
| `brandAccent` | `#3D8FE8` | `#6BB5FF` | Selected chips, secondary highlights |
| `brandSubtle` | `#E8F1FC` | `#0D2240` | Active rows, subtle selected states |

### Surfaces

| Token | Light | Dark | Usage |
|-------|-------|------|-------|
| `surfacePrimary` | `#FFFFFF` | `#0F1114` | Page background |
| `surfaceSecondary` | `#F7F8FA` | `#161A1E` | Alternate sections and sidebar |
| `surfaceElevated` | `#FFFFFF` | `#1C2026` | Cards, panels, sheets |
| `borderDefault` | `#E4E7EC` | `#2A2E34` | Cards, dividers, inputs |
| `borderSubtle` | `#F0F2F5` | `#1E2226` | Quiet separators |
| `borderStrong` | `#CBD1D8` | `#3A4049` | Focus and stronger outlines |

### Text

| Token | Light | Dark | Usage |
|-------|-------|------|-------|
| `textPrimary` | `#0D1117` | `#F0F2F5` | Headings and body |
| `textSecondary` | `#5A6370` | `#8B95A3` | Captions and metadata |
| `textTertiary` | `#8B95A3` | `#5A6370` | Placeholders and disabled text |
| `textInverse` | `#FFFFFF` | `#0D1117` | Text on filled surfaces |

### Semantic

| Token | Light | Dark | Usage |
|-------|-------|------|-------|
| `success` | `#1EA85A` | `#4DCF82` | Valid, paid, healthy, positive |
| `warning` | `#E8960C` | `#FFB84C` | Upcoming or needs attention |
| `danger` | `#DC3545` | `#FF5858` | Overdue, destructive, errors |
| `info` | `#0062CC` | `#55A1FF` | Neutral information |

### Charts

Use chart colors in this order:

```text
1. #0062CC  brand blue
2. #1EA85A  green
3. #E8960C  amber
4. #DC3545  coral
5. #8B5CF6  violet
6. #06B6D4  cyan
```

---

## Typography

**Font:** Space Grotesk.

| Style | Size | Weight | Line Height | Usage |
|-------|------|--------|-------------|-------|
| `displayLarge` | 40 | 700 | 1.1 | Hero totals |
| `displayMedium` | 32 | 700 | 1.15 | Dashboard metrics |
| `headlineMedium` | 28 | 700 | 1.2 | Screen titles |
| `titleLarge` | 22 | 700 | 1.25 | Major section headings |
| `titleMedium` | 16 | 700 | 1.35 | Card titles |
| `bodyLarge` | 16 | 400 | 1.5 | Primary body |
| `bodyMedium` | 14 | 400 | 1.5 | Lists and secondary copy |
| `bodySmall` | 12 | 400 | 1.5 | Metadata |
| `labelLarge` | 14 | 700 | 1.4 | Buttons and controls |
| `labelMedium` | 13 | 600 | 1.4 | Chips and tabs |

Avoid negative letter spacing in compact controls. Let text wrap or stack at large accessibility text sizes.

---

## Spacing

An 8-point baseline grid:

| Token | Value | Usage |
|-------|-------|-------|
| `xxs` | 2 | Fine adjustments |
| `xs` | 4 | Icon gaps |
| `sm` | 8 | Related elements |
| `md` | 12 | Compact inner padding |
| `lg` | 16 | Standard card padding |
| `xl` | 24 | Section spacing |
| `xxl` | 32 | Tablet and desktop page padding |
| `xxxl` | 48 | Large vertical rhythm |

---

## Radius

| Token | Value | Usage |
|-------|-------|-------|
| `xs` | 4 | Small badges |
| `sm` | 8 | Inputs and compact controls |
| `md` | 12 | Standard cards |
| `lg` | 16 | Large cards and media |
| `xl` | 24 | Hero cards, dialogs, sheets |
| `xxl` | 32 | Onboarding and large brand surfaces |
| `pill` | 999 | Pills and circular controls |

---

## Elevation

Use subtle shadows in light mode and borders in dark mode.

| Token | Light Usage |
|-------|-------------|
| `xs` | Subtle card lift |
| `sm` | Default card |
| `md` | Floating panels and menus |
| `lg` | Dialogs and overlays |
| `brandGlow` | Active vehicle and selected hero surfaces |

---

## Components

### Navigation

| Width | Pattern | Destinations |
|-------|---------|--------------|
| `< 600` | Bottom `NavigationBar` | Home, Garage, Analytics |
| `600-1199` | `NavigationRail` | Home, Garage, Analytics, Settings |
| `>= 1200` | Persistent sidebar | Logo, active car switcher, nav, theme toggle |

### Cards

- Standard content cards use `surfaceElevated`, a 1px border, `xl` radius for v2 feature surfaces, and `sm` shadow in light mode.
- Vehicle cards use 16:9 media, bottom gradient overlays, and status pills.
- Do not nest cards inside cards unless the inner element is a repeated list item with a clear interaction role.

### Buttons

| Variant | Appearance | Usage |
|---------|------------|-------|
| Primary | Filled brand blue | Main action per view |
| Secondary | Outlined brand blue | Secondary action |
| Ghost | Text/icon only | Inline or tertiary action |
| Danger | Filled red | Destructive actions |
| Icon | Circular hit area | Search, close, edit, settings |

Controls must keep at least a 48dp hit target.

### Status Pills

| State | Condition | Color |
|-------|-----------|-------|
| Healthy | More than 30 days remaining | `success` |
| Upcoming | 0-30 days remaining | `warning` |
| Overdue | Date is past | `danger` |
| Missing | No data | `info` |

### Charts

- Lead with the insight, then show the chart.
- Prefer horizontal bars for category ranking and compact bar/line views for trends.
- Use semantic captions for charts so screen readers have a useful summary.
- Always show an empty state when data is insufficient.

---

## Motion

| Token | Duration | Curve | Usage |
|-------|----------|-------|-------|
| `fast` | 150ms | `easeOutCubic` | Buttons, chips, hover |
| `normal` | 250ms | `easeOutCubic` | Route and panel transitions |
| `slow` | 400ms | `easeOutCubic` | Complex surfaces |
| `emphasis` | 600ms | `elasticOut` | Success and delightful states |

Respect `MediaQuery.disableAnimations` for custom motion.

---

## Accessibility

- Normal text contrast must meet WCAG AA.
- Every icon-only button needs a tooltip.
- Charts and custom painters need semantic descriptions.
- Interactive controls need at least a 48dp target.
- Layouts must tolerate 200% text scale by stacking instead of clipping.
- Do not communicate vehicle status by color alone; include text like `Overdue`, `14 d`, or `No data`.

---

## Implementation Rules

1. Prefer theme tokens and `AppColorScheme` over raw colors.
2. Prefer `AppSpacing`, `AppRadius`, and `AppShadows` over magic numbers.
3. New primary UI belongs in `features/*` and shared primitives in `design_system/`.
4. Legacy `presentation/` widgets may remain only while migration is active or where they are reused by v2 flows.
5. Run `flutter analyze` and `flutter test` before release-facing changes.
