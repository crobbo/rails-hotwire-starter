module UI
  class AnimationComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-animation", content, @html_attributes)
    end
  end
end
