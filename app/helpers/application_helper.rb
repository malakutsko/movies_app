module ApplicationHelper
  def active_link_to(text, path, options)
    options[:class] ||= ''
    options[:class] += ' active' if current_page?(path)

    link_to text, path, options
  end

  def alert_class(type)
    case type
    when 'alert'
      'alert-danger'
    when 'notice'
      'alert-success'
    end
  end
end
