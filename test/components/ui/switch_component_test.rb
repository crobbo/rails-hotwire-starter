require "test_helper"

class UI::SwitchComponentTest < ViewComponent::TestCase
  test "renders a checked form-associated switch" do
    render_inline(UI::SwitchComponent.new(
      label: "Email summaries",
      name: "project[email_summaries]",
      value: "1",
      hint: "Receive a weekly activity summary.",
      checked: true,
      data: { action: "change->preferences#save" }
    ))

    assert_selector "wa-switch[name='project[email_summaries]'][value='1'][checked]", text: "Email summaries"
    assert_selector "wa-switch[hint='Receive a weekly activity summary.'][data-action='change->preferences#save']"
  end

  test "rejects an unsupported size" do
    error = assert_raises(ArgumentError) do
      UI::SwitchComponent.new(label: "Email summaries", size: :huge)
    end

    assert_includes error.message, "size must be one of"
  end
end
