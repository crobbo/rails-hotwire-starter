module UI
  class DropdownItemComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-dropdown-item", content, @html_attributes)
    end
  end
end
