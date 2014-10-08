module FormHelper
  def form_label(name, label:nil, **options)
    label and content_tag(:label, for: name) do
      label
    end
  end

  def field(name, *args)
    [
      form_label(name, *args),
      form_field(name, *args),
      form_field_error(name),
    ].join.html_safe
  end

  def form_field(name, field: :input, **options)
    tag field, {
      id: name,
      name: name,
      type: 'text',
      class: 'form-control',
      :"ng-model" => name
    }.merge(options)
  end

  def form_field_error(name, **options)
    render "shared/form/field_error", field: name
  end
end
