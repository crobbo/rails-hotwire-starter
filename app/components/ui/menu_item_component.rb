module UI
  class MenuItemComponent < ApplicationComponent
    VARIANTS = %w[default danger].freeze
    TYPES = %w[normal checkbox].freeze

    renders_one :details

    def initialize(
      label: nil,
      value: nil,
      variant: :default,
      type: :normal,
      checked: false,
      disabled: false,
      icon_name: nil,
      icon_family: nil,
      icon_variant: nil,
      details: nil,
      submenu: [],
      **html_attributes
    )
      @label = label
      @value = value
      @variant = variant.to_s
      @type = type.to_s
      @checked = checked
      @disabled = disabled
      @icon_name = icon_name
      @icon_family = icon_family
      @icon_variant = icon_variant
      @details_text = details
      @submenu = submenu
      @html_attributes = html_attributes

      validate_option!(:variant, @variant, VARIANTS)
      validate_option!(:type, @type, TYPES)
      raise ArgumentError, "checked is only valid for checkbox items" if @checked && @type != "checkbox"
    end

    def before_render
      raise ArgumentError, "menu item label is required" if @label.blank? && content.blank?
    end

    private

    def label_content
      content.presence || @label
    end

    def icon?
      @icon_name.present?
    end

    def icon_attributes
      { name: @icon_name, slot: "icon" }.tap do |attributes|
        attributes[:family] = @icon_family if @icon_family.present?
        attributes[:variant] = @icon_variant if @icon_variant.present?
      end
    end

    def detail_content
      details? ? details : @details_text
    end

    def submenu_components
      @submenu.map do |options|
        UI::MenuItemComponent.new(**options.to_h.symbolize_keys, slot: "submenu")
      end
    end

    def attributes
      @html_attributes.merge(variant: @variant, type: @type).tap do |attributes|
        attributes[:value] = @value if @value.present?
        attributes[:checked] = true if @checked
        attributes[:disabled] = true if @disabled
      end
    end
  end
end
