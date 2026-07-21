module UI
  class SelectComponent < ApplicationComponent
    APPEARANCES = %w[filled outlined filled-outlined].freeze
    SIZES = %w[xs s m l xl].freeze
    SIZE_ALIASES = { "small" => "s", "medium" => "m", "large" => "l" }.freeze
    PLACEMENTS = %w[top bottom].freeze

    renders_many :options, lambda { |**options|
      UI::OptionComponent.new(**options)
    }

    def initialize(
      label:,
      name: nil,
      value: nil,
      hint: nil,
      placeholder: nil,
      appearance: :outlined,
      size: :m,
      placement: :bottom,
      multiple: false,
      max_options_visible: nil,
      required: false,
      disabled: false,
      with_clear: false,
      pill: false,
      open: false,
      **html_attributes
    )
      @label = label
      @name = name
      @value = value
      @hint = hint
      @placeholder = placeholder
      @appearance = appearance.to_s.tr("_", "-")
      @size = SIZE_ALIASES.fetch(size.to_s, size.to_s)
      @placement = placement.to_s
      @multiple = multiple
      @max_options_visible = max_options_visible
      @required = required
      @disabled = disabled
      @with_clear = with_clear
      @pill = pill
      @open = open
      @html_attributes = html_attributes

      raise ArgumentError, "label is required" if @label.blank?

      validate_option!(:appearance, @appearance, APPEARANCES)
      validate_option!(:size, @size, SIZES)
      validate_option!(:placement, @placement, PLACEMENTS)
    end

    def before_render
      raise ArgumentError, "at least one option is required" if options.empty?
    end

    private

    def attributes
      @html_attributes.merge(
        label: @label,
        appearance: @appearance,
        size: @size,
        placement: @placement
      ).tap do |attributes|
        attributes[:name] = @name if @name.present?
        attributes[:value] = @value unless @value.nil?
        attributes[:hint] = @hint if @hint.present?
        attributes[:placeholder] = @placeholder if @placeholder.present?
        attributes[:multiple] = true if @multiple
        attributes["max-options-visible"] = @max_options_visible unless @max_options_visible.nil?
        attributes[:required] = true if @required
        attributes[:disabled] = true if @disabled
        attributes["with-clear"] = true if @with_clear
        attributes[:pill] = true if @pill
        attributes[:open] = true if @open
      end
    end
  end
end
