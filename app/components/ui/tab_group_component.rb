module UI
  class TabGroupComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-tab-group", content, @html_attributes)
    end
  end
end
