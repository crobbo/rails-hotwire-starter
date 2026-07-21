require "test_helper"

class WebAwesomeCoverageTest < ActiveSupport::TestCase
  test "registers every component shipped by the pinned Web Awesome package" do
    component_root = Rails.root.join("node_modules/@awesome.me/webawesome/dist/components")
    installed_components = component_root.children.select(&:directory?).map(&:basename).map(&:to_s).sort

    imports = Rails.root.join("app/javascript/lib/web_awesome.js").read
    imported_components = imports.scan(%r{dist/components/([^/]+)/\1\.js}).flatten.sort

    assert_equal installed_components, imported_components,
      "Update app/javascript/lib/web_awesome.js when the pinned Web Awesome catalogue changes"
  end
end
