require "test_helper"

class UI::CheckboxComponentTest < ViewComponent::TestCase
  test "renders a checked form-associated checkbox" do
    render_inline(UI::CheckboxComponent.new(
      label: "Allow invitations",
      name: "project[allow_invitations]",
      value: "1",
      hint: "Members can invite other people.",
      checked: true,
      required: true
    ))

    assert_selector "wa-checkbox[name='project[allow_invitations]'][value='1'][checked][required]", text: "Allow invitations"
    assert_selector "wa-checkbox[hint='Members can invite other people.'][size='m']"
  end

  test "supports an indeterminate state" do
    render_inline(UI::CheckboxComponent.new(label: "Select all", indeterminate: true, size: :large))

    assert_selector "wa-checkbox[indeterminate][size='l']", text: "Select all"
  end
end
