module UI
  class MarkdownComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-markdown", content, @html_attributes)
    end
  end
end
