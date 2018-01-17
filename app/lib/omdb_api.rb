# frozen_string_literal: true

require 'json'
require 'net/http'

class OmdbApi
  def self.search_by_name(name)
    uri = URI('http://www.omdbapi.com')
    params = { t: name, apikey: Rails.application.secrets.omdb_api_key }

    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    res = JSON.parse(res.body)

    if res['Error'].present?
      nil
    else
      res
    end
  end
end
