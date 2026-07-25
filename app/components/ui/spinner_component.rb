module UI
  class SpinnerComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-spinner", content, @html_attributes)
    end
  end
end
