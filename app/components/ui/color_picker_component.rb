module UI
  class ColorPickerComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-color-picker", content, @html_attributes)
    end
  end
end
