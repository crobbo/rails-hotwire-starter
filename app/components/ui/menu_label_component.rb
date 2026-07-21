module UI
  class MenuLabelComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    private

    attr_reader :html_attributes
  end
end
