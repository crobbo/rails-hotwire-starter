# Design system workflow

This starter has one design source and two consumers:

- `DESIGN.md` is the human- and agent-readable source of truth.
- Tailwind uses the generated `@theme` variables for layout and application composition.
- Web Awesome uses the same variables through a small adapter for accessible interactive primitives.

## Commands

```sh
yarn design:lint
yarn design:build
yarn design:check
```

`design:lint` validates `DESIGN.md` against Google's alpha format. `design:build` exports the tokens to Tailwind v4 CSS and replaces the generated file atomically. `design:check` validates the document and compares the generated file with a fresh export without changing either file. It fails when the generated theme is missing or stale, regardless of Git staging state.

Run `yarn build` and `yarn build:css` after adding JavaScript or styles. `build:css` bundles Web Awesome's full stylesheet—including its required utilities and modal scroll lock—into `webawesome.css`, then builds the Tailwind application stylesheet. The generated design-token CSS is committed so a fresh clone can boot without requiring token generation first.

Tailwind Preflight resets padding on every element, including custom-element hosts. `components.css` uses `padding: revert-layer` on `wa-dropdown-item` and `wa-option` so Web Awesome's shadow-DOM host spacing remains authoritative. Keep those compatibility rules unless a future Tailwind or Web Awesome release changes the cascade behavior.

`UI::DialogComponent` keeps the custom-element host out of normal layout flow. Web Awesome changes that host to `display: block` while open; positioning the otherwise invisible host prevents it from becoming a new flex or grid item and moving the trigger.

## Changing the visual system

1. Change the normative tokens and supporting rationale in `DESIGN.md`.
2. Run `yarn design:lint` and resolve errors.
3. Run `yarn design:build`.
4. Review both Tailwind composition and Web Awesome components in `/components`.
5. Commit `DESIGN.md` and `app/assets/stylesheets/design/generated-theme.css` together.

Do not edit `generated-theme.css`. Edit `web-awesome-theme.css` only when mapping a semantic token onto a documented Web Awesome custom property. Keep app-specific component compositions in `components.css` or in ViewComponent templates.

## Component boundaries

Use Tailwind for page layout, responsive behavior, spacing, and application-specific composition. Use Web Awesome for dialogs, menus, dropdowns, inputs, tooltips, disclosures, and other interaction-rich primitives.

ViewComponent wrappers should express the Rails application's API, not conceal Web Awesome. Preserve documented slots, events, CSS parts, accessibility behavior, and useful custom properties. Stimulus coordinates application behavior such as opening a dialog after a Turbo response; it should not rebuild focus trapping, keyboard navigation, positioning, or dismissal.

`app/javascript/lib/web_awesome.js` explicitly imports all 66 free components in the pinned package. Explicit imports let esbuild produce a reliable Rails asset; Web Awesome's lazy loader expects separately hosted component modules that this starter does not publish. The coverage test keeps the manifest synchronized with package upgrades.

After a wrapper exists for an application primitive, prefer that wrapper outside this preview. Use the remaining `wa-*` elements directly until a Rails-specific API would genuinely improve them. Applications with a strict bundle budget can prune the import manifest after cloning the starter.

See `docs/component-coverage.md` for the installed catalogue, availability guarantee, wrapper policy, and recommended wrapper rollout order.

### Starter components

The initial wrappers live under the `UI` namespace:

~~~erb
<%= render UI::ButtonComponent.new(variant: :brand, appearance: :accent) do %>
  Save project
<% end %>

<%= render UI::InputComponent.new(
  label: "Project name",
  name: "project[name]",
  hint: "Shown to everyone in your workspace."
) %>

<%= render UI::SelectComponent.new(
  label: "Visibility",
  name: "project[visibility]"
) do |select| %>
  <% select.with_option(label: "Private", value: "private", selected: true) %>
  <% select.with_option(label: "Workspace", value: "workspace") %>
<% end %>

<%= render UI::TextareaComponent.new(
  label: "Description",
  name: "project[description]",
  maxlength: 160,
  with_count: true
) %>

<%= render UI::CheckboxComponent.new(
  label: "Allow invitations",
  name: "project[allow_invitations]",
  value: "1",
  checked: true
) %>

<%= render UI::SwitchComponent.new(
  label: "Email summaries",
  name: "project[email_summaries]",
  value: "1"
) %>

<%= render UI::DialogComponent.new(
  label: "Archive project",
  data: {dialog_target: "dialog"}
) do |dialog| %>
  <p>This removes the project from active work.</p>

  <% dialog.with_footer do %>
    <%= render UI::ButtonComponent.new(data: {action: "click->dialog#close"}) do %>
      Cancel
    <% end %>
  <% end %>
<% end %>

<%= render UI::MenuComponent.new do |menu| %>
  <% menu.with_trigger(appearance: :outlined, with_caret: true) do %>
    Project actions
  <% end %>
  <% menu.with_label do %>Project<% end %>
  <% menu.with_item(label: "Rename", value: "rename", icon_name: "pen", details: "⌘R") %>
  <% menu.with_item(label: "Show activity", value: "activity", type: :checkbox, checked: true) %>
  <% menu.with_divider %>
  <% menu.with_item(
    label: "Archive",
    value: "archive",
    variant: :danger,
    icon_name: "box-archive",
    data: {action: "click->project#archive"}
  ) %>
<% end %>

<%= render UI::NavbarComponent.new(label: "Workspace navigation") do |navbar| %>
  <% navbar.with_brand_content("Acme") %>
  <% navbar.with_link(label: "Projects", href: projects_path, current: true) %>
  <% navbar.with_link(label: "People", href: people_path) %>
  <% navbar.with_actions_content("Account controls") %>
<% end %>
~~~

Wrapper options deliberately use Web Awesome's names (`variant`, `appearance`, `placement`, and `size`). Pass ordinary Rails attributes such as `class`, `id`, `aria`, `data`, `autocomplete`, and documented Web Awesome attributes directly. Unsupported enum values raise early instead of silently rendering an invalid component. Menus preserve entry order across labels, items, and dividers; items support icons, shortcut details, checkbox state, danger styling, and nested submenu hashes. They retain Web Awesome's `wa-select` event and accept Stimulus actions through `data` attributes. Navbar links are ordinary anchors, so Rails path helpers, Turbo navigation, and `aria-current` continue to work normally.

## Upgrades

The Google `design.md` format is currently alpha and its package is pinned. Web Awesome is also pinned. Upgrade each deliberately, read its release notes, regenerate the theme, build assets, and browser-test the preview before committing the lockfile changes.

Rails tracks `main`, which currently removed `ActionView::Template.template_handler_extensions` before ViewComponent 4.12 adopted its replacement. `config/initializers/view_component_rails_main.rb` provides a narrow, feature-detected compatibility alias. Remove it once ViewComponent uses `ActionView::Template::Handlers.extensions`.
