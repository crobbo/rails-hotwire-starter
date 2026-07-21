module UI
  class OptionComponent < ApplicationComponent
    def initialize(value:, label: nil, selected: false, disabled: false, **html_attributes)
      @value = value
      @label = label
      @selected = selected
      @disabled = disabled
      @html_attributes = html_attributes

      raise ArgumentError, "value is required" if @value.blank?
    end

    def before_render
      raise ArgumentError, "label or content is required" if @label.blank? && !content?
    end

    private

    def label_content
      @label.presence || content
    end

    def attributes
      @html_attributes.merge(value: @value).tap do |attributes|
        attributes[:selected] = true if @selected
        attributes[:disabled] = true if @disabled
      end
    end
  end
end
