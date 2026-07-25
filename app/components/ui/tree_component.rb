module UI
  class TreeComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-tree", content, @html_attributes)
    end
  end
end
