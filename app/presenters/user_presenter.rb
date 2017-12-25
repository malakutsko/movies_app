# frozen_string_literal: true

class UserPresenter < BasePresenter
  def full_name
    [object.first_name, object.last_name].join(' ')
  end
end

