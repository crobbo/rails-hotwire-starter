module UI
  class BreadcrumbItemComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-breadcrumb-item", content, @html_attributes)
    end
  end
end
