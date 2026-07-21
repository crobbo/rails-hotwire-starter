require "test_helper"

class ComponentsControllerTest < ActionDispatch::IntegrationTest
  test "renders the component catalogue" do
    get components_url

    assert_response :success
    assert_select "h1", "Mulberry & Ink"
    assert_select "wa-dialog[label='Example dialog'] [slot='footer'] wa-button", "Close"
    assert_select "wa-copy-button[tooltip='copy'] wa-button[aria-label='Copy Rails command']", "Copy"
    assert_select "wa-animated-image[src='/web-awesome-demo.gif']"
    assert_select "wa-scroller .catalogue-scroller__track"
    assert_select "wa-badge[variant='brand']"
    assert_select "wa-badge[appearance='filled-outlined']"
    assert_select "wa-badge[attention='pulse']"
    assert_select "wa-badge[attention='bounce']"
    assert_select "wa-animation[name='bounce'][data-catalogue-target='animation']"
    assert_select "iframe[src='#{components_page_preview_path}'][data-catalogue-target='pageFrame']"
    assert_select "[data-action='click->catalogue#showDesktopPage']"
    assert_select "[data-action='click->catalogue#showMobilePage']"
    assert_select "[data-controller='catalogue']", minimum: 5
  end

  test "renders every component shipped by the pinned Web Awesome package across the catalogue previews" do
    get components_url
    catalogue_markup = response.body

    get components_page_preview_url
    page_preview_markup = response.body

    component_root = Rails.root.join("node_modules/@awesome.me/webawesome/dist/components")
    installed_components = component_root.children.select(&:directory?).map(&:basename).map(&:to_s).sort
    rendered_components = [ catalogue_markup, page_preview_markup ].join.scan(/<wa-([a-z0-9-]+)/).flatten.uniq.sort

    assert_equal installed_components, rendered_components
  end

  test "renders the include component fragment" do
    get components_include_fragment_url

    assert_response :success
    assert_select "p", "Loaded from a Rails partial endpoint."
  end

  test "renders a simple responsive page preview" do
    get components_page_preview_url

    assert_response :success
    assert_select "wa-page[mobile-breakpoint='640px']"
    assert_select "[slot='header']"
    assert_select "[slot='navigation-header']"
    assert_select "[slot='navigation']"
    assert_select "[slot='main-header']"
    assert_select "[slot='main-footer']"
    assert_select "main .page-preview__project-row", count: 3
  end
end
