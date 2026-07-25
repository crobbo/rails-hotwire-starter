module UI
  class RandomContentComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-random-content", content, @html_attributes)
    end
  end
end
