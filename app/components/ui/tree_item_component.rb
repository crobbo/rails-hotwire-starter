module UI
  class TreeItemComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-tree-item", content, @html_attributes)
    end
  end
end
