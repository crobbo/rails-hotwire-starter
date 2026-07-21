module UI
  class DividerComponent < ApplicationComponent
    ORIENTATIONS = %w[horizontal vertical].freeze

    def initialize(orientation: :horizontal, **html_attributes)
      @orientation = orientation.to_s
      @html_attributes = html_attributes

      validate_option!(:orientation, @orientation, ORIENTATIONS)
    end

    private

    def attributes
      @html_attributes.merge(orientation: @orientation)
    end
  end
end
