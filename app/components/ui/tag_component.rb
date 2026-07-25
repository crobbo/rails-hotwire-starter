module UI
  class TagComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-tag", content, @html_attributes)
    end
  end
end
