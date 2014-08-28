require 'faraday'
require 'json'

require "sonicapi/version"
require "sonicapi/analyze"
require "sonicapi/file"
require "sonicapi/process"
require "sonicapi/conversion"

module SonicApi
  extend SonicApi::Analyze
  extend SonicApi::File
  extend SonicApi::Process
  extend SonicApi::Conversion

  class << self
    attr_reader :access_id

    def authenticate(access_id)
      @access_id = access_id
      @uploads = {}
      connection
    end

    def connection
      @conn ||= Faraday.new("https://api.sonicapi.com") do |f|
        f.request :multipart
        f.request :url_encoded
        f.adapter :net_http
      end
    end

    def reset_connection!
      @conn = nil  # To force skipping memoization when calling `connection` method

      connection
    end
  end
end
