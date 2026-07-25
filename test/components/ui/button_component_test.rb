require "test_helper"

class UI::ButtonComponentTest < ViewComponent::TestCase
  test "renders Web Awesome options and Rails data attributes" do
    render_inline(UI::ButtonComponent.new(
      variant: :brand,
      appearance: :accent,
      size: :large,
      type: :submit,
      with_start: true,
      data: { action: "click->form#submit" }
    )) { "Save" }

    assert_selector "wa-button[variant='brand'][appearance='accent'][size='l'][type='submit'][with-start][data-action='click->form#submit']", text: "Save"
  end

  test "renders links without a button type" do
    render_inline(UI::ButtonComponent.new(href: "/projects")) { "Projects" }

    assert_selector "wa-button[href='/projects']:not([type])", text: "Projects"
  end

  test "rejects unsupported options" do
    error = assert_raises(ArgumentError) do
      UI::ButtonComponent.new(appearance: :shiny)
    end

    assert_includes error.message, "appearance must be one of"
  end
end
