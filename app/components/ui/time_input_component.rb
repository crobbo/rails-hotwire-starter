module UI
  class TimeInputComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-time-input", content, @html_attributes)
    end
  end
end
