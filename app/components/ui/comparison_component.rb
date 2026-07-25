module UI
  class ComparisonComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-comparison", content, @html_attributes)
    end
  end
end
