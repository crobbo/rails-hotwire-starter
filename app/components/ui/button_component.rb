module UI
  class ButtonComponent < ApplicationComponent
    VARIANTS = %w[neutral brand success warning danger].freeze
    APPEARANCES = %w[accent filled outlined filled-outlined plain].freeze
    SIZES = %w[xs s m l xl].freeze
    SIZE_ALIASES = { "small" => "s", "medium" => "m", "large" => "l" }.freeze

    def initialize(
      variant: :neutral,
      appearance: :filled,
      size: :m,
      href: nil,
      type: :button,
      disabled: false,
      loading: false,
      pill: false,
      with_caret: false,
      **html_attributes
    )
      @variant = variant.to_s
      @appearance = appearance.to_s.tr("_", "-")
      @size = SIZE_ALIASES.fetch(size.to_s, size.to_s)
      @href = href
      @type = type.to_s
      @disabled = disabled
      @loading = loading
      @pill = pill
      @with_caret = with_caret
      @html_attributes = html_attributes

      validate_option!(:variant, @variant, VARIANTS)
      validate_option!(:appearance, @appearance, APPEARANCES)
      validate_option!(:size, @size, SIZES)
    end

    private

    def attributes
      @html_attributes.merge(
        variant: @variant,
        appearance: @appearance,
        size: @size
      ).tap do |attributes|
        attributes[:href] = @href if @href.present?
        attributes[:type] = @type if @href.blank?
        attributes[:disabled] = true if @disabled
        attributes[:loading] = true if @loading
        attributes[:pill] = true if @pill
        attributes["with-caret"] = true if @with_caret
      end
    end
  end
end
