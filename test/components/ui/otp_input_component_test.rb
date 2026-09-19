require "test_helper"

class UI::OtpInputComponentTest < ViewComponent::TestCase
  test "renders a labelled code field with form attributes and hint content" do
    render_inline(UI::OtpInputComponent.new(
      label: "Verification code", name: "verification[code]", value: "123456", required: true,
      data: { action: "wa-complete->verification#submit" }
    )) { vc_test_view_context.content_tag(:span, "Check your messages.", slot: "hint") }

    assert_selector "wa-otp-input[label='Verification code'][name='verification[code]'][value='123456'][required][data-action='wa-complete->verification#submit']"
    assert_selector "wa-otp-input [slot='hint']", text: "Check your messages."
  end

  test "requires an accessible label" do
    assert_raises(ArgumentError) { UI::OtpInputComponent.new(label: "") }
  end
end
