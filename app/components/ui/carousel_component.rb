module UI
  class CarouselComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-carousel", content, @html_attributes)
    end
  end
end
