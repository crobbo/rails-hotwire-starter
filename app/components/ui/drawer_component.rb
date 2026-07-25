module UI
  class DrawerComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-drawer", content, @html_attributes)
    end
  end
end
