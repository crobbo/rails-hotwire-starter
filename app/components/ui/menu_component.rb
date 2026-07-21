module UI
  class MenuComponent < ApplicationComponent
    PLACEMENTS = %w[
      top top-start top-end
      bottom bottom-start bottom-end
      right right-start right-end
      left left-start left-end
    ].freeze
    SIZES = %w[xs s m l xl].freeze
    SIZE_ALIASES = { "small" => "s", "medium" => "m", "large" => "l" }.freeze

    renders_one :trigger, lambda { |**options|
      UI::ButtonComponent.new(**options, slot: "trigger")
    }
    renders_many :entries, types: {
      item: {
        renders: lambda { |**options| UI::MenuItemComponent.new(**options) },
        as: :item
      },
      divider: {
        renders: lambda { |**options| UI::DividerComponent.new(**options) },
        as: :divider
      },
      label: {
        renders: lambda { |**options| UI::MenuLabelComponent.new(**options) },
        as: :label
      }
    }

    def initialize(
      placement: :bottom_end,
      size: :m,
      distance: nil,
      skidding: nil,
      open: false,
      **html_attributes
    )
      @placement = placement.to_s.tr("_", "-")
      @size = SIZE_ALIASES.fetch(size.to_s, size.to_s)
      @distance = distance
      @skidding = skidding
      @open = open
      @html_attributes = html_attributes

      validate_option!(:placement, @placement, PLACEMENTS)
      validate_option!(:size, @size, SIZES)
    end

    def before_render
      raise ArgumentError, "menu trigger is required" unless trigger?
      raise ArgumentError, "at least one menu entry is required" if entries.empty?
    end

    private

    def attributes
      @html_attributes.merge(
        class: [ "ui-menu", @html_attributes[:class] ].compact.join(" "),
        placement: @placement,
        size: @size
      ).tap do |attributes|
        attributes[:distance] = @distance unless @distance.nil?
        attributes[:skidding] = @skidding unless @skidding.nil?
        attributes[:open] = true if @open
      end
    end
  end
end
