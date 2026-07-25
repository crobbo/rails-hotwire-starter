module UI
  class CheckboxGroupComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-checkbox-group", content, @html_attributes)
    end
  end
end
