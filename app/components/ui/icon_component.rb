module UI
  class IconComponent < ApplicationComponent
    def initialize(
      name:,
      family: nil,
      variant: nil,
      label: nil,
      library: nil,
      canvas: nil,
      **html_attributes
    )
      @name = name
      @family = family
      @variant = variant
      @label = label
      @library = library
      @canvas = canvas
      @html_attributes = html_attributes

      raise ArgumentError, "name is required" if @name.blank?
    end

    private

    def attributes
      @html_attributes.merge(name: @name).tap do |attributes|
        attributes[:family] = @family if @family.present?
        attributes[:variant] = @variant if @variant.present?
        attributes[:label] = @label if @label.present?
        attributes[:library] = @library if @library.present?
        attributes[:canvas] = @canvas if @canvas.present?
      end
    end
  end
end
