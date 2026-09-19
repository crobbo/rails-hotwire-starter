# Rails Hotwire Starter

A reusable Rails foundation for server-rendered product applications with Hotwire, ViewComponent, Tailwind, Web Awesome, and a design system that humans and coding agents can change from one source.

The starter intentionally provides infrastructure and useful defaults rather than an application kit. It does not prescribe authentication, billing, teams, or product architecture.

Explore the [live component demo](https://rails-starter.christianrobinson.dev/).

## Stack

- Ruby 4.0.6
- Node.js 24 LTS and Yarn 1.22.22
- Rails from the `main` branch, locked to a known commit
- PostgreSQL and Propshaft
- Turbo and Stimulus
- esbuild for JavaScript
- Tailwind CSS 4 for layout and composition
- Web Awesome 3.12 for accessible browser-native components
- ViewComponent for thin Rails-facing component APIs
- Google's `design.md` format as the design source of truth

All 70 components included in the version-locked Web Awesome 3.12 package are registered and wrapped. The catalogue at `/components` demonstrates 69 supported components across 53 examples; `animated-image` is excluded from the preview because of an upstream rendering issue.

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

Prerequisites are [mise](https://mise.jdx.dev/) and Docker. The development PostgreSQL database runs in Docker on host port `55433` (port `5432` inside the container). Install the Ruby and Node.js versions declared in `mise.toml`, then install the pinned Yarn version before setting up the application:

```sh
mise install
mise exec -- npm install --global yarn@1.22.22
docker compose up -d postgres
bin/setup
```

`bin/setup` installs Ruby and JavaScript dependencies, prepares the databases, clears temporary files, and starts the development processes. JavaScript installs use Yarn with the frozen lockfile, including Rails asset preparation and CI. To prepare without starting the server:

```sh
bin/setup --skip-server
```

Subsequent development sessions use:

```sh
bin/dev
```

Stop the local database with:

```sh
docker compose down
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

The starter bundles every component from Web Awesome 3.12 through esbuild. The dependency version is locked in `package.json` and `yarn.lock`, while `app/javascript/lib/web_awesome.js` is the explicit component import manifest. This favors immediate availability over the smallest possible bundle. Product applications can remove unused component imports when bundle size matters.

Every Web Awesome primitive has a `UI` ViewComponent wrapper. Keep baseline wrappers thin and enrich them only when Rails value is clear—form naming, validation, typed options, ordered slots, Turbo links, accessible defaults, or Stimulus coordination.

See [`docs/component-coverage.md`](docs/component-coverage.md) for the coverage guarantee and wrapper policy.

## Coding-agent guidance

[`AGENTS.md`](AGENTS.md) gives coding agents the same boundaries expected of human contributors. It requires agents to read `DESIGN.md`, preserve Web Awesome behavior, prefer semantic tokens, keep wrappers thin, and browser-test user-facing changes.

Keep those instructions in the repository after cloning. Add product-specific constraints there as the application develops instead of relying on chat history or undocumented conventions.

## Verification

Run the complete local verification set before committing changes to the starter itself:

```sh
bin/rails test
bin/rubocop
bin/bundler-audit
bin/brakeman --no-pager
yarn audit
yarn design:check
yarn build
yarn build:css
```

Browser-test user-facing changes at `/components`, including keyboard focus and light/dark treatment where applicable.

## Updating dependencies

Rails follows `main`, while the lockfile keeps clones reproducible. Advance it deliberately with `bundle update rails`, review upstream changes, and run the full verification set.

The Google `design.md` package and Web Awesome are locked to exact dependency versions. Upgrade them independently, read their release notes, regenerate assets, confirm component coverage, and browser-test the catalogue before committing lockfile changes.

Dependabot checks gems, JavaScript packages, and GitHub Actions weekly. CI checks design tokens, asset builds, dependency audits, Ruby style, and Rails tests using the pinned Node.js LTS version.

Solid Queue 1.7 adds batch tables. New queue databases include them in `db/queue_schema.rb`; existing deployments should run `RAILS_ENV=production bin/rails db:migrate:queue` with their usual database configuration before starting the updated workers. The migration in `db/queue_migrate` preserves existing jobs. ViewComponent 4.15 supports the current Rails API directly, so the earlier compatibility initializer has been removed.
