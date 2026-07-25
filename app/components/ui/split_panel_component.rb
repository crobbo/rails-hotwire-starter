module UI
  class SplitPanelComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-split-panel", content, @html_attributes)
    end
  end
end
