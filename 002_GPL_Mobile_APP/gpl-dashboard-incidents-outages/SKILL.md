---
name: gpl-dashboard-incidents-outages
description: Build or update the GPL Portal Mobile Dashboard and Incidents & outages screens exactly as designed (layout, values, content, behaviour). Use when coding, reviewing or extending either screen.
---

# GPL Portal Mobile: Dashboard and Incidents & outages

This skill describes two screens of the GPL Portal Mobile app (Guyana Power & Light) as they are in the V1.3 design (20 Nov 2026):

1. **Dashboard**: the home tab.
2. **Incidents & outages**: the second tab, where customers report faults and track outage reports.

Every value below is measured from the working prototype. Only values the app actually uses are listed. Don't pull other values from the design system.

Source files in the project: `GPL Dashboard.dc.html` (holds both screens, the shell and the routing), `GPL Outages and Faults.dc.html` → `GPL Service Requests.dc.html` (outages mode), `GPL Report an Issue.dc.html` (report flow), `GPL Outage Map.dc.html`.

---

## 1. Rules

- Reference phone width is **390px** (the prototype frame is 440 × 956). Side margin is **16px**, so content is **358px** wide.
- The font is **Inter**, at weights 400 / 500 / 600 / 700 / 800.
- Icons come from **Lucide** (v0.462.0) and use names such as `zap-off`, `chevron-right`, `history`.
- Colours: use the hex values in section 6. Status colours always come as a pair (text plus a tinted background).
- Copy is plain English. Use the exact strings given here.
- Tap targets are at least 44 × 44px.
- Hidden ≠ deleted. The cards listed in 3.7 stay in the code with `display:none` so they can return.

---

## 2. Shared shell (both screens)

| Part | Spec |
|---|---|
| Page background | `#EEF2F8` |
| Top bar | White, sticky. On the Dashboard it shows the GPL logo plus "Guyana Power & Light" (14px / 800, -0.01em, `#131C2E`). On other tabs it shows the page title (17px / 700, `#131C2E`), plus a back arrow where the page has one. Bell button on the right: 44px circle, 1px border `rgba(19,28,46,0.10)`, with a red badge `#C43D3D` holding "3" (10.5px / 700, white). |
| Address bar | White strip under the top bar. Home icon, then "Lot 22 Sheriff Street, Georgetown" (13px / 600, `#131C2E`), then "Account 40 2938 1 · Demerara" (11px / 400, `#4E5D75`). A circular search button sits on the right. |
| Bottom navigation | Floating dark pill `#08181E`, radius 999px, 16px from the screen edges, 4 tabs: **Dashboard** (`layout-dashboard`), **Incidents & outages** (`zap-off`), **Services** (`briefcase`), **Menu** (3 × 3 dot grid). Labels are 10px / 500, white. The active tab gets a lighter pill behind it. Leave 96px of bottom padding so content clears it. |
| Skip link | "Skip to main content". Shown only on keyboard focus. |

**Routing.** These are in-app views, not separate pages: `active = 'overview' | 'outages' | 'services' | 'prefs' | 'usage' | 'bills' | 'recentBills' | 'recentUsed' | 'profileSettings'`.

---

## 3. Dashboard (`active = 'overview'`)

Order from top to bottom, with 16–20px between blocks:

### 3.1 Outage alert carousel
- Horizontal scroll-snap row of cards, **311 × 178px**, radius **20px**, 12px gap. The next card peeks in from the right. Page dots sit under the row: the active dot is a wider `#404293` pill.
- **Card A, "Reported in your area"** (live outage)
  - Card: fill `rgba(196,61,61,0.05)`, inset ring 1px `rgba(196,61,61,0.35)`.
  - Overline: "REPORTED IN YOUR AREA", 12px / 700, uppercase, 0.1em tracking, `#C43D3D`. Reference "OUT-4903" on the right, 12px / 500.
  - Text: "Supply expected back **between 18:00 and 20:00 today**." 12px, line height 1.4, `#232E42`; the time is bold, `#131C2E`.
  - Progress: label "Crew on site" (13px / 700, `#C43D3D`), then a 3px bar with a red fill.
  - Footer: pager `‹ 1/2 ›` (13px / 600) and the button "I'm affected" with count chip "12". The button is a red outline pill, fill `rgba(196,61,61,0.10)`, hand icon.
