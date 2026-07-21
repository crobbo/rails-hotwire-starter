require "test_helper"

class UI::TextareaComponentTest < ViewComponent::TestCase
  test "renders a labelled textarea with Rails and Web Awesome options" do
    render_inline(UI::TextareaComponent.new(
      label: "Description",
      name: "project[description]",
      value: "A useful Rails app",
      hint: "Keep it concise.",
      rows: 5,
      maxlength: 160,
      with_count: true,
      required: true,
      data: { controller: "autosave" }
    ))

    assert_selector "wa-textarea[label='Description'][name='project[description]'][value='A useful Rails app']"
    assert_selector "wa-textarea[rows='5'][maxlength='160'][with-count][required][data-controller='autosave']"
  end

  test "rejects an unsupported resize mode" do
    error = assert_raises(ArgumentError) do
      UI::TextareaComponent.new(label: "Description", resize: :diagonal)
    end

    assert_includes error.message, "resize must be one of"
  end
end
