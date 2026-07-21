module UI
  class InputComponent < ApplicationComponent
    TYPES = %w[date datetime-local email number password search tel text time url].freeze
    APPEARANCES = %w[filled outlined filled-outlined].freeze
    SIZES = %w[xs s m l xl].freeze
    SIZE_ALIASES = { "small" => "s", "medium" => "m", "large" => "l" }.freeze

    def initialize(
      label:,
      name: nil,
      value: nil,
      hint: nil,
      placeholder: nil,
      type: :text,
      appearance: :outlined,
      size: :m,
      required: false,
      disabled: false,
      readonly: false,
      with_clear: false,
      password_toggle: false,
      pill: false,
      **html_attributes
    )
      @label = label
      @name = name
      @value = value
      @hint = hint
      @placeholder = placeholder
      @type = type.to_s
      @appearance = appearance.to_s.tr("_", "-")
      @size = SIZE_ALIASES.fetch(size.to_s, size.to_s)
      @required = required
      @disabled = disabled
      @readonly = readonly
      @with_clear = with_clear
      @password_toggle = password_toggle
      @pill = pill
      @html_attributes = html_attributes

      raise ArgumentError, "label is required" if @label.blank?

      validate_option!(:type, @type, TYPES)
      validate_option!(:appearance, @appearance, APPEARANCES)
      validate_option!(:size, @size, SIZES)
    end

    private

    def attributes
      @html_attributes.merge(
        label: @label,
        type: @type,
        appearance: @appearance,
        size: @size
      ).tap do |attributes|
        attributes[:name] = @name if @name.present?
        attributes[:value] = @value unless @value.nil?
        attributes[:hint] = @hint if @hint.present?
        attributes[:placeholder] = @placeholder if @placeholder.present?
        attributes[:required] = true if @required
        attributes[:disabled] = true if @disabled
        attributes[:readonly] = true if @readonly
        attributes["with-clear"] = true if @with_clear
        attributes["password-toggle"] = true if @password_toggle
        attributes[:pill] = true if @pill
      end
    end
  end
end
