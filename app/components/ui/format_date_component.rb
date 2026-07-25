module UI
  class FormatDateComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-format-date", content, @html_attributes)
    end
  end
end
