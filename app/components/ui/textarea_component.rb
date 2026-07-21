module UI
  class TextareaComponent < ApplicationComponent
    APPEARANCES = %w[filled outlined filled-outlined].freeze
    SIZES = %w[xs s m l xl].freeze
    SIZE_ALIASES = { "small" => "s", "medium" => "m", "large" => "l" }.freeze
    RESIZE_MODES = %w[none vertical horizontal both auto].freeze

    def initialize(
      label:,
      name: nil,
      value: nil,
      hint: nil,
      placeholder: nil,
      rows: nil,
      resize: :vertical,
      appearance: :outlined,
      size: :m,
      minlength: nil,
      maxlength: nil,
      required: false,
      disabled: false,
      readonly: false,
      with_count: false,
      **html_attributes
    )
      @label = label
      @name = name
      @value = value
      @hint = hint
      @placeholder = placeholder
      @rows = rows
      @resize = resize.to_s
      @appearance = appearance.to_s.tr("_", "-")
      @size = SIZE_ALIASES.fetch(size.to_s, size.to_s)
      @minlength = minlength
      @maxlength = maxlength
      @required = required
      @disabled = disabled
      @readonly = readonly
      @with_count = with_count
      @html_attributes = html_attributes

      raise ArgumentError, "label is required" if @label.blank?

      validate_option!(:resize, @resize, RESIZE_MODES)
      validate_option!(:appearance, @appearance, APPEARANCES)
      validate_option!(:size, @size, SIZES)
    end

    private

    def attributes
      @html_attributes.merge(
        label: @label,
        resize: @resize,
        appearance: @appearance,
        size: @size
      ).tap do |attributes|
        attributes[:name] = @name if @name.present?
        attributes[:value] = @value unless @value.nil?
        attributes[:hint] = @hint if @hint.present?
        attributes[:placeholder] = @placeholder if @placeholder.present?
        attributes[:rows] = @rows unless @rows.nil?
        attributes[:minlength] = @minlength unless @minlength.nil?
        attributes[:maxlength] = @maxlength unless @maxlength.nil?
        attributes[:required] = true if @required
        attributes[:disabled] = true if @disabled
        attributes[:readonly] = true if @readonly
        attributes["with-count"] = true if @with_count
      end
    end
  end
end
