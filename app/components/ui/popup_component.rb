module UI
  class PopupComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-popup", content, @html_attributes)
    end
  end
end
