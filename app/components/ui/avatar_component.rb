module UI
  class AvatarComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-avatar", content, @html_attributes)
    end
  end
end
