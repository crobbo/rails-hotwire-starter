module UI
  class PageComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-page", content, @html_attributes)
    end
  end
end
