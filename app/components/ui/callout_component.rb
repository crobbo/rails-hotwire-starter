module UI
  class CalloutComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-callout", content, @html_attributes)
    end
  end
end
