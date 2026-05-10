# Design System

CarsManager's design system is minimal, data-focused, and premium. Inspired by Revolut, Linear, and Bolt — not traditional automotive UI.

---

## Brand identity

**Brand voice:** Intelligent. Clean. Efficient.

**Do not use:**
- Metallic or chrome textures
- Racing aesthetics or speed motifs
- Aggressive dark automotive themes
- Skeuomorphic dashboards
- Overly masculine or aggressive colour palettes

**Do use:**
- Generous whitespace
- Soft, rounded surfaces
- Vibrant but restrained accent colours
- Data-forward layouts
- Subtle shadows, not heavy borders

---

## Color palette

Derived from the CarsManager logo gradient: `#004B9F` (deep blue) → `#63C83E` (vivid green).

### Brand tokens

| Token | Value | Usage |
|-------|-------|-------|
| `brandPrimary` | `#1A56FF` | Primary actions, active states, links |
| `brandSecondary` | `#4DCF82` | Success states, positive metrics, brand accent |
| `brandAccent` | `#5C7CFA` | Secondary actions, highlights |

### Surface tokens (Light)

| Token | Value | Usage |
|-------|-------|-------|
| `surfaceLight` | `#FFFFFF` | Page background |
| `surfaceAlt` | `#F7F8FA` | Alternate sections, sidebar |
| `cardLight` | `#F0F2F5` | Card backgrounds |
| `borderLight` | `#E4E7EC` | Dividers, input borders |

### Surface tokens (Dark)

| Token | Value | Usage |
|-------|-------|-------|
| `surfaceDark` | `#0F1114` | Page background |
| `surfaceAltDark` | `#181B1F` | Alternate sections, sidebar |
| `cardDark` | `#1E2226` | Card backgrounds |
| `borderDark` | `#2A2E34` | Dividers, input borders |

### Text tokens

| Token | Value | Usage |
|-------|-------|-------|
| `textPrimary` | `#0D1117` | Body text, headings (light mode) |
| `textSecondary` | `#6B7280` | Secondary labels, captions |
| `textDisabled` | `#B0B7C3` | Disabled states, placeholders |
| `textInverse` | `#FFFFFF` | Text on dark backgrounds |

### Semantic tokens

| Token | Value | Usage |
|-------|-------|-------|
| `success` | `#4DCF82` | Paid, valid, good status |
| `warning` | `#FFB84C` | Upcoming, needs attention |
| `danger` | `#FF5858` | Overdue, error, critical |
| `info` | `#55A1FF` | Informational, neutral |

### Chart palette

Order is intentional — most prominent category gets the first colour.

```
1. #1A56FF  (blue)
2. #4DCF82  (green)
3. #FFB84C  (amber)
4. #FF5858  (coral)
5. #AA82FF  (violet)
```

---

## Typography

**Font:** Space Grotesk (Google Fonts) — modern, humanist, highly legible.

### Type scale

| Style | Size | Weight | Line height | Letter spacing | Usage |
|-------|------|--------|-------------|----------------|-------|
| `displayLarge` | 40 | 700 | 1.1 | -1.2 | Hero numbers, empty state titles |
| `displayMedium` | 32 | 700 | 1.15 | -0.8 | Dashboard metric values |
| `headingLarge` | 24 | 700 | 1.2 | -0.4 | Screen titles |
| `headingMedium` | 20 | 600 | 1.25 | -0.3 | Section titles |
| `headingSmall` | 16 | 600 | 1.3 | -0.1 | Card titles, list headers |
| `bodyLarge` | 16 | 400 | 1.5 | 0 | Primary body text |
| `bodyMedium` | 14 | 400 | 1.5 | 0 | Secondary body, list items |
| `bodySmall` | 12 | 400 | 1.5 | 0 | Captions, metadata |
| `label` | 13 | 500 | 1.4 | 0.1 | Form labels, chip text |
| `caption` | 11 | 400 | 1.4 | 0.2 | Timestamps, fine print |
| `buttonText` | 15 | 600 | 1.0 | 0.1 | Button labels |

---

## Spacing

An 8-point baseline grid. Use only these values.

| Token | Value | Usage |
|-------|-------|-------|
| `xxs` | 2 dp | Fine adjustments, icon padding |
| `xs` | 4 dp | Icon gaps, tight spacing |
| `sm` | 8 dp | Between related items |
| `md` | 12 dp | Inner card padding (compact) |
| `lg` | 16 dp | Standard card padding, between sections |
| `xl` | 24 dp | Between major sections |
| `xxl` | 32 dp | Screen horizontal padding |
| `xxxl` | 48 dp | Hero sections, large gaps |

