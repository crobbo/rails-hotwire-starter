require "test_helper"

class UI::InputComponentTest < ViewComponent::TestCase
  test "renders a labelled form-associated input" do
    render_inline(UI::InputComponent.new(
      label: "Email",
      name: "user[email]",
      type: :email,
      hint: "We will only use this for account messages.",
      required: true,
      autocomplete: "email"
    ))

    assert_selector "wa-input[label='Email'][name='user[email]'][type='email'][required][autocomplete='email']"
    assert_selector "wa-input[size='m']"
  end

  test "requires an accessible label" do
    error = assert_raises(ArgumentError) do
      UI::InputComponent.new(label: "")
    end

    assert_equal "label is required", error.message
  end
end
