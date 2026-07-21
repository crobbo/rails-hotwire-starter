require "test_helper"

class UI::SelectComponentTest < ViewComponent::TestCase
  test "renders a form-associated select with ordered options" do
    component = UI::SelectComponent.new(
      label: "Visibility",
      name: "project[visibility]",
      hint: "Choose who can see this project.",
      with_clear: true,
      required: true,
      data: { action: "change->project#visibilityChanged" }
    )
    component.with_option(label: "Private", value: "private", selected: true)
    component.with_option(value: "team") { "Team" }
    component.with_option(label: "Public", value: "public", disabled: true)

    render_inline(component)

    assert_selector "wa-select[label='Visibility'][name='project[visibility]'][with-clear][required]"
    assert_selector "wa-select[data-action='change->project#visibilityChanged'] > wa-option", count: 3
    assert_selector "wa-option[value='private'][selected]", text: "Private"
    assert_selector "wa-option[value='team']", text: "Team"
    assert_selector "wa-option[value='public'][disabled]", text: "Public"
  end

  test "requires at least one option" do
    error = assert_raises(ArgumentError) do
      render_inline(UI::SelectComponent.new(label: "Visibility"))
    end

    assert_equal "at least one option is required", error.message
  end

  test "option requires a value" do
    error = assert_raises(ArgumentError) do
      UI::OptionComponent.new(label: "Private", value: "")
    end

    assert_equal "value is required", error.message
  end
end
