module UI
  class RatingComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-rating", content, @html_attributes)
    end
  end
end
