module UI
  class SliderComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-slider", content, @html_attributes)
    end
  end
end
