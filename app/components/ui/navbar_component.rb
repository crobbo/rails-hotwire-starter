module UI
  class NavbarComponent < ApplicationComponent
    renders_one :brand
    renders_many :links, lambda { |**options|
      UI::NavbarLinkComponent.new(**options)
    }
    renders_one :actions

    def initialize(label: "Primary navigation", **html_attributes)
      @label = label
      @html_attributes = html_attributes

      raise ArgumentError, "label is required" if @label.blank?
    end

    def before_render
      raise ArgumentError, "navbar brand is required" unless brand?
    end

    private

    def attributes
      @html_attributes.merge(
        aria: @html_attributes.fetch(:aria, {}).merge(label: @label),
        class: [ "ui-navbar", @html_attributes[:class] ].compact.join(" ")
      )
    end
  end
end