- **Card B, "Planned outage"**: same layout in amber `#C47D12` on fill `rgba(196,125,18,0.05)`. Date chip "14 August". Text "Power out … **09:00 to 14:00 on 14 August 2026**". Label "Scheduled".
- Tapping a card opens the **Incidents & outages** tab.

### 3.2 Recent bills
- Header row: "Recent bills" (18px / 600, -0.01em, `#232E42`), a sort button (`arrow-up-down` icon) and the link "View all" (13.5px / 600, `#404293`).
- Card: white, 1px border `rgba(19,28,46,0.10)`, radius **16px**, shadow `0 2px 8px rgba(19,28,46,0.06)`, 270px tall with 4 rows.
- Each row: padding 14px 16px, top divider `rgba(19,28,46,0.06)`.
  - Left: 34px icon tile, radius 10px, `file-text` icon.
  - Middle: month (15px / 600, `#131C2E`), then "Issued 04 August 2026 · G$ 17,728" (13px, `#4E5D75`, one line with an ellipsis).
  - Right: status chip, then `chevron-right` 16px `#6B7A93`.
- Rows: July 2026 **Due** · June 2026 Paid · May 2026 Paid · April 2026 Paid.
- "View all" opens Recent bills. A row opens Bills (Due → current bill, Paid → history).

### 3.3 Recent requests
- Card style as in 3.2, 291px tall.
- Header: "Recent requests" (15px / 600, `#232E42`) and the link "View all requests".
- Rows: 34px icon tile, title (15px / 600), reference (13px, `#4E5D75`). On the right, status chip over date (12.5px, `#6B7A93`).
  - No power — Sheriff Street · OUT-4821 · **Resolved** · 09 Aug 2026
  - Streetlight out — Lot 22 · RPT-2210 · **In progress** · 02 Aug 2026
  - Billing query · BIL-0914 · **Resolved** · 18 Jul 2026

### 3.4 Quick actions
- Card: white, radius **18px**, shadow `0 6px 18px rgba(19,28,46,0.09)`, header "Quick actions" (15px / 700).
- Six rows. Each has a 40px chip (radius 12px), a title (15px / 600), a hint (13px, line height 1.45, `#4E5D75`) and a 32px pin button on the right.

| id | Icon | Title | Hint | Opens |
|---|---|---|---|---|
| outage | `zap` | Report an outage | Your power is out | **Incidents & outages page** (Report an Issue tab), not the form |
| hazard | `triangle-alert` | Report a hazard | Sagging wires or a fallen pole | Report form, "Damaged or dangerous" |
| meter | `gauge` | Meter or prepaid problem | Broken meter, keypad or credit | Services → meter request |
| bill | `download` | Download your bill | July 2026 statement | Bills → current |
| usage | `chart-column` | Check your consumption | 351 kWh this month | **Consumption page** |
| requests | `list-checks` | Track your requests | 3 with GPL on this connection | Services → track |

- Pinning moves an action to the top; the maximum is 4 pins. Prototype storage: `localStorage gpl.pinnedActions`.
- Each tap is recorded as "recently used" (keep the newest 3). Prototype storage: `gpl.recentActions`.

### 3.5 Status chips (pill, 3px 10px, 12px / 700, 0.01em)

| Status | Text | Background |
|---|---|---|
| Due | `#C47D12` | warning-bg |
| Paid | `#4E5D75` | `#F4F6FA` |
| Resolved | `#1F8A5B` | success-bg |
| In progress | `#2A6FDB` | info-bg |

### 3.6 Search (address-bar button)
Opens type-ahead search. Matches include "Bills and payments", "Report an outage" (→ Incidents & outages page), "Monthly consumption" (→ Consumption page), "Track my requests" and "FAQ". Up to 6 results. Esc closes it; Enter picks the top result.

