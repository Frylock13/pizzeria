class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  def error_message(field_name)
    return if @object.errors[field_name].blank?
    @template.content_tag :div, @object.errors[field_name].join(', '), class: 'help-block'
  end

  def form_group(field_name, options = {})
    class_def = 'form-group'
    class_def << ' has-error' unless @object.errors[field_name].blank?
    class_def << " #{options[:class]}" if options[:class].present?
    options[:class] = class_def
    @template.content_tag(:div, options) { yield }
  end
end

# module FormsHelper
#   def form_field_group(field_name, form_record, div_class: nil, div_id: nil, &block)
#     classes = ['form-group', div_class]
#     classes << 'has-error' if form_record.errors[field_name].any?
#     content_tag :div, capture(&block), class: classes.join(' '), id: div_id
#   end
# end
