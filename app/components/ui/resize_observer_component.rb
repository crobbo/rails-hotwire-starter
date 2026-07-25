module UI
  class ResizeObserverComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-resize-observer", content, @html_attributes)
    end
  end
end