### 3.7 Hidden on the Dashboard (keep in code, `display:none`)
- **Amount due** card (dark `#08181E`, "G$ 17,728", "Due 27 Aug 2026", "View bill").
- **Monthly consumption** card ("351 kWh", 6-month bar chart).
- **Recently used** side card. This is replaced by Menu › Recent used.

---

## 4. Incidents & outages (`active = 'outages'`)

The top bar shows the title "Incidents & outages" (17px / 700, -0.024em). The shared address bar sits under it.

### 4.1 Tabs
- Two tabs on a white strip: **Report an Issue** (active: `#404293`, with a 2px underline) and **Track My Reports** (`#4E5D75`). Labels are 14.5px / 600.
- Track My Reports shows a count of open outage reports.

### 4.2 Report an Issue tab (default)
1. Heading "What would you like to report?" (16px / 700, -0.015em) with an info icon.
2. **Picker field**: white, radius 14px, 1px border, 52px tall, placeholder "Select what you would like to report" (14.5px / 600, `#6B7A93`), chevron-down. It opens a list grouped by family (each item shows its family label underneath):
   - **Power out or unsteady** (scheduled by GPL): Changing of transformers · Pole planting · Scheduled maintenance · Upgrading area · Vegetation management / line clearance
   - **Damaged or dangerous** (unexpected outage): Blown spur fuse · Blown transformer fuse · Blown transformer · Broken crossarm · Broken pole · Burning building · Burning pole · Burning wire (primary) · Burnt off jumper · Burst primary main · Burst secondary main · Defective gang air breaker (GAB) · Defective single pole disconnector (SPD) · Electrical fire · Fallen pole · Fire on wire · Fluctuating voltage (area) · High voltage (area) · Lights flickering (area) · Low voltage · No current to area · No current to few buildings · One phase out (area) · Secondary mains hanging low · Transformer hanging · Transformer leaking · Transformer on fire · Transformer sparking · Tree entangled with mains · Vehicle hit pole · System trips
   - **Meter or prepaid unit**: Meter burning, smoking, or wire sparking in the meter · Meter broken or damaged · Prepaid unit will not accept my credit · Prepaid keypad or unit not working · No current and I think it is the meter
   - **Non-outage** (any other fault)
   - The list comes from the GPL Incident & Outage Routing Matrix. Don't invent items.
3. **Status cards** (white, radius 16px, 1px tinted ring, 14px padding, 12px gap). Each has a 40px solid-colour icon tile, an overline (11px / 700, uppercase, 0.08em), a title (14.5px / 700, one line with an ellipsis), a status chip (11.5px / 700) and `chevron-right`:
   - Red `#C43D3D`: "OUTAGE IN YOUR AREA" · Sheriff Street and Lamaha Street · chip "Crew on site" (wrench icon)
   - Amber `#C47D12`: "PLANNED OUTAGE" · Planned maintenance in your area · chip "Planned" (calendar icon)
   - Tapping a card opens its detail: map, timeline and "I'm affected".
4. **Your outage reports** card (white, radius 16px, padding 18px)
   - Title (17px / 700), then "Outages and faults you reported that GPL still has open." (13px, line height 1.5, `#4E5D75`).
   - Report row: inner card, radius 14px, 1px border. Clock icon tile, reference "RPT-2210" (11px / 700, uppercase, `#6B7A93`), title "Streetlight out — Lot 22" (14.5px / 700), chip "In progress" (info blue).
   - Link "View all requests →" (14px / 600, `#404293`).

### 4.3 Report flow (after picking an item)
- Steps: **Choose a request → Your details → Check it → Submitted** ("Step n of 4").
- Scope question: Only my premises / A few premises / The whole street or area.
- Details: Location (my own premises, or a street or public place nearby), What you can see, Contact number.
- If an area outage is already logged, the user is linked to the existing case instead of opening a duplicate ("Linked reports").
- Priority comes from the matrix (P1 to P5), e.g. "P4 — area outage", "P3 — vehicle-hit pole".

