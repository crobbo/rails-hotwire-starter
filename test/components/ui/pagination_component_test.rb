require "test_helper"

class UI::PaginationComponentTest < ViewComponent::TestCase
  test "preserves link templates, page settings, and slotted content" do
    render_inline(UI::PaginationComponent.new(
      label: "Projects", total: 237, page: 3, "page-size": 25, "href-template": "/projects?page={page}",
      data: { action: "wa-page-change->projects#navigate" }
    )) { vc_test_view_context.content_tag(:span, "Next", slot: "next-icon") }

    assert_selector "wa-pagination[label='Projects'][total='237'][page='3'][page-size='25'][href-template='/projects?page={page}'][data-action='wa-page-change->projects#navigate']"
    assert_selector "wa-pagination [slot='next-icon']", text: "Next"
  end

  test "requires an accessible label" do
    assert_raises(ArgumentError) { UI::PaginationComponent.new(label: "") }
  end
end
