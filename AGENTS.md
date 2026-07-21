# Rails Hotwire Starter guidance

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

## Verification

- Run `yarn design:check`, `yarn build`, and `yarn build:css` for design-system changes.
- Run relevant Rails tests and linters.
- Browser-test user-facing changes, including keyboard focus, responsive layout, and light/dark treatment where applicable.
