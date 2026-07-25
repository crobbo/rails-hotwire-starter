module UI
  class ProgressRingComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-progress-ring", content, @html_attributes)
    end
  end
end