---

## Border radius

| Token | Value | Usage |
|-------|-------|-------|
| `xs` | 4 dp | Small chips, badges |
| `sm` | 8 dp | Input fields, small cards |
| `md` | 12 dp | Standard cards |
| `lg` | 16 dp | Large cards, bottom sheets |
| `xl` | 24 dp | Hero cards |
| `xxl` | 32 dp | Full-width hero sections |
| `pill` | 999 dp | Status pills, circular buttons |

---

## Elevation & shadows

Use shadows instead of border + background to separate layers.

| Token | Value | Usage |
|-------|-------|-------|
| `xs` | blur 4, offset (0,1), opacity 4% | Subtle card lift |
| `sm` | blur 8, offset (0,2), opacity 6% | Default card |
| `md` | blur 16, offset (0,4), opacity 8% | Floating elements, dropdowns |
| `lg` | blur 32, offset (0,8), opacity 10% | Modals, bottom sheets |

Shadow color is always `#000000` (opacity varies). Never use hard borders as a substitute for elevation.

---

## Animation

| Token | Duration | Curve | Usage |
|-------|----------|-------|-------|
| `fast` | 150 ms | `easeOutCubic` | Hover states, small transitions |
| `normal` | 250 ms | `easeOutCubic` | Screen transitions, modals |
| `slow` | 400 ms | `easeOutCubic` | Hero transitions, onboarding |
| `spring` | 600 ms | `elasticOut` | FAB entrance, success states |

---

## Components

### AppButton

Four variants:

| Variant | Appearance | Usage |
|---------|-----------|-------|
| `primary` | Filled, `brandPrimary` background | Main actions per screen |
| `secondary` | Outlined, `brandPrimary` border | Secondary actions |
| `ghost` | No background/border, `brandPrimary` text | Tertiary/inline actions |
| `danger` | Filled, `danger` background | Destructive actions (delete, reset) |

States: idle, hover (web), pressed, loading (shows `CircularProgressIndicator`), disabled.

### AppCard

- Background: `cardLight` / `cardDark`
- Border radius: `md` (12 dp) by default, `lg` (16 dp) for hero cards
- Shadow: `sm` by default
- Padding: `lg` (16 dp) standard, `xl` (24 dp) for hero cards

### StatusPill

Used for due date states across the app.

| State | Color | Condition |
|-------|-------|-----------|
| `ok` | `success` (`#4DCF82`) | > 30 days remaining |
| `upcoming` | `warning` (`#FFB84C`) | 0–30 days remaining |
| `overdue` | `danger` (`#FF5858`) | Past due date |

### EmptyState

All empty states share this structure:
1. Icon (48 dp, `textSecondary` colour)
2. Title (`headingSmall`)
3. Subtitle (`bodyMedium`, `textSecondary`)
4. CTA button (`AppButton.primary`)

---

## Iconography

- **Source:** Material Icons (included with Flutter)
- **Outlined style** preferred over filled for UI icons
- **Sizes:** `xs` (16), default (24), `lg` (32) — from `AppDimensions`
- **Colour:** inherit from context (matches text colour by default)
- **Custom SVG icons:** located in `assets/icons/` for brand-specific elements (fine.svg, inspection.svg)

---

## Adaptive layout breakpoints

| Breakpoint | Width | Navigation |
|------------|-------|-----------|
| Mobile | < 600 dp | `NavigationBar` (bottom) |
| Tablet | 600–1199 dp | `NavigationRail` (left, compact) |
| Desktop | ≥ 1200 dp | `NavigationDrawer` (left, persistent) |

Content columns:
- Mobile: 1 column (full width)
- Tablet: 2 columns (grid)
- Desktop: 3 columns (grid) + sidebar

---

## Usage rules

1. **Never use raw colour values** in widget code — always use `AppColors.*` tokens.
2. **Never use raw `TextStyle`** — always use `AppTextStyles.*` tokens.
3. **Never use raw numbers** for spacing — always use `AppSpacing.*` or `AppRadius.*`.
4. **Shared components first** — before writing a custom widget, check `presentation/common/widgets/` for an existing component.
5. **Dark mode always** — every component must look correct in both light and dark mode. Test both.
