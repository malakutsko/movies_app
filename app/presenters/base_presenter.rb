# frozen_string_literal: true

class BasePresenter
  attr_reader :object

  def initialize(object)
    @object  = object
  end
end
