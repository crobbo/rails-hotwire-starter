# Rails code and style guide

## Philosophy

- Prefer vanilla Rails and intention-revealing domain APIs over framework-like abstractions.
- Keep controllers thin and put record-owned business behavior in rich models.
- Do not introduce service objects by default.
- Compose complex models from small, cohesive concerns.
- Use POROs for algorithms, integrations, and workflows that have no natural Active Record owner.
- Keep background jobs shallow and make the underlying operation callable synchronously.

## Choosing where behavior belongs

Use this order when placing new backend behavior:

1. Put behavior on the Active Record model when that record owns the rule or transition.
2. Extract a model concern when one cohesive capability would otherwise dominate a model or is shared by models.
3. Use an Active Model form object for multi-step input, cross-record validation, or form-specific state.
4. Use a role-named PORO for an algorithm, strategy, value, integration client, or orchestration with no natural model owner.
5. Use a job only as the asynchronous entry point to one of the above.

Avoid a generic `Services` namespace or `app/services` dumping ground. Namespace POROs under the domain they serve and name them by role, such as `Search::Query`, `Billing::Gateway`, or `Report::Renderer`. A service-like PORO should have a small, intention-revealing public API and keep its collaborators explicit.

## Model patterns

### Composition through concerns

Keep the main model readable and let each concern own one capability:

```ruby
class Card < ApplicationRecord
  include Assignable, Closeable, Commentable, Searchable, Watchable

  belongs_to :board
  belongs_to :creator, class_name: "User", default: -> { Current.user }

  scope :latest, -> { order(last_active_at: :desc, id: :desc) }
  scope :preloaded, -> { preload(:board, :creator) }
end
```

- Derive association defaults from related records or `Current` when the invariant is unambiguous.
- Keep concerns focused on one capability, including its associations, scopes, callbacks, and public methods.
- Do not use a concern merely to make a model file shorter.

### Factory methods for compound creation

When creating one domain object requires several related records, expose an intention-revealing class method and keep the invariant in one place:

```ruby
class Account < ApplicationRecord
  def self.create_with_owner(account:, owner:)
    transaction do
      create!(**account).tap do |created_account|
        created_account.users.create!(role: :system, name: "System")
        created_account.users.create!(**owner.with_defaults(role: :owner))
      end
    end
  end
end
```

### Dynamic scopes

Keep whitelisted index filters in composable scopes:

```ruby
scope :indexed_by, ->(index) do
  case index
  when "closed" then closed
  when "flagged" then flagged
  else all
  end
end

scope :sorted_by, ->(sort) do
  case sort
  when "oldest" then order(created_at: :asc)
  else order(created_at: :desc)
  end
end
```

Do not interpolate arbitrary request values into SQL.

## Concern patterns

### State as an association

For domain state that has metadata, ownership, or a lifecycle, prefer an associated record to a boolean:

```ruby
module Card::Closeable
  extend ActiveSupport::Concern

  included do
    has_one :closure, dependent: :destroy

    scope :closed, -> { joins(:closure) }
    scope :open, -> { where.missing(:closure) }
  end

  def closed?
    closure.present?
  end

  def open?
    !closed?
  end

  def close(user: Current.user)
    unless closed?
      transaction do
        postponement&.destroy!
        create_closure!(user:)
        track_event(:closed, creator: user)
      end
    end
  end

  def reopen(user: Current.user)
    if closed?
      transaction do
        closure.destroy!
        track_event(:reopened, creator: user)
      end
    end
  end
end
```

- Pair query methods with scopes: `closed?`, `closed`, and `open`.
- Make transitions safe to repeat where practical.
- Wrap related writes and cleanup in a transaction.
- Use the state record's timestamps and associations instead of duplicating metadata on the parent.
- For a simple transition used by only one model, keep the methods directly on that model.

### Template hooks

Concerns may define small overridable hooks when including models need controlled variation:

```ruby
module Eventable
  extend ActiveSupport::Concern

  included do
    has_many :events, as: :eventable, dependent: :destroy
  end

  def track_event(action, creator: Current.user, **particulars)
    if should_track_event?
      events.create!(action:, creator:, particulars:)
    end
  end

  private

  def should_track_event?
    true
  end
end
```

Keep the default obvious and the extension points few.

## PORO patterns

### Form objects with Active Model

Use a form object for form-specific validation or a multi-step workflow:

