module UI
  class ToastComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end
  end
end
