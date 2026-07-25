module UI
  class CardComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-card", content, @html_attributes)
    end
  end
end
