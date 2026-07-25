module UI
  class ProgressBarComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-progress-bar", content, @html_attributes)
    end
  end
end
