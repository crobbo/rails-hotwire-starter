# Web Awesome component coverage

The version-locked Web Awesome 3.10 package contains 66 free components. The starter registers all 66 in its application bundle and renders a representative example of every one at `/components`. Treat the package and lockfile as the implementation source of truth, and use the [Web Awesome component catalogue](https://webawesome.com/docs/components) for status and API documentation.

`test/javascript/web_awesome_coverage_test.rb` compares the explicit import manifest with the installed component directories. `test/controllers/components_controller_test.rb` makes the same comparison against the custom-element tags rendered by the catalogue. A Web Awesome upgrade therefore fails the test suite until every newly installed component is deliberately imported and demonstrated.

## Wrapper policy

Every Web Awesome component has a `UI` ViewComponent wrapper. The baseline wrappers are intentionally thin: they preserve Web Awesome events, slots, CSS parts, custom properties, content, and arbitrary HTML attributes. Richer wrappers add Rails value where appropriate, such as typed options, accessible defaults, ordered slots, form integration, Turbo links, or Stimulus coordination.

Use the corresponding `UI` wrapper in application code. The `/components` catalogue may render underlying `wa-*` markup directly so it remains a compact reference for the upstream API.

This baseline deliberately favors immediate availability over the smallest possible JavaScript bundle. An application with a strict bundle budget can remove unused entries from `app/javascript/lib/web_awesome.js`; update or remove the coverage test at the same time so that choice stays explicit.

## Rails wrapper coverage

The wrapper test verifies that every installed Web Awesome component renders through its matching `UI` ViewComponent. Application-oriented wrappers for buttons, menus, form controls, dialogs, dividers, icons, and navigation add a richer Rails API on top of the thin baseline.

Experimental components are wrapped too, but their upstream APIs may change during Web Awesome upgrades.
