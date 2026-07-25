module UI
  class ButtonGroupComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-button-group", content, @html_attributes)
    end
  end
end
