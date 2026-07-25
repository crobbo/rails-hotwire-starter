module UI
  class MutationObserverComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-mutation-observer", content, @html_attributes)
    end
  end
end
