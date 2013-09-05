module ApplicationHelper
  
  def to_dos
    ToDo.all
  end

	def form_field(form, name, icon_class)
		generate_form form, get_label(name), icon_class do |f|
			f.text_field name 
		end
	end

  def course_form_select(form, name, icon_type)
		generate_form form, get_label(name), icon_type do |f|
			collection_select(:course, :id, Course.all,
				:name, :name, { prompt: 'Select a Course' })
		end
	end

	def get_label(name)
		name.to_s.sub(/_/, ' ').capitalize
	end

	def generate_form(form, name, icon_class)
		content_tag(:div, class: 'control-group') do
      form.label(name, class: 'control-label') +
      content_tag(:div, class: 'controls') do
        content_tag(:div, class: 'input-prepend') do
          content_tag(:span, class: 'add-on') do
            content_tag(:i, nil, class: icon_class)
          end + yield(form)
        end
      end
    end
	end

end
