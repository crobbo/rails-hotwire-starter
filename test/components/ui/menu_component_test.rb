require "test_helper"

class UI::MenuComponentTest < ViewComponent::TestCase
  test "renders a Web Awesome dropdown with trigger and items" do
    component = UI::MenuComponent.new(placement: :bottom_end, size: :medium)

    render_inline(component) do |menu|
      menu.with_trigger(appearance: :outlined, with_caret: true) { "Actions" }
      menu.with_label { "Editing" }
      menu.with_item(label: "Rename", value: "rename", icon_name: "pen", details: "⌘R")
      menu.with_divider
      menu.with_item(label: "Show grid", value: "grid", type: :checkbox, checked: true)
      menu.with_item(label: "Delete", value: "delete", variant: :danger, disabled: true)
    end

    assert_selector "wa-dropdown.ui-menu[placement='bottom-end'][size='m']" do
      assert_selector "wa-button[slot='trigger'][with-caret]", text: "Actions"
      assert_selector "h3", text: "Editing"
      assert_selector "wa-dropdown-item[value='rename']", text: "Rename" do
        assert_selector "wa-icon[slot='icon'][name='pen']"
        assert_selector "[slot='details']", text: "⌘R"
      end
      assert_selector "wa-divider[orientation='horizontal']"
      assert_selector "wa-dropdown-item[value='grid'][type='checkbox'][checked]", text: "Show grid"
      assert_selector "wa-dropdown-item[variant='danger'][disabled]", text: "Delete"
    end
  end

  test "requires a trigger" do
    component = UI::MenuComponent.new

    error = assert_raises(ArgumentError) do
      render_inline(component) do |menu|
        menu.with_item(value: "rename") { "Rename" }
      end
    end

    assert_equal "menu trigger is required", error.message
  end

  test "rejects checked normal items" do
    error = assert_raises(ArgumentError) do
      UI::MenuItemComponent.new(checked: true)
    end

    assert_equal "checked is only valid for checkbox items", error.message
  end

  test "renders submenu items in the documented slot" do
    component = UI::MenuItemComponent.new(
      label: "Export",
      submenu: [
        { label: "CSV", value: "csv" },
        { label: "PDF", value: "pdf" }
      ]
    )

    render_inline(component)

    assert_selector "wa-dropdown-item", text: "Export" do
      assert_selector "wa-dropdown-item[slot='submenu'][value='csv']", text: "CSV"
      assert_selector "wa-dropdown-item[slot='submenu'][value='pdf']", text: "PDF"
    end
  end
end
