module UI
  class IncludeComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-include", content, @html_attributes)
    end
  end
end