### 4.4 Track My Reports tab
- Lists outage cases. Example: case 3471 "No supply — Sheriff Street, Georgetown", status *Crew assigned*, ETA "11:00 – 13:00 today", team "T&D — Georgetown major crew", 14 linked customers.
- Stages: Reported → Confirmed → Crew assigned → Work in progress → Restored → Closed. The current stage is labelled "Happening now".
- The timeline shows each update with time, text and channel (SMS / email / WhatsApp).
- A restored case offers reopen within 24 hours ("Tell GPL within 24 hours if your supply is still off").

### 4.5 Outage map (`GPL Outage Map.dc.html`)
- Leaflet map using a basemap bundled in the project (`assets/guyana-basemap.json`, `georgetown-map.svg`), so no live tiles are needed. Pins: unplanned (red), planned (amber), restored (green).
- In production, connect a licensed tile provider (Mapbox / Google / Esri).

---

## 5. Entry points into Incidents & outages

| From | Lands on |
|---|---|
| Bottom nav "Incidents & outages" | Report an Issue tab |
| Dashboard alert card | Report an Issue tab |
| Quick action / search "Report an outage" | Report an Issue tab (page only, no form) |
| Quick action "Report a hazard" | Report form, Damaged or dangerous |
| Recent requests → an outage case | Track My Reports, case open |

---

## 6. Colours used on these two screens

| Role | Hex |
|---|---|
| Primary (links, active tab) | `#404293` · soft `rgba(64,66,147,0.12)` |
| Text 1 / 2 / 3 / 4 | `#131C2E` / `#232E42` / `#4E5D75` / `#6B7A93` |
| Page background | `#EEF2F8` |
| Card border | `rgba(19,28,46,0.10)` · row divider `rgba(19,28,46,0.06)` |
| Outage red | `#C43D3D` (tint `rgba(196,61,61,0.05)`, ring `0.35`) |
| Planned amber | `#C47D12` (tint `rgba(196,125,18,0.05)`) |
| Success green | `#1F8A5B` |
| Info blue | `#2A6FDB` |
| Nav and dark surfaces | `#08181E` |
| White | `#FFFFFF` |

Radius: cards 16px (Quick actions 18px, alert cards 20px), rows and fields 12–14px, icon tiles 10–12px, chips and nav 999px.
Shadows: `0 2px 8px rgba(19,28,46,0.06)` (cards) · `0 6px 18px rgba(19,28,46,0.09)` (Quick actions).

---

## 7. Accessibility
- Every tappable row has `role="button"` and `tabIndex=0`, so it can be reached and activated by keyboard.
- The alert carousel can be operated with the pager buttons as well as by swiping.
- Status is never shown by colour alone: chips always carry text, and an icon where one is listed.
- Labels in use: bell `aria-label="Notifications"`; pager buttons "Previous outage" / "Next outage" and "Previous planned outage" / "Next planned outage"; "Menu", "Back", "Close search", "Clear search".

---

## 8. API placeholders (production)
- `GET /account/{id}/dashboard` returns alerts, recentBills, recentRequests and pins.
- `GET /outages?area=` returns live and planned outages for the customer's feeder.
- `POST /outages/{id}/affected` is the "I'm affected" button (increments the count).
- `GET /incident-categories` returns the routing-matrix list (family → issues → priority).
- `POST /reports` returns `{ ref, priority, linkedCaseRef? }`.
- `GET /reports?type=outage` feeds Track My Reports.

---

## 9. Build checklist
- [ ] Shell: top bar, address bar and floating bottom nav, matching section 2
- [ ] Dashboard order: alert carousel → Recent bills → Recent requests → Quick actions
- [ ] Amount due, Monthly consumption and Recently used cards hidden, not deleted
- [ ] Report an outage → Incidents & outages page; Check your consumption → Consumption page
- [ ] Incidents & outages: two tabs; picker grouped by family from the matrix; status cards; Your outage reports
- [ ] Report flow in 4 steps, with linking to existing area cases
- [ ] Track My Reports timeline with the 6 outage stages
- [ ] Colours, sizes and type exactly as listed. Check at 390px, and at 360px for text wrapping.
