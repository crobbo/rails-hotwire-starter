module UI
  class IntersectionObserverComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-intersection-observer", content, @html_attributes)
    end
  end
end
