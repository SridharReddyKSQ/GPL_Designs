# Handoff: GPL Portal Mobile (Guyana Power & Light customer app)

## Overview
A mobile-first self-service portal for Guyana Power & Light (GPL) customers: sign in/register, view the outage/dashboard overview, report outages and faults, raise and track service requests, view/pay bills, and check consumption. Built as HTML/CSS/JS design prototypes (Design Components) — this bundle documents them for a real implementation.

## About the Design Files
The files in this bundle are **design references built in HTML** — high-fidelity prototypes of look, layout and interaction, not production code to copy directly. The task is to **recreate these HTML designs in the target codebase's environment** (React Native is the intended target per the design system — see below — but React/Vue/native are equally valid if that's the existing stack), using the codebase's own component/state patterns. Do not ship the HTML files as-is.

## Fidelity
**High-fidelity.** Colors, type, spacing, icons, copy and interaction states are final-intent. Recreate pixel-for-pixel using the target stack's equivalent primitives.

## Design system
Built against the **Guyana Government Portal design system** (React Native intended target; Inter typeface; Lucide icon set). Key tokens below are pulled from its `colors_and_type.css`. GPL's own agency accent overrides the neutral base:
- `--agency-accent: #404293` (indigo/blue-violet) — GPL's brand accent, used for primary actions, active nav, links, focus rings
- `--agency-accent-strong: #323373` — hover/press state of the accent
- `--agency-accent-soft: rgba(64,66,147,0.12)` — tinted chip/icon backgrounds, selected-state fills
- `--agency-accent-ring: rgba(64,66,147,0.30)` — 3px focus ring
- `--agency-contrast: #ffffff` — text/icon color on filled accent surfaces
- Neutral ink scale: `--fg-1` (near-black body text) → `--fg-4` (disabled/placeholder)
- Surfaces: `--surface-1` (white cards), `--surface-2`/`--surface-4` (light insets/chips), app background `#eef2f8`
- Status colors (semantic, agency-independent): success/warning/error/info, each with a soft background pair (e.g. `--status-success`, `--status-success-bg`)
- Radii: 12px inputs/chips, 16px cards, 20-28px large panels/sheets, pill (999px) for buttons/badges/tabs
- Shadows: soft, diffuse, multi-layer ambient (never hard-edged)
- Motion: spring-eased micro-interactions on every control — hover = lift + shadow deepen, press = scale to ~0.96, focus = visible 3px accent ring. Durations ~120-260ms.
- Type: Inter, 400-800 weight. Body 17px baseline; this app runs a tighter mobile scale (13-16px body/label text, 15-19px headings) to fit a 480px-max mobile viewport.

## Screens / Views

### 1. Login (`GPL Login Final.dc.html`)
- **Purpose:** Sign in with email + password, or jump to registration / forgot-password.
- **Layout:** Government-portal-style hero header — navy gradient (`rgb(8,23,47)` → `rgb(54,77,115)`, 180deg) with a faint Government of Guyana coat-of-arms watermark image bled off the right edge, GPL logo mark + gold uppercase wordmark, large white "GPL Online" title, a gold tagline, a short gold underline rule, and a white one-line service promise — over a white card (28px top corner radius) containing the sign-in form. Single column, max-width 480px, centered.
- **Components:** Email field, password field (show/hide toggle, 44px tap target), right-aligned "Forgot password?" link, primary "Sign in" button (full width pill, GPL brand blue `#1a3fa0`), "New to GPL Online? Create account" line, and a footer with a "Having trouble signing in? Get help" link + "Official Cooperative Republic of Guyana Portal" attribution line.
- **Behavior:** Client-side validation on submit; successful login routes to Dashboard. "Forgot password" opens a reset-password sub-view with a secondary "Back to sign in" button.

### 2. Registration (`GPL Registration Final.dc.html`)
- **Purpose:** New customer account creation, matched against GPL's billing records (customer/account/meter number) so the account binds to a real connection.
- **Layout:** Plain white sticky header (rounded back button + title). Below it, a progress bar (not a two-dot stepper) showing the current step label on the left and "Step 1 of 2" on the right, with a filled track underneath. Includes a "View sample bill" secondary button that opens an illustrative bill image with the 3 required numbers highlighted, and an explanatory note on where to find them.
- **Components:** Multi-field form (name, email, mobile, password, customer/account/meter numbers), inline validation, primary submit button.
- **Behavior:** Submits to OTP verification.

