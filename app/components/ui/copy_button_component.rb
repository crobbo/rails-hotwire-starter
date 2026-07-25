module UI
  class CopyButtonComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-copy-button", content, @html_attributes)
    end
  end
end
