module UI
  class TabComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-tab", content, @html_attributes)
    end
  end
end
