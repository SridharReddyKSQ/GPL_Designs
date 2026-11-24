GPL Portal Mobile V1.3 - full project (updated 20 Nov 2026)

OPEN THE PROTOTYPE
- GPL Portal Mobile - Standalone.html  -> whole app, works offline in any browser
- GPL Portal Mobile.dc.html            -> main project file (needs internet for React/fonts)

DEVELOPER HANDOFF
- GPL Developer Handoff Guide - Standalone.html -> full guide in one file, works offline (v1.5)
- GPL Developer Handoff Guide.dc.html  -> same guide, project version
- assets/handoff/  -> screen templates, gpl-tokens.css / gpl-tokens.json
- assets/fonts/    -> Inter font files (400-800)

WHAT'S NEW IN THIS UPDATE
- Multi-factor sign-in: one-time code step on Login; choice of Text message or Email in
  Menu > Profile > Sign-in and security (prototype code: 123456)
- Report an outage -> Incidents & outages page; Check your consumption -> Consumption page
- Recent used (Menu) opens your recently used options
- Hidden: Amount due + Monthly consumption cards (Dashboard); Billing preferences,
  Quotation awaiting payment, Estimate for August 2026 (Bills & Payments)

FOLDERS
- GPL *.dc.html -> individual screens
- assets/       -> logos, images, map data, Leaflet, fonts, tokens
- _ds/          -> Guyana design system bundle
- uploads/      -> source material (BRD, discovery notes, transcripts, references)
- scratch/      -> working screenshots
- design_handoff_gpl_portal/ -> earlier handoff pack

TIP: for .dc.html files, serve the folder locally (e.g. "npx serve" or
"python3 -m http.server") rather than double-clicking.
