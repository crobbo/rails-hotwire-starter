require "test_helper"

class UI::DialogComponentTest < ViewComponent::TestCase
  test "renders dialog content and footer slot" do
    component = UI::DialogComponent.new(
      label: "Confirm deletion",
      light_dismiss: true,
      data: { dialog_target: "dialog" }
    )

    render_inline(component) do |dialog|
      dialog.with_footer_content("Cancel")
      "This cannot be undone."
    end

    assert_selector "wa-dialog.ui-dialog[label='Confirm deletion'][light-dismiss][with-footer][data-dialog-target='dialog']" do
      assert_text "This cannot be undone."
      assert_selector "[slot='footer']", text: "Cancel"
    end
  end

  test "requires an accessible label" do
    error = assert_raises(ArgumentError) do
      UI::DialogComponent.new(label: nil)
    end

    assert_equal "label is required", error.message
  end
end
