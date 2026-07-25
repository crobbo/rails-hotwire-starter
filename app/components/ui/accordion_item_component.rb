module UI
  class AccordionItemComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-accordion-item", content, @html_attributes)
    end
  end
end
