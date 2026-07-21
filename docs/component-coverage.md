# Web Awesome component coverage

The pinned Web Awesome 3.10 package contains 66 free components. The starter registers all 66 in its application bundle and renders a representative example of every one at `/components`. Treat the package and lockfile as the implementation source of truth, and use the [Web Awesome component catalogue](https://webawesome.com/docs/components) for status and API documentation.

`test/javascript/web_awesome_coverage_test.rb` compares the explicit import manifest with the installed component directories. `test/controllers/components_controller_test.rb` makes the same comparison against the custom-element tags rendered by the catalogue. A Web Awesome upgrade therefore fails the test suite until every newly installed component is deliberately imported and demonstrated.

## Wrapper policy

Create a `UI` ViewComponent wrapper when it adds Rails value: form naming and errors, typed options, ordered slots, accessible defaults, Turbo links, or Stimulus coordination. Keep the wrapper thin and preserve Web Awesome events, slots, CSS parts, custom properties, and arbitrary HTML attributes.

Use a Web Awesome custom element directly when a wrapper would only rename its attributes. This applies especially to formatters, observers, low-level positioning helpers, and unusual media components. No additional JavaScript import is needed because every free component is registered by the starter.

This baseline deliberately favors immediate availability over the smallest possible JavaScript bundle. An application with a strict bundle budget can remove unused entries from `app/javascript/lib/web_awesome.js`; update or remove the coverage test at the same time so that choice stays explicit.

## Rails wrapper coverage

- Actions: button; dropdown with labels, items, icons, shortcut details, dividers, checkboxes, danger variants, and submenus.
- Forms: input, textarea, select and option, checkbox, and switch.
- Layout: dialog and divider.
- Media: icon.
- Rails compositions: responsive navbar.

## Recommended wrapper rollout

1. Forms: checkbox group, radio and radio group, number input, slider, color picker, and rating.
2. Application structure: drawer, details, accordion, tabs, breadcrumbs, tooltip, callout, badge, tag, and card.
3. Rich interaction: popover, tree, scroller, split panel, carousel, comparison, progress, and skeleton states.
4. Opt-in components: page scaffolding, markdown, QR code, zoomable frame, known date, and time input.
5. Direct-use helpers by default: formatters, relative time, observers, popup, include, animation, and random content.

Experimental components should be isolated behind wrappers only when an application needs them. Record their status in the wrapper documentation and expect API changes during Web Awesome upgrades.
