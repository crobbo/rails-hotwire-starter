# ViewComponent and Web Awesome guidance

## Scope and source of truth

- Read `DESIGN.md` before changing component appearance or behavior. Its tokens and prose are normative.
- Components in this directory are application-oriented ViewComponent wrappers, not a replacement component framework.
- Use Web Awesome for accessible interactive primitives and Tailwind for layout and application composition.
- Inherit the Rails conventions in `app/AGENTS.md` and the repository-wide design rules in the root `AGENTS.md`.

## When to add a wrapper

Add a wrapper when the application needs a stable name, defaults, validation, composition API, or repeated use of a Web Awesome primitive.

- Keep wrappers thin and preserve the underlying element's documented properties, slots, events, CSS parts, custom properties, form behavior, and accessibility behavior.
- Once a wrapper exists, use it instead of direct `wa-*` markup outside the components preview.
- Do not wrap a primitive only to hide its name or copy its markup without adding an application-oriented API.
- Do not recreate focus management, keyboard navigation, positioning, dismissal, selection, or other Web Awesome behavior.

## Structure and naming

- Put reusable primitives in the `UI` namespace as `UI::<Name>Component`.
- Pair `app/components/ui/<name>_component.rb` with a minimal `<name>_component.html.erb` template.
- Inherit from `ApplicationComponent` and share genuinely universal helpers there.
- Compose related wrappers through `renders_one` and `renders_many` slots instead of passing HTML strings.
- Use small supporting components for structured children such as menu items and select options.
- Prefer application terminology at the call site while keeping its mapping to Web Awesome obvious.

## Component API

- Use explicit keyword arguments for supported application options and accept `**html_attributes` for standard HTML, ARIA, Stimulus data attributes, slots, CSS custom properties, and documented pass-through behavior.
- Never silently discard caller-provided `id`, `class`, `data`, `aria`, `style`, or `slot` attributes.
- Merge classes and nested ARIA/data hashes deliberately so required component values do not erase caller values.
- Require accessible names for controls and landmarks. Use `label:` or an equivalent explicit API rather than relying on placeholder text.
- Normalize Rails-friendly symbol values at the boundary, such as converting underscores to Web Awesome's hyphenated values.
- Define frozen constants for documented enumerations and validate them with `validate_option!`.
- Add a narrowly useful alias only when it improves Rails call sites without making the upstream value unclear.
- Emit boolean attributes only when enabled. Preserve `false`, `nil`, blank strings, and zero according to the underlying property's semantics.
- Use `before_render` for validation that depends on content or populated slots; validate constructor arguments during initialization.
- Keep attribute construction in a private `attributes` method when the template only needs to render the underlying element.

## Templates and slots

Templates should expose the Web Awesome structure with as little intermediate markup as possible:

```erb
<%= content_tag(:"wa-button", content, attributes) %>
```

- Map ViewComponent slots to the documented Web Awesome `slot` names.
- Add wrapper elements only when Rails composition or shared application styling requires them.
- Do not move meaningful content into JavaScript.
- Preserve content order and slot semantics so keyboard and screen-reader behavior matches the upstream primitive.
- Let callers provide ordinary block content where the primitive supports it.

## Styling

- Use exported semantic Tailwind utilities whenever a design token exists.
- Add reusable visual decisions to `DESIGN.md`, then regenerate the theme.
- Never edit `app/assets/stylesheets/design/generated-theme.css` by hand.
- Put shared component adapter styles in the design stylesheet layer, not inline in individual views.
- Customize Web Awesome through documented theme variables, CSS parts, and custom properties.
- Do not target undocumented shadow DOM internals.
- Preserve the system's moderate density, visible focus, restrained elevation, tokenized spacing, and light/dark contrast.
- Avoid arbitrary colors, radii, spacing, and shadows when the design scale already expresses the decision.

## Behavior and Stimulus

- Web Awesome owns primitive interaction behavior.
- Use Stimulus only to orchestrate application actions, such as opening a dialog after a Rails-specific event or submitting a form in response to a documented component event.
- Listen for documented Web Awesome custom events rather than observing shadow DOM changes.
- Pass Stimulus actions and targets through `data:` attributes; the wrapper must not swallow or rename them.
- Do not add JavaScript merely to mirror a component property that Web Awesome already supports.

For a component that does not use Web Awesome and genuinely needs component-specific JavaScript, colocate its Stimulus controller with the component:

```text
app/components/ui/filter_component.rb
app/components/ui/filter_component.html.erb
app/components/ui/filter_component_controller.js
```

- Name the controller after the component with the `_controller.js` suffix.
- Register the example above as `ui--filter-component` in `app/components/controllers.js`, then use `data-controller="ui--filter-component"` in the component template.
- Nested directories become Stimulus scopes separated by `--`, and underscores become hyphens.
- Keep the controller owned by that component. Put cross-component or page-level orchestration in `app/javascript/controllers` instead.
- Keep `app/components/controllers.js` as the explicit manifest for colocated controllers. Import and register every component controller there.
- The application entry point imports that manifest, so the standard esbuild command includes the registered controllers in the application bundle and watches imported files during `yarn build --watch`.

## Accessibility

- Preserve visible keyboard focus and Web Awesome's native focus restoration.
- Require labels for form controls, dialogs, icons used without visible text, and navigation landmarks.
- Use native or Web Awesome disabled, required, readonly, checked, selected, and expanded semantics.
- Verify error and hint text remain programmatically associated with their controls.
- Do not make icon-only controls without an accessible name.
- Maintain WCAG AA contrast in light and dark modes.

## Component catalogue and manifest

- Keep `app/javascript/lib/web_awesome.js` as the complete explicit manifest of installed Web Awesome components.
- Do not remove manifest entries merely because the application does not yet use them.
- Add or update a concise catalogue example when introducing a wrapper or supported application pattern.
- Direct `wa-*` markup is allowed in the components preview to demonstrate unwrapped upstream primitives.
- Keep preview counts and category navigation truthful.
- Use framed preview routes for full-page or viewport-sensitive primitives.
- Omit a preview with a verified upstream behavior failure until it is workable.

## Tests and verification

Add or update a `ViewComponent::TestCase` under `test/components/ui` for every wrapper.

- Assert the rendered `wa-*` element, documented attributes, caller-supplied HTML/data/ARIA attributes, slots, and content.
- Test required accessible labels and rejected enumeration values.
- Test content-dependent validation by rendering the component.
- Cover composition APIs such as items, options, triggers, headers, and footers.
- For a colocated Stimulus controller, assert the rendered `data-controller`, targets, values, and actions, and browser-test its behavior.
- Prefer selector assertions against public markup over tests of private Ruby methods.

For component changes, run:

```sh
bin/rails test test/components
yarn build
yarn build:css
```

Also run `yarn design:check` when tokens or shared design styles change. Browser-test user-facing behavior with keyboard input, responsive layouts, and both light and dark treatment where applicable.
