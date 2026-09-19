module UI
  class OtpInputComponent < ApplicationComponent
    def initialize(label:, **html_attributes)
      raise ArgumentError, "label is required" if label.blank?

      @html_attributes = html_attributes.merge(label: label)
    end
  end
end
