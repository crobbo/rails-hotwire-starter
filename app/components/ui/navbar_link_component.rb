module UI
  class NavbarLinkComponent < ApplicationComponent
    def initialize(label:, href:, current: false, **html_attributes)
      @label = label
      @href = href
      @current = current
      @html_attributes = html_attributes

      raise ArgumentError, "label is required" if @label.blank?
      raise ArgumentError, "href is required" if @href.blank?
    end

    private

    def attributes
      @html_attributes.merge(
        href: @href,
        class: [ "ui-navbar__link", @html_attributes[:class] ].compact.join(" ")
      ).tap do |attributes|
        attributes["aria-current"] = "page" if @current
      end
    end
  end
end
