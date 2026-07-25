require "test_helper"

class UI::WebAwesomeWrappersTest < ViewComponent::TestCase
  WRAPPERS = {
    Accordion: "accordion", AccordionItem: "accordion-item", AnimatedImage: "animated-image", Animation: "animation",
    Avatar: "avatar", Badge: "badge", Breadcrumb: "breadcrumb", BreadcrumbItem: "breadcrumb-item", ButtonGroup: "button-group",
    Callout: "callout", Card: "card", Carousel: "carousel", CarouselItem: "carousel-item", CheckboxGroup: "checkbox-group",
    ColorPicker: "color-picker", Comparison: "comparison", CopyButton: "copy-button", Details: "details", Drawer: "drawer",
    Dropdown: "dropdown", DropdownItem: "dropdown-item", FormatBytes: "format-bytes", FormatDate: "format-date",
    FormatNumber: "format-number", Include: "include", IntersectionObserver: "intersection-observer", KnownDate: "known-date",
    Markdown: "markdown", MutationObserver: "mutation-observer", NumberInput: "number-input", Page: "page", Popover: "popover",
    Popup: "popup", ProgressBar: "progress-bar", ProgressRing: "progress-ring", QrCode: "qr-code", Radio: "radio",
    RadioGroup: "radio-group", RandomContent: "random-content", Rating: "rating", RelativeTime: "relative-time",
    ResizeObserver: "resize-observer", Scroller: "scroller", Skeleton: "skeleton", Slider: "slider", Spinner: "spinner",
    SplitPanel: "split-panel", Tab: "tab", TabGroup: "tab-group", TabPanel: "tab-panel", Tag: "tag", TimeInput: "time-input",
    Tooltip: "tooltip", Tree: "tree", TreeItem: "tree-item", ZoomableFrame: "zoomable-frame"
  }.freeze

  test "renders every thin Web Awesome wrapper with content and HTML attributes" do
    WRAPPERS.each do |name, tag|
      render_inline("UI::#{name}Component".constantize.new(data: {controller: "example"})) { "Example" }

      assert_selector "wa-#{tag}[data-controller='example']", text: "Example"
    end
  end
end
