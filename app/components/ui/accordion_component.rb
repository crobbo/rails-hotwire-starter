module UI
  class AccordionComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-accordion", content, @html_attributes)
    end
  end
end
