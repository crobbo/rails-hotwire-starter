module UI
  class PopoverComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-popover", content, @html_attributes)
    end
  end
end
