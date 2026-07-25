module UI
  class RelativeTimeComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-relative-time", content, @html_attributes)
    end
  end
end
