# frozen_string_literal: true

require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock

  # http://www.relishapp.com/vcr/vcr/v/3-0-3/docs/configuration/ignore-request
  config.ignore_request do |request|
    URI(request.uri).port == Capybara.server_port
  end
end
