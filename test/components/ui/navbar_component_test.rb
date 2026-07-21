require "test_helper"

class UI::NavbarComponentTest < ViewComponent::TestCase
  test "renders accessible navigation with links and actions" do
    component = UI::NavbarComponent.new(label: "Workspace navigation", data: { testid: "navbar" })

    render_inline(component) do |navbar|
      navbar.with_brand_content("Acme")
      navbar.with_link(label: "Projects", href: "/projects", current: true)
      navbar.with_link(label: "People", href: "/people")
      navbar.with_actions_content("Account")
    end

    assert_selector "nav.ui-navbar[aria-label='Workspace navigation'][data-testid='navbar']" do
      assert_selector ".ui-navbar__brand", text: "Acme"
      assert_selector "a.ui-navbar__link[href='/projects'][aria-current='page']", text: "Projects"
      assert_selector "a.ui-navbar__link[href='/people']:not([aria-current])", text: "People"
      assert_selector ".ui-navbar__actions", text: "Account"
    end
  end

  test "requires a brand" do
    error = assert_raises(ArgumentError) do
      render_inline(UI::NavbarComponent.new)
    end

    assert_equal "navbar brand is required", error.message
  end
end
