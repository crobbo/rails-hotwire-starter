module UI
  class DetailsComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-details", content, @html_attributes)
    end
  end
end
