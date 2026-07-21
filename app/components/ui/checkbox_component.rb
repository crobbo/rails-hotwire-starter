module UI
  class CheckboxComponent < ApplicationComponent
    SIZES = %w[xs s m l xl].freeze
    SIZE_ALIASES = { "small" => "s", "medium" => "m", "large" => "l" }.freeze

    def initialize(
      label:,
      name: nil,
      value: nil,
      hint: nil,
      size: :m,
      checked: false,
      indeterminate: false,
      required: false,
      disabled: false,
      **html_attributes
    )
      @label = label
      @name = name
      @value = value
      @hint = hint
      @size = SIZE_ALIASES.fetch(size.to_s, size.to_s)
      @checked = checked
      @indeterminate = indeterminate
      @required = required
      @disabled = disabled
      @html_attributes = html_attributes

      raise ArgumentError, "label is required" if @label.blank?

      validate_option!(:size, @size, SIZES)
    end

    private

    def attributes
      @html_attributes.merge(size: @size).tap do |attributes|
        attributes[:name] = @name if @name.present?
        attributes[:value] = @value unless @value.nil?
        attributes[:hint] = @hint if @hint.present?
        attributes[:checked] = true if @checked
        attributes[:indeterminate] = true if @indeterminate
        attributes[:required] = true if @required
        attributes[:disabled] = true if @disabled
      end
    end
  end
end
