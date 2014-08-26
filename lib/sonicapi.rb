require "sonicapi/version"
require "sonicapi/analyze"
require "sonicapi/file"
require "sonicapi/process"

module SonicApi
  extend SonicApi::Analyze
  extend SonicApi::File
  extend SonicApi::Process

  class << self
    def authenticate(access_key)
      @access_key = access_key
      @uploads = {}
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