### 3. OTP Verification (`GPL OTP Verification.dc.html`)
- **Purpose:** Verify mobile number or email via one-time code after registration.
- **Layout:** Plain white sticky header — rounded back button + title + one-line subline — matching the Registration screen's header exactly (no hero/gradient treatment on this screen).
- **Components:** Step progress row ("Your details" done / "Verify" current), 6-digit code input (segmented boxes), countdown/resend control, primary "Verify" button.

### 4. Dashboard (`GPL Dashboard.dc.html`) — the shell
- **Purpose:** Home base after login; also the layout shell that mounts every other authenticated screen (Outages, Services, Bills, Consumption, Recent Bills, FAQ, Preferences) as sub-views so the header/footer chrome stays consistent.
- **Layout (mobile):** Fixed 64px top header (logo/back button + page title + notification bell w/ badge + hamburger), scrollable content area, fixed bottom tab bar with 3 primary destinations + "Menu" (opens a right-side drawer with the remaining nav items + account). A floating chat-assistant button (bottom-right) sits above the tab bar/submit bars.
- **Overview content:** connection switcher (multiple service addresses/accounts), active-outage banner (if any), a 2x2 quick-actions grid (bill / consumption / meter issue / track requests), a "Monthly consumption" mini chart card, and a recent-activity list.
- **State:** `active` (which sub-view is showing), `subpage` (set by child views to swap the header into a back-button + sub-title, and to hide the bottom tab bar during focused task flows — see below), `conns` (the customer's connections), plus modal/sheet state for account switching, add-connection, etc.
- **Key behavior — task-flow chrome:** When a child view (Outages/Services) enters a multi-step flow (report a problem, service request form, category picker), it calls `onSubpage({active, title, onBack})`. The Dashboard shell then: (a) swaps the top header to show a back arrow + the flow's title instead of the tab-bar title, and (b) **hides the bottom tab bar entirely** so the task stays focused (no competing nav). Reproduce this pattern faithfully — losing it re-introduces a real usability bug (users abandoning a multi-step form via the tab bar).

### 5. Outages & Faults (`GPL Outages and Faults.dc.html`, mounts `GPL Service Requests.dc.html` in "outages" mode)
- **Purpose:** See active outages affecting the customer's area, report a new outage/fault, and track previously reported outages.
- **Layout:** Header with "Outages & faults" / "My outage reports" tabs (hidden during the report flow, see above). Status view shows outage cards (planned/unplanned, "reported in your area" banner with an "I'm affected" counter) and a map entry point. Track view lists the customer's own open/closed reports with a status stepper.
- **Sub-flow — Report a problem:** 4-step wizard (category → details → review → confirmation), each step shown via a compact progress/step label ("Step X of 4"), not a full stepper bar. Category step offers Planned/Unplanned/Non-Outage plus an escape-hatch "None of these — I will describe it." A "third-party" path lets a customer report on someone else's account (requires name + address + customer or account number). Step 4's sticky bottom bar holds a note + a **secondary "Back" button (left) + primary "Check and submit" → "Submit report" button (right)**, space-between aligned, each sized to content (not full-bleed) — reserve ~54-78px of bottom clearance so the floating chat button never overlaps the last list item.
- **Confirmation screen:** green circular check icon + "Report logged" heading, a summary sentence, a 2-up reference-number/priority fact row, a numbered "What happens next" list (agency's actual process steps, varies by fault type), and — for meter faults — a warning-toned "back-billing may apply" notice.
- **Outage map (`GPL Outage Map.dc.html`):** Leaflet-based map (via CDN) showing outage zones as pins/polygons with a detail panel on pin tap; opens from the outage banner or "View on map."

### 6. My Services (`GPL Service Requests.dc.html`, "services"/default mode)
- **Purpose:** Raise and track non-outage service requests (new connection, meter/prepaid issues, billing queries, etc.) via a category catalogue.
- **Layout:** "My services" / "Closed" tabs (also hidden during a task flow) → category picker ("Which service do you need?" heading, tooltip: "Pick the closest match. Each category opens the requests you can raise there.") → family sub-list → request form → confirmation, following the same chrome-hiding rule as Outages.
- **Components:** Category tiles with icon chip + title + one-line hint; each opens either a further family list or directly the relevant form (some routed through `GPL Report an Issue.dc.html` in non-outage mode for meter/prepaid faults).

### 7. Bills and Payments (`GPL Bills and Payments.dc.html`)
- **Purpose:** View current bill, pay it, see payment history, manage saved payment methods, and pay on behalf of another account.
- **Layout:** Tab row (Pay / History / Methods, roughly) inside a bordered header; a current-bill summary card with a "Download PDF" icon-button; a payment-methods list with an "Add a payment method" secondary button; a "Find another account" flow for paying someone else's bill; a paid-total summary + "Download statement" secondary button.
- **Payment confirmation bottom bar:** same left/right pattern as the report flow — secondary "Back" button (left) + primary pay button (right), space-between, each full-content-width (not stretched), 48px tall, with a receipt note above and ~112px of reserved bottom clearance. Processing state shows an inline spinner + label in place of the button.

### 8. Consumption (`GPL Consumption.dc.html`)
- **Purpose:** Chart of monthly kWh usage with 6/12-month range toggle, plus 3 summary stat cards.
- **Layout:** Meter-type badge (Prepaid/Postpaid) + connection picker row, a bar chart (12-month view shows all 12 bars shrunk to fit — no horizontal scroll), and a 3-up grid of stat cards: "Average daily use" (accent-tinted sun icon chip), "Same period last year" (accent-tinted history icon chip), "Days billed" (accent-tinted calendar icon chip, with a "View bill" link). All three icon chips share the **same accent-soft background + accent-colored icon** treatment — do not mix in a neutral-grey chip style, it should read as one consistent card family.
- **Standalone nav:** when opened outside the Dashboard shell (e.g. directly, for dev review), shows its own small top nav bar linking back to Dashboard/Outages/Services/Bills/Recent Bills.

### 9. Recent Bills (`GPL Recent Bills.dc.html`)
- **Purpose:** Full bill history list (beyond what fits on the Bills tab), each row showing month, issue date, amount, status.
- **Note:** Ships with representative demo data so the screen never renders empty when opened standalone.

### 10. Help Chat (`GPL Help Chat.dc.html`)
- **Purpose:** Floating assistant launcher (bottom-right, persistent on all authenticated screens) that expands into a full-screen chat sheet; supports a voice/mic bar.
- **Positioning rule:** the launcher's bottom offset is computed from two CSS custom properties set by whichever screen is active — `--gpl-nav-h` (bottom tab bar height, 0 when hidden) and `--gpl-submit-h` (any sticky submit/pay bar's height, including a reserved amount during list-only wizard steps that have no bar of their own). Always keep the launcher clear of the last item in any scrolling list.

### 11. Portal shell / router (`GPL Portal Mobile.dc.html`)
- Wraps everything in an iOS device frame for presentation and provides simple client-side routing between Login → Registration → OTP → Dashboard (and deep-links straight into a Dashboard section, e.g. Outages, Services, Bills, Consumption, Recent Bills) purely for design-review purposes. **This routing shell is a presentation convenience, not part of the product** — the real app's navigation should be built natively in whatever framework is chosen (e.g. React Navigation for React Native).
- Contains a `fitScale()` routine that scales the phone-frame content to fit the available viewport height; guards against measuring a height of 0 on first mount (retries via requestAnimationFrame) — a reminder that any "fit to viewport" scaling logic in the real app needs the same defensive check.

### 12. Site Map (`GPL Site Map.dc.html`)
- A print-ready reference document enumerating every screen, sub-flow and feature in the app, for stakeholder review/PDF export. Not part of the product UI.

## Interactions & Behavior (cross-cutting)
- **Bottom sheets:** every bottom sheet in the app includes a visible close control.
- **Back navigation:** every screen reachable from Dashboard has a rounded, bordered back button in the header (not just a bare chevron) matching the style used across the app.
- **Task-flow chrome:** any multi-step flow (report an issue, service request form) hides the outer tab bar and secondary tab row for its duration, and reserves clearance so the floating chat button never sits on top of list content (see Dashboard and Outages/Services sections above).
- **Card truncation:** list/summary cards keep a single-line title with `text-overflow: ellipsis` rather than wrapping to a second line; cards in the same row are equal height.
- **Toggles:** styled as pill switches (GPL-blue when on), consistent everywhere a boolean setting appears.
- **Primary vs secondary buttons:** primary = filled accent pill, white text; secondary = white/bordered pill, accent or ink text (used for Back, Cancel, "Add a payment method", "Download statement", etc.) — see the design system Button component for the canonical variants.
- **Footer text:** font-weight 500 throughout.
- **Header titles:** font-weight 700.
- **Tooltips:** used next to section headings to add one-line clarifying context (e.g. category pickers) without cluttering the heading itself.
- **All internal pages are click-through linked** to each other (Dashboard ⇄ Outages ⇄ Services ⇄ Bills ⇄ Consumption ⇄ Recent Bills) both via the Portal Mobile shell's router and via small standalone nav bars on pages that can be opened in isolation, so the whole prototype is navigable without a live backend.

## State Management
- Screen-level state lives in each Design Component's own class state (React-class-style: `state = {...}`, `this.setState`).
- Dashboard is the source of truth for: active section, current connection/account, subpage (task-flow chrome signal), bill-payment lock/dirty flags, notification/alert list, and various modal/sheet open flags.
- Cross-component signalling uses small custom DOM events (e.g. `gpl-goto-outages`, `gpl-open-service-request`, `gpl-requests-count`) rather than a shared store — in a real app, replace with your normal state-management approach (Redux/Zustand/Context/etc.); the events named above indicate the actual cross-screen dependencies to preserve.
- Bills/Consumption/Outages/Services all accept an `embedded` prop so they know whether to render their own standalone top nav or defer entirely to the Dashboard shell's chrome — mirror this as a "mounted inside app shell vs. deep-linked/standalone" concept if your app has an equivalent case (e.g. universal links).

## Design Tokens
See the "Design system" section above for the full token set. Quick reference:
- Accent (app-wide primary): `#404293` / hover `#323373` / soft `rgba(64,66,147,.12)` / ring `rgba(64,66,147,.30)`
- Login-screen-only palette: hero gradient `rgb(8,23,47)` → `rgb(54,77,115)`; gold accent `rgb(232,194,128)`; navy heading ink `rgb(11,29,58)`; primary button `#1a3fa0` (GPL logo blue)
- App background: `#eef2f8`; card surface: `#ffffff`; card border: `rgba(19,28,46,0.10)`
- Radii: 12 / 16 / 20-28 / pill(999)
- Button height: 44-48px; min tap target 44px
- Max content width: 480px (mobile-only app — every screen is capped at this width)
- Font: Inter, weights 400/500/600/700/800; icons: Lucide, stroke width 2

## Assets
Icons are Lucide (CDN), font is Inter (Google Fonts CDN), outage map uses Leaflet + OpenStreetMap tiles (CDN). One custom image: `assets/coat-of-arms-watermark.png` (Government of Guyana coat of arms, faint watermark on the Login header) — included in this bundle's `assets/` folder.

## Files
All screens are single-file HTML Design Components in the project root:
- GPL Login Final.dc.html
- GPL Registration Final.dc.html
- GPL OTP Verification.dc.html
- GPL Dashboard.dc.html (shell + overview)
- GPL Outages and Faults.dc.html
- GPL Outage Map.dc.html
- GPL Outages and Faults.dc.html
- GPL Outage Map.dc.html
- GPL Service Requests.dc.html (shared by Outages "report" flow and My Services catalogue)
- GPL Report an Issue.dc.html (the report/request wizard + confirmation, mounted by both of the above)
- GPL Bills and Payments.dc.html
- GPL Consumption.dc.html
- GPL Recent Bills.dc.html
- GPL Help Chat.dc.html
- GPL Portal Mobile.dc.html (review-only device-frame shell/router — not part of the product)
- GPL Site Map.dc.html (review-only feature index — not part of the product)

A working, click-through export of the whole flow is included as `GPL Portal Mobile (Offline).html` — open it in any browser to walk every screen end to end without needing this design tool.
