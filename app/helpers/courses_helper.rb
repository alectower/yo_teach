module CoursesHelper

  def form_field(form, name, icon_type)
    content_tag(:div, class: 'control-group') do
      form.label(name.to_s.sub(/_/, ' ').capitalize, class: 'control-label') +
      content_tag(:div, class: 'controls') do
        content_tag(:div, class: 'input-prepend') do
          content_tag(:span, class: 'add-on') do
            content_tag(:i, nil, class: icon_type)
          end +
          form.text_field(name)
        end
      end
    end
  end

end
