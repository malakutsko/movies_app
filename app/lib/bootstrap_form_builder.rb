ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.html_safe
end

class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  def form_group(method, options = {})
    class_def = 'form-group'
    class_def << ' has-error' if @object.errors[method].present?
    class_def << " #{options[:class]}" if options[:class].present?
    options[:class] = class_def
    @template.content_tag(:div, options) { yield }
  end

  %w(text_field email_field password_field text_area).each do |field_type|
    define_method "#{field_type}" do |method, options = {}|
      field_tag = super(method, options)
      with_errors(method, with_before_and_after(field_tag, options))
    end
  end

  private

  def errors_for(method)
    object.errors[method].map do |message|
      next unless message
      @template.content_tag(:div, message, class: 'form--error')
    end.join.html_safe
  end

  def with_errors(method, *elements)
    [*elements, errors_for(method)].join.html_safe
  end

  def with_before_and_after(field, options)
    @template.content_tag(:div, class: 'input-group') do
      if options.key?(:before) || options.key?(:after)
        [
          (@template.content_tag(:span, options.delete(:before), class: 'input-group-addon') if options.key?(:before)),
          field,
          (@template.content_tag(:span, options.delete(:after), class: 'input-group-addon') if options.key?(:after))
        ].join.html_safe
      else
        field
      end
    end
  end
end
