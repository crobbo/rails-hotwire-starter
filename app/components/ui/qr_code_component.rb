module UI
  class QrCodeComponent < ApplicationComponent
    def initialize(**html_attributes)
      @html_attributes = html_attributes
    end

    def call
      content_tag(:"wa-qr-code", content, @html_attributes)
    end
  end
end
