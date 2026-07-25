module UI
  class TabPanelComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-tab-panel", content, @html_attributes)
    end
  end
end
