module UI
  class ScrollerComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-scroller", content, @html_attributes)
    end
  end
end
