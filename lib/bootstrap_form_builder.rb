# This file goes in lib/
# Usage:
# <%= bootstrap_form_for @calendar_entry do |f| %>
#   <%= content_tag :legend, (locals[:title] || 'Edit Calendar Entry') %>
#   <%= f.text_field :name, :class => 'span3' %>
#   <%= f.text_area :description, :class => 'span3' %>
#   <%= f.check_box :all_day %>
#   <%= f.text_field :tag_string, :label => {:text => 'Tags'}, :class => 'span3' do %>
#     <p class="help-block">Use commas to separate tags.</p>
#   <% end %>
#   <div class="form-actions">
#     <%= f.submit 'Save', :class => 'btn btn-primary' %>
#     <%= link_to 'Cancel', calendar_entries_path, :class => 'btn' %>
#   </div>

module BootstrapFormBuilder
  module FormHelper
    [:form_for, :fields_for].each do |method|
      module_eval do
        define_method "bootstrap_#{method}" do |record, *args, &block|
          # add the TwitterBootstrap builder to the options
          options           = args.extract_options!
          options[:builder] = BootstrapFormBuilder::Builder

          if method == :form_for
            options[:html] ||= {}
            options[:html][:class] ||= ''
          end

          # call the original method with our overridden options
          send method, record, *(args << options), &block
        end
      end
    end
  end

  class Builder < ActionView::Helpers::FormBuilder
    include FormHelper

    def get_error_text(field, options)
      if @object.nil? || options[:hide_errors]
        ""
      else
        errors = @object.errors[field.to_sym]
        if errors.empty? then "" else errors.first end
      end
    end

    def get_object_id(field, options)
      return options[:id] || @object.class.title.underscore + '_' + field.to_s
    end

    def get_label(field, options)
      labelOptions = {:class => 'control-label'}.merge(options[:label] || {})
      text = labelOptions[:text] || nil
      labelTag = label(field, text, labelOptions)
    end

    def submit(value, options = {}, *args)
      super(value, {:class => "btn btn-primary"}.merge(options), *args)
    end

    basic_helpers = %w{
                      date_select
                      time_select
                      datetime_select
                      date_field
                      time_field
                      datetime_local_field
                      collection_select
                      text_field
                      text_area
                      select
                      email_field
                      password_field
                      check_box
                      number_field
                    }

    basic_helpers.each do |name|
      # First alias old method
      class_eval("alias super_#{name.to_s} #{name}")

      define_method(name) do |field, *args, &help_block|
        options = args.last.is_a?(Hash) ? args.last : {}

        labelTag = get_label(field, options)

        errorText = get_error_text(field, options)

        wrapperClass = 'control-group' + (errorText.empty? ? '' : ' error')
        prepend_icon = options.fetch(:prepend) {false}
        errorSpan = if errorText.empty? then "" else "<span class='help-inline'>#{errorText}</span>" end
        ("<div class='#{wrapperClass}'>" +
            labelTag +
            "<div class='controls'>" +
              "<div class='#{prepend_icon ? 'input-prepend' : ''}'>" +
                (prepend_icon ? "<span class='add-on'><i class=#{prepend_icon}></i></span>" : '') +
                super(field, *args) +
                (help_block ? @template.capture(&help_block) : "") +
              "</div>" +
              errorSpan +
            "</div>" +
          "</div>"
        ).html_safe
      end
    end

  end
end
