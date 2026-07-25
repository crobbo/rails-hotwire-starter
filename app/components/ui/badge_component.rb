module UI
  class BadgeComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-badge", content, @html_attributes)
    end
  end
end
