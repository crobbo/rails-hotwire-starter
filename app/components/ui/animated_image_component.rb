module UI
  class AnimatedImageComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-animated-image", content, @html_attributes)
    end
  end
end
