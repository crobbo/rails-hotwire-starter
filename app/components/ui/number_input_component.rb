module UI
  class NumberInputComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-number-input", content, @html_attributes)
    end
  end
end
