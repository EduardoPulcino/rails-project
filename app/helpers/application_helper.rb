module ApplicationHelper
  def field_error(resource, field)
    return unless resource.errors[field].any?

    field_name = resource.class.human_attribute_name(field)

    error_message = resource.errors[field].first

    tag.div("#{field_name} #{error_message}", class: "field-error")
  end
end
