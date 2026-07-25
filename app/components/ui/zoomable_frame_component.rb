module UI
  class ZoomableFrameComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-zoomable-frame", content, @html_attributes)
    end
  end
end
