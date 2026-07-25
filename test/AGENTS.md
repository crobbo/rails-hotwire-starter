# Minitest patterns

## Philosophy

- Test observable behavior and persisted state, not private methods or implementation structure.
- Use model tests for domain rules and transitions.
- Use integration tests for complete HTTP behavior, authentication boundaries, redirects, and rendered outcomes.
- Use job tests to verify enqueueing and the job boundary; test the synchronous domain operation directly.
- Cover successful paths, invalid input, authorization, repeated transitions, and related state cleanup.

## Current context

Establish and reset request context around tests that depend on `Current`:

```ruby
class Card::CloseableTest < ActiveSupport::TestCase
  setup do
    @user = users(:david)
    Current.session = Session.new(user: @user)
  end

  teardown do
    Current.reset
  end

  test "returns closed cards" do
    closed_card = cards(:closed)
    open_card = cards(:open)

    assert_includes Card.closed, closed_card
    assert_not_includes Card.closed, open_card
  end
end
```

Prefer `Current.set(session: ...) { ... }` when the context is needed only for one assertion.

## State transitions

Assert the state before and after the public domain method, including audit records or related effects:

```ruby
class Card::CloseableTest < ActiveSupport::TestCase
  test "closes a card and records the actor" do
    card = cards(:open)
    user = users(:david)

    assert_not card.closed?

    assert_difference -> { card.events.count }, 1 do
      card.close(user:)
    end

    assert card.closed?
    assert_equal user, card.closure.user
    assert_equal "closed", card.events.last.action
  end
end
```

Also test repeated calls when the transition is intended to be idempotent.

## Compound state changes

Verify related state is cleared or created atomically:

```ruby
test "closing a postponed card clears its postponement" do
  card = cards(:postponed)

  assert card.postponed?
  card.close

  assert card.closed?
  assert_nil card.reload.postponement
end
```

Reload when the assertion must prove persisted database state rather than an in-memory association.

## Integration tests

Exercise the public route and assert the user-visible result:

```ruby
class SearchFlowTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:david)
  end

  test "returns matching results" do
    get search_path, params: { q: "NHS" }

    assert_response :success
    assert_includes response.body, "NHS"
  end
end
```

Put reusable authentication helpers in `test/support/authentication_helpers.rb`, require them from `test/test_helper.rb`, and use the same helper in integration and system tests. Do not duplicate cookie or session setup across tests.

## Jobs

Test enqueueing separately from execution:

```ruby
test "enqueues delivery after commit" do
  assert_enqueued_with(job: Webhook::DeliveryJob) do
    Webhook::Delivery.create!(url: "https://example.test/hook")
  end
end

test "performs a pending delivery" do
  delivery = webhook_deliveries(:pending)

  Webhook::DeliveryJob.perform_now(delivery)

  assert_equal "completed", delivery.reload.state
end
```

Assert the resulting state instead of adding a mocking library solely to test delegation.

## Test data

- Use fixtures for stable domain examples and name them by meaning, such as `open` or `closed`.
- Create records inline when the setup is unique to one test and fixtures would obscure the behavior.
- Keep tests deterministic: freeze time when time matters and never depend on record ordering without an explicit order.
- Assert both the primary outcome and important side effects, but avoid restating every implementation step.
