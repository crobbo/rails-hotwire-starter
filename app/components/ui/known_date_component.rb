module UI
  class KnownDateComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-known-date", content, @html_attributes)
    end
  end
end
