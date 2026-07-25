module UI
  class DropdownComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-dropdown", content, @html_attributes)
    end
  end
end
