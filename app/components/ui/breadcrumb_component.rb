module UI
  class BreadcrumbComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-breadcrumb", content, @html_attributes)
    end
  end
end