```ruby
class Signup
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :email_address, :string

  attr_reader :account, :user

  validates :email_address, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true

  def save
    if valid?
      create_records
      true
    else
      false
    end
  end

  private

  def create_records
    Account.transaction do
      @account = Account.create!(name:)
      @user = @account.users.create!(email_address:)
    end
  end
end
```

The form object coordinates input and validation; domain invariants still belong to the models.

### Value objects

Use immutable Ruby objects for derived data:

```ruby
class Card::Entropy
  attr_reader :card, :period

  def self.for(card)
    new(card, card.auto_postpone_period) if card.last_active_at
  end

  def initialize(card, period)
    @card = card
    @period = period
  end

  def auto_clean_at
    card.last_active_at + period
  end
end
```

Prefer a factory such as `.for` when the value is not always applicable.

### Strategies and factories

Use a factory when behavior varies by a known domain type:

```ruby
class Notifier
  def self.for(source)
    case source
    when Event then EventNotifier.new(source)
    when Mention then MentionNotifier.new(source)
    end
  end

  def initialize(source)
    @source = source
  end
end
```

Keep type selection in one place. Subclasses or collaborators should implement the same small protocol.

### Integration clients

Wrap an external API in a dedicated client or gateway PORO:

- Keep credentials and transport details inside the integration boundary.
- Accept the HTTP adapter or other collaborator explicitly when useful for testing.
- Convert remote responses and errors into application-owned values and exceptions.
- Keep business decisions out of the client; the calling model or workflow owns them.

## Controller patterns

### Thin controllers

Controllers should authenticate, authorize, load records, delegate to a domain method, and choose the response:

```ruby
class Cards::ClosuresController < ApplicationController
  before_action :set_card

  def create
    @card.close
    redirect_to @card
  end

  def destroy
    @card.reopen
    redirect_to @card
  end

  private

  def set_card
    @card = Current.user.accessible_cards.find(params[:card_id])
  end
end
```

Do not put branching business workflows, cross-record mutations, or integration logic in controllers.

### RESTful state transitions

Represent state changes as resources:

```ruby
# Avoid custom verbs:
# post :close
# post :reopen

resources :cards do
  resource :closure, only: %i[create destroy]
end
```

Use `create` to establish the state record and `destroy` to remove it.

### Controller concerns

Use controller concerns only for cohesive behavior shared by multiple controllers, such as loading the same parent resource or applying the same authorization boundary. Keep rendering decisions in the controller unless they are genuinely shared.

## Job patterns

Jobs are asynchronous wrappers, not a second business-logic layer:

```ruby
class Webhook::DeliveryJob < ApplicationJob
  queue_as :webhooks
  discard_on ActiveJob::DeserializationError

  def perform(delivery)
    delivery.deliver
  end
end
```

For operations available synchronously and asynchronously:

```ruby
class Webhook::Delivery < ApplicationRecord
  after_create_commit :deliver_later

  def deliver_later
    Webhook::DeliveryJob.perform_later(self)
  end

  def deliver
    # Perform the synchronous domain operation.
  end
end
```

- `_later` enqueues work.
- The synchronous method has no suffix, or uses `_now` only when needed for clarity.
- Pass records or simple serializable values to jobs.
- Make retries safe; record progress or use idempotency keys for external side effects.
- Use `after_commit` when enqueueing work that depends on committed database state.

## Current attributes

Use `ActiveSupport::CurrentAttributes` for thread-safe request context:

```ruby
class Current < ActiveSupport::CurrentAttributes
  attribute :session, :request_id, :user_agent, :ip_address

  delegate :user, to: :session, allow_nil: true
end
```

- Populate `Current` at the request boundary.
- Use `Current.user` for authenticated actor defaults where appropriate.
- Use `Current.set(...) { ... }` or a small wrapper method to establish context in jobs.
- Never store request-specific data in class variables, global variables, or other process-wide mutable state.
- Reset context in tests.

## Code style

### Visibility modifiers

Leave a blank line after `private` and do not indent private methods:

```ruby
class SomeClass
  def public_method
  end

  private

  def private_method
  end
end
```

### Conditional returns

Prefer an expanded conditional when both outcomes matter:

```ruby
def records_for(ids)
  if ids
    Record.find(ids)
  else
    []
  end
end
```

A guard clause is appropriate at the start of a non-trivial method when it makes the main path clearer.

### Method ordering

Order methods by invocation flow: callers before callees. Readers should encounter the public story before its implementation details.

### Bang methods

Use a bang suffix when there is a corresponding non-bang method with different failure behavior. Do not add `!` merely because a method mutates data.
