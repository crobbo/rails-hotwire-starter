# Rails Hotwire Starter

A reusable Rails foundation for server-rendered product applications with Hotwire, ViewComponent, Tailwind, Web Awesome, and a design system that humans and coding agents can change from one source.

The starter intentionally provides infrastructure and useful defaults rather than an application kit. It does not prescribe authentication, billing, teams, or product architecture.

## Stack

- Ruby 4.0.6
- Rails from the `main` branch, locked to a known commit
- PostgreSQL and Propshaft
- Turbo and Stimulus
- esbuild for JavaScript
- Tailwind CSS 4 for layout and composition
- Web Awesome 3.10 for accessible browser-native components
- ViewComponent for thin Rails-facing component APIs
- Google's `design.md` format as the design source of truth

All 66 components included in the pinned free Web Awesome package are registered and demonstrated at `/components`.

## Start a project

Use GitHub's **Use this template** button, or open the [new repository form for this template](https://github.com/crobbo/rails-hotwire-starter/generate).

1. Choose the owner, repository name, and visibility for the application.
2. Create the repository from the template.
3. Clone the newly created repository—not this starter repository:

```sh
git clone https://github.com/<owner>/<new-repository>.git
cd <new-repository>
```

The generated repository starts with fresh history and its own `origin`, while retaining the starter's complete file structure. Clone `crobbo/rails-hotwire-starter` directly only when contributing improvements back to the starter itself.

Rename these starter identifiers deliberately before deployment:

| Starter value | Replace with | Used for |
| --- | --- | --- |
| `RailsHotwireStarter` | The Ruby application constant | `config/application.rb`, PWA metadata |
| `rails_hotwire_starter` | A snake-case application name | Databases, Kamal, Docker |
| `Rails Hotwire Starter` | A human-readable product name | Page metadata and catalogue copy |
| `RAILS_HOTWIRE_STARTER_DATABASE_PASSWORD` | A product-specific environment variable | Production database credentials |

Find every occurrence with:

```sh
rg -n -i 'rails[ _-]?hotwire[ _-]?starter|RailsHotwireStarter'
```

The application directory itself can be renamed independently. Review `config/database.yml` and `config/deploy.yml` even when the starter defaults look acceptable.

## Install and run

Prerequisites are Ruby 4.0.6, PostgreSQL, Node.js, and Yarn 1.x. With rbenv, make sure its shell integration is active so `.ruby-version` is respected.

```sh
bin/setup
```

`bin/setup` installs Ruby and JavaScript dependencies, prepares the databases, clears temporary files, and starts the development processes. To prepare without starting the server:

```sh
bin/setup --skip-server
```

Subsequent development sessions use:

```sh
bin/dev
```

The application defaults to [http://localhost:3000](http://localhost:3000), and the component catalogue is at [http://localhost:3000/components](http://localhost:3000/components).

## Design workflow

[`DESIGN.md`](DESIGN.md) is normative. Its front matter contains machine-readable tokens; its prose explains the visual intent and the rules behind them. The default system is **Mulberry & Ink**, designed to be distinctive without becoming a product-specific brand.

When changing the visual system:

1. Update tokens and rationale in `DESIGN.md`.
2. Validate the document with `yarn design:lint`.
3. Regenerate Tailwind tokens with `yarn design:build`.
4. Rebuild CSS with `yarn build:css`.
5. Review Tailwind compositions and Web Awesome components at `/components`.
6. Commit `DESIGN.md` and `app/assets/stylesheets/design/generated-theme.css` together.

Use this read-only consistency check locally and in CI:

```sh
yarn design:check
```

Never edit `app/assets/stylesheets/design/generated-theme.css` by hand. Map semantic tokens to documented Web Awesome variables in `app/assets/stylesheets/design/web-awesome-theme.css`; put application composition rules in `components.css` or ViewComponent templates.

See [`docs/design-system.md`](docs/design-system.md) for the complete workflow and component boundaries.

## Components

Use Tailwind for page layout, responsive composition, spacing, and application-specific presentation. Use Web Awesome for interaction-rich primitives such as dialogs, menus, dropdowns, form controls, tooltips, tabs, drawers, and disclosures.

The starter imports the complete pinned Web Awesome package in `app/javascript/lib/web_awesome.js`. This favors immediate availability over the smallest possible bundle. Product applications can prune the manifest deliberately when bundle size matters.

Create a `UI` ViewComponent wrapper when it adds Rails value—form naming, validation, typed options, ordered slots, Turbo links, accessible defaults, or Stimulus coordination. Avoid wrappers that merely rename Web Awesome attributes.

See [`docs/component-coverage.md`](docs/component-coverage.md) for the coverage guarantee, wrapper policy, and suggested rollout order.

## Coding-agent guidance

[`AGENTS.md`](AGENTS.md) gives coding agents the same boundaries expected of human contributors. It requires agents to read `DESIGN.md`, preserve Web Awesome behavior, prefer semantic tokens, keep wrappers thin, and browser-test user-facing changes.

Keep those instructions in the repository after cloning. Add product-specific constraints there as the application develops instead of relying on chat history or undocumented conventions.

## Verification

Run the complete local verification set before committing changes to the starter itself:

```sh
eval "$(rbenv init -)"
bin/rails test
bin/rubocop
yarn design:check
yarn build
yarn build:css
```

Browser-test user-facing changes at `/components`, including keyboard focus and light/dark treatment where applicable.

## Updating dependencies

Rails follows `main`, while the lockfile keeps clones reproducible. Advance it deliberately with `bundle update rails`, review upstream changes, and run the full verification set.

The Google `design.md` package and Web Awesome are pinned. Upgrade them independently, read their release notes, regenerate assets, confirm component coverage, and browser-test the catalogue before committing lockfile changes.

The temporary Rails-main compatibility shim for ViewComponent is documented in [`docs/design-system.md`](docs/design-system.md). Remove it once the released ViewComponent version supports the current Rails API directly.
