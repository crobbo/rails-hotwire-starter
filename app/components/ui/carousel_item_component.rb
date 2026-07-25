module UI
  class CarouselItemComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-carousel-item", content, @html_attributes)
    end
  end
end
