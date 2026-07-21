module UI
  class DialogComponent < ApplicationComponent
    renders_one :footer
    renders_one :header_actions

    def initialize(
      label:,
      open: false,
      light_dismiss: false,
      without_header: false,
      **html_attributes
    )
      @label = label
      @open = open
      @light_dismiss = light_dismiss
      @without_header = without_header
      @html_attributes = html_attributes

      raise ArgumentError, "label is required" if @label.blank?
    end

    private

    def attributes
      @html_attributes.merge(
        class: [ "ui-dialog", @html_attributes[:class] ].compact.join(" "),
        label: @label
      ).tap do |attributes|
        attributes[:open] = true if @open
        attributes["light-dismiss"] = true if @light_dismiss
        attributes["without-header"] = true if @without_header
        attributes["with-footer"] = true if footer?
      end
    end
  end
end
