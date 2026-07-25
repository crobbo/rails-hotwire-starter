module UI
  class TooltipComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-tooltip", content, @html_attributes)
    end
  end
end
