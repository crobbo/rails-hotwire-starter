# Rails Hotwire Starter guidance

## Architecture

1. Models are rich: business rules and record-owned behavior live with the domain model.
2. Controllers are thin: authenticate, authorize, load records, delegate, and render or redirect.
3. Concerns are small: each concern represents one cohesive capability.
4. POROs hold algorithms, workflows, and integrations that do not naturally belong to one model.
5. Jobs are shallow asynchronous wrappers around synchronous domain methods.
6. Prefer associations and timestamps over boolean columns for meaningful domain state.
7. Model state transitions as RESTful resources instead of custom controller actions.
8. Use `Current` for thread-safe request context, not global or class-level mutable state.
9. Wrap multi-record state changes in transactions.
10. Tests verify observable behavior and state, not private implementation details.

Do not create a generic service layer by default. Start with the model that owns the behavior. When no record naturally owns it, add a role-named, domain-namespaced PORO with a small public API. See `app/AGENTS.md` for the detailed Rails patterns.

## Design system

- Read `DESIGN.md` before making user-interface changes. Its tokens are normative and its prose explains intent.
- Add reusable visual decisions to `DESIGN.md`, then run `yarn design:lint` and `yarn design:build`.
- Never edit `app/assets/stylesheets/design/generated-theme.css` by hand.
- Use Tailwind for layout and application composition. Use exported semantic utilities instead of arbitrary values when a token exists.
- Use Web Awesome for accessible interactive primitives. Keep the complete installed component manifest in `app/javascript/lib/web_awesome.js`.
- Keep ViewComponent wrappers thin and application-oriented. Preserve Web Awesome behavior, slots, events, CSS parts, and documented custom properties.
- Use Stimulus for Rails and application orchestration, not to recreate focus management, keyboard navigation, positioning, dismissal, or other behavior Web Awesome already provides.
- Once a ViewComponent wrapper exists for a primitive, use it instead of direct `wa-*` markup outside the components preview.
- Customize Web Awesome through documented theme variables and CSS parts. Do not rely on its shadow DOM internals.

## Configuration and secrets

- Store API keys, tokens, and third-party secrets in Rails credentials by default.
- Keep secret access close to the integration that owns it, usually in an initializer or client object.
- Reserve plain `ENV` values for non-secret operational settings such as ports, concurrency, and timeouts.
- If browser code needs public configuration, have Rails read and expose it explicitly rather than adding a second frontend-only source of truth.
- Document newly required credential keys without documenting their values.

## Nested guidance

- Rails application and domain patterns: `app/AGENTS.md`
- ViewComponent and Web Awesome wrappers: `app/components/AGENTS.md`
- Minitest patterns: `test/AGENTS.md`

## Verification

- Run `yarn design:check`, `yarn build`, and `yarn build:css` for design-system changes.
- Run relevant Rails tests and linters.
- Browser-test user-facing changes, including keyboard focus, responsive layout, and light/dark treatment where applicable.
