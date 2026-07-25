module UI
  class SkeletonComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-skeleton", content, @html_attributes)
    end
  end
end
