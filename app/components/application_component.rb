class ApplicationComponent < ViewComponent::Base
  private

  def validate_option!(name, value, allowed_values)
    return if allowed_values.include?(value)

    raise ArgumentError, "#{name} must be one of: #{allowed_values.join(", ")}"
  end
end
